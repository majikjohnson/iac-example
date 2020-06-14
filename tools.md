
Flamethrower
------------

sudo apt-get install -y cmake build-essential g++ libldns-dev libgnutls28-dev pkg-config automake libtool

cd /tmp
wget https://github.com/libuv/libuv/archive/v1.38.0.tar.gz .
tar -zxvf v1.38.0.tar.gz 
cd libuv-1.38.0/
sh autogen.sh 
./configure
make
make check
sudo make install
cd ..
wget https://github.com/DNS-OARC/flamethrower/archive/v0.10.2.tar.gz
tar -zxvf v0.10.2.tar.gz 
cd flamethrower-0.10.2/
mkdir build
cd build
cmake .. && make
sudo mv flame /usr/local/bin/

dnsperf and resperf
-------------------
sudo add-apt-repository ppa:dns-oarc/dnsperf
sudo add-apt-repository ppa:isc/bind-esv
sudo apt-get update
sudo apt-get install dnsperf
sudo apt-get install resperf