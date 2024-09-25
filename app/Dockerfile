FROM alpine:latest

RUN apk add --no-cache nodejs npm curl

WORKDIR /app
COPY package.json /app
RUN npm install

COPY . /app

EXPOSE 80
CMD ["npm", "start"]
