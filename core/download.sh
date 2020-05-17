#!/bin/bash
echo 'downloading kafka...'

url="http://apache.is.co.za/kafka/${kafkaversion}/${env_filename}.tgz"

#wget http://apache.is.co.za/kafka/2.5.0/kafka_2.12-2.5.0.tgz -O kafka.tgz

wget -q --show-progress --progress=bar:force:noscroll "${url}"

echo 'completed'
