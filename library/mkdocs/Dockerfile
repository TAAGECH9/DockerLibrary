#
# Metadata used by docker-build-and-push.yml GitHub Action Workflow
# IMAGE_NAME: mkdocs
# IMAGE_VERSION: v0.0.1
#
FROM python:3.12

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

COPY . .

EXPOSE 80

CMD ["mkdocs","serve"]
