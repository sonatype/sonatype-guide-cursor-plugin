# Sonatype Guide

AI-powered dependency intelligence for Cursor. Check vulnerabilities, find safer versions, and make better dependency decisions using Sonatype's component data.

## Installation

```bash
/add-plugin sonatype-guide
```

## Prerequisites

You need a Sonatype Guide account and API token.

### Get Your Token

1. Visit [guide.sonatype.com/settings/tokens](https://guide.sonatype.com/settings/tokens)
2. Generate a new token
3. Copy the token value

### Configure Your Token

**Option A: Shell profile** (recommended)

Add to `~/.zshrc`, `~/.bashrc`, or `~/.profile`:

```bash
export SONATYPE_GUIDE_TOKEN="your-token-here"
```

Then reload your shell:
```bash
source ~/.zshrc  # or ~/.bashrc
```

**Option B: Claude Code settings**

Add to `.claude/settings.json` or `~/.claude/settings.json`:

```json
{
  "env": {
    "SONATYPE_GUIDE_TOKEN": "your-token-here"
  }
}
```

## Components

### Skills

| Skill | Description |
|:------|:------------|
| `check-dependency` | Analyze a dependency for vulnerabilities, license issues, and quality metrics |
| `find-safer-version` | Find recommended replacement versions ranked by Developer Trust Score |
| `audit-dependencies` | Comprehensive security audit of all project dependencies |
| `setup-guide-mcp` | Configure the Sonatype Guide MCP server connection |

### Rules

| Rule | Description |
|:-----|:------------|
| `dependency-hygiene` | Proactive guidance when editing package manifests |
| `security-first-deps` | Security-focused dependency selection guidance |

### Agents

| Agent | Description |
|:------|:------------|
| `dependency-advisor` | Specialized agent for evaluating dependencies, comparing alternatives, and planning upgrades |

## Usage Examples

**Check a specific package:**
```
/check-dependency lodash 4.17.20
```

**Find safer versions:**
```
/find-safer-version spring-core 5.3.20
```

**Audit all project dependencies:**
```
/audit-dependencies
```

**Natural language queries:**
```
What vulnerabilities exist in log4j 2.14.0?
```

```
Scan my package.json for vulnerable dependencies
```

```
What's the most secure version of commons-lang3 I should use?
```

## MCP Tools

This plugin connects to the Sonatype Guide MCP server and provides these tools:

| Tool | Purpose |
|------|---------|
| `getComponentVersion` | Detailed analysis of specific dependencies |
| `getLatestComponentVersion` | Find latest versions with quality data |
| `getRecommendedComponentVersions` | Top recommendations by Developer Trust Score |

## Troubleshooting

**MCP server not connecting:**
- Verify your token: `echo $SONATYPE_GUIDE_TOKEN`
- Ensure your token is valid at [guide.sonatype.com](https://guide.sonatype.com)
- Restart your IDE after setting the environment variable

**Token not recognized:**
- If using shell profile, restart your terminal
- If using settings.json, check JSON syntax
- Variable name must be exactly `SONATYPE_GUIDE_TOKEN`

## Links

- [Sonatype Guide](https://guide.sonatype.com)
- [Sonatype](https://www.sonatype.com)
- [Get Support](https://support.sonatype.com)

## License

MIT
