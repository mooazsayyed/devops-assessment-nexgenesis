#Vite Frontend Dockerfile - Distroless Production

# Stage 1: Builder
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files and install dependencies (including dev for building)
COPY package*.json ./
RUN npm ci && npm cache clean --force

# Install serve globally for static file serving
RUN npm install -g serve

# Copy source code and build production assets
COPY . .
RUN npm run build

# Stage 2: Production Runtime with Distroless
FROM gcr.io/distroless/nodejs20-debian12:nonroot

# Copy built assets from builder stage
COPY --from=builder /app/dist /app/dist

# Copy serve binary and node_modules
COPY --from=builder /usr/local/lib/node_modules/serve /app/node_modules/serve
COPY --from=builder /usr/local/bin/serve /app/serve

# Set working directory
WORKDIR /app

# Expose port
EXPOSE 5173

# Run as non-root user (distroless nonroot user)
USER nonroot

# Start static file server
CMD ["./serve", "-s", "dist", "-l", "5173"]