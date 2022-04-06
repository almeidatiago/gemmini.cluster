// See LICENSE.txt for license details.
package gemmini

import chisel3._
import chisel3.util._
import chisel3.util.HasBlackBoxResource

class mul16s_HHP extends BlackBox with HasBlackBoxPath {
  val io = IO(new Bundle {
    val A    = Input(SInt(16.W))
    val B    = Input(SInt(16.W))
    val O  = Output(SInt(32.W))
  })
  addPath("/home/tiago/chipyard/generators/gemmini/src/main/scala/gemmini/mul16s_HHP.v")
}