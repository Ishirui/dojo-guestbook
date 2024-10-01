# Debian bookworm running golang:1.23.1
FROM golang:1.23.1-bookworm

# Define workdir
WORKDIR /app

# Install dependencies
COPY go.mod go.mod
COPY go.sum go.sum
RUN go mod download

# App build
COPY main.go main.go
COPY ./public/ public
RUN go build

# Create unprivileged user
RUN useradd -u 1000 user
USER user

# Run app
EXPOSE 3000
ENTRYPOINT ["./dojo-guestbook"]
