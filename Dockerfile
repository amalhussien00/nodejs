# -------- Build stage --------
FROM node:20 AS builder
WORKDIR /usr/src/app

# Copy only package files first (better cache for dependencies)
COPY package*.json ./
RUN npm install --omit=dev

# Copy app source code
COPY . .

# -------- Runtime stage --------
FROM node:20-slim
WORKDIR /usr/src/app

# Copy compiled app + node_modules from builder
COPY --from=builder /usr/src/app ./

EXPOSE 3000
CMD ["node", "app.js"]
