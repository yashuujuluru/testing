# Use NGINX as the base image
FROM nginx:alpine

# Copy the custom Nginx configuration file
COPY default.conf /etc/nginx/conf.d/default.conf

# Copy the HTML files to the Nginx HTML directory
COPY index.html /usr/share/nginx/html/

# Expose port 
EXPOSE 8080

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
