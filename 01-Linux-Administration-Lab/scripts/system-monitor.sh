#!/bin/bash

echo "===== System Monitoring Report ====="

echo ""

echo "Hostname:"
hostname

echo ""

echo "Disk Usage:"
df -h

echo ""

echo "Memory Usage:"
free -h

echo ""

echo "Running Processes:"
ps aux | head
