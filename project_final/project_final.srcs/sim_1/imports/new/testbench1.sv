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


module testbench1();

timeunit 10ns;
timeprecision 1ns;


logic Clk,reset;
logic [1:0] fb; //simulator feedback 00=flyimg, 01=miss, 10=p1hit, 11=p2hit
logic [7:0] keycode; //keycode=8'd44 space keycode=8'd4 A keycode=8'd7 D keycode=8'd26 W keycode=8'd22 S
logic [1:0] p1m, p2m,gameState; // player movement, player action, gamestate gamestate: 00 start, 01 game over, 10 p1 round, 11 p2 round
logic [2:0] p1a, p2a;
logic [3:0] p1h, p2h; //health

gamestate status(.*);

always begin: CLOCK_GENERATION
    #1 Clk=~Clk;
end
   
initial begin: CLOCK_INITIALIZATION
    Clk=0;
end

initial begin: TEST_VECTORS
    reset=0; 
    keycode=8'b00000000;
    fb=2'b00;
    
    #2 reset=1; 
    #2 reset=0; 
    #2 keycode=8'd44;
    #2 keycode=8'd0;
    #2 keycode=8'd7;
    #2 keycode=8'd0;
    #2 keycode=8'd4;
    #20 keycode=8'd0;
    #2 keycode=8'd7;
    #2 keycode=8'd0;
    #2 keycode=8'd81;
    #2 keycode=8'd0;
    #2 keycode=8'd82;
    #2 keycode=8'd0;
    #2 fb=2'b11;
    #2 fb=2'b00;
    #2 keycode=8'd7;
    #2 keycode=8'd0;
    #2 keycode=8'd4;
    #20 keycode=8'd0;
    #2 keycode=8'd44;
    #2 keycode=8'd0;
    #2 fb=2'b11;
    #2 fb=2'b00;
end

    
endmodule
