FROM node:latest AS builder
WORKDIR /app
COPY ./ ./
RUN npm install -g @ionic/cli
RUN npm install
RUN npm run-script build

FROM httpd:latest
RUN sed -i "s/80/8080/g" /usr/local/apache2/conf/httpd.conf
COPY --from=build /app/www/ /usr/local/apache2/htdocs/
EXPOSE 8080
CMD ["httpd-foreground"]