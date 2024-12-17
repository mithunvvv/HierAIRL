# Use Ubuntu 18.04 as the base image 
# instructs Docker to use offical image from Docker Hub
FROM ubuntu:18.04

# Install basic dependencies and python 3.6
# Install a compatible version of protobuf for Python 3.6
# zlib and libjpeg needed for matplotlib
RUN apt-get update && \
    apt-get install -y \
    python3.8 \
    python3.8-dev \
    python3-pip \
    software-properties-common \
    git \
    zlib1g-dev \
    libjpeg-dev \ 
    && apt-get clean

    

# Set python 3.7 to default 
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1
RUN python --version  # Should output Python 3.8.x

RUN apt-get update && \
    apt-get install -y \
    curl 


# Install pip for Python 3.6 explicitly (if not installed)
RUN apt-get update && apt-get install -y python3.8-distutils
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3.8 get-pip.py
RUN ln -sf /usr/bin/pip3.8 /usr/bin/pip
# RUN ln -sf /usr/bin/pip3.8 /usr/bin/pip

# Install python packages/libraries 
# Install a compatible version of protobuf
# Install individual Python libraries
RUN pip install \ 
    torch==1.13.1 \
    protobuf==3.19.6 \
    tensorboard==2.5.0 

RUN pip install gym
RUN pip install matplotlib 
RUN pip install tqdm 
RUN pip install seaborn 
RUN pip install mujoco-py>=1.5

RUN apt-get update && apt-get install -y \
    wget \
    tar && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.mujoco/ && \
    wget https://mujoco.org/download/mujoco210-linux-x86_64.tar.gz && \
    tar -zxvf mujoco210-linux-x86_64.tar.gz -C /root/.mujoco/ && \
    rm mujoco210-linux-x86_64.tar.gz 

RUN apt-get update && apt-get install -y libosmesa6-dev libgl1-mesa-glx libglfw3
RUN ln -s /usr/lib/x86_64-linux-gnu/libGL.so.1 /usr/lib/x86_64-linux-gnu/libGL.so 

RUN  pip3 install "cython<3"
# RUN apt-get install python3-venv

RUN apt-get update && apt-get install patchelf

RUN pip install setuptools==65.5.0 pip==21
RUN pip install gym==0.19.0
RUN pip install --upgrade tensorboard 
# make compatible  with numpy version

WORKDIR /app
RUN apt-get update \
    && apt-get install -y \
    vim nano
    
RUN pip install wandb
# Copy your project files into the container (if applicable)
# COPY . /app

# Install specific versions for rl_zoo3 and panda-gym for consistency
RUN pip install panda-gym==3.0.7 rl_zoo3==2.4.0
WORKDIR /home

COPY functional.py /usr/local/lib/python3.8/dist-packages/torch/nn/functional.py