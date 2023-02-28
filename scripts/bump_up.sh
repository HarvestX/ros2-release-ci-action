#!/usr/bin/env bash

set -euo pipefail

main() {
  target_package_name=$1
  target_version=$2

  for package_file in $(find . -name 'package.xml'); do
    if ! grep -q "<name>$target_package_name</name>" $package_file; then
      continue
    fi

    # Upgrade package.xml
    be="<version>"
    ed="<\/version>"
    sv="\([0-9]\+\).\([0-9]\+\).\([0-9]\+\)"
    sed -i "s/$be$sv$ed/$be$target_version$ed/g" $package_file

    # Upgrade setup.py if it is ament_python
    package_path=$(dirname $package_file)
    py_file=$package_path/setup.py
    if [[ -f $py_file ]]; then
      sed -i "s/version=['\"]$sv['\"]/version='$target_version'/g" $py_file
    fi

    ## Success
    exit 0
  done

  # Case package not found
  echo "package [$target_package_name] does not exist"
  exit 1
}

main "$1" "$2"
