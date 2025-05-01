#!/bin/bash
set -e

USERNAME=seluser
GROUPNAME=seluser 

# --- ボリュームマウントポイントの所有者を名前で変更 ---
PROFILE_DIR="/home/seluser/chrome-profile"
echo "Ensuring ownership of ${PROFILE_DIR} is ${USERNAME}:${GROUPNAME}"
mkdir -p "${PROFILE_DIR}"
chown ${USERNAME}:${GROUPNAME} "${PROFILE_DIR}"

echo "Ownership set. Executing original Selenium entrypoint..."
exec /opt/bin/entry_point.sh "$@"
