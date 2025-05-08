module GPIO #(
    parameter DATA_WIDTH = 32
)(
    input clk,
	 input reset,
    input Mem_Read_i,
    input Mem_Write_i,
    input [31:0] gpio_addr_i,
    input [31:0] gpio_in_i,
    input [8:0] gpio_port_in_i,      // switches

    output reg [31:0] gpio_out_o,    // dato leído desde GPIO
    output reg [8:0] gpio_port_out_o // salida a los LEDs
);

    // Direcciones
    localparam GPIO_OUT_ADDR = 32'h10010024; // LEDS
    localparam GPIO_IN_ADDR  = 32'h10010028; // SWITCHES

    always @(posedge clk, negedge reset) begin
        if(reset==0)
		gpio_port_out_o <= 0;
	else	
		if(Mem_Write_i && gpio_addr_i == GPIO_OUT_ADDR)
			gpio_port_out_o <= gpio_in_i[8:0]; // solo los 9 bits bajos a los LEDs
    end
	 
always @(*) begin	
		if(Mem_Read_i && gpio_addr_i == GPIO_IN_ADDR)
			gpio_out_o <= gpio_port_in_i[8:0]; // solo los 9 bits bajos a los LEDs
		else
         gpio_out_o = 32'b0;
    end

endmodule
