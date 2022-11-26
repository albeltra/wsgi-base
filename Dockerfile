FROM ubuntu

ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install ffmpeg nano wget git libsndfile-dev
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O Miniconda3-latest-Linux-x86_64.sh &&\
    chmod +x Miniconda3-latest-Linux-x86_64.sh &&\
    bash Miniconda3-latest-Linux-x86_64.sh -b
RUN conda install -c conda-forge gxx

COPY ./subaligner /subaligner

RUN pip install /subaligner/ &&/
    pip install gunicorn pyjwt flask flask_cors

ENTRYPOINT ["gunicorn", "-w", "1", "--chdir", "/app", "app:app"]
