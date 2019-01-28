#!/usr/bin/env bash
#
# Quickstart!
#

ansible-galaxy install --force pmav99.compile_grass
wget -q https://git.io/fh8FY -O compile_grass.yml
sed -i -e "s/builder/`whoami`/g" compile_grass.yml
ansible-playbook compile_grass.yml --ask-become-pass
