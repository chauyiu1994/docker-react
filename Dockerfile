# multi-stage build (copy files of first container to second)
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# using nginx instead of the dev server
FROM nginx
# just for elasticbeanstalk
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html