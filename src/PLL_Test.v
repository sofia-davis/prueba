module PLL_Test
(
	input clk,
	input reset,
	
	output clk_pll
	
);

wire clk_pll_w;
wire clk_div_w;

Clock_Generator	
clk_gen
(
	.inclk0 ( clk ),
	.c0 ( clk_pll_w )
	
);

Clock_Divider
clk_div
(
		.clk(clk_pll_w ),
		.reset(reset),
		
		.clk_div(clk_div_w)
);
assign clk_pll = clk_div_w;

endmodule