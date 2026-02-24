# Sprint: guide-cursor-plugin-sprint

**Sprint name:** guide-cursor-plugin-sprint  
**Goal:** Harden and complete the Sonatype Guide Cursor plugin so it is installable, all four skills and the agent work against the real MCP, and token setup is as automated as possible during installation.  
**Tracking:** GUIDE project (Jira)

---

## Definition of Done

- [ ] Plugin is **installable** in Cursor (e.g. via `/add-plugin` or repo path).
- [ ] **All four skills** work against the real Sonatype Guide MCP:
  - `check-dependency`
  - `find-safer-version`
  - `audit-dependencies`
  - `setup-guide-mcp`
- [ ] **Dependency advisor agent** works against the real MCP.
- [ ] **Automated token setup** during/after installation: guided first-run flow so users can configure `SONATYPE_GUIDE_TOKEN` with minimal manual steps (within Cursor plugin capabilities).

---

## Work Units (Prioritized)

### P0 – Installability & MCP foundation

| ID | Task | Owner | Deps | Notes |
|----|------|-------|------|--------|
| P0-1 | **Plugin manifest & structure** – Validate `.cursor-plugin/plugin.json` and layout per [Cursor Building Plugins](https://cursor.com/docs/plugins/building). Ensure `name`, paths, `mcpServers` pointer, `logo` are correct and plugin loads. | Dev | — | Required for install. |
| P0-2 | **MCP config format** – Ensure `mcp.json` matches Cursor’s expected format (e.g. `mcpServers` wrapper if required). Verify HTTP URL and `Authorization: Bearer ${SONATYPE_GUIDE_TOKEN}`. | Dev | — | Env substitution must work. |
| P0-3 | **Install test** – Install plugin (local path or `/add-plugin` once published) and confirm MCP server “sonatype-guide” appears and can be enabled. | Dev | P0-1, P0-2 | Smoke test. |

### P1 – Skills & agent vs real MCP

| ID | Task | Owner | Deps | Notes |
|----|------|-------|------|--------|
| P1-1 | **Skill: check-dependency** – Run against real MCP (`getComponentVersion`). Verify PURL handling, output format, and error handling (no token, invalid PURL, API errors). | Dev | P0-3 | Use real package (e.g. lodash). |
| P1-2 | **Skill: find-safer-version** – Run against real MCP (`getRecommendedComponentVersions`). Verify recommendations and output. | Dev | P0-3 | |
| P1-3 | **Skill: audit-dependencies** – Run against real MCP; batch logic and report format. Verify manifest detection and PURL conversion for supported ecosystems. | Dev | P0-3 | |
| P1-4 | **Skill: setup-guide-mcp** – Verify flow: detect missing token, direct user to token page, document env/settings options, and optional verification step. | Dev | P0-3 | |
| P1-5 | **Agent: dependency-advisor** – Invoke agent and confirm it uses MCP tools correctly for evaluation, comparisons, and recommendations. | Dev | P1-1–P1-4 | |

### P2 – Token setup experience (automated where possible)

| ID | Task | Owner | Deps | Notes |
|----|------|-------|------|--------|
| P2-1 | **First-run token flow** – Define and implement the “automated” token setup: e.g. rule or prompt that triggers on first use when token is missing, runs setup-guide-mcp skill, and points to Cursor env/settings. If Cursor supports a plugin **command** (e.g. “Configure Sonatype Guide token”), add it. | Dev | P0-3 | Cursor may not expose write-to-settings API; document and/or script as fallback. |
| P2-2 | **Docs for token setup** – README + setup-guide-mcp skill: where to set `SONATYPE_GUIDE_TOKEN` in Cursor (e.g. Cursor Settings → env, or `.cursor` config), and that IDE/terminal restart may be needed. | Dev | P2-1 | |

### P3 – Hardening & polish

| ID | Task | Owner | Deps | Notes |
|----|------|-------|------|--------|
| P3-1 | **Rules** – Confirm `dependency-hygiene` and `security-first-deps` apply when editing manifests and don’t conflict. | Dev | P1-1 | |
| P3-2 | **README** – Installation, prerequisites, token setup, usage examples, troubleshooting, links. Align with final token flow. | Dev | P2-2 | |
| P3-3 | **Submission checklist** – If publishing to Cursor marketplace: paths, frontmatter, logo, name, description per Cursor docs. | Dev | P0–P2 | Optional for this sprint. |

---

## Non-goals (out of scope for this sprint)

- Creating Jira tickets (you’ll add to GUIDE as needed).
- Cursor marketplace submission (unless explicitly added).
- New MCP tools or Sonatype API changes.
- Support for other IDEs.

---

## Dependencies Between Work Units

```
P0-1, P0-2 → P0-3 (install test)
P0-3 → P1-1, P1-2, P1-3, P1-4 (skills + setup)
P1-1..P1-4 → P1-5 (agent)
P0-3 → P2-1 (token flow)
P2-1 → P2-2 (docs)
P2-2, P1-* → P3-2 (README)
```

---

## Immediate Next Steps

1. **Fix MCP config** – Add `mcpServers` wrapper to `mcp.json` if Cursor requires it.
2. **Validate manifest** – Confirm all paths and fields; fix any mismatches (e.g. `mcp.json` vs `.mcp.json`).
3. **Run P0-3** – Install and confirm MCP shows up and env var is used.
4. **Execute P1** – Test each skill and the agent against real MCP.
5. **Implement P2** – First-run token flow and docs.

---

## Handoff / Continuity

- After each session: update this plan with completed tasks and any new work items.
- Link Jira tickets (e.g. GUIDE-xxx) in commits and in this doc when created.
