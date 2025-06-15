[linkedin post] (https://www.linkedin.com/feed/update/urn:li:activity:7339983675251437569/)

# 🚀 Running LLaMA.cpp Python with GPU Acceleration – Even on the Latest NVIDIA Blackwell (RTX 5090, B200!)

We all know that `llama-cpp-python` supports **CPU inference** out of the box.  
But can it support **GPU inference**, especially on the latest **NVIDIA Blackwell architecture** (e.g., RTX 5090, B200)?

👉 **Short answer: Yes!**

---

## 🔧 How?

To run `llama-cpp-python` with GPU support, you need:

- ✅ The latest version (`v0.3.9`) of `llama-cpp-python` (standard or server variant)
- ✅ A build targeting your GPU’s compute architecture: `sm_86`, `sm_89`, `sm_90`, `sm_100`, or `sm_120` (for Blackwell)
- ✅ Your OS (e.g., Windows 11, RHEL 8)
- ✅ Your Python version (e.g., Python 3.11)

Unfortunately, **prebuilt binaries with GPU support** for the latest setups are hard to find.  
Most available binaries are outdated (e.g., `v0.3.2` or `v0.3.4`) and don’t support modern GPUs — especially Blackwell.

---

## 💡 That’s why I compiled `llama-cpp-python` **from source**, targeting:

- 🆕 `v0.3.9` (the latest release)
- 🧠 **NVIDIA Blackwell architecture** (Compute Capability 12.0)
- 💻 Windows 11
- 🐍 Python 3.11

### 📦 You can install it via:

```bash
pip install llama_cpp_python-0.3.9-cp311-cp311-win_amd64.whl


for the server variant:
pip install -r requirements.txt

# Check GPU acceleration support
import llama_cpp
compiled_with_cublas = llama_cpp.llama_cpp.llama_supports_gpu_offload()
print("✔️ Compiled with cuBLAS:" if compiled_with_cublas else "❌ cuBLAS not available")



