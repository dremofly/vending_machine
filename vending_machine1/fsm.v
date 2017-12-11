`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2016 03:43:31 PM
// Design Name: 
// Module Name: state_machine
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


module VENDING_MACHINE(
    input Enable,
	input RST,
	input OneDollar,
	input FiftyCents,
	input TenCents,
	input FiveCents,
	input CLK,
	output reg Release,
	output reg [6:0] acc_coin
	//output reg [2:1] CURR_STATE
    );
    
    //reg[15:0] acc_coin = 0, tmp=0;
    reg[6:0]  tmp = 0;
	localparam[1:0] INIT = 2'd0,
				WAIT_COIN = 2'd1,
				RELEASE_ITEM = 2'd2;
	reg[1:0]  CURR_STATE, NEXT_STATE;
	//reg RELEASE_FLAG=0;
	reg [3:0] PRE_INSERT = 0;
	wire [3:0] INSERT;
	wire RELEASE_FLAG;
	
	assign INSERT = {OneDollar, FiftyCents, TenCents, FiveCents};
	
	//implement the state flip-flop
	always @(posedge CLK)
	if(RST)
		CURR_STATE <= INIT;
	else
		CURR_STATE <= NEXT_STATE;
	
	always @(CURR_STATE, acc_coin, INSERT)begin
		case(CURR_STATE)
			INIT:begin
				if(Enable==1'b1)
					NEXT_STATE <= WAIT_COIN;
				else
					NEXT_STATE <= CURR_STATE;
			end
			WAIT_COIN:begin
			    //can not jump to INIT, because i dismiss 
			    //the poweroff problem
                if(acc_coin >= 25)
					NEXT_STATE <= RELEASE_ITEM;
				else
					NEXT_STATE <= CURR_STATE;
			end
			RELEASE_ITEM:begin
				NEXT_STATE <= WAIT_COIN;
			end
		endcase
	end

	
	always@(posedge CLK)begin
	   if(CURR_STATE == INIT)begin
	       acc_coin = 0;
	       Release = 0;
	   end
		else if(CURR_STATE == WAIT_COIN)begin
				if(INSERT==4'b0001&PRE_INSERT!=INSERT)begin
				    tmp = acc_coin;
				    tmp = acc_coin;
					acc_coin = tmp + 1;
					PRE_INSERT = PRE_INSERT;
				end
				else if(INSERT==4'b0010&PRE_INSERT!=INSERT)begin
				    tmp = acc_coin;
					acc_coin = tmp + 2;
					PRE_INSERT = INSERT;
				end
				else if(INSERT==4'b0100&PRE_INSERT!=INSERT)begin
				    tmp = acc_coin;
					acc_coin = tmp + 10;
					PRE_INSERT = INSERT;
				end
				else if(INSERT == 4'b1000&PRE_INSERT!=INSERT)begin
					tmp = acc_coin;
					acc_coin = tmp + 20;
					PRE_INSERT = INSERT;
				end
				else
				    PRE_INSERT = 0;
				//Release <= 1'b0;
		end
		else if(CURR_STATE == RELEASE_ITEM)begin
			acc_coin <= acc_coin - 25;
			Release <= 1'b1;
			//#10
			//Release <= 1'b0;
		end
	end
	
endmodule