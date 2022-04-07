#!/bin/bash

set -ex

rm -rf results
mkdir -p results
find build/bench/conv-def-b/* | sort -Vr | parallel -j10 --halt now,fail=1 "echo {};sims/simulator-chipyard-mul16sGemminiSoCConfig {}" &>> results/conv-def-b.txt
find build/bench/conv-def-i/* | sort -Vr | parallel -j10 --halt now,fail=1 "echo {};sims/simulator-chipyard-mul16sGemminiSoCConfig {}" &>> results/conv-def-i.txt

