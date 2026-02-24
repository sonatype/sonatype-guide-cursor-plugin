# Install test: Sonatype Guide Cursor plugin

Use this to run **P0-3** from [SPRINT_PLAN.md](./SPRINT_PLAN.md): confirm the plugin installs and the MCP server appears.

---

## Before you start

- **Token (optional for load test):** To actually call the MCP, set `SONATYPE_GUIDE_TOKEN` in your shell or Cursor env. For “does the plugin load?” you can skip this.
- **Cursor:** You need Cursor IDE (not only VS Code).

---

## Option A: Install from GitHub (recommended)

Use this if your plugin repo is on GitHub (e.g. `sonatype/sonatype-guide-cursor-plugin` or your fork).

1. **Push the plugin to GitHub** (if not already):
   - Create a repo and push this project.
   - Repo root must contain `.cursor-plugin/plugin.json`, `skills/`, `rules/`, `agents/`, `mcp.json`, etc.

2. **In Cursor:**
   - Open **Settings** (Cmd+,) → **Plugins** (or **Cursor Settings** → **Plugins**).
   - Use **Add plugin** / **Install plugin**.
   - Enter the GitHub URL, e.g.:
     - `https://github.com/sonatype/sonatype-guide-cursor-plugin`, or
     - `sonatype/sonatype-guide-cursor-plugin`
   - If Cursor chat supports `/add-plugin`, you can try:
     - `/add-plugin sonatype/sonatype-guide-cursor-plugin`
     - or the full repo URL.

3. **Confirm install:** The plugin should appear in your installed plugins. Enable it if there’s a toggle.

---

## Option B: Local install (for testing without publishing)

Use this to test the plugin from your machine without pushing to GitHub.

**Note:** Plugins added via the `local` section of `installed.json` may **not appear** in Settings → Plugins. Cursor’s UI typically lists plugins installed from the marketplace or by URL. If you need the plugin to show in the Installed list and have MCP/skills load, use **Option A (GitHub)** instead.

1. **Back up Cursor’s plugin list** (optional but recommended):
   ```bash
   cp ~/.cursor/plugins/installed.json ~/.cursor/plugins/installed.json.bak
   ```

2. **Run the local install script** from this repo:
   ```bash
   cd /Users/moliverio/projects/sonatype-guide-cursor
   ./scripts/local-plugin-install.sh
   ```
   This script adds `sonatype-guide` to the `local` section of `~/.cursor/plugins/installed.json` (no copy to cache).

3. **Restart Cursor.** The plugin may still not appear under Installed; if so, install via GitHub (Option A).

4. **Uninstall (revert) when done testing:**
   ```bash
   ./scripts/local-plugin-uninstall.sh
   ```

---

## Verification checklist

After installing (A or B):

| Step | What to check | Pass? |
|------|----------------|-------|
| 1 | Plugin appears in **Settings → Plugins** (or Cursor’s plugin list) | ☐ |
| 2 | **MCP:** In Cursor, open MCP / integrations and confirm **sonatype-guide** is listed | ☐ |
| 3 | Enable the **sonatype-guide** MCP server (if there’s a toggle) | ☐ |
| 4 | **Skills:** In chat/agent, confirm skills like `check-dependency`, `find-safer-version`, `audit-dependencies`, `setup-guide-mcp` are available | ☐ |
| 5 | **Agent:** Confirm **dependency-advisor** agent is available | ☐ |
| 6 | **Rules:** Open a `package.json` or `pom.xml` and confirm dependency-hygiene / security-first-deps are suggested or active | ☐ |
| 7 | **Live MCP (optional):** Set `SONATYPE_GUIDE_TOKEN`, then in chat run: “Check lodash 4.17.21” and confirm you get a real response from Sonatype Guide | ☐ |

---

## If something fails

- **Plugin not listed:** Ensure repo root (or the folder you added) contains `.cursor-plugin/plugin.json` and the paths inside it are correct. Restart Cursor after install.
- **MCP not showing:** Confirm `mcp.json` is in the plugin root and is referenced in `plugin.json` under `mcpServers`. Our `mcp.json` uses a `mcpServers` wrapper.
- **MCP errors / 401:** Set `SONATYPE_GUIDE_TOKEN` and restart Cursor (and terminal if you set it in the shell). Token must be valid at [guide.sonatype.com](https://guide.sonatype.com).

---

## After the test

- If you used **Option B**, run `./scripts/local-plugin-uninstall.sh` and optionally restore `installed.json.bak`.
- Update [SPRINT_PLAN.md](./SPRINT_PLAN.md): check off P0-3 and note any issues.
