#!/bin/bash
output_file="tasks_art.txt"
> "$output_file"

for pid_dir in /proc/[0-9]*/; do
    pid=$(basename "$pid_dir")
    ppid=$(grep -s "PPid" "$pid_dir/status" | awk '{print $2}')
    sum_exec=$(grep -s "sum_exec_runtime" "$pid_dir/sched" | awk '{print $3}')
    nr_switches=$(grep -s "nr_switches" "$pid_dir/sched" | awk '{print $3}')
    
    if [[ -n "$sum_exec" && -n "$nr_switches" && "$nr_switches" -ne 0 ]]; then
        art=$(echo "scale=6; $sum_exec / $nr_switches" | bc)
        echo "ProcessID=$pid: Parent_ProcessID=$ppid: Average_Running_Time=$art" >> "$output_file"
    fi
done

sort -t ':' -k 2 -n "$output_file" -o "$output_file"