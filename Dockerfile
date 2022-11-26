FROM ubuntu

ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install ffmpeg nano wget git libsndfile-dev python3 python3-pip g++
COPY ./subaligner /subaligner
COPY ./gunicorn.conf.py /gunicorn.conf.py
WORKDIR "/subaligner/"
RUN python3 -m pip install . &&\
    python3 -m pip install gunicorn pyjwt flask flask_cors

ENTRYPOINT ["gunicorn", "-c", "/gunicorn.conf.py", "-w", "1", "--chdir", "/app", "app:app"]
