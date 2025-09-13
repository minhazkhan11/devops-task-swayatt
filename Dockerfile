# MULTI-STAGE DOCKERFILE
# ===== Stage 1: Install dependencies =====
FROM node:18 AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# ===== Stage 2: Production =====
FROM node:18-slim

WORKDIR /app

# Copy only necessary files
COPY --from=builder /app /app

EXPOSE 3000

CMD ["npm", "start"]
