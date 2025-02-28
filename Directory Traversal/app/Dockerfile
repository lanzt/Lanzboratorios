FROM node:22

WORKDIR /opt/path-traversal

COPY package*.json .
RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "src/index.js"]
