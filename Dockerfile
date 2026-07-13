# Base image for the application runtime.
FROM node:14-alpine

# Install build tools required by native npm dependencies.
RUN apk add --no-cache python3 g++ make

# Set the working directory inside the container.
WORKDIR /app

# Copy the application source code into the container.
COPY . .

# Run the application in production mode.
ENV NODE_ENV=production

# Point the app to the database service name used by Docker Compose.
ENV DB_HOST=item-db

# Install production dependencies and build the frontend assets.
RUN npm install --production --unsafe-perm && npm run build

# Start the Node.js application.
CMD ["npm", "start"]

# Expose the port used by the application process.
EXPOSE 8080