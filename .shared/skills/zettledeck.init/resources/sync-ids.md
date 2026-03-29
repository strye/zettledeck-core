---
mode: sync-ids
description: Scan the vault for the highest scope ID in each range and update nextId in config
---

# Sync Next IDs

Run the bundled script. It handles all scanning and config updates directly — no file reading by Claude needed.

## Steps

1. Run the script from the project root:

   ```
   bash .shared/skills/zettledeck.init/scripts/sync-next-ids.sh
   ```

2. Show the script output to the user as-is.

3. If the script exits with an error, report the error message and suggest running `/zettledeck.init core` if the config is missing.
