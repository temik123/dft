FROM node:25-alpine3.21 as deps
WORKDIR /app
COPY package*.json .
RUN npm ci

FROM node:25-alpine3.21 as build
WORKDIR /app
COPY --from=deps /app/node_modules/ ./node_modules
COPY . .
RUN npm run build


FROM nginx:1.29.3-alpine as prod
WORKDIR /app
COPY --from=build /app/build /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf
RUN mkdir /etc/nginx/ssl && \
apk update && apk add --no-cache openssl && \ 
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/nginx.key \
  -out /etc/nginx/ssl/nginx.crt \
  -subj "/C=RU/ST=Moscow/L=Moscow/O=Local Dev/OU=Dev/CN=localhost"
EXPOSE 80 443
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
