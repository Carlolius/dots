# Dots
This repository contains my personal dotfiles, and other different configurations that are useful.
I use [Dotdrop][dotdrop] to help having same dotfiles for different hosts.

## Installation
To install the **dots** repository in a new host you need to clone the [Dotdrop][dotdrop] submodule, the easiest way is use the `--recurse-submodules` flag.
~~~
git clone --recursive-submodules https://github.com/Carlolius/dots.git
~~~

## Usage
As the submodule is installed in a virtualenv, you need to source the enviroment before using [Dotdrop][dotdrop].
~~~
source env/bin/activate
./dotdrop.sh --help
~~~
To deactivate the enviroment use: `deactivate`

## To do
* Add more dotfiles
* Cheatsheet for vim and i3
* How to use dotdrop

[dotdrop]: https://github.com/deadc0de6/dotdrop
