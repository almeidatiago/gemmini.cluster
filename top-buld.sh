#!/bin/bash

set -ex

rm -rf results
rm -rf build
rm -rf sims

./build-simulator.sh -m mul16s -n 16
./build-simulator.sh -m mul16s_HHP -n 16
./build-simulator.sh -m mul16s_HHPv2 -n 16
./build-simulator.sh -m mul16s_HHPv3 -n 16
./build-simulator.sh -m mul16s_HHPv4 -n 16
./build-simulator.sh -m mul16s_HHPv5 -n 16


./build-conv.sh

echo
echo 'SUCESS'
echo
