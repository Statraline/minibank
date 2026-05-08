#!/bin/bash

# =========================================================
# JOB NAME : BANKNIGHT
# DESC     : Mise a jour nocturne des soldes clients
# =========================================================

echo "========================================================="
echo "[JCL] STARTING JOB: BANKNIGHT"
echo "========================================================="

export FILETRANS="transactions.txt"
export FILEMASTER="master.txt"

echo "[JCL] ALLOCATING FILES :"
echo "      - TRANS  -> $FILETRANS"
echo "      - MASTER -> $FILEMASTER"
echo "---------------------------------------------------------"

./batch
RET_CODE=$?
echo "---------------------------------------------------------"
if [ $RET_CODE -eq 0 ]; then
    echo "[JCL] JOB COMPLETED SUCCESSFULLY (MAXCC=00)"
else
    echo "[JCL] JOB FAILED WITH CODE $RET_CODE"
fi
echo "========================================================="

