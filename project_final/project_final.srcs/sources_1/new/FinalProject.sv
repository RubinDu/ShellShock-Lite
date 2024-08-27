`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/13 13:24:38
// Design Name: 
// Module Name: FinalProject
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


module FinalProject(
    input logic Clk,
    input logic reset_rtl_0,
    
    //USB signals
    input logic [0:0] gpio_usb_int_tri_i,
    output logic gpio_usb_rst_tri_o,
    input logic usb_spi_miso,
    output logic usb_spi_mosi,
    output logic usb_spi_sclk,
    output logic usb_spi_ss,
    
    //UART
    input logic uart_rtl_0_rxd,
    output logic uart_rtl_0_txd,
    
    //HDMI
    output logic hdmi_tmds_clk_n,
    output logic hdmi_tmds_clk_p,
    output logic [2:0]hdmi_tmds_data_n,
    output logic [2:0]hdmi_tmds_data_p,
        
    //HEX displays
    output logic [7:0] hex_segA,
    output logic [3:0] hex_gridA,
    output logic [7:0] hex_segB,
    output logic [3:0] hex_gridB
    );
    logic [31:0] keycode0_gpio, keycode1_gpio;
    logic clk_25MHz, clk_125MHz, clk_100MHz;
    logic locked;
    logic [9:0] drawX, drawY, Xa, Xb, Ya, Yb;
    logic[7:0] Anga, Angb;
    logic [1:0] p1m, p2m, gameState, fb;
    logic [2:0] p1a, p2a, p1h, p2h;
    logic [9:0]  p1x, p2x, p1y, p2y, projx, projy;

    logic hsync, vsync, vde;
    logic [3:0] red, green, blue;
    logic reset_ah;
    logic [6:0] elv_output1, elv_output2, mv_output, Fuel;
    logic [7:0] ang;
    
    assign reset_ah = reset_rtl_0;
    
    always_ff@(posedge vsync)begin
        if(reset_ah)
            ang<=8'b0;
        else if(keycode0_gpio[7:0]==8'd20)
            ang<=ang+1'b1;
        else
            ang<=ang;
    end
    
    HexDriver HexA (
        .clk(Clk),
        .reset(reset_ah),
        .in({{2'b00,gameState}, {2'b00,fb}, {0,p1h}, {0,p2h}}),
        .hex_seg(hex_segA),
        .hex_grid(hex_gridA)
    );
    
    HexDriver HexB (
        .clk(Clk),
        .reset(reset_ah),
        .in({ {1'b0,p1a}, {1'b0,p2a}, elv_output1[6:3], elv_output2[6:3]}),
        .hex_seg(hex_segB),
        .hex_grid(hex_gridB)
    );
    
    design_1 design_1_i(
        .clk_100MHz(Clk),
        .gpio_usb_int_tri_i(gpio_usb_int_tri_i),
        .gpio_usb_keycode_0_tri_o(keycode0_gpio),
        .gpio_usb_keycode_1_tri_o(keycode1_gpio),
        .gpio_usb_rst_tri_o(gpio_usb_rst_tri_o),
        .reset_rtl_0(~reset_ah), //Block designs expect active low reset, all other modules are active high
        .uart_rtl_0_rxd(uart_rtl_0_rxd),
        .uart_rtl_0_txd(uart_rtl_0_txd),
        .usb_spi_miso(usb_spi_miso),
        .usb_spi_mosi(usb_spi_mosi),
        .usb_spi_sclk(usb_spi_sclk),
        .usb_spi_ss(usb_spi_ss)
    );
    
    level terrain(.Xa, .Xb(drawX), .Ya, .Yb, .Anga, .Angb);
    
    gamestate status(.Clk(vsync),.reset(reset_ah), .fb, .keycode(keycode0_gpio[7:0]), .p1m, .p2m, .p1a, .p2a,.gameState, .p1h, .p2h, .Fuel
        );
    
    simulator Simulator(.Clk(vsync),.reset(reset_ah),
        .p1m, .p2m, .p1a, .p2a,.gameState,
        .ty(Ya),.tx(Xa),.p1x, .p2x, .p1y, .p2y, .projx, .projy,.fb, .elv_output1, .elv_output2, .mv_output);
    
    colormapper render(.Clk(vsync), .reset(reset_ah),.P1x(p1x), .P2x(p2x), .P1y(p1y), .P2y(p2y), .p1a, .p2a,.p1h, .p2h,.gameState, .projx, .projy,.ter_y(Yb), .DrawX(drawX), .DrawY(drawY), .Ang(Angb), .Elv_output1(elv_output1), .Elv_output2(elv_output2), .mv_output, .Fuel,.Red(red), .Green(green), .Blue(blue));
    
    clk_wiz_0 clk_wiz (
        .clk_out1(clk_25MHz),
        .clk_out2(clk_125MHz),
        .reset(reset_ah),
        .locked(locked),
        .clk_in1(Clk)
    );
    
        vga_controller vga (
        .pixel_clk(clk_25MHz),
        .reset(reset_ah),
        .hs(hsync),
        .vs(vsync),
        .active_nblank(vde),
        .drawX(drawX),
        .drawY(drawY)
    );    
    
        hdmi_tx_0 vga_to_hdmi (
        //Clocking and Reset
        .pix_clk(clk_25MHz),
        .pix_clkx5(clk_125MHz),
        .pix_clk_locked(locked),
        //Reset is active LOW
        .rst(reset_ah),
        //Color and Sync Signals
        .red(red),
        .green(green),
        .blue(blue),
        .hsync(hsync),
        .vsync(vsync),
        .vde(vde),
        
        //aux Data (unused)
        .aux0_din(4'b0),
        .aux1_din(4'b0),
        .aux2_din(4'b0),
        .ade(1'b0),
        
        //Differential outputs
        .TMDS_CLK_P(hdmi_tmds_clk_p),          
        .TMDS_CLK_N(hdmi_tmds_clk_n),          
        .TMDS_DATA_P(hdmi_tmds_data_p),         
        .TMDS_DATA_N(hdmi_tmds_data_n)          
    );
    
endmodule
