#!/bin/bash
set -u

source_app="${1}"
destination="/Applications/vidp.app"
backup="/Applications/.vidp.app.previous"

if [[ -e "${destination}" ]]; then
  bundle_id=$(/usr/libexec/PlistBuddy -c "Print :CFBundleIdentifier" "${destination}/Contents/Info.plist" 2>/dev/null || true)
  if [[ "$bundle_id" != "com.vidp.vidp" ]]; then
    echo "Warning: skipped /Applications/vidp.app because it belongs to another application." >&2
    exit 0
  fi
fi

rm -rf "${backup}"
if [[ -e "${destination}" ]]; then
  mv "${destination}" "${backup}" ||
    {
      echo "Warning: could not update /Applications/vidp.app." >&2
      exit 0
    }
fi

if ! ditto "${source_app}" "${destination}"; then
  rm -rf "${destination}"
  if [[ -e "${backup}" ]]; then
    mv "${backup}" "${destination}"
  fi
  echo "Warning: could not copy vidp.app to /Applications." >&2
  exit 0
fi

rm -rf "${backup}"
echo "Installed vidp.app in /Applications"
