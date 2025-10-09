# /frontend/Dockerfile

# ---- Stage 1: Build ----
# Use a Node.js LTS version for the build environment
FROM node:18-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to leverage Docker cache
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Build the application for production
RUN npm run build

# ---- Stage 2: Production ----
# Use a lightweight Nginx image for the production environment
FROM nginx:stable-alpine

# Remove default nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy the custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the built static files from the 'builder' stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80 for the Nginx server
EXPOSE 80

# The default Nginx command will be run, starting the server
CMD ["nginx", "-g", "daemon off;"]
