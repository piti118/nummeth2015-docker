FROM ubuntu:14.04
RUN apt-get update
RUN apt-get install -y python python-dev
RUN apt-get install -y python-pip
RUN apt-get install -y python-numpy python-scipy
RUN apt-get install -y libfreetype6-dev libpng-dev
RUN apt-get install -y pkg-config
RUN pip install matplotlib ipython[notebook] cython
RUN pip install https://github.com/jakevdp/JSAnimation/archive/master.zip
RUN python -m IPython.external.mathjax -i /usr/share/
RUN apt-get clean auto-clean
VOLUME /data
WORKDIR /data
EXPOSE 8888
CMD ipython notebook --port=8888 --ip=* --no-browser
