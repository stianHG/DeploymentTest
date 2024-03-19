#Stage 1 
FROM --platform=linux/arm64 node:18-alpine as builder
WORKDIR /app
COPY package.json .
COPY yarn.lock .
RUN yarn install
COPY . .
#RUN yarn build

#Stage 2
FROM --platform=linux/arm64 nginx:1.19.0
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
