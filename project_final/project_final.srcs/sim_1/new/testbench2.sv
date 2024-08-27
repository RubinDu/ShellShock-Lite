//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/09 00:41:11
// Design Name: 
// Module Name: testbench1
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


module testbench2();

timeunit 10ns;
timeprecision 1ns;


logic Clk, reset;
logic [1:0] p1m, p2m, p1a, p2a,gameState; //movement  00-halt, 10-left, 11-right; action 00-halt, 01-fire, 10-aim left, 11-aim right
logic [9:0] ty;
logic [9:0] tx;
logic [9:0] p1x, p2x, p1y, p2y, projx, projy;
logic [1:0] fb; //feedback 00-nothing happened, 01-miss, 10-hit p1, 11-hit p2

simulator Simulator(.*);
//sinTable S1(.count(tx),.phase(ty),.sel(2'b01));

always begin: CLOCK_GENERATION
    #1 Clk=~Clk;
end
   
initial begin: CLOCK_INITIALIZATION
    Clk=0;
end

initial begin: TEST_VECTORS
    reset=0; 
    fb=2'b00;
    p1m=2'b00;
    p2m=2'b00;
    p1a=2'b00;
    p2a=2'b00;
    ty=10'b100;
    gameState=2'b00;
    
    #2 reset=1; 
    #2 reset=0; 
    #2 gameState=2'b10;
    #2 p1m=2'b10;
    #20 p1m=2'b00;
    #2 p1a=2'b10;
    #20 p1a=2'b00;
    #2 p1a=2'b01;
    #40 p1a=2'b00;
    #2 gameState=2'b11;
    #2 p2m=2'b10;
    #20 p2m=2'b00;
    #2 p2a=2'b10;
    #20 p2a=2'b00;
    #2 p2a=2'b01;
    #40 p2a=2'b00;
end

    
endmodule
