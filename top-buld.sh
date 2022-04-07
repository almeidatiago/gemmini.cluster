#!/bin/bash

set -ex

./build-simulator.sh -m mul16s -n 10
./build-simulator.sh -m mul16s_HHP -n 10
./build-simulator.sh -m mul16s_HHPv2 -n 10
./build-simulator.sh -m mul16s_HHPv3 -n 10
./build-simulator.sh -m mul16s_HHPv4 -n 10
./build-simulator.sh -m mul16s_HHPv5 -n 10


#./build-conv.sh

echo
echo 'SUCESS'
echo
