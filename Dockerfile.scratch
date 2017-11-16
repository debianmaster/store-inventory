FROM registry.centos.org/dharmit/golang:1.8
USER root
RUN mkdir /app 
RUN go get github.com/gin-gonic/gin &&  go get github.com/lib/pq 
ADD . /app/
WORKDIR /app
RUN env GOOS=linux GOARCH=386 go build -o main .  && chmod +x main

FROM scratch
COPY --from=0 /app/main . 

EXPOSE 8000
CMD ["/main"]
