#!/bin/bash
#Purpose: eval command Evaluating twice
# START #
COMMAND="ls -ltr /etc"
echo "$COMMAND"
eval $COMMAND
# END #
