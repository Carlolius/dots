# Dots
This repository contains my personal dotfiles, and other different configurations that are useful.
I use [Dotdrop][dotdrop] to help having same dotfiles for different hosts.

## Installation
To install the **dots** repository in a new host you need to clone the [Dotdrop][dotdrop] submodule, the easiest way is use the `--recurse-submodules` flag. The best way is to use a Python virtualenv.
~~~
git clone --recursive-submodules https://github.com/Carlolius/dots.git
virtualenv -p python3 env
source env/bin/activate
pip install -r dotdrop/requirements.txt
~~~
Then you need to configure your **configure.yaml** file adding the profile, usually the hostname and the dotfiles that you want in your new host.

## Usage
As the submodule is installed in a virtualenv, you need to source the enviroment before using [Dotdrop][dotdrop].
~~~
source env/bin/activate
./dotdrop.sh --help
~~~
To deactivate the enviroment use: `deactivate`

## To do
* Add more dotfiles
* How to use dotdrop

[dotdrop]: https://github.com/deadc0de6/dotdrop
