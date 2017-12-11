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


module vm_tb2;
    reg Enable;
    reg RST;
    reg OneDollar;
    reg FiftyCents;
    reg TenCents;
    reg FiveCents;
    reg CLK;
    wire Rel;

	//for convenience I output this variables when debuged
    //wire[6:0] acc_coin;
    /*     used for debugging
    wire OneDollar_d;
    wire FiftyCents_d;
            wire TenCents_d;
            wire FiveCents_d;
            wire [3:0] INSERT;*/
          //  wire [3:0] PRE_INSERT;
    /**/        
    //wire[1:0] CURR_STATE;
    
    //period paramter
    parameter PER = 20.0;
    parameter LPER = 20000.0;
    VENDING_MACHINE uut(
        .Enable(Enable),
        .RST(RST),
        .OneDollar(OneDollar),
        .FiftyCents(FiftyCents),
        .TenCents(TenCents),
        .FiveCents(FiveCents),
        .CLK(CLK),
        .Rel(Rel),
        /*
        .acc_coin(acc_coin),
        */
        .OneDollar_d(OneDollar_d),

                .TenCents_d(TenCents_d),
                .FiveCents_d(FiveCents_d),
                .FiftyCents_d(FiftyCents_d)
                //.INSERT(INSERT),
               // .PRE_INSERT(PRE_INSERT)
            /*    */
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
    
    initial
    begin
		//when insert two dollar
        RST = 1'b1;
        #(2*PER) RST = 1'b0;	
        Enable = 1'b1;	//Release the rst and start to recieve coins
		//insert coin with boucing. 
		//Insert one dollar
        #(2*LPER)        
        OneDollar = 1'b1;                    
        #400000 OneDollar = 1'b0;          //blocked                  
        #800000 OneDollar = 1'b1;                        
        #800000 OneDollar = 1'b0;                                    
        #800000 OneDollar = 1'b1;        
        #40000000 OneDollar= 1'b0;                    
        #4000000 OneDollar = 1'b1;                            
        #40000000 OneDollar = 1'b0;        
        #400000 OneDollar= 1'b1;                    
        #800000 OneDollar= 1'b0;                            
        #800000 OneDollar = 1'b1;        
        #800000 OneDollar = 1'b0;        
        #40000000 OneDollar = 1'b1;                            
        #4000000 OneDollar = 1'b0;
        //insert one dollar
        #(10*LPER)
        OneDollar = 1'b1;
        #400000 OneDollar = 1'b0;                                    
        #800000 OneDollar = 1'b1;                                
        #800000 OneDollar = 1'b0;                                            
        #800000 OneDollar = 1'b1;                
        #40000000 OneDollar= 1'b0;                            
        #4000000 OneDollar = 1'b1;                                    
        #40000000 OneDollar = 1'b0;                
        #400000 OneDollar= 1'b1;                            
        #800000 OneDollar= 1'b0;                                    
        #800000 OneDollar = 1'b1;                
        #800000 OneDollar = 1'b0;                
        #40000000 OneDollar = 1'b1;                                    
        #4000000 OneDollar = 1'b0;

        //when insert one dollar fifty cents
        #(100*LPER)
        RST = 1'b1;
        #(2*LPER) RST = 1'b0;        
		//insert one dollar
        #(2*LPER)
        OneDollar = 1'b1;
        #400000 OneDollar = 1'b0;                                    
        #800000 OneDollar = 1'b1;                                
        #800000 OneDollar = 1'b0;                                            
        #800000 OneDollar = 1'b1;                
        #40000000 OneDollar= 1'b0;                            
        #4000000 OneDollar = 1'b1;                                   
        #40000000 OneDollar = 1'b0;                
        #400000 OneDollar= 1'b1;                            
        #800000 OneDollar= 1'b0;                                    
        #800000 OneDollar = 1'b1;                
        #800000 OneDollar = 1'b0;                
        #40000000 OneDollar = 1'b1;                                    
        #4000000 OneDollar = 1'b0;
        //inset FiftyCents
        #(10*LPER)
        FiftyCents = 1'b1;
        #400000 FiftyCents= 1'b0;                    
        #800000 FiftyCents= 1'b1;                                
        #800000 FiftyCents= 1'b0;                                            
        #800000 FiftyCents= 1'b1;                
        #40000000 FiftyCents= 1'b0;                            
        #4000000 FiftyCents= 1'b1;                                    
        #40000000 FiftyCents= 1'b0;                
        #400000 FiftyCents= 1'b1;                            
        #800000 FiftyCents= 1'b0;                                    
        #800000 FiftyCents= 1'b1;                
        #800000 FiftyCents= 1'b0;                
        #40000000 FiftyCents= 1'b1;                                    
        #4000000 FiftyCents= 1'b0;
        
        //one dollar twlve fiev cents
        #(10*LPER)
        RST = 1'b1;
		//Insert one dollar
        #(2*LPER)
        OneDollar = 1'b1;
        #400000 OneDollar = 1'b0;                                    
        #800000 OneDollar = 1'b1;                                
        #800000 OneDollar = 1'b0;                                            
        #800000 OneDollar = 1'b1;                
        #40000000 OneDollar= 1'b0;                            
        #4000000 OneDollar = 1'b1;                                   
        #40000000 OneDollar = 1'b0;                
        #400000 OneDollar= 1'b1;                            
        #800000 OneDollar= 1'b0;                                    
        #800000 OneDollar = 1'b1;                
        #800000 OneDollar = 1'b0;                
        #40000000 OneDollar = 1'b1;                                    
        #4000000 OneDollar = 1'b0;
		//insert ten cents
        #(2*LPER)
        OneDollar = 1'b1;
        #400000 TenCents = 1'b0;                                    
        #800000 TenCents = 1'b1;                                
        #800000 TenCents = 1'b0;                                            
        #800000 TenCents = 1'b1;                
        #40000000 TenCents= 1'b0;                            
        #4000000 TenCents = 1'b1;                                   
        #40000000 TenCents = 1'b0;                
        #400000 TenCents= 1'b1;                            
        #800000 TenCents= 1'b0;                                    
        #800000 TenCents = 1'b1;                
        #800000 TenCents = 1'b0;                
        #40000000 TenCents = 1'b1;                                    
        #4000000 TenCents = 1'b0;
		//inset ten cents
        #400000 TenCents = 1'b0;                                    
        #800000 TenCents = 1'b1;                                
        #800000 TenCents = 1'b0;                                            
        #800000 TenCents = 1'b1;                
        #40000000 TenCents= 1'b0;                            
        #4000000 TenCents = 1'b1;                                   
        #40000000 TenCents = 1'b0;                
        #400000 TenCents= 1'b1;                            
        #800000 TenCents= 1'b0;                                    
        #800000 TenCents = 1'b1;                
        #800000 TenCents = 1'b0;                
        #40000000 TenCents = 1'b1;                                    
        #4000000 TenCents = 1'b0;
		//insert five cents
        #400000 FiveCents = 1'b0;                                    
        #800000 FiveCents = 1'b1;                                
        #800000 FiveCents = 1'b0;                                            
        #800000 FiveCents = 1'b1;                
        #40000000 FiveCents= 1'b0;                            
        #4000000 FiveCents = 1'b1;                                   
        #40000000 FiveCents = 1'b0;                
        #400000 FiveCents= 1'b1;                            
        #800000 FiveCents= 1'b0;                                    
        #800000 FiveCents = 1'b1;                
        #800000 FiveCents = 1'b0;                
        #40000000 FiveCents = 1'b1;                                    
        #4000000 FiveCents = 1'b0;
    end
endmodule
