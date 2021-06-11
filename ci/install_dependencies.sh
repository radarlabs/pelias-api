#!/bin/bash

set -ex

# CircleCI comes with pyenv
pyenv install --skip-existing 3.5.2
pyenv global 3.5.2

# beanstalk CLI
pip3 install -U pip3
pip3 install awsebcli==3.20.0
