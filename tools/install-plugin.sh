#!/bin/bash

DIR="$(cd "$(dirname "${0}")" && pwd)"
PLG_PATH="${DIR}/DisplayCheckerPlugin.lplug4"
DST_DIR="${HOME}/AppData/Local/Logi/LogiPluginService/Plugins/DisplayChecker"

trap 'echo "Plugin installation failed: $?"' ERR

if [ "$(ls -A ${DST_DIR})" ]; then
  rm -rf "${DST_DIR:?}"
fi

mkdir -p "${DST_DIR}"

if ! unzip -q "${PLG_PATH}" -d "${DST_DIR}"; then
    echo "Failed to extract ${PLG_PATH}"
    exit 1
fi

echo "Plugin installation complete."
echo "The plugin has been installed to: ${DST_DIR}"
