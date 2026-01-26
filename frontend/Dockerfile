# ================================
# Stage 1: Build Vite app
# ================================
FROM node:20-alpine AS builder

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci && npm cache clean --force

# Copy source and build
COPY . .
RUN npm run build


# ================================
# Stage 2: Production runtime
# ================================
FROM node:20-alpine

# Create non-root user
RUN addgroup -S appuser -g 1001 \
    && adduser  -S appuser -u 1001 -G appuser

WORKDIR /app

# Install serve locally (NO npx)
RUN npm install serve@14.2.1 --production \
    && npm cache clean --force

# Copy built assets
COPY --from=builder /app/dist ./dist

# Fix ownership
RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 5173

# IMPORTANT: run serve binary directly
CMD ["./node_modules/.bin/serve", "-s", "dist", "-l", "5173"]