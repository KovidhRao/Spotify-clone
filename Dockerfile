# Base image: Ultra-lightweight web server
FROM nginx:alpine

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy your Spotify clone files into Nginx public directory
COPY . /usr/share/nginx/html/

# Copy home.html to index.html so Nginx serves it by default at http://localhost:8080
RUN cp /usr/share/nginx/html/home.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
