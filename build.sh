#!/bin/sh
set -ex
pythons="cp37-cp37m cp36-cp36m"
cd /src
for p in $pythons; do
    python=/opt/python/$p/bin/python
    $python -m pip install poetry
    $python -m poetry install
    $python -m poetry build
    auditwheel repair --wheel-dir dist/ dist/*-linux_x86_64.whl
    rm dist/*-linux_x86_64.whl
done
chown -R $REAL_UID:$REAL_GID .
