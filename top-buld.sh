#!/bin/bash

set -ex

./build-simulator.sh -m mul16s -n 10
./build-simulator.sh -m mul16s_HHP -n 10

./build-conv.sh

echo "\nSUCESS\n"
