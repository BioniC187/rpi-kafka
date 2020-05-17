FROM bionic187/rpi-java:1.0.0-ubuntu-jdk8

ARG kafkaversion=2.5.0
ARG scalaversion=2.12

ENV env_filename=kafka_${scalaversion}-${kafkaversion}
ENV env_installpath=/usr/${env_filename}
ENV env_config_suffix=config_
ENV env_config_file_relative_path=config/server.properties

RUN apt-get update
RUN apt-get install -y wget

COPY core/download.sh /tmp
RUN sh /tmp/download.sh 

RUN tar -xzf ${env_filename}.tgz -C /usr

WORKDIR ${env_installpath}

COPY core/var-sub.sh ${env_installpath}
COPY core/start.sh ${env_installpath}

RUN chmod +x ./start.sh
RUN chmod +x bin/kafka-server-start.sh

ARG ip=172.17.0.3
ARG oip=192.168.88.103
ARG config_zookeeper_connect=192.168.88.103:2181
ARG config_advertised_host_name=${oip}

ENV config_zookeeper_connect=${config_zookeeper_connect}
ENV config_advertised_host_name=${config_advertised_host_name}

CMD ["bash", "start.sh"]

