if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Set CUDA and cuDNN paths
set -gx PATH /usr/lib/cuda/bin $PATH
set -gx LD_LIBRARY_PATH /usr/lib/cuda/lib64 $LD_LIBRARY_PATH
set -gx CUDNN_INCLUDE_DIR /usr/lib/cuda/include
set -gx CUDNN_LIB_DIR /usr/lib/cuda/lib64
set -x XLA_FLAGS "--xla_gpu_cuda_data_dir=/usr/lib/cuda"

set -g fish_greeting ""
set -Ux EDITOR nvim

alias gs="git status"
alias v="nvim"
alias a-uno-compile="arduino-cli compile --fqbn arduino:avr:uno"
alias a-uno-upload="arduino-cli upload -p /dev/ttyUSB0 --fqbn arduino:avr:uno"
