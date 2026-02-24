#!/usr/bin/env bash
# Remove local Sonatype Guide plugin from Cursor.

set -e
CURSOR_PLUGINS="${CURSOR_PLUGINS:-$HOME/.cursor/plugins}"
INSTALLED_JSON="$CURSOR_PLUGINS/installed.json"
PLUGIN_NAME="sonatype-guide"

if [[ ! -f "$INSTALLED_JSON" ]]; then
  echo "Cursor plugins file not found: $INSTALLED_JSON"
  exit 0
fi

if command -v jq &>/dev/null; then
  if jq -e ".local[\"$PLUGIN_NAME\"]" "$INSTALLED_JSON" &>/dev/null; then
    jq "del(.local[\"$PLUGIN_NAME\"])" "$INSTALLED_JSON" > "${INSTALLED_JSON}.tmp"
    mv "${INSTALLED_JSON}.tmp" "$INSTALLED_JSON"
    echo "Removed local plugin: $PLUGIN_NAME"
  else
    echo "Local plugin $PLUGIN_NAME not found in installed.json"
  fi
else
  echo "jq not found. To uninstall, edit $INSTALLED_JSON and remove the \"$PLUGIN_NAME\" entry from the \"local\" object."
fi

if [[ -f "$INSTALLED_JSON.bak" ]]; then
  echo "Backup exists: $INSTALLED_JSON.bak (not restored; remove manually if desired)"
fi
