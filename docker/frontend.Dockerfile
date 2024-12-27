# Stage 1: Build the Ember.js application
FROM node:14-alpine AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Ember.js application for production
RUN npm run build --environment=production

# Stage 2: Serve the application using a lightweight server
FROM nginx:alpine

# Copy the built Ember.js application from the build stage
COPY --from=build /app/dist /usr/share/nginx/html

# Copy a custom Nginx configuration file, if necessary
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose the port Nginx will use
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
