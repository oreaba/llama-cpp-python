
# llama-cpp-python CUDA Build Guide

## 1. Install Visual Studio & Check C++ Compiler Version

```bash
cl
# Output example:
# Microsoft (R) C/C++ Optimizing Compiler Version 19.44.35208 for x86

where cl
# Example path:
# C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC
```

---

## 2. Install CUDA Toolkit & Check Version

```bash
nvcc --version
# Output example:
# Cuda compilation tools, release 12.9, V12.9.41
```

---

## 3. Clear Temp (Important if you see errors when compiling Cython)

```bash
%TMP%
```

---

## 4. Compile `llama-cpp-python` with CUDA (Given GPU Compute Capability)

```bash
pip cache purge
py -3.11 -m venv .venv
.venv\Scripts\activate
python -m pip install --upgrade pip setuptools wheel
```

Set temp path for build and configure build arguments:

```bash
set TEMP=D:\temp
set TMP=D:\temp

set FORCE_CMAKE=1
set GGML_CUDA=1
set CMAKE_ARGS=-DGGML_CUDA=on -DCMAKE_CUDA_ARCHITECTURES=86;89;120
```

---

## 5. Install the Package

### Normal Version:

```bash
pip install --verbose --force-reinstall --no-binary :all: llama-cpp-python
```

### Server Version:

1. Install Rust:
   - via terminal:  
     ```bash
     curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
     ```
   - or download from:  
     [Rust for Windows (MSVC)](https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc/rustup-init.exe)

2. Compile:

```bash
pip install --verbose --force-reinstall --no-binary :all: llama-cpp-python[server]
```

---

## 6. Save Compiled Wheel

```bash
mkdir wheel-prebuilt && cd wheel-prebuilt
pip wheel llama-cpp-python
```

---

## 7. Test Model with Built-in Server

### CPU:
```bash
python -m llama_cpp.server --model models/7B/llama-2-7b.Q2_K.gguf --chat_format chatml
```

### GPU:
```bash
python -m llama_cpp.server --model models/7B/llama-2-7b.Q2_K.gguf --chat_format chatml --main_gpu 0 --n_gpu_layers 32
```

Docs: [http://localhost:8000/docs](http://localhost:8000/docs)

---

## 8. Compute Capability Table

| Compute | Target GPU | CUDA Toolkit | MSVC Version | Visual Studio |
|---------|-------------|----------------|----------------|----------------|
| 120     | RTX 5090    | 12.5–12.9       | MSVC 2022 (19.44) | VS 2022 (≥17.7) |
| 89      | RTX 4090    | 11.8–12.2+      | MSVC 2019 (≥16.11) / VS 2022 (17.4–17.6) | VS 2022 17.6 |
| 86      | RTX 3090    | 11.1–11.8+      | MSVC 2019 (16.9+) | VS 2019 16.11 / VS 2022 |

---

## 9. Notes

### Note 1: Universal Wheel (Supports All GPUs Above)

```bash
set CMAKE_ARGS=-DGGML_CUDA=on -DCMAKE_CUDA_ARCHITECTURES=86;89;120
```

### Note 2: CUDA Driver vs CUDA Runtime vs Toolkit

- **CUDA Driver**: GPU driver (e.g. check via `nvidia-smi`)
  - Example:
    ```
    Driver Version: 576.52
    CUDA Version: 12.9
    ```
- **CUDA Runtime**: Determined by the driver (`nvidia-smi`).
- **CUDA Toolkit**: Dev toolchain (`nvcc --version`)
  - Example:
    ```
    Cuda compilation tools, release 12.9, V12.9.41
    ```

> To run the compiled app, the target system must have the matching CUDA **runtime** version.

### Note 3: Source Code

```bash
git clone https://github.com/abetlen/llama-cpp-python
```

### Note 4: Prebuilt Wheels with CUDA Support

```bash
pip install llama-cpp-python==0.3.4 --extra-index-url https://abetlen.github.io/llama-cpp-python/whl/cu121

pip install --no-cache-dir llama-cpp-python==0.2.90 --extra-index-url https://abetlen.github.io/llama-cpp-python/whl/cu123
```
