# Build multistage

# Use the official Node.js image as the base image
FROM node:current-alpine3.18 as build

# Set the working directory inside the container
WORKDIR /app

# Copy the rest of the application code to the working directory
COPY . .

# Install the dependencies
RUN npm install && npm install -g typescript

# Build the React application
RUN npm run build

# Use an official Nginx image to serve the React app
FROM nginx:alpine3.18-slim

# Copy the built React app from the previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
