FROM golang:1.22.0
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
COPY tracker.db ./
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /my_app
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y sqlite3 libsqlite3-dev
CMD [ "/my_app" ]