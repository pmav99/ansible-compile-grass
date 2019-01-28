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

The main usecase is to kickstart the creation of a GRASS GIS development environment.

That being said, the role can also be used to deploy GRASS GIS on e.g. servers. Arguably, there
are more suitable solutions for such a usecase, but if you don't care too much about
deployment times, you can still use it.

Requirements
------------

You need an Ubuntu 18.04 installation; it can be either a Physical machine or a Virtual
One. You will also need ansible 2.7 which must be installed from a ppa. Instructions
[here](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#latest-releases-via-apt-ubuntu)

Quickstart
----------

If you are OK with the defaults (i.e. build as your current user, using Python 3,
cloning the repo at `~/src/grass`), this is all you need to do:

    curl -Ssl https://raw.githubusercontent.com/pmav99/ansible-role-compile_grass/master/quickstart.sh | bash

Depending on your internet connection and the CPU power of your VM, the whole procedure
should last 10-30 minutes.

That's all! :)

What to do after installing
---------------------------

Due to the way we install the python dependencies, in order to use GRASS you will first
need to activate the virtualenv and add the grass binary to `$PATH`.  To make this a bit
easier, the role also installs some scripts that take care of `$PATH` and virtualenv
activation. These scripts are:

- `do_configure.sh`
- `do_compile.sh`
- `run_grass.sh` which executes the grass binary. The script passes along any CLI
    arguments to the grass binary (e.g. `--text`, `--help`, etc)
- `run_tests.sh` which runs the tests in `testsuite/examples`.

You will find these scripts inside the checked out SVN repo.

So, after you make a change in the source code, all you have to do is to run
`./do_compile.sh` followed by `./run_grass.sh` or `./run_tests.sh`.

If you don't want to use the scripts, remember to activate the virtualenv:

```
source venv/bin/activate
```

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
        gcs_account_username: 'builder'
        gcs_source_dir: '/home/builder/src'
        gcs_python_version: 3
        # gcs_svn_branch_url: 'https://svn.osgeo.org/grass/grass/branches/releasebranch_7_6/'
        gcs_svn_branch_url: 'https://svn.osgeo.org/grass/grass/trunk/'

      roles:
         - role: 'pmav99.compile_grass'
           become: true

After saving the playbook as `playbook.yml`, you can run it with:

    ansible-playbook playbook.yml --ask-become-pass

This command will ask you for your sudo password, and start executing the various tasks.

In order to customize what the role will do, you need to edit the playbook file and
modify the keys and the values of variables defined in the `vars` section.

Note: In order to execute the role in the local machine, `vars` is the **only** section
of the playbook file you need to modify. If you need to execute the role on a remote
machine, you should learn some ansible first :)

### Role Variables

The only mandatory variable is `gcs_account_username`. This defines the name of the user
that will do own the directory with the GRASS source and with which the compilation will
be done. If you do not set it the playbook will not execute. If a user with the
specified username does not exist, the playbook will create a new user account with that
username.  The password for the new user will be 1234 (you can set that too using
`gcs_account_password`).

The [sample
playbook](https://github.com/pmav99/ansible-role-compile_grass/blob/master/compile_grass.yml)
sets the username to `builder` but you should probably use your main account's username.

You can set the location of the GRASS repository with `gcs_source_dir`. Other useful
variables are `gcs_svn_branch_url` which is the URL to the Subversion branch that will
be compiled and `gcs_python_version` which specifies the Python version which will be
used (defaults to Python 3).

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

### Troubleshooting

#### Running

If you see a message like the following:
```
fatal: [127.0.0.1]: FAILED! => {"changed": false, "module_stderr": "sudo: a password is required\n", "module_stdout": "", "msg": "MODULE FAILURE", "rc": 1}
```
Then you forgot to use `--ask-become-pass`

#### Compilation

You will find the compilation output in `compilation_output.txt` inside the repository
directory. For the record, we had to redirect it to a file because the output surpassed
the limits imposed by Travis.

License
-------

MIT
