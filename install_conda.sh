#!/usr/bin/env bash
set -e

curl https://repo.anaconda.com/miniconda/Miniconda3-py310_23.3.1-0-Linux-x86_64.sh -o miniconda.sh
bash miniconda.sh -b
~/miniconda3/bin/conda init bash

# need to re-source bashrc