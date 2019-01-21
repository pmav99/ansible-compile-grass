[![Build Status](https://travis-ci.com/pmav99/ansible-role-compile_grass.svg?branch=master)](https://travis-ci.com/pmav99/ansible-role-compile_grass)

compile_grass
=============

An ansible role for compiling GRASS GIS from source on Ubuntu 18.04.

Major points:

- Almost all configuration options are supported.
- Both Python 2 and 3 are supported (Python 3 is the default).
- By default it uses trunk but it should work with any 7.x branch.

Quickstart
----------

    ansible-galaxy install pmav99.compile_grass
    wget https://git.io/fh8FY -O compile_grass.yml
    ansible-playbook compile_grass.yml --ask-become-pass

Install the role
----------------

You can install the role by using:

    ansible-galaxy install pmav99.compile_grass

Role Variables
--------------

### Mandatory

The only mandatory variable is `gcs_builder_username`. This is the user that will own
the directory with GRASS source and with which the compilation will be done. If you do
not set it the playbook will not execute. If a user with the specified username does not
exist, the playbook will create a new user account with that username.

The sample playbook sets this to `builder` but you should probably use your main
account's username.

### Configuration options

The rest options are pretty-much self-explanatory and you can check them in
`defaults/main.yml`

Example Playbook
----------------

If you want to install grass locally you can use the following playbook:

    - hosts: '127.0.0.1'
      connection: 'local'

      vars:
        gcs_builder_username: 'builder'
        # gcs_svn_branch: 'https://svn.osgeo.org/grass/grass/branches/releasebranch_7_6/'
        gcs_svn_branch: 'https://svn.osgeo.org/grass/grass/trunk/'
        gcs_python_version: 3

      roles:
         - role: 'pmav99.compile_grass'
           become: true

and you can run it with:

    ansible-playbook playbook.yml --ask-become-pass

License
-------

MIT
