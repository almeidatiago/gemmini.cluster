#!/bin/bash

set -ex

ROOT="$PWD/"

while getopts n: flag
do
    case "${flag}" in
        n) name=${OPTARG};;
    esac
done

help () {
  echo "Usage: $0 -n MULT_NAME"
  echo
  echo "Examples:"
  echo "         $0 -n mul16s"
  echo "         $0 -n mul16s_HHP"
  exit
}

if [ $# -le 0 ]; then
    help
fi

if [ $show_help -eq 1 ]; then
   help
fi

source ~/chipyard/env.sh

# Copy the files to the docker to compile
cp src/CustomConfigs.scala ~/chipyard/generators/gemmini/src/main/scala/gemmini/CustomConfigs.scala
cp src/Arithmetic_${name}.scala ~/chipyard/generators/gemmini/src/main/scala/gemmini/Arithmetic.scala
cp src/${name}.scala ~/chipyard/generators/gemmini/src/main/scala/gemmini/${name}.scala
cp src/${name}.v ~/chipyard/generators/gemmini/src/main/scala/gemmini/${name}.v

# Build the simulator
cd ~/chipyard/generators/gemmini
./scripts/build-verilator.sh

# Copy simulator to git repo
cd -
cp ~/chipyard/sims/verilator/simulator-chipyard-CustomGemminiSoCConfig src/simulator-chipyard-${name}GemminiSoCConfig

# Create files to simulate
file="test_${name}.sh"

echo "#!/bin/bash" > $file
echo >> $file
echo "set -ex" >> $file
echo >> $file
echo "rm -rf results" >> $file
echo "mkdir -p results" >> $file
echo 'find build/bench/conv-def-b/*| sort -Vr | parallel -j16 --halt now,fail=1 "echo {};sims/simulator-chipyard-${name}GemminiSoCConfig {}" \ &>> results/conv-def-b.txt' >> $file
echo 'find build/bench/conv-def-i/* | sort -Vr | parallel -j16 --halt now,fail=1 "echo {};sims/simulator-chipyard-${name}GemminiSoCConfig {}" &>> results/conv-def-in-dim.txt' >> $file
echo >> $file
cat $file

chmod 777 test_${name}.sh

file="run_${name}.condor"

echo "getenv = true" > $file
echo >> $file
echo "executable  = ./test_${name}.sh" >> $file
echo "arguments   = $(Process)" >> $file
echo "output      = results/${name}.out" >> $file
echo "error       = results/${name}.err" >> $file
echo "log         = results/${name}.log" >> $file
echo >> $file
echo "request_cpus = 16" >> $file
echo "queue 1" >> $file
echo  >> $file
cat $file

