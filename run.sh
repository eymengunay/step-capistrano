#!/bin/sh

if ! type gem &> /dev/null ; then
    fail "ruby gem not found."
fi

debug "ruby version: $(ruby --version)"
debug "gem version: $(gem --version)"

# Capistrano
debug "installing capistrano"
sudo gem install capistrano
debug "capistrano version: $(cap --version)"

# Capistrano composer
debug "installing capistrano-composer"
sudo gem install capistrano-composer

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