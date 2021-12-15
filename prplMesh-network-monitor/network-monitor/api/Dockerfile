# syntax=docker/dockerfile:1

# FROM python:3.8-slim-buster

#WORKDIR /app

#COPY requirements.txt requirements.txt
#RUN pip3 install -r requirements.txt

#COPY . .

#CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]

FROM ubuntu:18.04

RUN apt-get update -y && \
    apt-get install -y python3-pip python3-dev iputils-ping docker.io && \
    apt remove libiperf0 && \
    apt install libsctp1


EXPOSE 5000

WORKDIR app

COPY * /app/

RUN dpkg -i libiperf0_3.9-1_amd64.deb iperf3_3.9-1_amd64.deb

RUN pip3 install -r requirements.txt

CMD python3 app.py


