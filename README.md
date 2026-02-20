# rivanna_llama
Build a local LLM instance on Rivanna HPC

1. Clone this repo to your home or scratch directory
2. At the command line, run `bash ./bin/probe.sh` . This should detect and describe the GPU and cmake toolchain for building llama.cpp.
3. At the command line, run `bash ./bin/build_llama.sh`. This will clone a fork of the llama.cpp project from my educational github account and build it for you to run locally.
4. At the command line, run `bash ./bin/get_model.sh`. This will download a gguf model file from huggingface.com; in this case, it's Mistral-7B-Instruct-v0.3.Q4_K_M.gguf, a high quality model of modest size for basic tasks. 
5. At the command line, run `bash .h/run_chat.sh`. This will launch a llama.cpp server, load Mistral, and begin a command-line chat session. The initial prompt is, "Explain, in plain language, what an LLM is and what it is not," to which it will respond. After that, you can chat directly with the LLM. For example, ask, "Can you write a simple template for doing PCA in Scikit-Learn?"

For the first session on Rivanna, I recommend:
    
- Use VS Code Server
- Instructional Partition
- 1-2 hours
- 2-3 cores
- 64GB RAM (building llama.cpp can be expensive; after it's built, you can scale this back to 32GB RAM)
- SCRATCH should be more performant than HOME, but SCRATCH gets wiped every 90 days
- Indicate you want 1 GPU for the session


