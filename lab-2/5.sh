#!/bin/bash
n=$1
ps ax -o pid,etimes | awk -v limit="$n" -v self="$$" '$2 < limit && $1 != self {print $1}' > killed.log
while read -r pid; do
    kill "$pid" 2>/dev/null
done < killed.log