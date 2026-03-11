#!/bin/bash
n=$1

ps ax -o pid,etimes | awk -v limit="$n" '$2 > limit {print $1}' | while read pid; do
    renice -n 10 -p "$pid"
done