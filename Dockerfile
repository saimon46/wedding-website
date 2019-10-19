FROM node:10.16.3-alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
RUN npm link gulp@^3.9.1
COPY . .
WORKDIR '/app/www'
RUN gulp

FROM nginx
EXPOSE 80
COPY --from=builder /app/node_modules /usr/share/nginx/html/node_modules
COPY --from=builder /app/www /usr/share/nginx/html