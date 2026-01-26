#Vite Frontend Dockerfile - Secure Production

# Stage 1: Builder
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files and install dependencies 
COPY package*.json ./
RUN npm ci && npm cache clean --force

# Copy source code and build production assets
COPY . .
RUN npm run build

# Stage 2: Production Runtime
FROM node:20-alpine AS production

# Create non-root user
RUN addgroup -g 1001 -S appuser && \
    adduser -S appuser -G appuser -u 1001

WORKDIR /app

# Create a minimal package.json for serve installation
RUN echo '{"name": "static-server", "version": "1.0.0", "dependencies": {"serve": "^14.2.1"}}' > package.json

# Install serve with all its dependencies locally
RUN npm install --production && npm cache clean --force

# Copy built assets from builder stage
COPY --from=builder /app/dist /app/dist

# Change ownership to non-root user
RUN chown -R appuser:appuser /app

# Expose port
EXPOSE 5173

# Run as non-root user
USER appuser

# Start static file server using local installation
CMD ["npx", "serve", "-s", "dist", "-l", "5173"]