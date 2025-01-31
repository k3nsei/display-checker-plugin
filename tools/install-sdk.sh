#!/bin/bash

# parse parameters
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --sdk-url)
            SDK_URL="$2"
            shift
            ;;
        --sdk-url=*)
            SDK_URL="${1#*=}"
            ;;
        *)
            echo "Unknown parameter passed: $1"
            exit 1
            ;;
    esac
    shift
done

DOWNLOAD_URL="${SDK_URL:-https://marketplace.logi.com/resources/20/Logi_Plugin_Tool_Win_6_0_1_20790_ccd09903f8.zip}"

DIR="$(cd "$(dirname "${0}")" && pwd)"
TMP_DIR="$(mktemp -d)"

PKG_PATH="${TMP_DIR}/LogiPluginSdkTools.zip"
OUT_PATH="${DIR}/LogiPluginSdkTools"
NESTED_PATH="${OUT_PATH}/LogiPluginSdkTools"

cleanup() {
  rm -rf "${TMP_DIR:?}"
}
trap cleanup EXIT

# remove output directory if it exists
rm -rf "${OUT_PATH}"

# recreate output directory
mkdir -p "${OUT_PATH}"

# download package file
curl -s "${DOWNLOAD_URL}" -o "${PKG_PATH}"

# extract downloaded package
unzip -q "${PKG_PATH}" -d "${OUT_PATH}"

# move the extracted files back to output directory if they are nested
if [ -d "${NESTED_PATH}" ]; then
  mv "${NESTED_PATH}"/* "${OUT_PATH}"
  rmdir "${NESTED_PATH}"
fi

echo "SDK installation complete"
