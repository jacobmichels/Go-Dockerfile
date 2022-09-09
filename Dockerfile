FROM golang:1.19-alpine3.16 AS builder

WORKDIR /app

COPY go.mod .
COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o /usr/bin/app cmd/app/main.go

FROM alpine:3.16.2

COPY --from=builder /usr/bin/app /usr/bin/app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

ENTRYPOINT [ "/usr/bin/app" ]
