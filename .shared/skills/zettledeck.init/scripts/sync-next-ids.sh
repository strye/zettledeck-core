#!/usr/bin/env bash
# sync-next-ids.sh — Sync nextId values in .zettledeck/core/config.json
# Scans vault filenames to find the highest scope ID in each assigned range,
# then updates nextId to (max + 1). Safe to run repeatedly.
#
# Usage: bash sync-next-ids.sh [project-root]
#        Defaults to current working directory.
#
# Compatible: macOS, Linux, WSL (Windows Subsystem for Linux)
# Requirements: bash 3.2+, awk, sed, find, tr — all standard on macOS, Linux, and WSL

set -euo pipefail

PROJECT_ROOT="${1:-$(pwd)}"
CONFIG="$PROJECT_ROOT/.zettledeck/core/config.json"

if [[ ! -f "$CONFIG" ]]; then
    echo "ERROR: Config not found at $CONFIG" >&2
    exit 1
fi

# Extract scopeMethod — pipe through tr to strip \r for Windows-created files (WSL)
SCOPE_METHOD=$(sed -n 's/.*"scopeMethod"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "$CONFIG" | tr -d '\r')

if [[ "$SCOPE_METHOD" != "assignedRanges" ]]; then
    echo "scopeMethod is '$SCOPE_METHOD' — nextId sync only applies to assignedRanges. Nothing to do."
    exit 0
fi

# ---------------------------------------------------------------------------
# Parse repositoryFolders from config.json
# Outputs one line per folder: FOLDER|RANGE_START|RANGE_END|CURRENT_NEXT_ID
# BSD awk compatible — no gensub, no match() with capture arrays
# \r is stripped per-record to handle Windows line endings (WSL)
# ---------------------------------------------------------------------------
parse_folders() {
    awk '
        { gsub(/\r/, "") }
        BEGIN { in_array=0; in_obj=0; fo=""; rs=""; re=""; ni="" }

        /"repositoryFolders"/ { in_array=1; next }
        !in_array { next }

        /\{/ { in_obj=1; fo=""; rs=""; re=""; ni="" }

        in_obj && /"folder"/ {
            line = $0
            sub(/.*"folder"[[:space:]]*:[[:space:]]*"/, "", line)
            sub(/".*/, "", line)
            fo = line
        }
        in_obj && /"rangeStart"/ {
            line = $0
            sub(/.*"rangeStart"[[:space:]]*:[[:space:]]*/, "", line)
            sub(/[^0-9].*/, "", line)
            rs = line
        }
        in_obj && /"rangeEnd"/ {
            line = $0
            sub(/.*"rangeEnd"[[:space:]]*:[[:space:]]*/, "", line)
            sub(/[^0-9].*/, "", line)
            re = line
        }
        in_obj && /"nextId"/ {
            line = $0
            sub(/.*"nextId"[[:space:]]*:[[:space:]]*/, "", line)
            sub(/[^0-9].*/, "", line)
            ni = line
        }

        in_obj && /\}/ && fo != "" && rs != "" {
            print fo "|" rs "|" re "|" ni
            in_obj=0; fo=""; rs=""; re=""; ni=""
        }

        /\]/ { in_array=0 }
    ' "$CONFIG"
}

# ---------------------------------------------------------------------------
# Scan the vault for the highest scope ID within a given numeric range
# Filenames match: optional-uppercase-prefix + 4-digit-ID + underscore
# e.g.  S1001_MyScope.md  or  1001_MyScope.md
# ---------------------------------------------------------------------------
find_max_id() {
    local range_start=$1
    local range_end=$2
    local max_id=""
    local filename id_str id

    while IFS= read -r filepath; do
        filename=$(basename "$filepath")
        # ${BASH_REMATCH[1]} works in bash 3.2+
        if [[ "$filename" =~ ^[A-Z]?([0-9]{4})_ ]]; then
            id_str="${BASH_REMATCH[1]}"
            id=$((10#$id_str))   # force base-10 to avoid octal interpretation
            if [[ $id -ge $range_start && $id -le $range_end ]]; then
                if [[ -z "$max_id" || $id -gt $max_id ]]; then
                    max_id=$id
                fi
            fi
        fi
    done < <(find "$PROJECT_ROOT" \
        \( -path "*/.git" -o -path "*/.claude" -o -path "*/.kiro" \
           -o -path "*/node_modules" -o -path "*/.zettledeck" \) -prune \
        -o -name "*.md" -type f -print 2>/dev/null)

    echo "$max_id"
}

# ---------------------------------------------------------------------------
# Main — collect all folders, compute new nextId values, report and rewrite
# ---------------------------------------------------------------------------

# Build a lookup string passed to awk for the rewrite pass.
# Format: "folder1:newId1|folder2:newId2|..."
# Folder names are paths (00_Resources/, 20_Professional/21_Career, etc.)
# and will not contain | or : so these delimiters are safe.
LOOKUP=""
CHANGED=0
UNCHANGED=0
REPORT_CHANGED=""
REPORT_UNCHANGED=""

while IFS='|' read -r folder range_start range_end old_next_id; do
    [[ -z "$range_start" ]] && continue

    max_id=$(find_max_id "$range_start" "$range_end")

    if [[ -z "$max_id" ]]; then
        new_next_id=$range_start
        found_label="no IDs found"
    else
        new_next_id=$((max_id + 1))
        found_label=$(printf "highest found: %04d" "$max_id")
    fi

    # Append to lookup
    entry="${folder}:${new_next_id}"
    LOOKUP="${LOOKUP:+$LOOKUP|}$entry"

    if [[ "$new_next_id" -ne "$old_next_id" ]]; then
        CHANGED=$((CHANGED + 1))
        REPORT_CHANGED="${REPORT_CHANGED}  ${folder}\n    nextId  $(printf '%04d' "$old_next_id") → $(printf '%04d' "$new_next_id")  (${found_label})\n"
    else
        UNCHANGED=$((UNCHANGED + 1))
        REPORT_UNCHANGED="${REPORT_UNCHANGED}  ${folder}  nextId=$(printf '%04d' "$new_next_id")  (${found_label})\n"
    fi

done < <(parse_folders)

# ---------------------------------------------------------------------------
# Rewrite config.json with updated nextId values
# Uses awk to do a single-pass rewrite — only touches nextId lines inside
# repositoryFolders objects whose folder name has a new value in the lookup.
# ---------------------------------------------------------------------------
TMPFILE=$(mktemp)
awk -v lookup="$LOOKUP" '
    { gsub(/\r/, "") }
    BEGIN {
        in_array=0; in_obj=0; current_folder=""
        # Parse lookup: "folder1:id1|folder2:id2|..."
        n = split(lookup, parts, "|")
        for (i=1; i<=n; i++) {
            colon = index(parts[i], ":")
            key = substr(parts[i], 1, colon - 1)
            val = substr(parts[i], colon + 1)
            new_ids[key] = val
        }
    }

    /"repositoryFolders"/ { in_array=1 }
    in_array && /\{/    { in_obj=1; current_folder="" }

    in_array && in_obj && /"folder"/ {
        line = $0
        sub(/.*"folder"[[:space:]]*:[[:space:]]*"/, "", line)
        sub(/".*/, "", line)
        current_folder = line
    }

    in_array && in_obj && /"nextId"/ && (current_folder in new_ids) {
        # Replace only the numeric value, preserving indent and trailing comma
        sub(/[0-9]+/, new_ids[current_folder])
        print
        next
    }

    in_array && /\}/ { in_obj=0 }
    /\]/ { in_array=0 }

    { print }
' "$CONFIG" > "$TMPFILE"

mv "$TMPFILE" "$CONFIG"

# ---------------------------------------------------------------------------
# Output report
# ---------------------------------------------------------------------------
if [[ $CHANGED -eq 0 ]]; then
    echo "All nextId values are correct. No changes made."
    echo ""
else
    echo "Updated $CHANGED folder(s):"
    echo ""
    printf "%b" "$REPORT_CHANGED"
fi

if [[ $UNCHANGED -gt 0 ]]; then
    echo "Unchanged ($UNCHANGED):"
    printf "%b" "$REPORT_UNCHANGED"
fi

echo "Config: $CONFIG"
