FROM node:current-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    cmake \
    build-essential \
    pkg-config \
    git \
    uuid-dev \
    openjdk-11-jre

# Set environment variables
ENV PROGRAM_ROOT /server/server/programs

# Set working directory
WORKDIR /server

# Copy source code
COPY . .

# Change working directory to HOME and install ANTLR
WORKDIR /root
RUN mkdir antlr && cd antlr\
    sudo git clone https://github.com/antlr/antlr4.git

    # cd antlr4\
    # git checkout 4.10.1\
    # mkdir antlr4-build && cd antlr4-build\
    # mkdir ../../antlr4-install\
    # cmake ../runtime/Cpp/ \
    # -DCMAKE_BUILD_TYPE=RELEASE \
    # -DCMAKE_INSTALL_PREFIX="/root/antlr/antlr4-install"\
    # export ANTLR_INS="/root/antlr/antlr4-install"  

# Set working directory to server
WORKDIR /server