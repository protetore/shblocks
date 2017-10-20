#!/bin/bash

. ../helpers/linux.sh
. ../output/fancy.sh

dpkg_package_exists "apache2"
#dpkg_package_exists "apache2"
#package_exists "apache2" d

result=$?
e_header $result
if [ "$result" ==  1 ]; then
	e_error "Not installed"
else
	e_success "Installed"
fi
echo

seek_confirmation "OK?"

if is_confirmed; then
    e_success "END"
else
    e_underline "Continue"
fi
