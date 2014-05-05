#!/bin/sh

# First make sure capistrano is installed
if ! type cap &> /dev/null ; then
    if ! type gem &> /dev/null ; then
        fail "neither capistrano nor ruby gem found."
    else
        info "capistrano was not found, installing"
        sudo gem install capistrano
    fi
else
    info "capistrano is available"
    debug "capistrano version: $(capistrano --version)"
fi

capistrano_command="cap"

# Parse some variable arguments
if [ -n "$WERCKER_CAPISTRANO_STAGE" ] ; then
    capistrano_command="$capistrano_command $WERCKER_CAPISTRANO_STAGE"
fi

if [ -n "$WERCKER_CAPISTRANO_TASKS" ] ; then
    capistrano_command="$capistrano_command $WERCKER_CAPISTRANO_TASKS"
else
    capistrano_command="$capistrano_command deploy"
fi

debug "$capistrano_command"
$capistrano_command

if [[ $? -ne 0 ]]; then
    warn "$result"
    fail "capistrano command failed"
else
    success "finished $capistrano_command"
fi