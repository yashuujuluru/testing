# Use NGINX as the base image
FROM nginx:alpine

# Copy the index.html file from your local directory into the container at /usr/share/nginx/html/
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 to allow incoming traffic
EXPOSE 80

# Command to start NGINX and serve the HTML file
CMD ["nginx", "-g", "daemon off;"]
