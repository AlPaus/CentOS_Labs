#!/bin/bash
awk -F'[:=]' '
NR > 1 && $4 != last {
    print "Average_Running_Children_of_ParentID=" last " is " sum/count
    sum=0; count=0
}
{
    print $0
    last=$4; sum+=$6; count++
}
END {
    print "Average_Running_Children_of_ParentID=" last " is " sum/count
}' tasks_art.txt