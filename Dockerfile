# Alpine Linux 3.20 running golang 1.23.1
FROM golang:1.23.1-alpine3.20 AS build

# Define workdir
WORKDIR /app

# Install dependencies
COPY go.* ./
RUN go mod download

# App build
COPY main.go main.go
RUN CGO_ENABLED=0 go build . && go mod tidy

FROM scratch AS final

# Copy binary from build container
WORKDIR /app
COPY ./public/ public
COPY --from=build /app/dojo-guestbook ./dojo-guestbook

# Run app
EXPOSE 3000
ENTRYPOINT ["/app/dojo-guestbook"]
