# stage 1: build the binary
FROM golang:alpine AS builder
RUN apk --update add ca-certificates
WORKDIR /app
COPY . ./
RUN go build -v -o gatus .

# stage 2: run the binary
FROM alpine:3.23
RUN addgroup -g 10001 -S gatus
RUN adduser -u 10001 -S gatus -g gatus
WORKDIR /app
RUN mkdir /app/config
COPY --from=builder /app/gatus /app/gatus
COPY --from=builder /app/config.yaml /app/config/config.yaml
RUN chown -R gatus:gatus /app/config && chown -R gatus:gatus /app
RUN chmod 500 /app/gatus
USER gatus
EXPOSE 8080
ENTRYPOINT ["/app/gatus"]