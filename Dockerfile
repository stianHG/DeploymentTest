FROM nginx:alpine
COPY index.html /usr/share/nginx/html

EXPOSE 8087 
CMD ["nginx", "-g", "daemon off;"]
