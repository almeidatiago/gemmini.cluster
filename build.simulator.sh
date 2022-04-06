#!/bin/bash

set -ex

source ~/chipyard/env.sh

# Copy the files to the docker to compile
cp src/Arithmetic_mul16s.scala ~/chipyard/generators/gemmini/src/main/scala/gemmini/Arithmetic.scala
cp src/mul16s.scala ~/chipyard/generators/gemmini/src/main/scala/gemmini/mul16s.scala
cp src/mul16s.v ~/chipyard/generators/gemmini/src/main/scala/gemmini/mul16s.v

# Build the simulator
cd ~/chipyard/generators/gemmini
./scripts/build-verilator.sh

# Copy simulator to git repo
cd -
cp ~/chipyard/sims/verilator/simulator-chipyard-CustomGemminiSoCConfig src/simulator-chipyard-mul16sGemminiSoCConfig

# Copy the files to the docker to compile
cp src/Arithmetic_mul16s_HHP.scala ~/chipyard/generators/gemmini/src/main/scala/gemmini/Arithmetic.scala
cp src/mul16s_HHP.scala ~/chipyard/generators/gemmini/src/main/scala/gemmini/mul16s_HHP.scala
cp src/mul16s_HHP.v ~/chipyard/generators/gemmini/src/main/scala/gemmini/mul16s_HHP.v

# Build the simulator
cd ~/chipyard/generators/gemmini
./scripts/build-verilator.sh

# Copy simulator to git repo
cd -
cp ~/chipyard/sims/verilator/simulator-chipyard-CustomGemminiSoCConfig src/simulator-chipyard-mul16s_HHPGemminiSoCConfig
