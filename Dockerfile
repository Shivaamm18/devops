# Use Node.js as base image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy project files
COPY . .

# Create .env file for production
RUN echo "VITE_API_URL=https://chat-backend-daem.onrender.com" > .env

# Build the app
RUN node --max-old-space-size=512 node_modules/vite/bin/vite.js build

# Install serve to run the application
RUN npm install -g serve

# Expose port
EXPOSE 3000

# Start the application
CMD ["serve", "-s", "dist", "-l", "3000"]
