# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster

ENV PORT 8080
EXPOSE 8080

ENTRYPOINT ["gunicorn", "--timeout", "600", "--access-logfile", "'-'", "--error-logfile", "'-'", "--chdir=/opt/defaultsite", "application:app"]

# copy the requirements file into the image
COPY ./requirements.txt /app/requirements.txt

# switch working directory
WORKDIR /app

# install the dependencies and packages in the requirements file
RUN apt-get update && apt-get install -y cmake && apt-get install -y python3-pip && apt-get install -y build-essential
RUN apt-get install ffmpeg libsm6 libxext6  -y
RUN apt-get install -y libjpeg-dev
RUN apt-get install -y libpng-dev

RUN pip install -r requirements.txt

# copy every content from the local file to the image
COPY . /app

# configure the container to run in an executed manner
ENTRYPOINT [ "python" ]

CMD ["app.py" ]