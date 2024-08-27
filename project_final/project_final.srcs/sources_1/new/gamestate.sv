`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/13 13:33:36
// Design Name: 
// Module Name: gamestate
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


module gamestate(
    input logic Clk,reset,
    input logic [1:0] fb, //simulator feedback 00=flyimg, 01=miss, 10=p1hit, 11=p2hit
    input logic [7:0] keycode, 
    output logic [1:0] p1m, p2m, gameState, // player movement, player action, gamestate gamestate: 00 start, 01 game over, 10 p1 round, 11 p2 round
    output logic [2:0] p1a, p2a, p1h, p2h, //health
    output logic [5:0] Fuel
    );
    enum logic [4:0] {game_start, init1, init2, player_1, player_2, proj_1, proj_2, buf_1, buf_2, buf_3, game_over}   State, Next_state;
    logic [5:0] fuel;
    logic [1:0] P1m, P2m;
    
    always_ff @ (posedge Clk)
	begin
		if (reset) begin
			State <= game_start;
		    fuel<=6'b111111;
	     end
		else begin
			State <= Next_state;
		    if((keycode==8'd4||keycode==8'd7)&&fuel!=6'b0)begin
		      fuel<=fuel-1;
		      p1m<=P1m;
		      p2m<=P2m;
		    end
		    else if(p1a==3'b001||p2a==3'b001)begin
		      fuel<=6'b111111;
		    end
		    else begin
		      p1m<=2'b00;
		      p2m<=2'b00;
		    end
		    if(gameState==2'b00)begin
		      p1h<=3'b111;
		      p2h<=3'b111;
		    end
		    if(fb==2'b10)
		      p1h<=p1h-1;
		    else if(fb==2'b11)
		      p2h<=p2h-1;
		end
	end
	
	always_comb
	begin 
		Next_state = State;
		P1m=2'b00;
		P2m=2'b00;
		p1a=3'b000;
		p2a=3'b000;
		gameState=2'b00;
		Fuel=fuel;
		unique case (State)
		  game_start:begin
		      if(keycode!=8'b0)
		          Next_state=init1;
		  end
		  init1:begin
		      Next_state=init2;
		  end
		  init2:begin
		      Next_state=player_1;
		  end
		  player_1:begin
		      if(keycode==8'd44)
		          Next_state=proj_1;
		      else
		          Next_state=player_1;
		      end
		  player_2:begin
		      if(keycode==8'd44)
		          Next_state=proj_2;
		      else
		          Next_state=player_2;
		      end
		  proj_1:
		      begin
		      if(fb==2'b0)
		          Next_state=proj_1;
		      else begin
		          Next_state=buf_1;
		          if(p1h==4'b1&&fb==2'b10||p2h==4'b1&&fb==2'b11)
		              Next_state=game_over;
		      end
		      end
		  buf_1:
		      begin
		          if(keycode!=8'd44)
		              Next_state=player_2;
		      end
		  proj_2:
		      begin
		      if(fb==2'b0)
		          Next_state=proj_2;
		      else begin
		          Next_state=buf_2;
		          if(p1h==4'b1&&fb==2'b10||p2h==4'b1&&fb==2'b11)
		              Next_state=game_over;
		      end
		      end
		  buf_2:
		      begin
		          if(keycode!=8'd44)
		              Next_state=player_1;
		      end
		  game_over:
		      if(keycode!=8'b0&&keycode!=8'd44)
		          Next_state=buf_3;
		  buf_3:
		      begin
		          if(keycode==8'd0)
		              Next_state=game_start;
		      end
		  default:;
		endcase
		
		case (State)
		  game_start:
		      gameState=2'b00;
		  init1:
		      gameState=2'b10;
		  init2:
		      gameState=2'b11;
		  player_1:begin
		      gameState=2'b10;
		          if(keycode==8'd7)
		              P1m=2'b10;
		          else if(keycode==8'd4)
		              P1m=2'b11;
		          else
		              P1m=2'b00;
		          if(keycode==8'd26)
		              p1a=3'b010;
		          else if(keycode==8'd22)
		              p1a=3'b011;
		          else if(keycode==8'd81)
		              p1a=3'b100;
		          else if(keycode==8'd82)
		              p1a=3'b101;
		          else
		              p1a=3'b000;
		  end
		  player_2:begin
		      gameState=2'b11;
		          if(keycode==8'd7)
		                  P2m=2'b10;
		          else if(keycode==8'd4)
		                  P2m=2'b11;
		          else
		              P2m=2'b00;
		          if(keycode==8'd26)
		              p2a=3'b010;
		          else if(keycode==8'd22)
		              p2a=3'b011;
		          else if(keycode==8'd81)
		              p2a=3'b100;
		          else if(keycode==8'd82)
		              p2a=3'b101;
		          else
		              p2a=3'b000;
		  end
		  proj_1: begin
		      gameState=2'b10;
		      P1m=2'b0;
		      p1a=3'b001;
		  end
		  buf_1: begin
		      gameState=2'b11;
		      P2m=2'b00;
		      p2a=3'b000;
		      end
		  proj_2: begin
		      gameState=2'b11;
		      P2m=2'b0;
		      p2a=3'b001;
		  end
		  buf_2: begin
		      gameState=2'b10;
		      P1m=2'b00;
		      p1a=3'b000;
		      end
		  game_over:
		      gameState=2'b01;
		  buf_3:
		      gameState=2'b00;
		endcase
	end
    
endmodule
