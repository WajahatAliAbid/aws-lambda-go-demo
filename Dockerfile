FROM golang:1.11

LABEL version="1.0"
LABEL maintainer="Wajahat Ali Abid <https://wajahataliabid.github.io>"

WORKDIR /app

COPY . .

RUN go get -d -v ./...

RUN go install -v ./...

CMD ["app"]