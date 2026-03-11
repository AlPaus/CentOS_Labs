#!/bin/bash
max_mem=0
max_pid=0

for pid_dir in /proc/[0-9]*/; do
    pid=$(basename "$pid_dir")
    mem=$(awk '{print $1}' "$pid_dir/statm" 2>/dev/null)
    if [[ -n "$mem" && "$mem" -gt "$max_mem" ]]; then
        max_mem=$mem
        max_pid=$pid
    fi
done
echo "Max memory PID: $max_pid (Pages: $max_mem)"
echo "Compare with top output:"
top -b -n 1 -o %MEM | head -n 8