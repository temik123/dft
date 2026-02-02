FROM node:25-alpine3.21 as deps
WORKDIR /app
COPY package*.json .
RUN npm ci --only=production

FROM node:25-alpine3.21 as prod
WORKDIR /app
RUN adduser -D someuser
USER someuser
COPY --from=deps /app/node_modules ./node_modules
COPY server.js .
EXPOSE 3001
ENTRYPOINT ["node", "server.js"]