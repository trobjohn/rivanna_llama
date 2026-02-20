# rivanna_llama
Build a local LLM instance on Rivanna HPC

### To build:

1. Clone this repo to your home or scratch directory
2. At the command line, run `bash ./bin/probe.sh` . This should detect and describe the GPU and cmake toolchain for building llama.cpp.
3. At the command line, run `bash ./bin/build_llama.sh`. This will clone a fork of the llama.cpp project from my educational github account and build it for you to run locally. When I built it on the scratch drive, it took about 25 minutes. Once this step concludes and llama-cli and llama-server are built, you don't have to do this again.
4. At the command line, run `bash ./bin/get_model.sh`. This will download a gguf model file from huggingface.com; in this case, it's Mistral-7B-Instruct-v0.3.Q4_K_M.gguf, a high quality model of modest size for basic tasks. 
5. At the command line, run `bash ./bin/run_chat.sh`. This will launch a llama.cpp server, load Mistral, and begin a command-line chat session. The initial prompt is, "Explain, in plain language, what an LLM is and what it is not," to which it will respond. After that, you can chat directly with the LLM. For example, ask, "Can you write a simple template for doing PCA in Scikit-Learn?" (Somewhat amusingly, my first run of this provided the answer: " An LLM, or Master of Laws, is an advanced, postgraduate academic degree in law. It's primarily pursued by students who already hold a first degree in law (such as a JD in the United States, a Bachelor of Laws or LLB in many common law countries, or a Diploma de Estudios Superiores en Derecho in Spain and Latin America)." which... is true.)

For the first session on Rivanna, I recommend:
    
- Use VS Code Server
- Instructional Partition
- 1-2 hours
- 2-3 cores
- 64GB RAM (building llama.cpp can be expensive; after it's built, you can scale this back to 32GB RAM)
- SCRATCH should be more performant than HOME, but SCRATCH gets wiped every 90 days
- Indicate you want 1 GPU for the session

### To run:

Once the initial build and model download are done, you can run llama.cpp in chat mode again by skipping to `bash ./bin/run_chat.sh`. This initiates a CLI chat session with Mistral (or whatever model).

That will quickly become limiting for integration with other code and research purposes. The more flexible -- but costly -- option is llama.cpp in server mode.

At the command line, run `bash .bin/run_server.sh`. This spins up a localhost running llama.cpp on port 8000. T

To check that the server is running, you can type `curl http://localhost:8000/health`. To send a message and get a reply, run `./bin/check_server.sh`. Once that script runs, further programming can be done in Python using `requests`, `urllib`, or the OpenAI Python client (the OAI Python package doesn't necessarily involve ChatGPT; you can point it directly at this llama.cpp server and use the same API. This also accelerates development of applications that do use ChatGPT, but you don't want to waste tokens in development). 
