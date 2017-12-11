`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/07 20:43:47
// Design Name: 
// Module Name: vm_tb
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


module vm_tb;
    reg Enable;
    reg RST;
    reg OneDollar;
    reg FiftyCents;
    reg TenCents;
    reg FiveCents;
    reg CLK;
    wire Release;
    wire[6:0] acc_coin;
    //wire[1:0] CURR_STATE;
    
    
    parameter PER = 10.0;
    VENDING_MACHINE uut(
        .Enable(Enable),
        .RST(RST),
        .OneDollar(OneDollar),
        .FiftyCents(FiftyCents),
        .TenCents(TenCents),
        .FiveCents(FiveCents),
        .CLK(CLK),
        .Release(Release),
        .acc_coin(acc_coin)
        //.CURR_STATE(CURR_STATE)
    );
    initial begin
    //initial inputs
    CLK = 0;
    RST = 0;
    OneDollar = 0;
    FiftyCents = 0;
    TenCents = 0;
    FiveCents = 0;
    end
    
    //run the clock
    always
        #(PER/2) CLK = ~CLK;
    
    always
    begin
        RST = 1'b1;
        #(2*PER) RST = 1'b0;
        Enable = 1'b1;
        //two dollar
        #(2*PER)
        OneDollar = 1'b1;
        #(2*PER)
        OneDollar = 1'b0;
        #(10*PER)
        OneDollar = 1'b1;
        #(2*PER)
        OneDollar = 1'b0;
        //one dollar fifty cents
        #(10*PER)
        RST = 1'b1;
        #(2*PER) RST = 1'b0;
        
        #(2*PER)
        OneDollar = 1'b1;
        #(2*PER)
        OneDollar = 1'b0;
        #(10*PER)
        FiftyCents = 1'b1;
        #(2*PER)
        FiftyCents = 1'b0;
        //one dollar twlve cents
        #(10*PER)
        RST = 1'b1;
        #(2*PER) RST = 1'b0;
        
        #(2*PER)
        OneDollar = 1'b1;
        #(2*PER)
        OneDollar = 1'b0;
        #(10*PER)
        TenCents = 1'b1;
        #(2*PER)
        TenCents = 1'b0;
        #(10*PER)
        TenCents = 1'b1; 
        #(2*PER)
        TenCents = 1'b0;
        #(10*PER)
        FiveCents = 1'b1;
        #(2*PER)
        FiveCents = 1'b0;
    end
endmodule