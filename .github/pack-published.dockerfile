#Stage 1 
FROM node:18-alpine as builder
WORKDIR /app
COPY package.json .
COPY yarn.lock .
RUN yarn install
COPY . .
#RUN yarn build

#Stage 2
FROM nginx:1.19.0
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]

#FROM --platform=linux/amd64 nginxinc/nginx-unprivileged:stable-alpine
#ADD build /usr/share/nginx/html
#USER root
#RUN apk add --no-cache bash
#ADD .github/default.conf.template /etc/nginx/templates/default.conf.template
#ADD .github/assign-environment.sh /docker-entrypoint.d/5-assign-environment.sh
#ADD env-config.js /usr/share/nginx/html/env-config.js
#RUN \
#    chown nginx:nginx /usr/share/nginx/html/env-config.js /usr/share/nginx/html/env-config.js && \
#    chmod +x /docker-entrypoint.d/5-assign-environment.sh
#USER nginx
