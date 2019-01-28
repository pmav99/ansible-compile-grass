[![Build Status](https://travis-ci.com/pmav99/ansible-role-compile_grass.svg?branch=master)](https://travis-ci.com/pmav99/ansible-role-compile_grass)

compile_grass
=============

An ansible role for compiling GRASS GIS from source on Ubuntu 18.04.

Running this will:

- install all dependencies needed for compiling and running GRASS GIS
- checkout the source code
- create a virtualenv directory and install all the python dependencies
- compile GRASS GIS

**Major points**:

- Almost all configuration options are supported.
- Both Python 2 and 3 are supported (Python 3 is the default).
- By default it uses trunk but it should work with any 7.x branch.

When to use
-----------

The main usecase for this role is to kickstart the creation of a GRASS GIS development
environment.

Apart from that, you can also use this role in order to deploy a customised GRASS
GIS Installation on one or more servers.

Requirements
------------

You need an Ubuntu 18.04 installation; it can be either a Physical machine or a Virtual
One. You will also need ansible 2.7 which must be installed from a ppa. Instructions
[here](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#latest-releases-via-apt-ubuntu)

Quickstart
----------

If you are OK with the defaults, this is all you need to do:

    ansible-galaxy install pmav99.compile_grass             # install the role from ansible-galaxy
    wget https://git.io/fh8FY -O compile_grass.yml          # donwload the sample playbook-file
    ansible-playbook compile_grass.yml --ask-become-pass    # run the playbook. It will ask you for the sudo password

That being said, the defaults are often not what you want so reading the detailed
instructions would be a good idea.

Detailed Instructions
---------------------

### Install the role

You can install the role by running:

    ansible-galaxy install pmav99.compile_grass

### Sample Playbook

After installing the role, in order to use it you need a "playbook" which is a yaml
file.  This is a sample playbook that that runs the role on the local machine.

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

After saving the playbook as `playbook.yml`, you can run it with:

    ansible-playbook playbook.yml --ask-become-pass

This command will ask you for your sudo password, and start executing the various tasks.

### Role Variables

In order to customize what the playbook will do, you need to edit the playbook and
modify the keys and the values of variables defined in `vars`.

The only mandatory variable is `gcs_builder_username`. This defines the name of the user
that will do own the directory with the GRASS source and with which the compilation will
be done. If you do not set it the playbook will not execute. If a user with the
specified username does not exist, the playbook will create a new user account with that
username.  The password for the new user will be 1234 (you can set that too using
`gcs_builder_password`).

The [sample
playbook](https://github.com/pmav99/ansible-role-compile_grass/blob/master/compile_grass.yml)
sets the username to `builder` but you should probably use your main account's username.

Other useful variables are `gcs_svn_branch_url` which is the URL to the Subversion branch
that will be compiled and `gcs_python_version` which specifies the Python version which
will be used (defaults to 3).

#### Compilation options

By default, the role uses the same defaults as the `configure` script. You can change
that though by setting the appropriate variables to `true`. E.g. to enable MySQL and
ODBC support you need:

```
        gcs_mysql_support: true
        gcs_odbc_support: true
```

The full list of options can be found at
[`defaults/main.yml`](https://github.com/pmav99/ansible-role-compile_grass/blob/master/defaults/main.yml).

License
-------

MIT
