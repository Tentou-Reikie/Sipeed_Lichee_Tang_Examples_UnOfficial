
module RGB_LED (
	clk_24MHz_i ,
	rst_n_i     ,
	LED_R_n_o   ,
	LED_G_n_o   ,
	LED_B_n_o    
) ;

/*    _i  : Input            */
/*    _o  : Output           */
/*    _b  : Bidirectional    */
/*    _od : Open Drain       */
/*    _p  : Posedge          */
/*    _n  : Negedge          */

/****************************************************************/

input          clk_24MHz_i    ;
input          rst_n_i        ;

wire           clk_24MHz_i    ;
wire           rst_n_i        ;

/****************************************************************/

reg    [15:00] PWM_Counter    ;

/****/

always @ ( posedge clk_24MHz_i or negedge rst_n_i ) begin
	if ( ! rst_n_i ) begin
		PWM_Counter <= 16'h0000 ;
	end
	else begin
		PWM_Counter <= PWM_Counter + 1'b1 ;
	end
end

/****/

wire           PWM_clk_p_i    ;

assign PWM_clk_p_i = ( PWM_Counter == 16'hFFFF ) ;

/****************************************************************/

reg    [02:00] RGB_State      ;
reg    [07:00] R_PWM_Counter  ;
reg    [07:00] G_PWM_Counter  ;
reg    [07:00] B_PWM_Counter  ;

/****/

always @ ( posedge PWM_clk_p_i or negedge rst_n_i ) begin
	if ( ! rst_n_i ) begin
		RGB_State     <= 3'b000 ;
		R_PWM_Counter <= 8'h00  ;
		G_PWM_Counter <= 8'h00  ;
		B_PWM_Counter <= 8'h00  ;
	end
	else begin
		if ( RGB_State == 3'b000 ) begin
			     if ( R_PWM_Counter != 8'hFF ) begin
				RGB_State     <= RGB_State            ;
				R_PWM_Counter <= R_PWM_Counter + 1'b1 ;
				G_PWM_Counter <= G_PWM_Counter        ;
				B_PWM_Counter <= B_PWM_Counter        ;
			end
			else if ( R_PWM_Counter == 8'hFF ) begin
				RGB_State     <= 3'b100               ;
				R_PWM_Counter <= R_PWM_Counter        ;
				G_PWM_Counter <= G_PWM_Counter        ;
				B_PWM_Counter <= B_PWM_Counter        ;
			end
			else begin
				RGB_State     <= RGB_State            ;
				R_PWM_Counter <= R_PWM_Counter        ;
				G_PWM_Counter <= G_PWM_Counter        ;
				B_PWM_Counter <= B_PWM_Counter        ;
			end
		end
		else if ( RGB_State == 3'b100 ) begin
			     if ( G_PWM_Counter != 8'hFF ) begin
				RGB_State     <= RGB_State            ;
				R_PWM_Counter <= R_PWM_Counter        ;
				G_PWM_Counter <= G_PWM_Counter + 1'b1 ;
				B_PWM_Counter <= B_PWM_Counter        ;
			end
			else if ( G_PWM_Counter == 8'hFF ) begin
				RGB_State     <= 3'b110               ;
				R_PWM_Counter <= R_PWM_Counter        ;
				G_PWM_Counter <= G_PWM_Counter        ;
				B_PWM_Counter <= B_PWM_Counter        ;
			end
			else begin
				RGB_State     <= RGB_State            ;
				R_PWM_Counter <= R_PWM_Counter        ;
				G_PWM_Counter <= G_PWM_Counter        ;
				B_PWM_Counter <= B_PWM_Counter        ;
			end
		end
		if ( RGB_State == 3'b110 ) begin
			     if ( R_PWM_Counter != 8'h00 ) begin
				RGB_State     <= RGB_State            ;
				R_PWM_Counter <= R_PWM_Counter - 1'b1 ;
				G_PWM_Counter <= G_PWM_Counter        ;
				B_PWM_Counter <= B_PWM_Counter        ;
			end
			else if ( R_PWM_Counter == 8'h00 ) begin
				RGB_State     <= 3'b010               ;
				R_PWM_Counter <= R_PWM_Counter        ;
				G_PWM_Counter <= G_PWM_Counter        ;
				B_PWM_Counter <= B_PWM_Counter        ;
			end
			else begin
				RGB_State     <= RGB_State            ;
				R_PWM_Counter <= R_PWM_Counter        ;
				G_PWM_Counter <= G_PWM_Counter        ;
				B_PWM_Counter <= B_PWM_Counter        ;
			end
		end
		if ( RGB_State == 3'b010 ) begin
			     if ( B_PWM_Counter != 8'hFF ) begin
				RGB_State     <= RGB_State            ;
				R_PWM_Counter <= R_PWM_Counter        ;
				G_PWM_Counter <= G_PWM_Counter        ;
				B_PWM_Counter <= B_PWM_Counter + 1'b1 ;
			end
			else if ( B_PWM_Counter == 8'hFF ) begin
				RGB_State     <= 3'b011               ;
				R_PWM_Counter <= R_PWM_Counter        ;
				G_PWM_Counter <= G_PWM_Counter        ;
				B_PWM_Counter <= B_PWM_Counter        ;
			end
			else begin
				RGB_State     <= RGB_State            ;
				R_PWM_Counter <= R_PWM_Counter        ;
				G_PWM_Counter <= G_PWM_Counter        ;
				B_PWM_Counter <= B_PWM_Counter        ;
			end
		end
		if ( RGB_State == 3'b011 ) begin
			     if ( G_PWM_Counter != 8'h00 ) begin
				RGB_State     <= RGB_State            ;
				R_PWM_Counter <= R_PWM_Counter        ;
				G_PWM_Counter <= G_PWM_Counter - 1'b1 ;
				B_PWM_Counter <= B_PWM_Counter        ;
			end
			else if ( G_PWM_Counter == 8'h00 ) begin
				RGB_State     <= 3'b001               ;
				R_PWM_Counter <= R_PWM_Counter        ;
				G_PWM_Counter <= G_PWM_Counter        ;
				B_PWM_Counter <= B_PWM_Counter        ;
			end
			else begin
				RGB_State     <= RGB_State            ;
				R_PWM_Counter <= R_PWM_Counter        ;
				G_PWM_Counter <= G_PWM_Counter        ;
				B_PWM_Counter <= B_PWM_Counter        ;
			end
		end
		if ( RGB_State == 3'b001 ) begin
			     if ( R_PWM_Counter != 8'hFF ) begin
				RGB_State     <= RGB_State            ;
				R_PWM_Counter <= R_PWM_Counter + 1'b1 ;
				G_PWM_Counter <= G_PWM_Counter        ;
				B_PWM_Counter <= B_PWM_Counter        ;
			end
			else if ( R_PWM_Counter == 8'hFF ) begin
				RGB_State     <= 3'b101               ;
				R_PWM_Counter <= R_PWM_Counter        ;
				G_PWM_Counter <= G_PWM_Counter        ;
				B_PWM_Counter <= B_PWM_Counter        ;
			end
			else begin
				RGB_State     <= RGB_State            ;
				R_PWM_Counter <= R_PWM_Counter        ;
				G_PWM_Counter <= G_PWM_Counter        ;
				B_PWM_Counter <= B_PWM_Counter        ;
			end
		end
		else if ( RGB_State == 3'b101 ) begin
			     if ( B_PWM_Counter != 8'h00 ) begin
				RGB_State     <= RGB_State            ;
				R_PWM_Counter <= R_PWM_Counter        ;
				G_PWM_Counter <= G_PWM_Counter        ;
				B_PWM_Counter <= B_PWM_Counter - 1'b1 ;
			end
			else if ( B_PWM_Counter == 8'h00 ) begin
				RGB_State     <= 3'b100               ;
				R_PWM_Counter <= R_PWM_Counter        ;
				G_PWM_Counter <= G_PWM_Counter        ;
				B_PWM_Counter <= B_PWM_Counter        ;
			end
			else begin
				RGB_State     <= RGB_State            ;
				R_PWM_Counter <= R_PWM_Counter        ;
				G_PWM_Counter <= G_PWM_Counter        ;
				B_PWM_Counter <= B_PWM_Counter        ;
			end
		end
	end
end

/****************************************************************/

reg            LED_R          ;
reg            LED_G          ;
reg            LED_B          ;
wire           LED_R_i        ;
wire           LED_G_i        ;
wire           LED_B_i        ;

/****/

assign LED_R_i = ( PWM_Counter [15:08] < R_PWM_Counter ) ? ( 1'b0 ) : ( 1'b1 ) ;
assign LED_G_i = ( PWM_Counter [15:08] < G_PWM_Counter ) ? ( 1'b0 ) : ( 1'b1 ) ;
assign LED_B_i = ( PWM_Counter [15:08] < B_PWM_Counter ) ? ( 1'b0 ) : ( 1'b1 ) ;

/****/

always @ ( posedge clk_24MHz_i or negedge rst_n_i ) begin
	if ( ! rst_n_i ) begin
		LED_R <= 'b0 ;
		LED_G <= 'b0 ;
		LED_B <= 'b0 ;
	end
	else begin
		LED_R <= LED_R_i ;
		LED_G <= LED_G_i ;
		LED_B <= LED_B_i ;
	end
end

/****/

output         LED_R_n_o      ;
output         LED_G_n_o      ;
output         LED_B_n_o      ;

wire           LED_R_n_o      ;
wire           LED_G_n_o      ;
wire           LED_B_n_o      ;

assign LED_R_n_o = LED_R ;
assign LED_G_n_o = LED_G ;
assign LED_B_n_o = LED_B ;

/****************************************************************/

endmodule
