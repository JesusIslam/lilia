# Tags: latest, 0.0.1-alpha, v0.0.2-alpha, v0.0.4-alpha
# Buid with: docker build --compress --tag didasy/lilia:v0.0.4-alpha --tag didasy/lilia:latest .
# Run with: docker run -d -p 9000:9000 -v /host/dir:/view -v /host/dir:/security -v /host/dir:/log -v /host/dir:/configuration --name lilia didasy/lilia
# Dev run: docker run -d -p 9000:9000 -v /home/didasy/projects/docker/lilia/log:/log -v /home/didasy/projects/docker/lilia/view:/view -v /home/didasy/projects/docker/lilia/security:/security -v /home/didasy/projects/docker/lilia/configuration:/configuration --name lilia didasy/lilia

FROM mhart/alpine-node:8

WORKDIR /

RUN mkdir /configuration \
    && mkdir /security \
    && mkdir /log \
    && mkdir /view \
    && apk add --no-cache wget \
    && apk add --no-cache tar \
    && wget --no-check-certificate -O /app.tar.gz https://github.com/JesusIslam/lilia/archive/v0.0.4-alpha.tar.gz \
    && tar -zxvf /app.tar.gz \
    && rm /app.tar.gz \
    && mv /lilia-0.0.4-alpha /app \
    && cd /app \
    && npm install --production

VOLUME ["/configuration", "/view", "/log", "/security"]

EXPOSE 9000

WORKDIR /app

ENTRYPOINT ["npm", "start"]
