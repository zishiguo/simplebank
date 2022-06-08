FROM golang:1.17-alpine as builder

RUN echo -e http://mirrors.ustc.edu.cn/alpine/v3.15/main/ > /etc/apk/repositories

ENV GOPROXY https://goproxy.cn

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 go build -o main main.go
RUN apk add curl
RUN curl -L https://github.z-o.top/golang-migrate/migrate/releases/download/v4.15.2/migrate.linux-amd64.tar.gz | tar xvz

FROM alpine as prod

WORKDIR /app

COPY --from=builder /app/migrate /app/main ./
COPY app.env start.sh wait-for.sh ./
COPY db/migration ./migration

EXPOSE 8080
CMD ["./main"]
ENTRYPOINT ["./start.sh"]