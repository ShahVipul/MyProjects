#!/bin/bash

############################################
# Oracle Transaction Success Ratio Script
# Purpose:
#   Get card-type-wise transaction count
#   and success ratio for last 1 hour
############################################

export ORACLE_HOME=/u01/app/oracle/product/19c/dbhome_1
export ORACLE_SID=PAYMENTDB
export PATH=$ORACLE_HOME/bin:$PATH

DB_USER="paymentDB"
DB_PASS="StrongPassword123"

LOG_DIR="/home/oracle/reports"
DATE=$(date +%F_%H-%M-%S)

mkdir -p $LOG_DIR

REPORT_FILE="$LOG_DIR/card_success_report_$DATE.log"

echo "==========================================" > $REPORT_FILE
echo "CARD TYPE SUCCESS REPORT - LAST 1 HOUR" >> $REPORT_FILE
echo "Generated At : $(date)" >> $REPORT_FILE
echo "==========================================" >> $REPORT_FILE

sqlplus -s ${DB_USER}/${DB_PASS} <<EOF >> $REPORT_FILE

SET PAGESIZE 100
SET LINESIZE 200
SET FEEDBACK OFF
SET HEADING ON
COL CARD_NETWORK FORMAT A15
COL TOTAL_TXN FORMAT 999999
COL SUCCESS_TXN FORMAT 999999
COL FAILED_TXN FORMAT 999999
COL SUCCESS_RATIO FORMAT 999.99

SELECT
    card_network,

    COUNT(*) AS total_txn,

    SUM(
        CASE
            WHEN status = 'SUCCESS'
            THEN 1
            ELSE 0
        END
    ) AS success_txn,

    SUM(
        CASE
            WHEN status = 'FAILED'
            THEN 1
            ELSE 0
        END
    ) AS failed_txn,

    ROUND(
        (
            SUM(
                CASE
                    WHEN status = 'SUCCESS'
                    THEN 1
                    ELSE 0
                END
            ) * 100
        ) / COUNT(*),
        2
    ) AS success_ratio

FROM transaction_req

WHERE request_time >= SYSTIMESTAMP - INTERVAL '1' HOUR

GROUP BY card_network

ORDER BY success_ratio DESC;

EXIT;
EOF

echo ""
echo "=========================================="
echo "Report Generated Successfully"
echo "Location : $REPORT_FILE"
echo "=========================================="

cat $REPORT_FILE
