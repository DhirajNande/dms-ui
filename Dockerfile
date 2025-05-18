FROM node:18-alpine AS build
WORKDIR /app
COPY ./angular-ui/package.json ./angular-ui/package-lock.json ./
RUN npm install --force
COPY ./angular-ui/. .
RUN npm run build -- --output-path=dist --configuration production
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
