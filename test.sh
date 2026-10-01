#!/bin/bash
# shellcheck disable=SC2164
set -x
cat ~/.ai-jail
cd ~/foo
ls -la ~/foo
ai-jail sh -c 'grep " /home" /proc/self/mountinfo | cut -d" " -f4-6'
ai-jail touch hello
