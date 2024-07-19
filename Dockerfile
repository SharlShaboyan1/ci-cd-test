FROM ubuntu:20.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl sudo

RUN curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
RUN apt-get install -y nodejs
RUN npm i -g serve

WORKDIR /app
COPY dist /app/
COPY .env /app/
#CMD ["/bin/bash", "-c", "/app/env.sh && serve -s . -l $PORT --ssl-cert $CERT_FILE_PATH --ssl-key $KEY_FILE_PATH"]
CMD ["/bin/bash", "-c", "serve -s . -l $PORT"]
#CMD 'if [ "$REQUIRE_HTTPS" = true ]; then ["/bin/bash", "-c", "/app/env.sh && serve -s . -l $PORT --ssl-cert $CERT_FILE_PATH --ssl-key $KEY_FILE_PATH"]; else ["/bin/bash", "-c", "/app/env.sh && serve -s . -l $PORT"]; 