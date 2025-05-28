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

# Expose port
EXPOSE 3000

# Start the application using npm start
CMD ["npm", "start"]
