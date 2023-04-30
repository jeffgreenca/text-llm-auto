#!/usr/bin/env bash
set -e
BASE_PATH=${HOME}
REPO=${HOME}/text-generation-webui
CONDA_CMD="conda run -n textgen"

# update and install system stuff
sudo apt-get update && sudo apt-get install -y ansible sysstat build-essential

# create conda env
conda create --yes -n textgen python=3.10.9

# TODO -> conda run -n textgen bash <script part 2>
${CONDA_CMD} pip3 install torch torchvision torchaudio

# clone repo and install requirements
git clone https://github.com/oobabooga/text-generation-webui ${REPO} && cd ${REPO}
${CONDA_CMD} pip install -r requirements.txt

# in background, download model
cd ${REPO} 
${CONDA_CMD} python download-model.py anon8231489123/vicuna-13b-GPTQ-4bit-128g &

# quantization support
#conda activate textgen
${CONDA_CMD} conda install --yes -c conda-forge cudatoolkit-dev

# GPTQ extension
mkdir -p ${REPO}/repositories && cd ${REPO}/repositories
git clone https://github.com/oobabooga/GPTQ-for-LLaMa.git -b cuda
cd GPTQ-for-LLaMa 
${CONDA_CMD} python setup_cuda.py install

# LoRA for GPTQ extension
mkdir -p ${REPO}/repositories && cd ${REPO}/repositories
git clone https://github.com/johnsmith0031/alpaca_lora_4bit

${CONDA_CMD} pip install git+https://github.com/sterlind/GPTQ-for-LLaMa.git@lora_4bit

# wait for background process to complete
wait

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
