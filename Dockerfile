FROM golang:1.9
RUN mkdir /app 
RUN go get github.com/gin-gonic/gin && go get github.com/go-sql-driver/mysql 
ADD . /app/
WORKDIR /app
RUN go build -o main .


FROM scratch
COPY --from=0 /app/main . 
EXPOSE 8080
CMD ["/main"]
