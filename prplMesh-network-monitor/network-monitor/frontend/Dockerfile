FROM node:10

EXPOSE 8888

WORKDIR app

COPY package-lock.json /app/
COPY package.json /app/
COPY babel.config.js /app/
COPY vue.config.js /app/

RUN npm install

#ENV NODE_ENV=development


RUN npm install @vue/cli
RUN npm install @vue/cli-service

COPY . .

#RUN echo "SERVER_URL=192.168.1.11:8888"

CMD npm run serve

