`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/13 13:33:36
// Design Name: 
// Module Name: level
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


module level(
    input logic [9:0] Xa, Xb,
    output logic [9:0] Ya, Yb, 
    output logic [7:0] Anga, Angb
    );
    logic [7:0] ya, yb;
    logic [7:0] anga, angb;
    logic dira, dirb;
    sinTable S1(.angle(Xa[7:0]),.ratio(ya));
    sinTable S2(.angle(Xb[7:0]),.ratio(yb));
    sinTable Sa1(.angle(Xa[7:0]+7'b1000000),.ratio(anga));
    sinTable Sa2(.angle(Xb[7:0]+7'b1000000),.ratio(angb));
    assign Ya=ya[7:2]+10'b0010000000;
    assign Yb=yb[7:2]+10'b0010000000;
    always_comb begin
    if(anga[7])
        Anga={4'b0000, anga[6:3]};
    else
        Anga={4'b1111, anga[6:3]};
    if(angb[7])
        Angb={4'b0000, angb[6:3]};
    else
        Angb={4'b1111, angb[6:3]};
    end
endmodule
