# -------- build stage --------
FROM node:20-alpine AS build
WORKDIR /app

# Declare build argument
ARG VITE_API_URL
# Set as environment variable for Vite to use during build
ENV VITE_API_URL=${VITE_API_URL}

COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build

# -------- runtime stage --------
FROM node:20-alpine
WORKDIR /app

# Install serve and its dependencies in a node_modules directory
RUN npm install serve

# Copy built assets
COPY --from=build /app/dist ./dist

EXPOSE 5173

# Use npx to run serve from local node_modules
CMD ["npx", "serve", "-s", "dist", "-l", "5173"]