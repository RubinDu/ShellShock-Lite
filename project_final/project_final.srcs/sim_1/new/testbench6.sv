//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/29 19:11:34
// Design Name: 
// Module Name: testbench6
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


module testbench6();

timeunit 10ns;
timeprecision 1ns;

logic Clk;
logic [9:0] x_init, y_init, xp, yp;
logic [6:0] elv, mv;
logic on;

aimassist aimassist(.*);

always begin: CLOCK_GENERATION
    #1 Clk=~Clk;
end
   
initial begin: CLOCK_INITIALIZATION
    Clk=0;
end

initial begin: TEST_VECTORS
elv=7'b1000000;
x_init=10'd50;
y_init=10'd50;
mv=7'b0001111;
xp=10'd50;
yp=10'd55;

#2yp=10'd54;
#2yp=10'd55;
#2yp=10'd56;
#2yp=10'd57;
#2yp=10'd58;
#2yp=10'd59;
#2yp=10'd60;
end

    
endmodule
