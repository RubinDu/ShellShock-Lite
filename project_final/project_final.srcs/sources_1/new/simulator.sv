`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/13 13:32:39
// Design Name: 
// Module Name: simulator
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


module simulator(
    input logic Clk, reset,
    input logic [1:0] p1m, p2m, gameState, //movement  00-halt, 10-left, 11-right; action 00-halt, 01-fire, 10-aim left, 11-aim right
    input logic [2:0] p1a, p2a,
    input logic [9:0] ty,
    output logic [9:0] tx,
    output logic [9:0] p1x, p2x, p1y, p2y, projx, projy,
    output logic [1:0] fb, //feedback 00-nothing happened, 01-miss, 10-hit p1, 11-hit p2
    output logic [6:0] elv_output1, elv_output2, mv_output
    );
    parameter [9:0] p1x_init=10'd64;
    parameter [9:0] p2x_init=10'd576;
    logic st, Reset;
    logic[9:0] P1x, P2x, P1y, P2y, Projx, Projy, x_init, y_init;
    logic[6:0] elv2, elv1, elv, mv1, mv2, mv;
    logic[1:0] P1m,P2m;
    always_ff@(posedge Clk)begin
 //       if(reset)begin
 //           fb<=2'b0;
 //       end
 //   else begin
    case(gameState)
                2'b10: begin
                    if(p1a==3'b001)begin
                        tx<=Projx;
                        P1y<=P1y;
                        P2y<=P2y;
                        end
                    else begin
                        tx<=P1x;
                        P1y<=ty;
                        P2y<=P2y;
                        end
                    x_init<=P1x;
                    y_init<=P1y+10'd2;
                    elv<=elv1;
                    mv<=mv1;
                    Reset<=1'b0;
                    if(p2x-p1x<21&&p1m==2'b10)
                        P1m<=2'b00;
                    else
                        P1m<=p1m;
                    end
                2'b11: begin
                    if(p2a==3'b001)begin
                        tx<=Projx;
                        P1y<=P1y;
                        P2y<=P2y;
                    end
                    else begin
                        tx<=P2x;
                        P1y<=P1y;
                        P2y<=ty;
                        end
                    x_init<=P2x;
                    y_init<=P2y+10'd2;
                    elv<=elv2;
                    mv<=mv2;
                    Reset<=1'b0;
                    if(p2x-p1x<21&&p2m==2'b11)
                        P2m<=2'b00;
                    else
                        P2m<=p2m;
                    end
                    default:begin
                        Reset<=1'b1;
                    end
              endcase
    end
    
    always_comb begin
        if(p1a==3'b001)begin
            st=1'b1;
                if(Projy<ty||Projx>10'd640)
                    fb=2'b01;
                else if((Projx-P2x<16||P2x-Projx<16)&&(Projy-P2y<16||P2y-Projy<16))
                    fb=2'b11;
                else
                    fb=2'b0;
        end
        else if(p2a==3'b001)begin
            st=1'b1;
                if(Projy<ty||Projx>10'd640)
                    fb=2'b01;
                else if((Projx-P1x<16||P1x-Projx<16)&&(Projy-P1y<16||P1y-Projy<16))
                    fb=2'b10;
                else
                    fb=2'b0;
        end
        else begin
            st=1'b0;
            fb=2'b0;
        end
        p1x=P1x;
        p2x=P2x;
        p1y=P1y;
        p2y=P2y;
        projx=Projx;
        projy=Projy;
        elv_output1=elv1;
        elv_output2=elv2;
        mv_output=mv;
    end
    
    player P1( .Clk,.reset(reset||Reset),.mov(P1m), .aim(p1a),.x_init(p1x_init),.x(P1x),.elv(elv1), .mv(mv1));
    player P2( .Clk,.reset(reset||Reset),.mov(P2m), .aim(p2a),.x_init(p2x_init),.x(P2x),.elv(elv2), .mv(mv2));
    projectile pj(.Clk,.st,.x_init, .y_init,.mv,.elv,. x(Projx), .y(Projy));
     
endmodule
