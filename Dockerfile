# -------- Build stage --------
FROM node:20 AS builder
WORKDIR /usr/src/app
COPY *.tgz ./
RUN tar -xvzf *.tgz --strip-components=1
RUN npm install --omit=dev


# -------- Runtime stage --------
FROM node:20-slim
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app ./
EXPOSE 3000
CMD ["node", "app.js"]
