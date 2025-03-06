# Base image
FROM nginx:alpine

# Set working directory
WORKDIR /usr/share/nginx/html

# Copy application files into Nginx directory
COPY . .

# Expose application port
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]