FROM node:18-alpine as build

WORKDIR /app

COPY package*.json ./

#RUN apk --no-cache --virtual build-dependencies add \
#  python \
#  make \
#  g++
RUN yarn install

COPY . .

# React app for production
RUN yarn run build

# Using Nginx for serving static files
FROM nginx:alpine

#COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

# Copying the built files from the previous stage
COPY --from=build /app/build /usr/share/nginx/html

#CMD ["nginx", "-g", "daemon off;"]
