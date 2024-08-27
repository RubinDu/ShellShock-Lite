`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/30 19:14:15
// Design Name: 
// Module Name: aimassist
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


module aimassist(
    input logic [9:0] x_init, y_init, xp, yp,
    input logic [6:0] elv, mv,
    output logic on
    );
    logic [6:0] sin, cos;
    logic [13:0] multx, multy;
    logic [9:0] offx, offy, resx, resy;//, res[7:0], reso[7:0]
    sinTable Sin(.angle({0,elv}),.ratio(sin));
    sinTable Cos(.angle({0,elv+7'b1000000}),.ratio(cos));
    always_comb begin
        if(elv[6])begin
        offx=x_init-xp;
        end
        else begin
        offx=xp-x_init;
        end
        on=1'b0;
        for(int i=0; i<8; i++) begin
            multx=mv*cos;
            multy=mv*sin;
            if(multy[13:10]>i)begin
                offy=yp-y_init;
                resy=(multy[13:10]-i)*i*2;
                resx=multx[13:10]*i*2;
            end
            else begin
                offy=y_init-yp;
                resy=(i-multy[13:10])*i*2;
                resx=multx[13:10]*i*2;
            end
            //res[i]=resy;
            //reso[i]=offy;
                if((offy==resy||offy==resy+1)&&(offx==resx||offx==resx+1))
                    on=1'b1;
        end
    end
endmodule
