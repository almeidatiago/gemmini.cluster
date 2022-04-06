#!/bin/bash

set -ex

rm -rf results
mkdir -p results
find build/bench/conv-def-b/*| sort -Vr | parallel -j16 --halt now,fail=1 "echo {};sims/simulator-chipyard-${name}GemminiSoCConfig {}" \ &>> results/conv-def-b.txt
find build/bench/conv-def-i/* | sort -Vr | parallel -j16 --halt now,fail=1 "echo {};sims/simulator-chipyard-${name}GemminiSoCConfig {}" &>> results/conv-def-in-dim.txt

