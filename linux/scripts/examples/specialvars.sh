#!/bin/bash
#Purpose: 
#START

#'$* it stores the complete set of positional parameters as a single string'
#'$# it is set to the number of arguments specified'
#'$1 first argument, $2 second argument'
#'$0 name of executed command'
#"$@" each quoted string treated as a separate argument
#'$? exit status of last command'
#'$$ PID of the current shell
#'$! PID of the last background job'

echo "'\$*' output is $*"
echo "'\$#' output is $#"
echo "'\$1 & \$2' output $1 and $2"
echo "'\$@' output is $@"
echo "'\$?' output is $?"
echo "'\$\$' output is $$"
sleep 400 &
echo "'\$!' output is $!"
echo "'\$0' output is $0"
#END
