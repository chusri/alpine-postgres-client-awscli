# Dockerfile
FROM alpine:3.21

# Install MySQL 5 client and AWS CLI
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk add --no-cache \
    postgresql17-client \
    aws-cli \
    vim 


CMD ["sh"]
