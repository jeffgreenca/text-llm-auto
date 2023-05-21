# text-llm-auto

Tailored auto-up config for a cloud-based VM that would be used for inference or LoRa training using oogabooga.

At first, this is just a script that can be cloned and run. 

## Usage

### With Conda Pre-Installed, Directly Run
```
curl -sSL https://raw.githubusercontent.com/jeffgreenca/text-llm-auto/main/setup.sh | bash
```

### With Conda Pre-Installed
```
git clone https://github.com/jeffgreenca/text-llm-auto
cd text-llm-auto
bash setup.sh
```

### Complete Install including Miniconda
```
git clone https://github.com/jeffgreenca/text-llm-auto
cd text-llm-auto
bash install_conda.sh
bash setup.sh
```