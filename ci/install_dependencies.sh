#!/bin/bash

set -ex

# CircleCI comes with pyenv
pyenv install --skip-existing 3.6.2
pyenv global 3.6.2

# beanstalk CLI
pip3 install --upgrade pip
pip3 install awsebcli==3.20.0
