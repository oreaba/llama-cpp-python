

# First: Install Visual studion & check version of c++ compiler
cl
Microsoft (R) C/C++ Optimizing Compiler Version 19.44.35208 for x86
where cl
C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC

# Second: Install Cuda Toolkit & check the version of cuda compiler
nvcc --version
Cuda compilation tools, release 12.9, V12.9.41

# cleat temp - important i you see errors when compiling cython
%TMP%

# compile the llama cpp python given your GPU compute capability
pip cache purge
py -3.11 -m venv .venv
.venv\Scripts\activate
python -m pip install --upgrade pip setuptools wheel

# specify temp path for build and build arguments
set TEMP=D:\temp
set TMP=D:\temp

set FORCE_CMAKE=1
set GGML_CUDA=1
set CMAKE_ARGS=-DGGML_CUDA=on -DCMAKE_CUDA_ARCHITECTURES=86;89;120

# To install the normal version: "llama-cpp-python"
pip install --verbose --force-reinstall --no-binary :all: llama-cpp-python

# To install the server version: "llama-cpp-python[server]"
# 1. install rust with cargo
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc/rustup-init.exe
# 2. compile the server version & deps
# pip install --verbose --force-reinstall --no-binary :all: llama-cpp-python[server]

# save the comiled binary as wheel files
mkdir wheel-prebuilt && cd wheel-prebuilt
pip wheel llama-cpp-python

# test model with built in server (if installed server version)
# CPU:
python -m llama_cpp.server --model models/7B/llama-2-7b.Q2_K.gguf --chat_format chatml
# GPU:
python -m llama_cpp.server --model models/7B/llama-2-7b.Q2_K.gguf --chat_format chatml  --main_gpu 0 --n_gpu_layers 32
# Documentation:
http://localhost:8000/docs
--------------------------------------------------------------------------------------------------------------------------------
compute capability      Target GPU      CUDA toolkit            Required MSVC Version                           VS
120                     RTX 5090        min 12.5 - 12.9         MSVS 2022 (19.44)                               VS 2022 (≥17.7)    
89                      RTX 4090        min 11.8 - 12.2+        MSVC 2019 (≥16.11) or VS 2022 (17.4–17.6)       VS 2022 17.6
86                      RTX 3090        min 11.1 - 11.8+        MSVC 2019 (16.9 or newer)                       VS 2019 16.11 or VS 2022
--------------------------------------------------------------------------------------------------------------------------------
# Note 1: to create a wheel that works on all the 3 GPU cards above
to include all, but bigger wheel:
set CMAKE_ARGS=-DGGML_CUDA=on -DCMAKE_CUDA_ARCHITECTURES=86;89;120
# ------------------------------------------------------------------------------------------------------------------------------
# Note 2: cuda driver vs cuda version vs cuda toolkit
- cuda driver: is the graphics card driver - check in cmd using: nvidia-smi  
- Driver Version: 576.52 (this is the driver version)
- CUDA Version: 12.9 (this is the cuda run time version - maximum CUDA runtime version that your driver supports)

- cuda toolkit: full development environment for building CUDA apps, including the nvidia complier - check in cmd using: nvcc --version
- Cuda compilation tools, release 12.9, V12.9.41

- to compile an application using cuda toolkit 12.9 this will require cuda runtime 12.9 to exist on the target machine.
# ------------------------------------------------------------------------------------------------------------------------------
# note 3: source: (with guide to buidl & test)
git clone https://github.com/abetlen/llama-cpp-python
# ------------------------------------------------------------------------------------------------------------------------------
# note 4: prebuilt wheel with cuda
pip install llama-cpp-python==0.3.4 --extra-index-url https://abetlen.github.io/llama-cpp-python/whl/cu121

pip install --no-cache-dir llama-cpp-python==0.2.90 --extra-index-url https://abetlen.github.io/llama-cpp-python/whl/cu123