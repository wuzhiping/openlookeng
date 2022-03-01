FROM ubuntu:20.04

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone
#jdk8
RUN apt-get -q update && \
    apt-get -y --no-install-recommends install curl git gnupg software-properties-common && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9 && \
    apt-add-repository "deb http://repos.azul.com/azure-only/zulu/apt stable main" && \
    apt-get -q update && \
    apt-get -y --no-install-recommends install zulu-8-azure-jdk=8.38.0.13 && \
    rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/zulu-8-azure-amd64

RUN java -version

RUN apt-get -q update && \
    apt-get -y --no-install-recommends install wget vim curl git gnupg software-properties-common sshpass gawk expect iproute2 iproute2-doc apt-utils && \
    rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8

# WORKDIR /opt
# RUN git clone https://gitee.com/agile-bpm/agile-bpm-basic.git
# WORKDIR agile-bpm-basic/web
# RUN mvn clean install
# /opt/agile-bpm-basic/web/src/main/resources/properties/app-sit.properties
# /opt/agile-bpm-basic/web/src/main/resources/properties/app-dev.properties
#CMD mvn org.mortbay.jetty:maven-jetty-plugin:run

EXPOSE 8090

COPY install.sh /opt/install.sh
RUN bash /opt/install.sh
#RUN wget -O - https://download.openlookeng.io/install.sh|bash

RUN apt-get -q update && \
    apt-get -y --no-install-recommends install openssh-client && \
    rm -rf /var/lib/apt/lists/*

RUN ln -fs /usr/bin/python3 /usr/bin/python
RUN python -V
RUN rm /opt/openlookeng/hetu-server/etc/catalog/memory.properties

COPY start.sh /opt/start.sh
#CMD bash /opt/openlookeng/bin/start.sh
CMD bash /opt/start.sh
#CMD python3 /opt/openlookeng/hetu-server/bin/launcher.py start
