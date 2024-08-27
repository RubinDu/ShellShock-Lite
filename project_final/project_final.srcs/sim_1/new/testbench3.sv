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


module testbench3();

timeunit 10ns;
timeprecision 1ns;


logic Clk, st;
logic [9:0] x_init, y_init;
logic [6:0] mv;
logic [6:0] elv;
logic [9:0] x, y;

projectile pj(.*);

always begin: CLOCK_GENERATION
    #1 Clk=~Clk;
end
   
initial begin: CLOCK_INITIALIZATION
    Clk=0;
end

initial begin: TEST_VECTORS
    x_init=10'd0;
    y_init=10'd50;
    mv=7'b1111111;
    st=1'b0;
    

#2 elv=7'd0;
#2 elv=7'd1;
#2 elv=7'd2;
#2 elv=7'd3;
#2 elv=7'd4;
#2 elv=7'd5;
#2 elv=7'd6;
#2 elv=7'd7;
#2 elv=7'd8;
#2 elv=7'd9;
#2 elv=7'd10;
#2 elv=7'd11;
#2 elv=7'd12;
#2 elv=7'd13;
#2 elv=7'd14;
#2 elv=7'd15;
#2 elv=7'd16;
#2 elv=7'd17;
#2 elv=7'd18;
#2 elv=7'd19;
#2 elv=7'd20;
#2 elv=7'd21;
#2 elv=7'd22;
#2 elv=7'd23;
#2 elv=7'd24;
#2 elv=7'd25;
#2 elv=7'd26;
#2 elv=7'd27;
#2 elv=7'd28;
#2 elv=7'd29;
#2 elv=7'd30;
#2 elv=7'd31;
#2 elv=7'd32;
#2 elv=7'd33;
#2 elv=7'd34;
#2 elv=7'd35;
#2 elv=7'd36;
#2 elv=7'd37;
#2 elv=7'd38;
#2 elv=7'd39;
#2 elv=7'd40;
#2 elv=7'd41;
#2 elv=7'd42;
#2 elv=7'd43;
#2 elv=7'd44;
#2 elv=7'd45;
#2 elv=7'd46;
#2 elv=7'd47;
#2 elv=7'd48;
#2 elv=7'd49;
#2 elv=7'd50;
#2 elv=7'd51;
#2 elv=7'd52;
#2 elv=7'd53;
#2 elv=7'd54;
#2 elv=7'd55;
#2 elv=7'd56;
#2 elv=7'd57;
#2 elv=7'd58;
#2 elv=7'd59;
#2 elv=7'd60;
#2 elv=7'd61;
#2 elv=7'd62;
#2 elv=7'd63;
#2 elv=7'd64;
#2 elv=7'd65;
#2 elv=7'd66;
#2 elv=7'd67;
#2 elv=7'd68;
#2 elv=7'd69;
#2 elv=7'd70;
#2 elv=7'd71;
#2 elv=7'd72;
#2 elv=7'd73;
#2 elv=7'd74;
#2 elv=7'd75;
#2 elv=7'd76;
#2 elv=7'd77;
#2 elv=7'd78;
#2 elv=7'd79;
#2 elv=7'd80;
#2 elv=7'd81;
#2 elv=7'd82;
#2 elv=7'd83;
#2 elv=7'd84;
#2 elv=7'd85;
#2 elv=7'd86;
#2 elv=7'd87;
#2 elv=7'd88;
#2 elv=7'd89;
#2 elv=7'd90;
#2 elv=7'd91;
#2 elv=7'd92;
#2 elv=7'd93;
#2 elv=7'd94;
#2 elv=7'd95;
#2 elv=7'd96;
#2 elv=7'd97;
#2 elv=7'd98;
#2 elv=7'd99;
end

    
endmodule
