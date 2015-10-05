`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:07:25 08/17/2015 
// Design Name: 
// Module Name:    Lab1_2 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Lab1_2( A,B,Ci,display_ctl,clk,display,rst_n,
   S,Co );
input rst_n;	 
input clk;	 
input [3:0]A;
input [3:0]B;
input Ci;
output [3:0]S;
output Co;
output [3:0]display_ctl;
output [14:0]display;
wire [3:0]z;
wire [3:0]Ct;
wire [2:0]Ce;
wire [1:0]clk_ctl;
wire [3:0]bcd;
assign z[0]= (A[0]^B[0])^Ci;
assign Ct[0]=(A[0]&B[0])|((A[0]^B[0])&Ci);
assign z[1]= A[1]^B[1]^Ct[0];
assign Ct[1]=(A[1]&B[1])|((A[1]^B[1])&Ct[0]);
assign z[2]= A[2]^B[2]^Ct[1];
assign Ct[2]=(A[2]&B[2])|((A[2]^B[2])&Ct[1]);
assign z[3]= A[3]^B[3]^Ct[2];
assign Ct[3]=(A[3]&B[3])|((A[3]^B[3])&Ct[2]);
assign Co=Ct[3]|(z[3]&z[1])|(z[3]&z[2]);
assign S[0]=z[0]^0;
assign Ce[0]=(z[0]&0)|((z[0]^0)&0);
assign S[1]=z[1]^Co^Ce[0];
assign Ce[1]=(z[1]&Co)|((z[1]^Co)&Ce[0]);
assign S[2]=z[2]^Co^Ce[1];
assign Ce[2]=(z[2]&Co)|((z[2]^Co)&Ce[1]);
assign S[3]=z[3]^0^Ce[2];

frequency_divider f1(
	.clk_ctl(clk_ctl), // divided clock output
	.clk(clk), // global clock input
	.rst_n(rst_n) // active low reset
	);

scan_ctl s1(
	.ftsd_ctl(display_ctl), // ftsd display control signal 
	.ftsd_in(bcd), // output to ftsd display
	.in0(A), // 1st input
	.in1(B), // 2nd input
	.in2(Co), // 3rd input
	.in3(S), // 4th input
	.ftsd_ctl_en(clk_ctl) // divided clock for scan control
	);
bcd_14display ds1(
	.bcd(bcd),
	.display(display)
);
endmodule
