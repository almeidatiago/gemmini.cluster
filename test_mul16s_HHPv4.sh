#!/bin/bash

set -ex

find build/bench/conv-def-b/* | sort -Vr | xargs -I {} bash -c "echo {}; sims/simulator-chipyard-mul16s_HHPv4GemminiSoCConfig {}" &>> results/mul16s_HHPv4_conv-def-b.txt
find build/bench/conv-def-i/* | sort -Vr | xargs -I {} bash -c "echo {}; sims/simulator-chipyard-mul16s_HHPv4GemminiSoCConfig {}" &>> results/mul16s_HHPv4_conv-def-i.txt

