#!/bin/bash

ps ax -o pid,etime --sort=etime | tail -n 1 | awk '{print $1}'