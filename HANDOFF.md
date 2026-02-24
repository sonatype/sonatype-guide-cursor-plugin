# Handoff: guide-cursor-plugin-sprint

**Session focus:** CRIT requirements, sprint plan, install test setup  
**Sprint:** guide-cursor-plugin-sprint  
**Project:** Sonatype Guide Cursor plugin (`sonatype-guide-cursor`)

---

## What was delivered

1. **CRIT applied** – Context, Role, Interview, Task framework used to lock scope:
   - Sprint name: **guide-cursor-plugin-sprint**
   - Goal: Harden and complete the Cursor plugin; installable, all four skills + agent working against real MCP; automated/guided token setup where possible.
   - Definition of done and non-goals captured in sprint plan.

2. **SPRINT_PLAN.md** – Prioritized backlog (P0–P3) with work units, dependencies, and next steps. Jira tracking: GUIDE project.

3. **MCP config fix** – `mcp.json` updated to Cursor’s expected format: top-level `mcpServers` wrapper with `sonatype-guide` entry (HTTP URL, `Authorization: Bearer ${SONATYPE_GUIDE_TOKEN}`).

4. **Plugin manifest validated** – `.cursor-plugin/plugin.json` checked against [Cursor Building Plugins](https://cursor.com/docs/plugins/building); paths and structure are correct.

5. **INSTALL_TEST.md** – Install test guide with:
   - Option A: Install from GitHub (Add plugin / repo URL).
   - Option B: Local install via scripts.
   - Verification checklist (plugin visible, MCP, skills, agent, rules, optional live MCP).
   - Troubleshooting notes.

6. **Local install scripts** – For testing without publishing:
   - `scripts/local-plugin-install.sh`: backs up `~/.cursor/plugins/installed.json`, adds `local["sonatype-guide"] = <repo path>` (uses `jq` when available).
   - `scripts/local-plugin-uninstall.sh`: removes that entry.
   - Scripts were run once; plugin is registered locally. User was instructed to **restart Cursor** and verify.

---

## Why decisions were made

- **CRIT before acting:** Agent0 pattern—clarify scope and “done” before implementation to avoid rework.
- **mcpServers wrapper:** Cursor docs state the MCP config file must contain server entries under a `mcpServers` key; previous flat format could fail parsing.
- **Two install options:** GitHub path is the normal install; local scripts support testing before the repo is published or without pushing.
- **jq + sed fallback in scripts:** Keeps JSON edits safe when `jq` exists; gives clear manual instructions when it doesn’t.

---

## Current state of the codebase

| Area | State |
|------|--------|
| **Manifest** | `.cursor-plugin/plugin.json` valid; points to `./skills/`, `./rules/`, `./agents/`, `./mcp.json`; `assets/avatar.svg` present. |
| **MCP** | `mcp.json` has `mcpServers.sonatype-guide` with HTTP URL and env-based auth. |
| **Skills** | 4 skills: `check-dependency`, `find-safer-version`, `audit-dependencies`, `setup-guide-mcp` (SKILL.md with frontmatter). |
| **Rules** | 2 rules: `dependency-hygiene.mdc`, `security-first-deps.mdc` (globs for manifests). |
| **Agents** | 1 agent: `dependency-advisor.md`. |
| **Docs** | README (install, token, usage, troubleshooting); SPRINT_PLAN.md; INSTALL_TEST.md. |
| **Cursor local state** | `~/.cursor/plugins/installed.json` has `local["sonatype-guide"]` pointing at this repo. User must restart Cursor to see the plugin. |

**Repo layout (relevant):**

```
sonatype-guide-cursor/
├── .cursor-plugin/plugin.json
├── mcp.json
├── agents/dependency-advisor.md
├── rules/dependency-hygiene.mdc, security-first-deps.mdc
├── skills/{check-dependency,find-safer-version,audit-dependencies,setup-guide-mcp}/SKILL.md
├── assets/avatar.svg
├── scripts/local-plugin-install.sh, local-plugin-uninstall.sh
├── README.md
├── SPRINT_PLAN.md
├── INSTALL_TEST.md
├── HANDOFF.md
└── LICENSE
```

---

## Known risks and gaps

- **P0-3 not yet confirmed:** Local install was run, but it’s unknown whether Cursor actually loads plugins from the `local` map. User needs to restart Cursor and confirm plugin + MCP appear; if not, use Option A (GitHub) or investigate Cursor’s local plugin behavior.
- **Token setup:** Automated token setup (P2-1) not implemented; depends on Cursor exposing a way to set env or run a first-run flow. Fallback is docs + setup-guide-mcp skill.
- **Skills/agent vs real MCP:** P1-1–P1-5 (verification against live Sonatype Guide MCP) not run; no confirmation yet that tool names and response shapes match.
- **Jira:** No GUIDE tickets created; sprint plan is the source of truth for now.

---

## Immediate next priorities

1. **Confirm install (P0-3):** Restart Cursor → Settings → Plugins. Verify Sonatype Guide appears and **sonatype-guide** MCP is listed and can be enabled. If local install doesn’t work, push to GitHub and install via Option A in INSTALL_TEST.md.
2. **Run P1:** With plugin and MCP enabled, test each skill and the dependency-advisor agent against the real MCP (e.g. “Check lodash 4.17.21”); fix any tool/response mismatches.
3. **P2 token flow:** Implement first-run/guided token flow (rule or prompt when token missing + pointer to Cursor env/settings); update README and setup-guide-mcp as in P2-2.
4. **Optional:** Create GUIDE-xxx tickets and link them in SPRINT_PLAN.md and commits.

---

## SQUAD / COE / Beads

- **SQUAD:** No agents spawned this session; work was planning and setup.
- **COE:** No dedicated review this session; security/UX/SET can be engaged when implementing P1/P2.
- **Beads:** Not in use in this workspace; sprint plan and this handoff are the task record.

---

## Before next session (recommended)

- Run through INSTALL_TEST.md verification checklist and note results (especially P0-3).
- If you change `installed.json` or uninstall locally, run `./scripts/local-plugin-uninstall.sh` when done testing.
- Commit and push so the next session (or another Agent0) has this handoff and current plan:  
  `git add -A && git commit -m "Handoff: sprint plan, install test, local install scripts" && git push`

---

*Handoff produced so another operator or Agent0 can continue without loss of context.*
