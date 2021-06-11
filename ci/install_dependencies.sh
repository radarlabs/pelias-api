#!/bin/bash

set -ex

# CircleCI comes with pyenv
pyenv local 3.5

# beanstalk CLI
pip3 install -U pip
pip3 install awsebcli==3.17.1
