`timescale 1ns / 100ps
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
	output reg Rel,
	//output reg [6:0] acc_coin,
	/* used for debugging,  for convenience when debuged, I outputed the variables and commented them when finished debugging*/
	output OneDollar_d,
	output FiftyCents_d,
	output TenCents_d,
	output FiveCents_d
	//output reg [2:1] CURR_STATE
	//output [3:0] INSERT,
	
	//output reg [3:0] PRE_INSERT
	
    );
    
    //reg[15:0] acc_coin = 0, tmp=0;
    reg[6:0] acc_coin = 0;
    reg[6:0]  tmp = 0;
	localparam[1:0] INIT = 2'd0,
				WAIT_COIN = 2'd1,
				RELEASE_ITEM = 2'd2;
	reg[1:0]  CURR_STATE, NEXT_STATE;

        wire [3:0] INSERT;   //used to combine the input
	reg [3:0] PRE_INSERT = 0;    // used to show the previous value of INSERT
	/*
	wire OneDollar_d=0;
	wire FiftyCents_d=0;
	wire TenCents_d=0;
	wire FiveCents_d=0;
    /**/
        // debouncing module 
	DeBounce u1(.clk(CLK), .n_reset(RSST),.button_in(OneDollar),  .DB_out(OneDollar_d));
	DeBounce u2(.clk(CLK), .n_reset(RST), .button_in(FiftyCents), .DB_out(FiftyCents_d));
	DeBounce u3(.clk(CLK), .n_reset(RST), .button_in(TenCents),   .DB_out(TenCents_d));
	DeBounce u4(.clk(CLK), .n_reset(RST), .button_in(FiveCents),  .DB_out(FiveCents_d));

	assign INSERT = {OneDollar_d, FiftyCents_d, TenCents_d, FiveCents_d};
	
	//implement the state flip-flop
	always @(posedge CLK)
	if(RST)
		CURR_STATE <= INIT;
	else
		CURR_STATE <= NEXT_STATE;
	
        //when to change the state
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
                if(acc_coin >= 125)
					NEXT_STATE <= RELEASE_ITEM;
				else
					NEXT_STATE <= CURR_STATE;
			end
			RELEASE_ITEM:begin
                                //release item and automaticly jump back to WAIT_COIN state
				NEXT_STATE <= WAIT_COIN;
			end
		endcase
	end

	
	always@(posedge CLK)begin
	   if(CURR_STATE == INIT)begin
	       acc_coin = 0;
	       Rel = 0;
	       PRE_INSERT = 0;
	   end
		else if(CURR_STATE == WAIT_COIN)begin
		  if(INSERT != PRE_INSERT)begin
		      case(INSERT)
		          4'b0000:begin
		              PRE_INSERT = 0;
		          end
		          4'b0001:begin
		              acc_coin = acc_coin + 5;
		              PRE_INSERT = INSERT;
		              end
		         4'b0010:begin
		              acc_coin = acc_coin + 10;
		              PRE_INSERT = INSERT;
		         end
		         4'b0100:begin
		              acc_coin = acc_coin + 50;
		              PRE_INSERT = INSERT;
		         end
		         4'b1000:begin
		              acc_coin = acc_coin + 100;
		              PRE_INSERT = INSERT;
		         end
		      endcase
		  end
		  else
		      PRE_INSERT = PRE_INSERT;
		end
		else if(CURR_STATE == RELEASE_ITEM)begin
			acc_coin <= acc_coin - 125;
			Rel <= 1'b1;
		end
		
	end
	
endmodule
