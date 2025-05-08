module Decodificador (
    input [31:0] Address_i,
    input Mem_write_i,
    input Mem_read_i,
    
    output  Mem_write_ram_o,
    output  Mem_write_gpio_o,
    output  Mem_read_ram_o,
    output  Mem_read_gpio_o,
    output  reg selector_gpio_o,
    output  [31:0] address_gpio_o,
    output  [31:0] address_ram_o
);



assign  address_gpio_o   = Address_i;
assign  address_ram_o   = Address_i;

assign Mem_write_gpio_o = Mem_write_i;
assign Mem_read_gpio_o = Mem_read_i;
assign Mem_write_ram_o = Mem_write_i;
assign Mem_read_ram_o = Mem_read_i;


    always @(*) begin

        selector_gpio_o   = 0;

        // GPIO: 0x10010100 - salida
        //       0x10010108 - entrada
        if (Address_i == 32'h10010024 && Mem_write_i)
            //32'h10010100: begin // Escritura al GPIO (LEDs)
                selector_gpio_o  = 1;
                
            else if (Address_i == 32'h10010028 && Mem_read_i)

            //32'h10010108: begin // Lectura desde GPIO (Switches)
 
                selector_gpio_o = 1;
            
					// Todo lo demás es RAM
				else
                selector_gpio_o = 0;

		end

endmodule
