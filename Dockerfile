# ==========================================
# Stage 1: Build stage (Dependencies & Cache)
# ==========================================
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package manifests first to leverage Docker build layer caching
COPY package*.json ./

# Install production dependencies
RUN npm install --only=production

# Copy application source code
COPY . .

# ==========================================
# Stage 2: Production Runtime stage (Lightweight)
# ==========================================
FROM node:18-alpine

WORKDIR /app

# Non-root user for security best practice
USER node

# Copy only the compiled/installed artifacts from builder stage
COPY --chown=node:node --from=builder /app/package*.json ./
COPY --chown=node:node --from=builder /app/node_modules ./node_modules
COPY --chown=node:node --from=builder /app/server.js ./

EXPOSE 3000

CMD ["node", "server.js"]
