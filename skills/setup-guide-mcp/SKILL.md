---
name: setup-guide-mcp
description: Configure the Sonatype Guide MCP server connection. Use when first installing the plugin or troubleshooting connection issues.
---

# Setup Guide MCP

## Trigger

Use when setting up the Sonatype Guide MCP server or troubleshooting connection issues.

## Prerequisites

- Sonatype Guide account at https://guide.sonatype.com
- API token from https://guide.sonatype.com/settings/tokens

## Workflow

1. Check if `SONATYPE_GUIDE_TOKEN` environment variable is set.
2. If not set, guide user through token setup:
   - Direct to token generation page
   - Show configuration options (shell profile vs settings file)
3. Verify MCP server connection by listing available tools.
4. Test with a simple component lookup.
5. Confirm successful setup.

## Configuration Options

### Option A: Shell Profile (Recommended)

Add to `~/.zshrc`, `~/.bashrc`, or `~/.profile`:

```bash
export SONATYPE_GUIDE_TOKEN="your-token-here"
```

Then reload:
```bash
source ~/.zshrc  # or ~/.bashrc
```

### Option B: Claude Code Settings

Add to `.claude/settings.json` or `~/.claude/settings.json`:

```json
{
  "env": {
    "SONATYPE_GUIDE_TOKEN": "your-token-here"
  }
}
```

## Verification Steps

1. Check environment variable:
   ```bash
   echo $SONATYPE_GUIDE_TOKEN
   ```

2. Verify MCP server is connected:
   ```
   /mcp
   ```
   Look for `sonatype-guide` in the list.

3. Test a lookup:
   ```
   Check lodash 4.17.21
   ```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Token not recognized | Restart terminal/IDE after setting env var |
| MCP server not connecting | Verify token is valid at guide.sonatype.com |
| API errors | Check network connectivity to mcp.guide.sonatype.com |
| Rate limiting | Wait and retry, or upgrade Sonatype Guide plan |

## Output

- Configuration status
- Available MCP tools
- Test result confirmation
