#!/bin/bash

help () {
  echo "Usage: $0 [-h] -m MULT_NAME -n NUM_NODES"
  echo
  echo "Options:"
  echo " MULT_NAME  - Name of the multiplier in 'src' dir"
  echo
  echo " NUM_NODOES - Number of nodes to run into the cluster"
  echo
  echo "Examples:"
  echo "         $0 -m mul16s -n 10"
  echo "         $0 -m mul16s_HHP -n 10"
  exit
}

while getopts m:n: flag
do
  case "${flag}" in
    m) name=${OPTARG} ;;
    n) nodes=${OPTARG} ;;
    *) help ;;
  esac
done

shift $((OPTIND-1))

if [ -z "${name}" ] || [ -z "${nodes}" ]; then
    help
fi

source ~/chipyard/env.sh

# Copy the files to the docker to compile
cp src/CustomConfigs.scala ~/chipyard/generators/gemmini/src/main/scala/gemmini/CustomConfigs.scala
cp src/Arithmetic_${name}.scala ~/chipyard/generators/gemmini/src/main/scala/gemmini/Arithmetic.scala
cp src/${name}.scala ~/chipyard/generators/gemmini/src/main/scala/gemmini/${name}.scala
cp src/${name}.v ~/chipyard/generators/gemmini/src/main/scala/gemmini/${name}.v

# Build the simulator
cd ~/chipyard/sims/verilator/
make -j$(nproc) ${debug} CONFIG=CustomGemminiSoCConfig VERILATOR_THREADS=${nodes}

# Copy simulator to git repo
cd -
mkdir sims
cp ~/chipyard/sims/verilator/simulator-chipyard-CustomGemminiSoCConfig sims/simulator-chipyard-${name}GemminiSoCConfig

# Create files to simulate
# Bash file
file="test_${name}.sh"

echo "#!/bin/bash" > $file
echo >> $file
echo "set -ex" >> $file
echo >> $file
echo 'find build/bench/conv-def-b/* | sort -Vr | xargs -I {} bash -c "echo {}; sims/simulator-chipyard-'${name}'GemminiSoCConfig {}" &>> results/'${name}'_conv-def-b.txt' >> $file
#echo 'find build/bench/conv-def-b/* | sort -Vr | parallel -j$(nproc) --halt now,fail=1 "echo {}; sims/simulator-chipyard-'${name}'GemminiSoCConfig {}" &>> results/'${name}'_conv-def-b.txt' >> $file
echo 'find build/bench/conv-def-i/* | sort -Vr | xargs -I {} bash -c "echo {}; sims/simulator-chipyard-'${name}'GemminiSoCConfig {}" &>> results/'${name}'_conv-def-i.txt' >> $file
#echo 'find build/bench/conv-def-i/* | sort -Vr | parallel -j$(nproc) --halt now,fail=1 "echo {}; sims/simulator-chipyard-'${name}'GemminiSoCConfig {}" &>> results/'${name}'_conv-def-i.txt' >> $file
echo >> $file
cat $file

chmod 777 test_${name}.sh

# Condor file
file="run_${name}.condor"

echo "getenv = true" > $file
echo >> $file
echo "executable  = ./test_${name}.sh" >> $file
echo 'arguments   = $(Process)' >> $file
echo "output      = results/${name}.out" >> $file
echo "error       = results/${name}.err" >> $file
echo "log         = results/${name}.log" >> $file
echo >> $file
echo "request_cpus = ${nodes}" >> $file
echo "queue 1" >> $file
echo  >> $file
cat $file

mkdir results

file="results/${name}.log"
echo > $file
cat $file
