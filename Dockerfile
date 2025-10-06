# ==============================
# Stage 1: Build the Next.js frontend
# ==============================
FROM node:18-alpine AS frontend-builder
WORKDIR /app/frontend
COPY project/frontend/package*.json ./
RUN npm install
COPY project/frontend ./
RUN npm run build

# ==============================
# Stage 2: Run backend + serve frontend
# ==============================
FROM node:18-alpine
WORKDIR /app

# Copy backend files
COPY project/backend/package*.json ./backend/
WORKDIR /app/backend
RUN npm install
COPY project/backend ./ 

# Copy built frontend into final image
WORKDIR /app
COPY --from=frontend-builder /app/frontend ./frontend

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3000
ENTRYPOINT ["/entrypoint.sh"]

