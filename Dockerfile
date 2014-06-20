FROM ubuntu:14.04

MAINTAINER Andrew Long <aslong87@gmail.com>

RUN useradd -m -s /bin/bash -G root docker
#RUN adduser docker root
#RUN sudo usermod -a -G vboxsf docker
RUN echo "docker:docker" | chpasswd
RUN echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN echo '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /home/docker/.bashrc
RUN echo 'export PATH=$HOME/npm/bin:$PATH' >> /home/docker/.bashrc

ADD . /home/docker/app
WORKDIR /home/docker/app
VOLUME ["/home/docker/app"]

USER docker

ENV DEBIAN_FRONTEND noninteractive

RUN sudo apt-get -y update
RUN sudo apt-get -y install software-properties-common python-software-properties
RUN sudo add-apt-repository -y ppa:chris-lea/node.js
RUN sudo apt-get -y update
RUN sudo apt-get -y install python g++ make nodejs
#RUN sudo apt-get -y install nodejs-legacy
RUN sudo npm config set prefix ~/npm

RUN sudo npm install -g grunt-cli yo
RUN sudo npm install

CMD ["grunt", "start"]

EXPOSE 8000
