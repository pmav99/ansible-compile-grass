[![Build Status](https://travis-ci.com/pmav99/ansible-role-compile_grass.svg?branch=master)](https://travis-ci.com/pmav99/ansible-role-compile_grass)

compile_grass
=============

An ansible role for compiling GRASS GIS from source on Ubuntu 18.04.

The role also installs the latest Python 2 version and R

All configuration options are supported.

Install the role
----------------

You can install the role by using:

    ansible-galaxy install pmav99.compile_grass

Role Variables
--------------

A description of the settable variables for this role should go here, including
any variables that are in defaults/main.yml, vars/main.yml, and any variables
that can/should be set via parameters to the role. Any variables that are read
from other roles and/or the global scope (ie. hostvars, group vars, etc.) should
be mentioned here as well.


Example Playbook
----------------

If you want to install grass locally you can use the following playbook:

    - hosts: 127.0.0.1
      connection: local

      vars:
        gsi_builder_username: 'builder'

      roles:
         - role: pmav99.compile_grass

and you can run it with:

    ansible-playbook playbook.yml


License
-------

MIT
