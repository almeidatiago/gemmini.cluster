#!/bin/bash

set -ex

./build-simulator.sh -m mul16s -m 10
./build-simulator.sh -m mul16s_HHP -m 10

./build-conv.sh

