FROM python:3

LABEL maintainer="Leonardo Menezes"

USER root

# Install Node and Allure-Commandline

RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -
RUN apt-get install -y build-essential nodejs
RUN npm install -g allure-commandline

# Install java and set JAVA_HOME

RUN apt-get install -y default-jdk
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/

# User configuration

RUN useradd -ms /bin/bash pyenv-user

USER pyenv-user

WORKDIR /home/pyenv-user

USER pyenv-user

# Pyenv installation and configuration

RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv

ENV HOME /home/pyenv-user
ENV PYENV_ROOT "$HOME/.pyenv"
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# Pipenv instalation

RUN pip install --user pipenv

RUN pyenv install 3.7.6
RUN pyenv global 3.7.6
RUN pyenv rehash
