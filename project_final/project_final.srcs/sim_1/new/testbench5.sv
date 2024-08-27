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


module testbench5();

timeunit 10ns;
timeprecision 1ns;

logic Clk;
logic [9:0] Xa, Xb;
logic [9:0] Ya, Yb;
logic [7:0] Anga, Angb;

level terrain(.*);

always begin: CLOCK_GENERATION
    #1 Clk=~Clk;
end
   
initial begin: CLOCK_INITIALIZATION
    Clk=0;
end

initial begin: TEST_VECTORS
    Xa=10'b10;
    Xb=10'b10;
    
#2 Xa=10'd0;
#2 Xa=10'd1;
#2 Xa=10'd2;
#2 Xa=10'd3;
#2 Xa=10'd4;
#2 Xa=10'd5;
#2 Xa=10'd6;
#2 Xa=10'd7;
#2 Xa=10'd8;
#2 Xa=10'd9;
#2 Xa=10'd10;
#2 Xa=10'd11;
#2 Xa=10'd12;
#2 Xa=10'd13;
#2 Xa=10'd14;
#2 Xa=10'd15;
#2 Xa=10'd16;
#2 Xa=10'd17;
#2 Xa=10'd18;
#2 Xa=10'd19;
#2 Xa=10'd20;
#2 Xa=10'd21;
#2 Xa=10'd22;
#2 Xa=10'd23;
#2 Xa=10'd24;
#2 Xa=10'd25;
#2 Xa=10'd26;
#2 Xa=10'd27;
#2 Xa=10'd28;
#2 Xa=10'd29;
#2 Xa=10'd30;
#2 Xa=10'd31;
#2 Xa=10'd32;
#2 Xa=10'd33;
#2 Xa=10'd34;
#2 Xa=10'd35;
#2 Xa=10'd36;
#2 Xa=10'd37;
#2 Xa=10'd38;
#2 Xa=10'd39;
#2 Xa=10'd40;
#2 Xa=10'd41;
#2 Xa=10'd42;
#2 Xa=10'd43;
#2 Xa=10'd44;
#2 Xa=10'd45;
#2 Xa=10'd46;
#2 Xa=10'd47;
#2 Xa=10'd48;
#2 Xa=10'd49;
#2 Xa=10'd50;
#2 Xa=10'd51;
#2 Xa=10'd52;
#2 Xa=10'd53;
#2 Xa=10'd54;
#2 Xa=10'd55;
#2 Xa=10'd56;
#2 Xa=10'd57;
#2 Xa=10'd58;
#2 Xa=10'd59;
#2 Xa=10'd60;
#2 Xa=10'd61;
#2 Xa=10'd62;
#2 Xa=10'd63;
#2 Xa=10'd64;
#2 Xa=10'd65;
#2 Xa=10'd66;
#2 Xa=10'd67;
#2 Xa=10'd68;
#2 Xa=10'd69;
#2 Xa=10'd70;
#2 Xa=10'd71;
#2 Xa=10'd72;
#2 Xa=10'd73;
#2 Xa=10'd74;
#2 Xa=10'd75;
#2 Xa=10'd76;
#2 Xa=10'd77;
#2 Xa=10'd78;
#2 Xa=10'd79;
#2 Xa=10'd80;
#2 Xa=10'd81;
#2 Xa=10'd82;
#2 Xa=10'd83;
#2 Xa=10'd84;
#2 Xa=10'd85;
#2 Xa=10'd86;
#2 Xa=10'd87;
#2 Xa=10'd88;
#2 Xa=10'd89;
#2 Xa=10'd90;
#2 Xa=10'd91;
#2 Xa=10'd92;
#2 Xa=10'd93;
#2 Xa=10'd94;
#2 Xa=10'd95;
#2 Xa=10'd96;
#2 Xa=10'd97;
#2 Xa=10'd98;
#2 Xa=10'd99;
end

    
endmodule
