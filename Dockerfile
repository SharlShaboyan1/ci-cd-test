# Use an official Node.js runtime as a parent image
FROM node:20.14.0 as build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the project
RUN npm run build

# Use an official Nginx image to serve the built application
FROM nginx:alpine

# Copy the build output to the Nginx HTML directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
