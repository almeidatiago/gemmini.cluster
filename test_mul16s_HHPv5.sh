#!/bin/bash

set -ex

find build/bench/conv-def-b/* | sort -Vr | xargs -I {} bash -c "sims/simulator-chipyard-mul16s_HHPv5GemminiSoCConfig {}" &>> results/mul16s_HHPv5_conv-def-b.txt
find build/bench/conv-def-i/* | sort -Vr | xargs -I {} bash -c "sims/simulator-chipyard-mul16s_HHPv5GemminiSoCConfig {}" &>> results/mul16s_HHPv5_conv-def-i.txt

