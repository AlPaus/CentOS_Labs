#!/bin/bash

ps -eo stat,pid | grep  "^[RSDZT]" | awk '{print $2}' | paste -sd,
