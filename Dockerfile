FROM node:0.10.28

MAINTAINER Andrew Long <aslong87@gmail.com>

ADD . /usr/src/app
WORKDIR /usr/src/app

RUN npm install -g grunt-cli

# Install npm dependencies
RUN npm install

#EXPOSE 8000

#CMD [ "grunt", "start" ]
