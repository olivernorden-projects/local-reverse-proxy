FROM nginx:alpine

RUN apk add --no-cache bash

COPY ./nginx /etc/nginx/

COPY ./entrypoint /docker-entrypoint.d/
RUN chmod -R +x /docker-entrypoint.d/

COPY ./scripts /tmp/scripts/
RUN chmod -R +x /tmp/scripts/

# SSL certs
RUN sh /tmp/scripts/certs.sh

RUN rm -rf /tmp/scripts
