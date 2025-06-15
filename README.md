"# llama-cpp-python" 

Installation:
pip install llama_cpp_python-0.3.9-cp311-cp311-win_amd64.whl
or the server variant:
pip install -r requirements.txt

# Check GPU Support
import llama_cpp
# Check cuBLAS support
compiled_with_cublas = llama_cpp.llama_cpp.llama_supports_gpu_offload()
print("✔️ Compiled with cuBLAS:" if compiled_with_cublas else "❌ cuBLAS not available")
"# llama-cpp-python" 
