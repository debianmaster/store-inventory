FROM golang:1.9
RUN mkdir /app 
RUN go get github.com/gin-gonic/gin && go get github.com/go-sql-driver/mysql 
ADD . /app/
WORKDIR /app
RUN env GOOS=linux GOARCH=386 go build -o main .


#FROM scratch
#COPY --from=0 /app/main . 

EXPOSE 8080
CMD ["/app/main"]


#CMD ["/main"]
