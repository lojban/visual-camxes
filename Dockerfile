FROM docker.io/library/python:2.7

RUN apt-get update
RUN apt-get install -y default-jre-headless

# User setup
ARG CX_USERID
ARG CX_GROUPID

COPY sudoers /etc/sudoers.d/sampre_cx

RUN groupadd -g ${CX_GROUPID} sampre_cx
RUN useradd -p '**LOCKED**' -g sampre_cx -u ${CX_USERID} -m sampre_cx

# Download and install all the python bits
RuN pip install --upgrade pip
RUN pip install Flask-Genshi gunicorn==19.10.0 Werkzeug==0.16.1
RUN pip install --upgrade git+https://github.com/lojban/python-camxes.git

# Basic user config
USER sampre_cx
ENV TZ America/Los_Angeles
ENV LANG en_US.UTF-8
ENV HOME /home/sampre_cx
RUN mkdir /home/sampre_cx/visual_camxes
WORKDIR /home/sampre_cx/visual_camxes
