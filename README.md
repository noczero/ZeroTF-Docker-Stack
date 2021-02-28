ZeroTF Docker Stack
===============

This repository is use TensorFlow with GPU enabled and Jupyter in docker.
You can add any python library in requirements.txt, and set jupyter token password in .env

## Getting Started

Make sure you have installed docker engine and docker-compose. If not you can refer to the [docker installation guide](https://docs.docker.com/engine/install/) and [docker-compose installation guid](https://docs.docker.com/compose/install/)

### Install NVIDIA Docker support

Make sure you have installed the NVIDIA driver and Docker engine for your Linux distribution Note that you do not need to install the CUDA Toolkit on the host system, but the NVIDIA driver needs to be installed.

For instructions on getting started with the NVIDIA Container Toolkit, refer to the [installation guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker).

### Install The Stack

$ git clone https://github.com/noczero/ZeroTF-Docker-Stack.git ZeroTF
$ cd ZeroTF
$ docker-compose up --build -d

if nothing error, then you can open 127.0.0.1:8888 with your browser then type zeroml as default token. All files including notebooks or any python file are stored in code directory. 

The container won't stop unless you stop it, using [ docker stop <container-id> ].

