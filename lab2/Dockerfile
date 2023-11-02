FROM ubuntu

RUN apt-get update && \
    apt-get install -y build-essential \
    htop \
    net-tools

WORKDIR /app

COPY . .
COPY $ARGUMENT /app/

RUN g++ -o main main.cpp

CMD ["/bin/bash", "-c", "./main $ARGUMENT"]
