#!/usr/bin/env bash

source ../output/logger.sh
source ../output/confirm.sh
source ../output/progress.sh

#
# Logger
#
echo "# ---------------------------------------"
echo "# OUTPUT"
echo "# ---------------------------------------"

logger::out "Out\n"
logger::echo "Echo"
logger::bold "Bold"
logger::italic "Italic"
logger::striketrough "Striketrough"
logger::title "Title"
logger::sub "Sub"
logger::step "Step"
logger::success "Success"
logger::warn "Warn"
logger::error "Error"
logger::code "<code></code>"
logger::conf "CONF=1"
logger::keyVal "Key" "Value"
logger::wait
logger::showDate
logger::echo "With Date"
logger::hideDate
logger::echo "No Date"

#
# Confirmation
#
echo
echo "# ---------------------------------------"
echo "# CONFIRMATION"
echo "# ---------------------------------------"

confirm::confirm "Are you sure?"
if confirm::isConfirmed; then
    echo "Positive"
else
    echo "Negative"
fi

confirm::ask "Type something"
answer=$(confirm::answer)
echo "${answer}"

#
# Progress
#
echo
echo "# ---------------------------------------"
echo "# PROGRESS"
echo "# ---------------------------------------"
progress::wait 5
