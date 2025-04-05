# Stage 1: Build the application
FROM node:18-alpine AS build

# Set working directory for the build stage
WORKDIR /app

# Copy the dependency files and install dependencies
COPY package.json package-lock.json ./

# Install app dependencies
RUN npm install --production

# Copy the application source code
COPY . .

# Stage 2: Set up the runtime environment
FROM node:18-alpine

# Set working directory for the runtime environment
WORKDIR /app

# Copy only necessary files from the build stage
COPY --from=build /app /app

# Install only production dependencies
RUN npm prune --production

# Expose the application port
EXPOSE 3000

# Create a non-root user and use it
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Start the Node.js app
CMD ["npm", "start"]
