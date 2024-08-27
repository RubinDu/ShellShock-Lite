`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/14 19:35:33
// Design Name: 
// Module Name: colormapper
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


module colormapper(
input logic Clk, reset,
input  logic [9:0] P1x, P2x, P1y, P2y, projx, projy,ter_y, DrawX, DrawY,
input logic [6:0] Elv_output1, Elv_output2, mv_output, Fuel,
input logic [2:0] p1a, p2a, p1h, p2h,
input logic [1:0] gameState,
input logic [7:0] Ang,
output logic [3:0]  Red, Green, Blue
);
    logic p1_on, p2_on, proj_on, ter_on, dirs, dirc, dirx, diry, sub, b1_on, b2_on, as_on, h1_on, h2_on, f1_on, f2_on, bd_on1, bd_on2, bd_on3, bd_on4, ttl_on, blk_on, end_on, blu_on, grn_on, hlt_on, ful_on;
    logic [9:0] drawy, asx, asy, charaddr, p1x, p2x, p1y, p2y;
    logic [6:0] sin, cos, Sin, Cos, elv_output, p1f, p2f, elv_output1, elv_output2;
    logic [4:0]  xp, yp, offx, offy, addr,sum1, sum2, res1, res2, buft;
    logic [5:0] bufr;
    logic [7:0] ct,offc, ang;
    logic [31:0] data;
    logic [175:0] chardata;
    logic [12:0] mult1, mult2, mult3, mult4;
    int DistX, DistY;
    assign drawy=10'd480-DrawY;
    assign DistX = DrawX - projx;
    assign DistY = drawy - projy;
 
    sinTable SinMod(.angle(ang),.ratio({dirs, Sin}));
    sinTable CosMod(.angle(ang+7'b1000000),.ratio({dirc, Cos}));
    sinTable animation(.angle(ct),.ratio( offc));
    barrel b1(.x_init(p1x), .y_init(p1y+10'd8), .xp(DrawX), .yp(drawy), .elv(elv_output1), .on(b1_on));
    barrel b2(.x_init(p2x), .y_init(p2y+10'd8), .xp(DrawX), .yp(drawy), .elv(elv_output2), .on(b2_on));
    aimassist as(.x_init(asx), .y_init(asy), .xp(DrawX), .yp(drawy), .elv(elv_output), .mv(mv_output), .on(as_on));
    statusbar h1(.x_init(10'd224), .y_init(10'd450), .xp(DrawX), .yp(drawy), .value({p1h,p1h}), .bd(bd_on1),.on(h1_on));
    statusbar h2(.x_init(10'd352), .y_init(10'd450), .xp(DrawX), .yp(drawy), .value({p2h,p2h}), .bd(bd_on2),.on(h2_on));
    statusbar f1(.x_init(10'd224), .y_init(10'd440), .xp(DrawX), .yp(drawy), .value(p1f[5:0]), .bd(bd_on3),.on(f1_on));
    statusbar f2(.x_init(10'd352), .y_init(10'd440), .xp(DrawX), .yp(drawy), .value(p2f[5:0]), .bd(bd_on4),.on(f2_on));
    spriterom rom(.addr, .data);
    charrom char(.addr(charaddr), .data(chardata));
    
    
    always_ff @ (posedge Clk)
	begin
	if(reset)
	   ct<=8'b0;
	else begin
	   ct<=ct+2'b10;
	end
	end
    
    always_comb
    begin
        if ((DrawX-p1x<4'd12||p1x-DrawX<4'd12)&&drawy-p1y<5'd24) begin
            yp=4'd15-(drawy-p1y);
            xp=DrawX+4'd8-p1x;
            addr=res2;
            p1_on=data[5'd31-res1]||b1_on;
        end
        else 
            p1_on = 1'b0;
        if ((DrawX-p2x<4'd12||p2x-DrawX<4'd12)&&drawy-p2y<5'd24)begin
            yp=4'd15-(drawy-p2y);
            xp = DrawX+4'd8-p2x;
            addr=res2;
            p2_on=data[res1]||b2_on;
        end
        else 
            p2_on = 1'b0;
        if ((DistX*DistX + DistY*DistY) <= 9)
            proj_on = 1'b1;
        else 
            proj_on = 1'b0;
        if (ter_y>drawy)
            ter_on = 1'b1;
        else 
            ter_on = 1'b0;
        if(gameState==2'b10)begin
            ang=Ang;
            p1x=P1x;
            p1y=P1y;
            p2x=P2x;
            p2y=P2y;
            elv_output1=Elv_output1;
            elv_output2=Elv_output2;
            asx=p1x;
            asy=p1y+3'd5;
            elv_output=elv_output1;
            p1f=Fuel;
            p2f=7'b0;
        end
        else if(gameState==2'b11) begin
            ang=Ang;
            p1x=P1x;
            p1y=P1y;
            p2x=P2x;
            p2y=P2y;
            elv_output1=Elv_output1;
            elv_output2=Elv_output2;
            asx=p2x;
            asy=p2y+3'd5;
            elv_output=elv_output2;
            p1f=7'b0;
            p2f=Fuel;
        end 
        else begin
            ang=8'b0;
            p1x=10'd100;
            p1y=10'd240;
            elv_output1=7'b0;
            p2x=10'd540;
            p2y=10'd240;
            elv_output2=7'b1111111;
        end
        
     end 
     
     always_comb begin:characters
        if(gameState==2'b00)begin
            if(DrawX>10'd200&&DrawX<10'd440&&drawy>10'd303+offc[7:5]&&drawy<10'd335+offc[7:5])begin
                charaddr=(10'd335+offc[7:5]-drawy)/2;
                ttl_on=chardata[(10'd440-DrawX)/2];
                blk_on=1'b0;
            end
            else if(DrawX>10'd232&&DrawX<10'd408&&drawy>10'd150&&drawy<10'd166)begin
                charaddr=10'd166-drawy+5'd16;
                blk_on=chardata[10'd408-DrawX]&ct[7];
                ttl_on=1'b0;
            end
            else begin
                ttl_on=1'b0;
                blk_on=1'b0;
            end
        end
        else if(gameState==2'b01)begin
            if(DrawX>10'd272&&DrawX<10'd368&&drawy>10'd192&&drawy<10'd240)begin
                charaddr=(10'd240-drawy)/3+7'd80;
                end_on=chardata[(10'd368-DrawX)/3];
                blu_on=1'b0;
                grn_on=1'b0;
            end
            else if(p1h==3'b0)begin
                if(DrawX>10'd280&&DrawX<10'd360&&drawy>10'd240&&drawy<10'd272)begin
                charaddr=(10'd272-drawy)/2+7'd64;
                end_on=1'b0;
                blu_on=1'b0;
                grn_on=chardata[(10'd360-DrawX)/2];
                end
                else begin
                    end_on=1'b0;
                    blu_on=1'b0;
                    grn_on=1'b0;
                end
            end
            else begin
                if(DrawX>10'd288&&DrawX<10'd352&&drawy>10'd240&&drawy<10'd272)begin
                charaddr=(10'd272-drawy)/2+6'd48;
                end_on=1'b0;
                blu_on=chardata[(10'd352-DrawX)/2];
                grn_on=1'b0;
                end
                else begin
                    end_on=1'b0;
                    blu_on=1'b0;
                    grn_on=1'b0;
                end
            end
        end
        else begin
                if(DrawX>10'd296&&DrawX<10'd344&&drawy>10'd450&&drawy<10'd466)begin
                charaddr=10'd466-drawy+7'd96;
                hlt_on=chardata[10'd344-DrawX];
                ful_on=1'b0;
                end
                else if(DrawX>10'd304&&DrawX<10'd336&&drawy>10'd434&&drawy<10'd450)begin
                charaddr=10'd450-drawy+7'd112;
                hlt_on=1'b0;
                ful_on=chardata[10'd336-DrawX];
                end
                else begin
                hlt_on=1'b0;
                ful_on=1'b0;
                end
        end
     end
     
     always_comb begin:rotation
        if(!dirs)
            sin=7'b1111111-Sin;
        else
            sin=Sin;
        if(!dirc)
            cos=7'b1111111-Cos;
        else
            cos=Cos;
        if(xp>=8)begin
            dirx=1'b1;
            offx=xp-5'd8;
        end
        else begin
            dirx=1'b0;
            offx=5'd8-xp;
        end
        if(yp>=8)begin
            diry=1'b1;
            offy=yp-5'd8;
        end
        else begin
            diry=1'b0;
            offy=5'd8-yp;
        end
        mult1=cos*offx;
        mult2=sin*offy;
        mult3=sin*offx;
        mult4=cos*offy;
        if(dirc==dirx)
            sum1=5'd16+mult1/11'h7f;
        else
            sum1=5'd16-mult1/11'h7f;
        if((!dirs)==diry)
            res1=sum1+mult2/11'h7f;
        else
            res1=sum1-mult2/11'h7f;
        if(dirs==dirx)
            sum2=5'd16+mult3/11'h7f;
        else
            sum2=5'd16-mult3/11'h7f;
        if(dirc==diry)
            res2=sum2+mult4/11'h7f;
        else 
            res2=sum2-mult4/11'h7f;
     end
     
    always_comb
    begin:RGB_Display
        if(gameState==2'b00)begin
            if (blk_on) begin 
            Red = 4'h0;
            Green = 4'h0;
            Blue = 4'h0;
            end 
            else if (ttl_on) begin 
            Red = DrawY[4:1]+2'd3;
            Green = DrawY[4:1]+2'd3;
            Blue = DrawY[4:1]+2'd3;
            end       
            else if ((p1_on == 1'b1)) begin 
            buft =drawy-p1y+4'h4;
            Red = buft[4:1];
            Green = buft[4:1];
            Blue = 4'hf;
            end       
            else if ((p2_on == 1'b1)) begin 
            buft =drawy-p2y+4'h4;
            Red = buft[4:1];
            Green = 4'hf;
            Blue = buft[4:1];
            end
            else begin 
            Red = 4'hf - drawy[9:6]; 
            Green = 4'hf - drawy[9:6];
            Blue = 4'hf;
            end    
        end
        else if(gameState==2'b10||gameState==2'b11) begin
            if ((bd_on1||bd_on2||bd_on3||bd_on4||hlt_on||ful_on)) begin 
            Red = 4'h0;
            Green = 4'h0;
            Blue = 4'h0;
            end 
            else if ((h1_on == 1'b1)) begin 
            Red = 4'hf;
            Green = {p1h,p1h[3]};
            Blue = 4'h0;
            end 
            else if ((h2_on == 1'b1)) begin 
            Red = 4'hf;
            Green = {p2h,1'b0};
            Blue = 4'h0;
            end 
            else if ((f1_on == 1'b1&&p1a!=3'b001&&p2a!=3'b001)) begin 
            Red = 4'h0;
            Green = 4'hf;
            Blue = 4'h0;
            end 
            else if ((f2_on == 1'b1&&p1a!=3'b001&&p2a!=3'b001)) begin 
            Red = 4'h0;
            Green = 4'hf;
            Blue = 4'h0;
            end 
            else if ((p1_on == 1'b1)) begin 
            buft =drawy-p1y+4'h4;
            Red = buft[4:1];
            Green = buft[4:1];
            Blue = 4'hf;
            end       
            else if ((p2_on == 1'b1)) begin 
            buft =drawy-p2y+4'h4;
            Red = buft[4:1];
            Green = 4'hf;
            Blue = buft[4:1];
            end
            else if ((ter_on == 1'b1)) begin 
            if(ter_y-drawy>10'd63)begin
                Red = 4'h3;
                Green = 4'h2;
                Blue = 4'h0;
            end
            else begin
                bufr=ter_y-drawy;
                Red = 3'd6-bufr[5:4];
                Green = 4'd10-bufr[5:3];
                Blue = 4'h0;
            end
            end       
            else if ((proj_on == 1'b1&&(p1a==3'b001||p2a==3'b001))) begin 
            Red = 4'hf;
            Green = 4'h0;
            Blue = 4'h0;
            end              
            else if ((as_on == 1'b1)) begin 
            Red = 4'h0;
            Green = 4'h0;
            Blue = 4'h0;
            end      
            else begin 
            Red = 4'hf - drawy[9:6]; 
            Green = 4'hf - drawy[9:6];
            Blue = 4'hf;
            end       
        end
        else begin
            if(end_on)begin
            Red = 4'b0; 
            Green = 4'b0;
            Blue = 4'b0;
            end
            else if(blu_on)begin
            Red = 4'b0; 
            Green = 4'b0;
            Blue = 4'hf;
            end
            else if(grn_on)begin
            Red = 4'b0; 
            Green = 4'hf;
            Blue = 4'b0;
            end
            else begin 
            Red = 4'hf - drawy[9:6]; 
            Green = 4'hf - drawy[9:6];
            Blue = 4'hf;
            end       
        end
    end 
    
    
endmodule
