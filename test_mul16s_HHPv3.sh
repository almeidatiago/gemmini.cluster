#!/bin/bash

set -ex

find build/bench/conv-def-b/* | sort -Vr | xargs -I {} bash -c "sims/simulator-chipyard-mul16s_HHPv3GemminiSoCConfig {}" &>> results/mul16s_HHPv3_conv-def-b.txt
find build/bench/conv-def-i/* | sort -Vr | xargs -I {} bash -c "sims/simulator-chipyard-mul16s_HHPv3GemminiSoCConfig {}" &>> results/mul16s_HHPv3_conv-def-i.txt
