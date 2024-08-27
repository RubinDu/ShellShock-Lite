`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/13 13:34:55
// Design Name: 
// Module Name: player
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


module player(
    input Clk,reset,
    input[1:0] mov, 
    input [2:0] aim,
    input [9:0] x_init,
    output [9:0] x,
    output [6:0] elv, mv
    );
    //might overflow
    logic [9:0] X;
    logic [6:0] ELV;
    logic [6:0] MV;
    always_ff@(posedge Clk) begin
        if (reset) begin
            X<=x_init;
            ELV <=7'b0;
            MV <=7'b0;
        end
        else begin
        if(mov==2'b10&&X+1!=10'd635)
            X<=X+1;
        else if(mov==2'b11&&X!=10'd5)
            X<=X-1;
        else
            X<=X;
        if(aim==3'b010&&ELV!=7'b1111111)
            ELV<=ELV+1;
        else if(aim==3'b011&&ELV!=7'b0)
            ELV<=ELV-1;
        else
            ELV<=ELV;
        if(aim==3'b101&&MV!=7'b1111111)
            MV<=MV+1;
        else if(aim==3'b100&&MV!=7'b0)
            MV<=MV-1;
        else
            MV<=MV;
        end
    end
    assign x=X;
    assign elv=ELV;
    assign mv=MV;
endmodule
