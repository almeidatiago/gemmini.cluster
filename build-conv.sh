#!/bin/bash

set -ex

source ~/chipyard/env.sh

BATCHES=$(seq 1 10)
IN_DIMS=$(seq 10 10 100)
SRC=$(pwd)/src/conv-def.c
OUT=$(pwd)/build

mkdir -p $OUT
mkdir -p $OUT/bench/conv-def-b
mkdir -p $OUT/bench/conv-def-i

echo BATCHES = $BATCHES
echo IN_DIMS = $IN_DIMS

cd ~/chipyard/generators/gemmini/software/gemmini-rocc-tests

declare -r CFLAGS="-DPREALLOCATE=1 -DMULTITHREAD=1 -mcmodel=medany \
-std=gnu99 -O2 -ffast-math -fno-common -fno-builtin-printf -march=rv64gc \
-Wa,-march=rv64gcxhwacha -lm -lgcc"
declare -r INCLUDE="-I./riscv-tests -I./riscv-tests/env -I./ -I./riscv-tests/benchmarks/common"
declare -r LINKER_SCRIPT="-T ./riscv-tests/benchmarks/common/test.ld"
declare -r FILES="./riscv-tests/benchmarks/common/syscalls.c ./riscv-tests/benchmarks/common/crt.S"

build () {
    riscv64-unknown-elf-gcc $CFLAGS $INCLUDE -DID_STRING=  -nostdlib -nostartfiles \
    -static $LINKER_SCRIPT -DBAREMETAL=1  $SRC -o $1 \
     $FILES \
    -D BATCH_SIZE=$2 -D IN_DIM=$3 -D IN_CHANNELS=$4 -D OUT_CHANNELS=$5 -D KERNEL_DIM=$6 -D PADDING=$7 -D STRIDE=$8 #-D __GEMMINI_ONLY
}

for i in $BATCHES
do
    build $OUT/bench/conv-def-b/conv-def-b$i $i 56 17 31 3 1 2
done

for i in $IN_DIMS
do
    build $OUT/bench/conv-def-i/conv-def-i$i 4 $i 17 31 3 1 2
done
