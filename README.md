SourcePackageManager
====================

.. A tiny embeddable package manager library and application.  
SourcePackageManager, hereafter refered to as 'SPM', is designed to be used in the same way as RVM regarding paths, and in the same way as RubyGems in terms of managing packages, except with support for per-project dependencies, and not just system-wide and per-user packages. In fact, system-wide packages are not really handled by SPM, but instead left for your local system package manager.  
  
To use this system, simply run

    git clone https://github.com/mastersrp/SourcePackageManager.git ~/.spm

Then follow the instructions in the Compiling section.
  
Requirements
------------

Even though SPM is rather small, it does have some dependencies.

* bash
* tar
* bzip2
* base64
* gcc 4.6.3
* lua 5.2.1 (for running the bootstrapping process)
* git (for pulling down dependencies)
* CMake (for building libgit2)

Compiling
---------

Currently, SPM is only supported for compilation on 32bit and 64bit architectures of GNU/Linux systems. Other systems may work out of the box, but have not been tested.  
Feel free to open issues with patches if you got it working on your platform.  
  
Compiling SPM is simply done by running

    ./bootstrap.sh

In the root of the SPM directory.  
The bootstrap script also creates a bin/spm script which contain the required binaries and scripts to run. This script can also be shipped alongside your projects. Please note that binaries are NOT platform-agnostic, and as such SPM built on 64bit platform will NOT run on a 32bit platform.    
  
Alternatively you can try to run the lite spm.sh script which is the lite version of SPM copied from a successful build from build/scripts/spm.sh to spm.sh.  
First, configure the system:
  
    ./spm.sh configure

Then check the configuration in build/tup.config and make sure that everything is set to values that you're okay with.  
To build a lite SPM package, simply change the BUILD\_TYPE configuration from 'standalone' to 'lite' and the build files will do the rest.  
Then, to build the system, simply run

    ./spm.sh build

This will build the entire system and all dependencies.
Installation
------------

There's no installation step. The file 'bin/spm' is really all there is required. Put it whereever you want, or just run

    source scripts/spm

to prepend the bin directory to your PATH variable.  
Note that this only works for the current terminal session. For permanent use, you should add

    source [spm_clone_directory]/scripts/spm

To your bashrc or zshrc file.
