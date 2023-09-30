#!/usr/bin/env bash
cat /dev/stdin <(printf "\0") >>~/.clipboard
