# Use Ubuntu 18.04 as the base image 
# instructs Docker to use offical image from Docker Hub
FROM ubuntu:18.04

# Install basic dependencies and python 3.6
# Install a compatible version of protobuf for Python 3.6
# zlib and libjpeg needed for matplotlib
RUN apt-get update && \
    apt-get install -y \
    python3.6 \
    python3.6-dev \
    python3-pip \
    software-properties-common \
    git \
    zlib1g-dev \
    libjpeg-dev \ 
    && apt-get clean

    

# Set python 3.7 to default 
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1
RUN python --version  # Should output Python 3.6.x

# Install pip for Python 3.6 explicitly (if not installed)
RUN apt-get install -y python3-pip 

# Install python packages/libraries 
# Install a compatible version of protobuf
# Install individual Python libraries
RUN pip3 install \ 
    torch==1.6.0 \
    protobuf==3.19.6 \
    tensorboard==2.5.0 \
    gym==0.19.0 \
    matplotlib \
    tqdm \
    seaborn \
    mujoco-py>=1.5

RUN apt-get update && apt-get install -y \
    wget \
    tar && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.mujoco/mujoco210 && \
    wget https://mujoco.org/download/mujoco210-linux-x86_64.tar.gz && \
    tar -zxvf mujoco210-linux-x86_64.tar.gz -C /root/.mujoco/mujoco210 && \
    rm mujoco210-linux-x86_64.tar.gz 

RUN apt-get update && apt-get install -y libosmesa6-dev libgl1-mesa-glx libglfw3

RUN  pip3 install "cython<3"

RUN apt-get update && apt-get install patchelf

WORKDIR /app

# Copy your project files into the container (if applicable)
# COPY . /app