wget https://download.openlookeng.io/install.sh --no-check-certificate
docker build -t shawoo/openlookeng:1.4.1 .

docker run --rm -it -p 8090:8090 -v $PWD/start.sh:/opt/start.sh -v $PWD/etc:/opt/openlookeng/hetu-server/etc --name=openlk openlookeng bash /opt/start.sh
openlkadmin
