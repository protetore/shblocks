#!/usr/bin/env bash

source ../helpers/linux.sh
source ../output/fancy.sh

linux::dpkg_package_exists "apache2"
#dpkg_package_exists "apache2"
#package_exists "apache2" d

result=$?
fancy::header $result
if [ "$result" ==  1 ]; then
	e_error "Not installed"
else
	e_success "Installed"
fi
echo

fancy::confirm "OK?"

if fancy::is_confirmed; then
    fancy::success "END"
else
    fancy::underline "Continue"
fi
