//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/02 16:13:03
// Design Name: 
// Module Name: statusbar
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


module statusbar(
    input logic [9:0] x_init, y_init, xp, yp,
    input logic [5:0] value,
    output logic bd, on
    );
    
    always_comb begin
    if((xp==x_init||xp==x_init+6'd63)&&yp-y_init<3'd7||(yp==y_init||yp==y_init+3'd7)&&xp-x_init<6'd63) begin
        on=1'b0;
        bd=1'b1;
    end
    else if(xp-x_init<value&&yp-y_init<3'd7) begin
        on=1'b1;
        bd=1'b0;
    end
    else begin
        bd=1'b0;
        on=1'b0;
    end
    end
    
endmodule
