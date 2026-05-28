#!/bin/bash

echo "Starting Service 1..."
sleep 5000 &
SERVICE1_PID=$!

echo "Starting Service 2..."
sleep 5000 &
SERVICE2_PID=$!

echo ""
echo "Service 1 PID: $SERVICE1_PID"
echo "Service 2 PID: $SERVICE2_PID"

echo ""
echo "Both services running in background."

wait
