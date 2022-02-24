#/bin/bash
export DISPLAY=your.ip.address:0
module load cuda/10.2 cudnn/10.2
module load anaconda
conda activate pytorch1.10
export TERM=xterm-256color 
export XDG_RUNTIME_DIR=
export JUPYTER_ALLOW_INSECURE_WRITES=true 
cd ~/your/code/folder
ipython