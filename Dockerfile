FROM alpine:3.7
MAINTAINER reach4avik@yahoo.com
LABEL maintainer="avikdatta"

ENTRYPOINT []

ENV NB_USER vmuser
ENV NB_GROUP vmuser
ENV NB_UID 1000

USER root
WORKDIR /root/

RUN echo "http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/v3.7/main" >> /etc/apk/repositories; \
    echo "http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/v3.7/community" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    echo "http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/edge/testing" >> /etc/apk/repositories

RUN apk update; \
    apk add --upgrade apk-tools; \
    apk --update add --no-cache --force-broken-world \
        gcc \
        g++ \
        python3 \
        python3-dev \
        pip3 \
        .build-deps \
        build-base \
        libbz2-dev \
        libopenblas-dev \
        libreadline6 \
        libreadline6-dev \
        libsqlite3-dev \
        libssl-dev \
        locales \
        texlive-xetex \
        zlib1g-dev 
      
RUN apk add --no-cache --force-broken-world \
    git                    \
    locales                \
    curl                   \
    wget                   \
    make                   \
    g++                    \
    patch                  \
    build-essential        \
    libssl-dev             \
    zlib1g-dev             \
    libbz2-dev             \
    libsqlite3-dev         \
    libssl-dev             \
    libreadline6-dev       \
    libreadline6           \
    libopenblas-dev        \
    texlive-xetex          \
    openssl                \
    ca-certificates      

RUN pip install --no-cache-dir -q jupyter jupyterlab

USER $NB_USER
WORKDIR /home/$NB_USER

RUN mkdir -p /home/$NB_USER/.jupyter
RUN echo "c.NotebookApp.password = u'sha1:c991cd11a7cc:f4c7bd274c69271f7333ea24bfe85103566464de'" > /home/$NB_USER/.jupyter/jupyter_notebook_config.py

EXPOSE 8888
CMD ["jupyter","lab","--ip=0.0.0.0","--port=8888","--no-browser"]