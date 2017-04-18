#!/bin/bash

seafiledir=/home/seafile

  umask g-w,o-w

  printf "Cloning Seafile...\n"
  hash git >/dev/null 2>&1 || {
    echo "Error: git is not installed at the moment"
    exit 1
  }
  if [ -n /home/seafile ]; then
    echo "Error: seafile is not installed at the moment"
    exit 1
  }
  
  env git clone https://github.com/braun-it/seafile.git $seafiledir || {
    printf "Error: git clone of seafile repo failed\n"
    exit 1
  }
