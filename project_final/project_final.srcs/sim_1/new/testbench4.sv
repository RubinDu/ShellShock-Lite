//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/22 15:22:49
// Design Name: 
// Module Name: testbench3
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

//////////////////////////////////////////////////////////////////////////////////


module testbench4();

timeunit 10ns;
timeprecision 1ns;
logic Clk;
logic [9:0] p1x, p2x, p1y, p2y, projx, projy,ter_y, DrawX, DrawY;
logic [7:0] ang;
logic [3:0]  Red, Green, Blue;
colormapper render(.*);

always begin: CLOCK_GENERATION
    #1 Clk=~Clk;
end
   
initial begin: CLOCK_INITIALIZATION
    Clk=0;
end

initial begin: TEST_VECTORS
p1x=10'd50;
p2x=10'd100;
p1y=10'd50;
p2y=10'd100;
projx=10'd80;
projy=10'd80;
ter_y=10'd10;
DrawX=10'd51;
DrawY=10'd429;
ang=8'b10000000;

#2DrawX=10'd52;
#2DrawX=10'd53;
#2DrawX=10'd54;
#2DrawX=10'd55;
#2DrawX=10'd56;
#2DrawX=10'd57;
#2DrawX=10'd58;
#2DrawX=10'd59;
#2DrawX=10'd60;
DrawY=10'd428;
#2DrawX=10'd52;
#2DrawX=10'd53;
#2DrawX=10'd54;
#2DrawX=10'd55;
#2DrawX=10'd56;
#2DrawX=10'd57;
#2DrawX=10'd58;
#2DrawX=10'd59;
#2DrawX=10'd60;
#2DrawY=10'd427;
#2DrawX=10'd52;
#2DrawX=10'd53;
#2DrawX=10'd54;
#2DrawX=10'd55;
#2DrawX=10'd56;
#2DrawX=10'd57;
#2DrawX=10'd58;
#2DrawX=10'd59;
#2DrawX=10'd60;
#2DrawY=10'd426;
#2DrawX=10'd52;
#2DrawX=10'd53;
#2DrawX=10'd54;
#2DrawX=10'd55;
#2DrawX=10'd56;
#2DrawX=10'd57;
#2DrawX=10'd58;
#2DrawX=10'd59;
#2DrawX=10'd60;
#2DrawY=10'd425;
#2DrawX=10'd52;
#2DrawX=10'd53;
#2DrawX=10'd54;
#2DrawX=10'd55;
#2DrawX=10'd56;
#2DrawX=10'd57;
#2DrawX=10'd58;
#2DrawX=10'd59;
#2DrawX=10'd60;
#2DrawY=10'd424;
#2DrawX=10'd52;
#2DrawX=10'd53;
#2DrawX=10'd54;
#2DrawX=10'd55;
#2DrawX=10'd56;
#2DrawX=10'd57;
#2DrawX=10'd58;
#2DrawX=10'd59;
#2DrawX=10'd60;
#2DrawY=10'd423;
#2DrawX=10'd52;
#2DrawX=10'd53;
#2DrawX=10'd54;
#2DrawX=10'd55;
#2DrawX=10'd56;
#2DrawX=10'd57;
#2DrawX=10'd58;
#2DrawX=10'd59;
#2DrawX=10'd60;
#2DrawY=10'd422;
#2DrawX=10'd52;
#2DrawX=10'd53;
#2DrawX=10'd54;
#2DrawX=10'd55;
#2DrawX=10'd56;
#2DrawX=10'd57;
#2DrawX=10'd58;
#2DrawX=10'd59;
#2DrawX=10'd60;
#2DrawY=10'd421;
#2DrawX=10'd52;
#2DrawX=10'd53;
#2DrawX=10'd54;
#2DrawX=10'd55;
#2DrawX=10'd56;
#2DrawX=10'd57;
#2DrawX=10'd58;
#2DrawX=10'd59;
#2DrawX=10'd60;
#2DrawY=10'd420;
#2DrawX=10'd52;
#2DrawX=10'd53;
#2DrawX=10'd54;
#2DrawX=10'd55;
#2DrawX=10'd56;
#2DrawX=10'd57;
#2DrawX=10'd58;
#2DrawX=10'd59;
#2DrawX=10'd60;
#2DrawY=10'd419;
#2DrawX=10'd52;
#2DrawX=10'd53;
#2DrawX=10'd54;
#2DrawX=10'd55;
#2DrawX=10'd56;
#2DrawX=10'd57;
#2DrawX=10'd58;
#2DrawX=10'd59;
#2DrawX=10'd60;
#2DrawY=10'd418;



end

    
endmodule
