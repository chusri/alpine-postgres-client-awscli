# Dockerfile
FROM alpine:3.21

# Install PG client and AWS CLI
RUN apk add --no-cache \
    postgresql17-client \
    aws-cli 


CMD ["sh"]
