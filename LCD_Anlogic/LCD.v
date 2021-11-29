
module LCD (
	clk_24MHz_i        ,
	rst_n_i            ,
	LCD_R_o            ,
	LCD_G_o            ,
	LCD_B_o            ,
	LCD_Data_Valid_p_o ,
	LCD_PCLK_p_o       ,
	LCD_PWM_o         
) ;

/*    _i  : Input            */
/*    _o  : Output           */
/*    _b  : Bidirectional    */
/*    _od : Open Drain       */
/*    _p  : Posedge          */
/*    _n  : Negedge          */

/****************************************************************/

input                 clk_24MHz_i        ;
input                 rst_n_i            ;

wire                  clk_24MHz_i        ;
wire                  rst_n_i            ;

/****************************************************************/

wire                  pll_rst_p_i        ;

assign pll_rst_p_i = ~ rst_n_i           ;

wire                  pll_clk0_o         ;

EG_PHY_PLL clk_33MHz (
	.refclk   ( clk_24MHz_i                                               ) ,
	.reset    ( pll_rst_p_i                                               ) ,
	.stdby    ( 1'b0                                                      ) ,
	.extlock  ( open                                                      ) ,
	.load_reg ( 1'b0                                                      ) ,
	.psclk    ( 1'b0                                                      ) ,
	.psdown   ( 1'b0                                                      ) ,
	.psstep   ( 1'b0                                                      ) ,
	.psclksel ( 3'b000                                                    ) ,
	.psdone   ( open                                                      ) ,
	.dclk     ( 1'b0                                                      ) ,
	.dcs      ( 1'b0                                                      ) ,
	.dwe      ( 1'b0                                                      ) ,
	.di       ( 8'b00000000                                               ) ,
	.daddr    ( 6'b000000                                                 ) ,
	.do       ( { open , open , open , open , open , open , open , open } ) ,
	.fbclk    ( 1'b0                                                      ) ,
	.clkc     ( { open , open , open , open , pll_clk0_o }                )  
);
defparam clk_33MHz.DPHASE_SOURCE     = "DISABLE"     ;
defparam clk_33MHz.DYNCFG            = "DISABLE"     ;
defparam clk_33MHz.FIN               = "24.000"      ;
defparam clk_33MHz.FEEDBK_MODE       = "NOCOMP"      ;
defparam clk_33MHz.FEEDBK_PATH       = "VCO_PHASE_0" ;
defparam clk_33MHz.STDBY_ENABLE      = "DISABLE"     ;
defparam clk_33MHz.PLLRST_ENA        = "ENABLE"      ;
defparam clk_33MHz.SYNC_ENABLE       = "DISABLE"     ;
defparam clk_33MHz.DERIVE_PLL_CLOCKS = "DISABLE"     ;
defparam clk_33MHz.GEN_BASIC_CLOCK   = "DISABLE"     ;
defparam clk_33MHz.GMC_GAIN          = 0             ;
defparam clk_33MHz.ICP_CURRENT       = 9             ;
defparam clk_33MHz.KVCO              = 2             ;
defparam clk_33MHz.LPF_CAPACITOR     = 2             ;
defparam clk_33MHz.LPF_RESISTOR      = 8             ;
defparam clk_33MHz.REFCLK_DIV        = 2             ;
defparam clk_33MHz.FBCLK_DIV         = 75            ;
defparam clk_33MHz.CLKC0_ENABLE      = "ENABLE"      ;
defparam clk_33MHz.CLKC0_DIV         = 27            ;
defparam clk_33MHz.CLKC0_CPHASE      = 26            ;
defparam clk_33MHz.CLKC0_FPHASE      = 0             ;

wire                  clk_33MHz_i        ;

assign clk_33MHz_i = pll_clk0_o ;

/****************************************************************/

 // Standard: VESA                                  
 // Refresh Rate: 60 Hz ( 60.125060 Hz )            
 // Resolution: 800 x 480                           
 // Color Bit Depth (Bits Per Color): 8 bit         
 // Color Space : RGB                               
 // Chroma Sampling: Not Applicable                 
 // H-Total            1056 pixels                  
 // H-Blank             256 pixels                  
 // H-Sync Offset       N/A pixels                  
 // H-Sync Pulse        N/A pixels                  
 // H-Back Porch        N/A pixels                  
 // H-Active            800 pixels                  
 // H-Sync Polarity       -                         
 // H-Sync Freq       31500 Hz                      
 // H-Border              0 pixels                  
 // V-Total             525 lines   =  554400 pixels
 // V-Blank              45 lines   =   47520 pixels
 // V-Sync Offset       N/A lines   =     N/A pixels
 // V-Sync Pulse        N/A lines   =     N/A pixels
 // V-Back Porch        N/A lines   =     N/A pixels
 // V-Active            480 lines   =  506880 pixels
 // V-Sync Polarity       -                         
 // V-Sync Freq          60 Hz ( 60.125060 Hz )     
 // V-Border              0 lines                   
 // Pixel Clock             33333333.33333333 Hz    
 // Aspect Ratio        5:3                         
 // TMDS Clock          N/A                         
 // Active Pixels                      384000 pixels

localparam bpp             =    8 ;
localparam H_Total         = 1056 ;
localparam H_Blank_Total   =  256 ;
localparam H_Sync_Offset   =    0 ;
localparam H_Sync_Pulse    =    0 ;
localparam H_Back_Porch    =    0 ;
localparam H_Active        =  800 ;
localparam H_Sync_Polarity =    0 ; // ( 1 + 0 - )
localparam H_Border        =    0 ;
localparam V_Total         =  525 ;
localparam V_Blank_Total   =   45 ;
localparam V_Sync_Offset   =    0 ;
localparam V_Sync_Pulse    =    0 ;
localparam V_Back_Porch    =    0 ;
localparam V_Active        =  480 ;
localparam V_Sync_Polarity =    0 ; // ( 1 + 0 - )
localparam V_Border        =    0 ;

/****************************************************************/

output [ bpp - 1:00 ] LCD_R_o            ;
output [ bpp - 1:00 ] LCD_G_o            ;
output [ bpp - 1:00 ] LCD_B_o            ;
output                LCD_Data_Valid_p_o ;
output                LCD_PCLK_p_o       ;

wire   [ bpp - 1:00 ] LCD_R_o            ;
wire   [ bpp - 1:00 ] LCD_G_o            ;
wire   [ bpp - 1:00 ] LCD_B_o            ;
wire                  LCD_Data_Valid_p_o ;
wire                  LCD_PCLK_p_o       ;

/****************************************************************/

reg    [ $clog2(H_Total) : 0 ] H_Scanning_Counter   ;
wire   [ $clog2(H_Total) : 0 ] H_Scanning_Counter_i ;
wire   [ $clog2(H_Total) : 0 ] H_Scanning_Counter_o ;

/****/

assign H_Scanning_Counter_o = H_Scanning_Counter ;
assign H_Scanning_Counter_i = ( ( H_Scanning_Counter_o == ( H_Total - 1'b1 ) ) ? ( 'b0 ) : ( H_Scanning_Counter_o + 1'b1 ) ) ;

/****/

always @ ( posedge clk_33MHz_i or negedge rst_n_i ) begin
	if ( ! rst_n_i ) begin
		H_Scanning_Counter <= 'b0 ;
	end
	else begin
		H_Scanning_Counter <= H_Scanning_Counter_i ;
	end
end

/****************************************************************/

reg    [ $clog2(V_Total) : 0 ] V_Scanning_Counter   ;
wire   [ $clog2(V_Total) : 0 ] V_Scanning_Counter_i ;
wire   [ $clog2(V_Total) : 0 ] V_Scanning_Counter_o ;

/****/

assign V_Scanning_Counter_o = V_Scanning_Counter ;
assign V_Scanning_Counter_i =
	( 
		( ( V_Scanning_Counter_o == ( V_Total - 1'b1 ) ) & ( H_Scanning_Counter_o == ( H_Total - 1'b1 ) ) )
			?
				( 'b0 )
					:
				( ( H_Scanning_Counter_o == ( H_Total - 1'b1 ) ) ? ( V_Scanning_Counter_o + 1'b1 ) : ( V_Scanning_Counter_o ) )
	) ;

/****/

always @ ( posedge clk_33MHz_i or negedge rst_n_i ) begin
	if ( ! rst_n_i ) begin
		V_Scanning_Counter <= 'b0 ;
	end
	else begin
		V_Scanning_Counter <= V_Scanning_Counter_i ;
	end
end

/****************************************************************/

wire   [ bpp - 1:00 ] LCD_R_i          ;
wire   [ bpp - 1:00 ] LCD_G_i          ;
wire   [ bpp - 1:00 ] LCD_B_i          ;

assign LCD_R_i          = ( (
                              (
                    /* R**** */ ( ( H_Scanning_Counter_o >= H_Blank_Total        ) & ( H_Scanning_Counter_o <= ( H_Blank_Total + 160          - 1'b1 ) ) )
                    /* ***** */ &
                    /* ***** */ ( ( V_Scanning_Counter_o >= V_Blank_Total        ) & ( V_Scanning_Counter_o <= ( V_Blank_Total + 160          - 1'b1 ) ) )
                              )
                              |
                              (
                    /* ***** */ ( ( H_Scanning_Counter_o >= H_Blank_Total + 160  ) & ( H_Scanning_Counter_o <= ( H_Blank_Total + 320          - 1'b1 ) ) )
                    /* *R*** */ &
                    /* ***** */ ( ( V_Scanning_Counter_o >= V_Blank_Total + 160  ) & ( V_Scanning_Counter_o <= ( V_Blank_Total + 320          - 1'b1 ) ) )
                              )
                              |
                              (
                    /* ***** */ ( ( H_Scanning_Counter_o >= H_Blank_Total + 320  ) & ( H_Scanning_Counter_o <= ( H_Blank_Total + 480          - 1'b1 ) ) )
                    /* ***** */ &
                    /* **R** */ ( ( V_Scanning_Counter_o >= V_Blank_Total + 320  ) & ( V_Scanning_Counter_o <= ( V_Blank_Total + 480          - 1'b1 ) ) )
                              )
                              |
                              (
                    /* ***R* */ ( ( H_Scanning_Counter_o >= H_Blank_Total + 480  ) & ( H_Scanning_Counter_o <= ( H_Blank_Total + 640          - 1'b1 ) ) )
                    /* ***** */ &
                    /* ***** */ ( ( V_Scanning_Counter_o >= V_Blank_Total        ) & ( V_Scanning_Counter_o <= ( V_Blank_Total + 160          - 1'b1 ) ) )
                              )
                              |
                              (
                    /* ***** */ ( ( H_Scanning_Counter_o >= H_Blank_Total + 640  ) & ( H_Scanning_Counter_o <= ( H_Blank_Total + 800          - 1'b1 ) ) )
                    /* ****R */ &
                    /* ***** */ ( ( V_Scanning_Counter_o >= V_Blank_Total + 160  ) & ( V_Scanning_Counter_o <= ( V_Blank_Total + 320          - 1'b1 ) ) )
                              )
                            )                                                                                                                          ? (  8'b11111111    ) : (    8'b00000000    ) ) ;
assign LCD_G_i          = ( (
                              (
                    /* ***** */ ( ( H_Scanning_Counter_o >= H_Blank_Total        ) & ( H_Scanning_Counter_o <= ( H_Blank_Total + 160          - 1'b1 ) ) )
                    /* G**** */ &
                    /* ***** */ ( ( V_Scanning_Counter_o >= V_Blank_Total + 160  ) & ( V_Scanning_Counter_o <= ( V_Blank_Total + 320          - 1'b1 ) ) )
                              )
                              |
                              (
                    /* ***** */ ( ( H_Scanning_Counter_o >= H_Blank_Total + 160  ) & ( H_Scanning_Counter_o <= ( H_Blank_Total + 320          - 1'b1 ) ) )
                    /* ***** */ &
                    /* *G*** */ ( ( V_Scanning_Counter_o >= V_Blank_Total + 320  ) & ( V_Scanning_Counter_o <= ( V_Blank_Total + 480          - 1'b1 ) ) )
                              )
                              |
                              (
                    /* **G** */ ( ( H_Scanning_Counter_o >= H_Blank_Total + 320  ) & ( H_Scanning_Counter_o <= ( H_Blank_Total + 480          - 1'b1 ) ) )
                    /* ***** */ &
                    /* ***** */ ( ( V_Scanning_Counter_o >= V_Blank_Total        ) & ( V_Scanning_Counter_o <= ( V_Blank_Total + 160          - 1'b1 ) ) )
                              )
                              |
                              (
                    /* ***** */ ( ( H_Scanning_Counter_o >= H_Blank_Total + 480  ) & ( H_Scanning_Counter_o <= ( H_Blank_Total + 640          - 1'b1 ) ) )
                    /* ***G* */ &
                    /* ***** */ ( ( V_Scanning_Counter_o >= V_Blank_Total + 160  ) & ( V_Scanning_Counter_o <= ( V_Blank_Total + 320          - 1'b1 ) ) )
                              )
                              |
                              (
                    /* ***** */ ( ( H_Scanning_Counter_o >= H_Blank_Total + 640  ) & ( H_Scanning_Counter_o <= ( H_Blank_Total + 800          - 1'b1 ) ) )
                    /* ***** */ &
                    /* ****G */ ( ( V_Scanning_Counter_o >= V_Blank_Total + 320  ) & ( V_Scanning_Counter_o <= ( V_Blank_Total + 480          - 1'b1 ) ) )
                              )
                            )                                                                                                                          ? (  8'b11111111    ) : (    8'b00000000    ) ) ;
assign LCD_B_i          = ( (
                              (
                    /* ***** */ ( ( H_Scanning_Counter_o >= H_Blank_Total        ) & ( H_Scanning_Counter_o <= ( H_Blank_Total + 160          - 1'b1 ) ) )
                    /* ***** */ &
                    /* B**** */ ( ( V_Scanning_Counter_o >= V_Blank_Total + 320  ) & ( V_Scanning_Counter_o <= ( V_Blank_Total + 480          - 1'b1 ) ) )
                              )
                              |
                              (
                    /* *B*** */ ( ( H_Scanning_Counter_o >= H_Blank_Total + 160  ) & ( H_Scanning_Counter_o <= ( H_Blank_Total + 320          - 1'b1 ) ) )
                    /* ***** */ &
                    /* ***** */ ( ( V_Scanning_Counter_o >= V_Blank_Total        ) & ( V_Scanning_Counter_o <= ( V_Blank_Total + 160          - 1'b1 ) ) )
                              )
                              |
                              (
                    /* ***** */ ( ( H_Scanning_Counter_o >= H_Blank_Total + 320  ) & ( H_Scanning_Counter_o <= ( H_Blank_Total + 480          - 1'b1 ) ) )
                    /* **B** */ &
                    /* ***** */ ( ( V_Scanning_Counter_o >= V_Blank_Total + 160  ) & ( V_Scanning_Counter_o <= ( V_Blank_Total + 320          - 1'b1 ) ) )
                              )
                              |
                              (
                    /* ***** */ ( ( H_Scanning_Counter_o >= H_Blank_Total + 480  ) & ( H_Scanning_Counter_o <= ( H_Blank_Total + 640          - 1'b1 ) ) )
                    /* ***** */ &
                    /* ***B* */ ( ( V_Scanning_Counter_o >= V_Blank_Total + 320  ) & ( V_Scanning_Counter_o <= ( V_Blank_Total + 480          - 1'b1 ) ) )
                              )
                              |
                              (
                    /* ****B */ ( ( H_Scanning_Counter_o >= H_Blank_Total + 640  ) & ( H_Scanning_Counter_o <= ( H_Blank_Total + 800          - 1'b1 ) ) )
                    /* ***** */ &
                    /* ***** */ ( ( V_Scanning_Counter_o >= V_Blank_Total        ) & ( V_Scanning_Counter_o <= ( V_Blank_Total + 160          - 1'b1 ) ) )
                              )
                            )                                                                                                                          ? (  8'b11111111    ) : (    8'b00000000    ) ) ;

/****/

wire                  LCD_Data_Valid_i ;

assign LCD_Data_Valid_i = ( (
                            ( ( H_Scanning_Counter_o >= H_Blank_Total        ) & ( H_Scanning_Counter_o <= ( H_Total                      - 1'b1 ) ) )
                            &
                            ( ( V_Scanning_Counter_o >= V_Blank_Total        ) & ( V_Scanning_Counter_o <= ( V_Total                      - 1'b1 ) ) )
                            )                                                                                                                          ? (  1'b1           ) : (    1'b0           ) ) ;

/****/

reg    [ bpp - 1:00 ] LCD_R          ;
reg    [ bpp - 1:00 ] LCD_G          ;
reg    [ bpp - 1:00 ] LCD_B          ;
reg                   LCD_Data_Valid ;

always @ ( posedge clk_33MHz_i or negedge rst_n_i ) begin
	if ( ! rst_n_i ) begin
		LCD_R          <= 'b0 ;
		LCD_G          <= 'b0 ;
		LCD_B          <= 'b0 ;
		LCD_Data_Valid <= 'b0 ;
	end
	else begin
		LCD_R          <= LCD_R_i          ;
		LCD_G          <= LCD_G_i          ;
		LCD_B          <= LCD_B_i          ;
		LCD_Data_Valid <= LCD_Data_Valid_i ;
	end
end

assign LCD_R_o            = LCD_R          ;
assign LCD_G_o            = LCD_G          ;
assign LCD_B_o            = LCD_B          ;
assign LCD_Data_Valid_p_o = LCD_Data_Valid ;

/****************************************************************/

assign LCD_PCLK_p_o       = rst_n_i ? clk_33MHz_i : 1'b0 ;

/****************************************************************/

output                LCD_PWM_o          ;

wire                  LCD_PWM_o          ;

assign LCD_PWM_o        = rst_n_i ? 1'b1    : 1'b0 ;

/****************************************************************/

endmodule
