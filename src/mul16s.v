/***
* This code is a part of EvoApproxLib library (ehw.fit.vutbr.cz/approxlib) distributed under The MIT License.
* When used, please cite the following article(s): V. Mrazek, Z. Vasicek, L. Sekanina, H. Jiang and J. Han, "Scalable Construction of Approximate Multipliers With Formally Guaranteed Worst Case Error" in IEEE Transactions on Very Large Scale Integration (VLSI) Systems, vol. 26, no. 11, pp. 2572-2576, Nov. 2018. doi: 10.1109/TVLSI.2018.2856362 
* This file contains a circuit from a sub-set of pareto optimal circuits with respect to the pwr and ep parameters
***/
// MAE% = 0.00019 %
// MAE = 8192 
// WCE% = 0.00076 %
// WCE = 32769 
// WCRE% = 300.00 %
// EP% = 62.50 %
// MRE% = 0.018 %
// MSE = 17895.697e4 
// PDK45_PWR = 2.325 mW
// PDK45_AREA = 2760.4 um2
// PDK45_DELAY = 3.11 ns


module mul16s ( A, B, O );
  input [15:0] A;
  input [15:0] B;
  output [31:0] O;

  assign O = A * B;

endmodule
