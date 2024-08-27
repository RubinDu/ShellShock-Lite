`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/13 13:34:55
// Design Name: 
// Module Name: projectile
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


module projectile(
    input logic Clk, st,
    input logic [9:0] x_init, y_init,
    input logic [6:0] elv, mv,
    output logic [9:0] x, y
    );
    logic [9:0] xp, yp;
    logic [4:0] xv, yv;
    logic [6:0] sin, cos;
    logic [13:0] multx, multy;
    logic diry, Dirx, Diry;
    sinTable Sin(.angle({0,elv}),.ratio({diry,sin}));
    sinTable Cos(.angle({0,elv+7'b1000000}),.ratio(cos));
    always_ff@(posedge Clk)begin 
        if(!st)begin
         multx<=mv*cos;
         multy<=mv*sin;
            xv<=multx[13:10];
            yv<=multy[13:10];
            xp<=x_init;
            yp<=y_init;
            Dirx<=!elv[6];
            Diry<=diry;
        end
        else begin
            if(Dirx)
                xp<=xp+xv;
            else
                xp<=xp-xv;
            if(Diry) begin
                if(yv>4'd1)
                    yv<=yv-4'd1;
                else begin
                    Diry<=0;
                    yv<=4'd1-yv;
                end
                yp<=yp+yv;
            end
            else begin
                yv<=yv+4'd1;
                yp<=yp-yv;
            end
        end
    end
    assign x=xp;
    assign y=yp;
endmodule
