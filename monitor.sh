#!/bin/bash
# System monitoring script

echo "=== System Monitor =="
echo "Date: $(date)"
echo "Hostname: $(hostname)"
echo ""

echo "--- CPU ---"
top -bn1 | head -5
echo ""

echo "--- Memory ---"
free -h
echo ""

echo "--- Disk ---"
df -h | grep -E "^/dev"
echo ""

echo "--- Top Processes ---"
ps aux --sort=-%mem | head -6
