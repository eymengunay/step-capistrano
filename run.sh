#!/bin/sh

if ! type gem &> /dev/null ; then
    fail "ruby gem not found."
fi

debug "ruby version: $(ruby --version)"
debug "gem version: $(gem --version)"

# Capistrano
$(gem query --name-matches 'capistrano' --installed)
if [[ $? -ne 0 ]]; then
    debug "capistrano not found, installing"
    $(sudo gem install capistrano)
fi

debug "capistrano version: $(cap --version)"

# Capistrano composer
$(gem query --name-matches 'capistrano-composer' --installed)
if [[ $? -ne 0 ]]; then
    $(sudo gem install capistrano-composer)
fi

capistrano_command="cap"

# Parse some variable arguments
if [ -n "$WERCKER_CAPISTRANO_STAGE" ] ; then
    capistrano_command="$capistrano_command $WERCKER_CAPISTRANO_STAGE"
else
    capistrano_command="$capistrano_command production"
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