#!/bin/bash
n=$1
ps ax -o pid,etimes | awk -v limit="$n" '$2 < limit && $1 != $$ {print $1}' > killed.log
while read -r pid; do
    kill "$pid" 2>/dev/null
done < killed.log