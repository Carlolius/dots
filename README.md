# 🟢 🟠 🔴 Dots
This repository contains my personal dotfiles, managed by [Dotdrop][dotdrop].

## Installation
To install the **dots** repository in a new host you need to clone the [Dotdrop][dotdrop] submodule, the easiest way is use the `--recurse-submodules` flag. I install it in a Python virtualenv.
~~~
git clone --recurse-submodules https://github.com/Carlolius/dots.git
virtualenv -p python3 env
echo 'env' > .gitignore
source env/bin/activate
pip install -r dotdrop/requirements.txt
~~~
Then you need to configure your **configure.yaml** file adding a new profile, usually the hostname of the machine, and the dotfiles that you want in your new host.  
Also can install with `./dotdrop.sh -p` and add the profile you want to install (check [configure.yaml](https://github.com/Carlolius/dots/blob/master/config.yaml)).

## Usage
As the submodule is installed in a virtualenv, you need to source the enviroment before using [Dotdrop][dotdrop].
~~~
source env/bin/activate
./dotdrop.sh --help
~~~
To deactivate the enviroment use: `deactivate`
### Help
To check [Dotdrop][dotdrop] help. Here you can find the [documentation](https://dotdrop.readthedocs.io/en/latest/).  
`./dotdrop.sh --help`
### Install
To add new config files to your computer, edit **configure.yaml** with the desired dotfiles and install.  
`./dotdrop.sh install`

### Import
To save new dotfiles to the cloud you need to use import with the name of the file.  
`./dotdrop.sh import ~/path/to/file/`

## Python update
When Python updates it can't find the shared libraries for the virtual env so it's necesary to delete and create a new one.
~~~
rm -r env/ # Path to the virtual env
virtualenv -p python3 env
source env/bin/activate
pip install -r dotdrop/requirements.txt
~~~

[dotdrop]: https://github.com/deadc0de6/dotdrop
