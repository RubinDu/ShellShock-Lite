//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/04 19:06:32
// Design Name: 
// Module Name: testbench7
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench7( );
timeunit 10ns;
timeprecision 1ns;

logic Clk;
logic [9:0] addr;
logic [175:0] data;

charrom char(.addr, .data);

always begin: CLOCK_GENERATION
    #1 Clk=~Clk;
end
   
initial begin: CLOCK_INITIALIZATION
    Clk=0;
end

initial begin: TEST_VECTORS
addr=10'd1+6'b100000;
#2addr=10'd2+6'b100000;
#2addr=10'd3+6'b100000;
#2addr=10'd4+6'b100000;
#2addr=10'd5+6'b100000;
#2addr=10'd6+6'b100000;
#2addr=10'd7+6'b100000;
#2addr=10'd8+6'b100000;
#2addr=10'd9+6'b100000;
#2addr=10'd10+6'b100000;
#2addr=10'd15;
#2addr=10'd16;
#2addr=10'd17;
#2addr=10'd18;
#2addr=10'd19;
#2addr=10'd20;
#2addr=10'd21;
#2addr=10'd22;
#2addr=10'd23;
#2addr=10'd24;
#2addr=10'd25;
#2addr=10'd26;
#2addr=10'd27;
#2addr=10'd28;
#2addr=10'd29;
#2addr=10'd30;
end

    
endmodule