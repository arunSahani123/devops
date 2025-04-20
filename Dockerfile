# Use an official Node.js image as base
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy all other source code
COPY . .

# Build the React app for production
RUN npm run build

# Use an official Nginx image to serve the build
FROM nginx:alpine

# Copy the build output to Nginx's public directory
COPY --from=0 /app/build /usr/share/nginx/html

# Copy custom Nginx config if needed (optional)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
