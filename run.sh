#!/usr/bin/bash
# set thing to fail out if command non-zero exit code
# TODO check this
BASE_PATH="$(HOME)"

# update and install system stuff
sudo apt update
sudo apt install sysstat build-essential -y

# verify conda is available, create conda environment

# TODO what command to auto-accept this
conda create -n textgen python=3.10.9
conda activate textgen

pip3 install torch torchvision torchaudio

cd ${BASE_PATH}
git clone https://github.com/oobabooga/text-generation-webui
cd text-generation-webui
pip install -r requirements.txt

# in background, download model
# TODO verify downloads in the right location, suggest using variable for model for testing use smaller model
python download-model.py anon8231489123/vicuna-13b-GPTQ-4bit-128g &

# install prereqs required for LoRa on quantized
#conda activate textgen
# TODO - what command to auto accept this
conda install -c conda-forge cudatoolkit-dev

# install GPTQ extension
mkdir repositories
cd repositories
git clone https://github.com/oobabooga/GPTQ-for-LLaMa.git -b cuda
cd GPTQ-for-LLaMa
python setup_cuda.py install

# install LoRA for GPTQ
cd text-generation-webui/repositories
git clone https://github.com/johnsmith0031/alpaca_lora_4bit
pip install git+https://github.com/sterlind/GPTQ-for-LLaMa.git@lora_4bit

# Done - can start server as background process using monkey patch?
# python server.py --monkey-patch

# Other things - grab training data from somewhere, set up connection information, private keys, firewall ?

#export MYIP=(get ip somehow?)
#sudo -s
#ufw default deny incoming
#ufw default allow outgoing
#ufw allow from ${MYIP} to any port 22
#ufw allow from ${MYIP} to any port 7860
#ufw enable
#exit
