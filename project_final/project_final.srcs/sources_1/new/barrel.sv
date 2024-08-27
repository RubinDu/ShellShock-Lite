//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/29 18:10:21
// Design Name: 
// Module Name: barrel
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


module barrel(
    input logic [9:0] x_init, y_init, xp, yp,
    input logic [6:0] elv,
    output logic on
    );
    logic [6:0] sin, cos;
    logic [9:0] multx, multy;
    logic [4:0] offx, offy;
    sinTable Sin(.angle({0,elv}),.ratio(sin));
    sinTable Cos(.angle({0,elv+7'b1000000}),.ratio(cos));
    always_comb begin
        if(elv[6])begin
        offx=x_init-xp;
        end
        else begin
        offx=xp-x_init;
        end
        offy=yp-y_init;
        on=1'b0;
        for(int i=0; i<8; i++) begin
            multx=i*cos;
            multy=i*sin;
            if((offx==multx[9:6]||offx==multx[9:6]+1)&&(offy==multy[9:6]||offy==multy[9:6]+1))
                on=1'b1;
        end
    end
    
    
endmodule
