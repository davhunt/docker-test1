FROM sebastientourbier/connectomemapper-bidsapp:latest

WORKDIR /app

COPY . /app

EXPOSE 5900

RUN ldconfig

RUN mkdir -p /N/u /N/home /N/dc2 /N/soft

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

RUN apt install libqt4-dev
#RUN yes "yes" | apt install libqt5x11extras5
RUN apt-get --assume-yes install libqt5x11extras5
RUN apt-get --assume-yes install libxinerama-dev
RUN apt-get --assume-yes install build-essential
RUN apt-get --assume-yes install qtcreator
RUN apt-get --assume-yes install qt5-default
RUN apt-get --assume-yes install qt5-doc
RUN apt-get --assume-yes install qt5-doc-html qtbase5-doc-html
RUN apt-get install qtbase5-examples
RUN apt-get install zlib1g-dev
#RUN apt-get --assume-yes install libpng16-16
RUN apt-get --assume-yes install libpng16-dev

RUN cp /usr/lib/x86_64-linux-gnu/libz.so libz.so.old

#COPY /usr/lib/x86_64-linux-gnu/qt5/plugins/platforms/libqxcb.so /opt/conda/lib
#COPY /usr/lib/x86_64-linux-gnu/qt5/plugins/platforms/libqxcb.so /opt/conda/bin

RUN cp /usr/lib/x86_64-linux-gnu/qt5/plugins/platforms/libqxcb.so /opt/conda/lib
RUN cp /usr/lib/x86_64-linux-gnu/qt5/plugins/platforms/libqxcb.so /opt/conda/bin

RUN mv /lib/x86_64-linux-gnu/libz.so.1 /lib/x86_64-linux-gnu/libz.so.1.old
#RUN ln -s /opt/conda/lib/libz.so.1 /lib/x86_64-linux-gnu/libz.so.1
RUN cp /app/libz.so.1 /lib/x86_64-linux-gnu/libz.so.1
#RUN ln -s /opt/conda/lib/libz.so.1 /lib/x86_64-linux-gnu/libz.so.1


RUN /sbin/ldconfig -v
RUN ldconfig

#RUN printf "\nexport QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/qt5/plugins/platforms/:/usr/lib/x86_64-linux-gnu/qt4/plugins\n" >> .bashrc

RUN export QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/qt5/plugins/platforms/:/usr/lib/x86_64-linux-gnu/qt4/plugins
RUN export QT_STYLE_OVERRIDE=gtk2
#RUN export QT_DEBUG_PLUGINS=1

#RUN ldd /usr/lib/x86_64-linux-gnu/qt5/plugins/platforms/libqxcb.so



RUN ln -sf /usr/lib/x86_64-linux/gnu/qt5/plugins/platforms/ /usr/bin/

RUN sed -i 's/handler = Instance/#handler = Instance/g' ./run_connectomemapper3.py

#RUN bash

#RUN echo asdf
