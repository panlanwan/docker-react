FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
#npm run build needed to build a prod image
RUN npm run build

FROM nginx
#Following instructions tells AWS beanstalk to listen to requests on port 80
ENV PORT 80
EXPOSE 80
#copu /app/build folder from above image(stage: builder) to the nginx image
COPY --from=builder /app/build /usr/share/nginx/html