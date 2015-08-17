FROM debian:jessie
#uid 1000 is required for default vbshare
RUN useradd -u 1000 -ms /bin/bash student

RUN apt-get update

RUN apt-get install -y python python-dev python-pip \
                        python-numpy python-scipy \
                        libfreetype6-dev libpng-dev pkg-config \
                        git node npm

RUN pip install matplotlib ipython[notebook] cython
RUN pip install https://github.com/jakevdp/JSAnimation/archive/master.zip
RUN pip install scikit-learn

RUN python -m IPython.external.mathjax -i /usr/share/

#there is a node commmand for ham-radio in sbin for some reason
RUN apt-get remove -y ax25-node
RUN ln -s /usr/bin/nodejs /usr/bin/node
ENV USER=root
RUN npm install -g codebox

RUN apt-get install -y supervisor net-tools

RUN apt-get clean auto-clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /supervisor
WORKDIR /supervisor
ADD ./supervisor.conf supervisor.conf


RUN mkdir -p /data/mnt
RUN chown -R student /data

EXPOSE 8888 9999
VOLUME /data/mnt

USER student
WORKDIR /data
CMD supervisord -c /supervisor/supervisor.conf
