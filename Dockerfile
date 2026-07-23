# Lightweight Node.js 20 base image
FROM node:20-alpine

# Set working directory inside container
WORKDIR /src

# Copy dependency manifests first (for build cache)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application code
COPY index.js ./

# Default app port
ENV PORT=3001

# RabbitMQ connection defaults
ENV RABBITMQ_HOST=my-rabbitmq
ENV RABBITMQ_PORT=5672

# Run as non-root user for security
USER node

# Document exposed port
EXPOSE $PORT

# Start the application
CMD ["node", "index.js"]