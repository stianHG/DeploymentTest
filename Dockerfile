FROM nginx:alpine
COPY . /usr/share/nginx/html

EXPOSE 8087 
CMD ["nginx", "-g", "daemon off;"]
