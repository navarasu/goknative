FROM golang:alpine AS build-executable
RUN mkdir /app
ADD . /app
WORKDIR /app
RUN apk --no-cache add git
RUN go build
# Using a Docker multi-stage build to create a lean image.
FROM alpine
RUN mkdir /app
RUN apk --no-cache --update add ca-certificates
COPY --from=build-executable /app/go_example /app/go_example

CMD ["./app/go_example"]
