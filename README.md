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

If you are OK with the defaults, this is all you need to do:

    ansible-galaxy install pmav99.compile_grass             # install the role from ansible-galaxy
    wget https://git.io/fh8FY -O compile_grass.yml          # donwload the sample playbook-file
    ansible-playbook compile_grass.yml --ask-become-pass    # run the playbook. It will ask you for the sudo password

Install the role
----------------

You can install the role by using:

    ansible-galaxy install pmav99.compile_grass

Role Variables
--------------

The only mandatory variable is `gcs_builder_username`. This is the user that will own
the directory with GRASS source and with which the compilation will be done. If you do
not set it the playbook will not execute. If a user with the specified username does not
exist, the playbook will create a new user account with that username. The password for 
the new user will be 1234 (you can set that too using `gcs_builder_password`).

The [sample playbook](https://github.com/pmav99/ansible-role-compile_grass/blob/master/compile_grass.yml)
sets the username to `builder` but you should probably use your main account's username.

Other useful variables are `gcs_svn_branch_url` which is the URL to the Subversion branch
that will be compiled and `gcs_python_version` which specifies the Python version which
will be used.

The rest options are pretty-much self-explanatory and you can check them out in
[`defaults/main.yml`](https://github.com/pmav99/ansible-role-compile_grass/blob/master/defaults/main.yml)

Sample Playbook
----------------

    - hosts: '127.0.0.1'
      connection: 'local'

      vars:
        gcs_builder_username: 'builder'
        # gcs_svn_branch_url: 'https://svn.osgeo.org/grass/grass/branches/releasebranch_7_6/'
        gcs_svn_branch_url: 'https://svn.osgeo.org/grass/grass/trunk/'
        gcs_python_version: 3

      roles:
         - role: 'pmav99.compile_grass'
           become: true

You can run it with:

    ansible-playbook playbook.yml --ask-become-pass

License
-------

MIT
