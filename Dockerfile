FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

COPY helpers.mjs .
COPY app.mjs .

EXPOSE 3000

CMD [ "node", "app.mjs" ]
