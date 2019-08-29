FROM jfloff/alpine-python:3.7-slim
WORKDIR /opt
RUN apk add --update bash curl py3-pip
RUN pip3 install --upgrade pip
RUN pip3 install flask werkzeug
WORKDIR /opt
ADD ${PWD}/files/src/api/api.py /opt/stack/
EXPOSE 5000
CMD ["python", "/opt/stack/api.py"]
