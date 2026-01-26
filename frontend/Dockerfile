# Multi-stage React/Vite Frontend Dockerfile

# Stage 1: Builder
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci && npm cache clean --force

# Stage 2: Runtime
FROM node:20-alpine AS runtime

WORKDIR /app

# Install system dependencies
RUN apk add --no-cache curl

# Create non-root user
RUN adduser -D -h /home/appuser appuser

# Copy dependencies from builder stage
COPY --from=builder --chown=appuser:appuser /app/node_modules ./node_modules

# Copy source code
COPY --chown=appuser:appuser . .

# Switch to non-root user
USER appuser

# Expose port
EXPOSE 5173

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:5173 || exit 1

# Start Vite dev server
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]