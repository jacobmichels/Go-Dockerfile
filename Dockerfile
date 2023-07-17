# Remember to sha pin!
FROM golang:1.20.6-alpine3.17 AS builder

WORKDIR /app

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

RUN go build -o /usr/bin/app cmd/app/main.go

# Remember to sha pin!
FROM alpine:3.18.0

COPY --from=builder /usr/bin/app /usr/bin/app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

ENTRYPOINT [ "/usr/bin/app" ]
