FROM node:25-alpine3.21 as deps
WORKDIR /app
COPY package*.json .
RUN npm ci

FROM node:25-alpine3.21 as build
WORKDIR /app
COPY --from=deps /app/node_modules/ .
COPY . .
RUN npm run build


FROM nginx:1.29.3-alpine as prod
WORKDIR /app
COPY --from=build /app/build /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
