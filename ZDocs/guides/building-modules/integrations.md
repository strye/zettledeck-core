---
title: MCP Servers & Providers
description: Connecting a module to external services — declaring MCP servers and defining named capability providers.
---

# MCP Servers & Providers

Modules that integrate with external services use these two asset types. `mcp.json` declares the servers themselves; `providers/` declares the named capabilities those servers back.

## `mcp.json`

Declares MCP (Model Context Protocol) servers that your module needs. Servers are merged into the project's shared MCP configuration so the agentic tool can find them.

**Installed to:** Merged into `.shared/settings/mcp.json`.

**Install behavior:** Servers keyed by name under `mcpServers`. Each server is added if the name isn't already registered. If a server with the same name already exists, the duplicate is skipped and a diff warning is printed so the user can reconcile manually.

**Update behavior:** Same as install — additive, with duplicate detection.

### Format

```json
{
  "mcpServers": {
    "server-name": {
      "command": "executable-name",
      "env": { "VAR": "value" },
      "autoApprove": ["*"],
      "disabledTools": ["tool-a", "tool-b"]
    }
  }
}
```


| Field           | Description                                                  |
| --------------- | ------------------------------------------------------------ |
| `command`       | The MCP server executable — must be on the user's PATH       |
| `env`           | Environment variables passed to the server                   |
| `autoApprove`   | Patterns of tool invocations auto-approved for this server   |
| `disabledTools` | Specific tools to disable from an otherwise-enabled server   |

### Conflicts

When two modules need the same MCP server, the first install wins and subsequent installs warn. Users resolve conflicts by editing `.shared/settings/mcp.json` directly. This is deliberate — MCP server configurations can differ in consequential ways (different environment variables, different disabled tools), and a silent merge would mask real incompatibilities.

If your module's MCP needs might realistically collide with another module's, document the conflict in your module's README so users know to check.

## `providers/`

Capability provider definitions. Each `.md` file declares a named source for a capability (email, calendar, contacts, etc.) that skills can bind to at runtime.

**Installed to:** `.zettledeck/providers/`

**Install behavior:** Each `.md` file copied. Skipped if already exists.

**Update behavior:** Each `.md` file copied. Skipped if already exists (source-aware — providers are user-bound once configured).

### Format

```markdown
---
provider: provider-name
capability: email | calendar | contacts | ...
mcpServer: required-mcp-server-name
description: Short description of what this provider connects to
source: {module-name}
---

# {Provider Name}

## MCP Server

Server name: `{mcpServer-name}`

## Available Operations

...
```

### Why providers

Providers solve the problem of "which implementation of *capability X* should we use?"

Consider email. One module might define a generic email workflow — triage rules, classification, draft conventions. A different module might provide the concrete integration to a specific mail system (Gmail, Outlook, AWS Outlook). The workflow module shouldn't care about the integration; the integration module shouldn't own the workflow.

Providers are how the two stay separate. The workflow skill asks for "the email provider" by capability, and the user's config wires a specific provider to that role during `/zettledeck.init`. Swapping providers is a config change, not a module swap.

### Providers usually pair with `mcp.json`

A module that ships a provider usually also ships the MCP server that backs it — the provider file declares which server to bind to, and the `mcp.json` registers that server. Users who install the module get both in one step.

This pairing is a strong pattern but not a rule. A provider that wraps a REST API or a shell command doesn't need an MCP server at all; the provider file can declare whatever transport it uses.

---

**Next reading:**

- [[module-config|`module-config.json`]] — register placeholder markers in `init-steps.md` that users bind to providers at setup time
- [[user-config|Init & Note Rules]] — how users choose between available providers during configuration
- [[conventions|Conventions & Composition]] — the placeholder-marker system that lets workflow skills reference providers abstractly
