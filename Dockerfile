FROM debian

RUN apt-get update &&\
    apt-get install -y curl git-core &&\
    curl -sL https://deb.nodesource.com/setup_10.x | bash - &&\
    apt-get update &&\
    apt-get install -y nodejs

RUN apt-get update &&\
    apt-get install -y build-essential

RUN apt-get update &&\
    apt-get install -y jq

RUN adduser ethnetintel

RUN cd /home/ethnetintel &&\
    git clone https://github.com/fuseio/eth-net-intelligence-api &&\
    cd eth-net-intelligence-api &&\
    npm install &&\
    npm install -g pm2

COPY run.sh /home/ethnetintel/run.sh

RUN chmod +x /home/ethnetintel/run.sh &&\
    chown -R ethnetintel. /home/ethnetintel

USER ethnetintel
ENTRYPOINT ["/home/ethnetintel/run.sh"]
