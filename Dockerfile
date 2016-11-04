FROM ubuntu
MAINTAINER Tomás Pérez <t@0x101.com>
ARG GITHUB_TOKEN
ARG GITHUB_USERNAME
ARG GITHUB_EMAIL
ARG GITHUB_NAME

# Install required packages
RUN apt-get update && apt-get install -y curl sudo apt-utils && rm -rf /var/lib/apt/lists/*

RUN sudo apt-get update
RUN apt-get install -y git

RUN apt-get update && apt-get install -y \
  curl \
  bash-completion \
  keychain \
  tmux \
  tmuxinator \
  git \
  vim \
  vim-pathogen \
  cmake \
  exuberant-ctags \
  silversearcher-ag \
  build-essential \
  python-pip \
  python-dev

# Setup node.js
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get install -y nodejs

# Add the user
RUN useradd -ms /bin/bash t
RUN adduser t sudo
RUN echo "t ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
USER t
WORKDIR /home/t

# Configure git
RUN git config --global user.email $GITHUB_EMAIL
RUN git config --global user.name $GITHUB_NAME
RUN git config --global github.token $GITHUB_TOKEN
RUN git config --global github.user $GITHUB_USERNAME
RUN git config --global credential.helper 'cache --timeout=3600'
RUN git config --global url."https://${GITHUB_TOKEN}:x-oauth-basic@github.com/".insteadOf ssh://git@github.com/
RUN git config --add --global url."https://${GITHUB_TOKEN}:x-oauth-basic@github.com/".insteadOf git@github.com:

# Configure HOME dotfiles
RUN git clone --depth 1 --single-branch git@github.com:tomasperezv/configuration.git
RUN cd configuration && sh init.sh

# Configure VIM
RUN git clone --depth 1 --single-branch https://github.com/tomasperezv/vim-is-great.git
RUN cd vim-is-great && sh setup.sh && sh update-home-vim.sh
RUN ln -s /home/t/vim /home/t/.vim

# Clone my-dev-env
RUN git clone --depth 1 --single-branch https://github.com/tomasperezv/my-dev-env.git

ENTRYPOINT tmuxinator start dev-base
