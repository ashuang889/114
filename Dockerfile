FROM node:20

RUN apt-get update && apt-get install -y build-essential libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev

RUN npm install -g babel-cli

RUN mkdir -p /opt/data /opt/server /opt/web /opt/logs /opt/docker

WORKDIR /opt/docker
ADD docker/docker-entrypoint.sh /opt/docker

WORKDIR /opt/client
ADD client /opt/client
RUN npm install
RUN npm run build

WORKDIR /opt/server
ADD server /opt/server
RUN npm install

EXPOSE 9898

ENTRYPOINT ["/opt/docker/docker-entrypoint.sh"]
