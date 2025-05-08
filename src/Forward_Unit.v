module Forward_Unit
(
	input [4:0]Rs1_id_ex,
	input [4:0]Rs2_id_ex,
	input [4:0]Rd_ex_mem,
	input [4:0]Rd_mem_wb,
	input reg_write_ex_mem,
	input reg_write_mem_wb,
	
	output reg [1:0]Selector_a_alu,
	output reg [1:0]Selector_b_alu
	
);

always@(*) begin

	if (reg_write_ex_mem && (Rd_ex_mem != 0) && (Rd_ex_mem == Rs1_id_ex))
			Selector_a_alu = 2'b10;
	else if (reg_write_mem_wb && (Rd_mem_wb != 0) && (Rd_ex_mem != Rs1_id_ex) && (Rd_mem_wb == Rs1_id_ex))
			Selector_a_alu = 2'b01;
	else 
		Selector_a_alu = 2'b00;
		
		
	if (reg_write_ex_mem && (Rd_ex_mem != 0) && (Rd_ex_mem == Rs2_id_ex))
			Selector_b_alu = 2'b10;	
	else if (reg_write_mem_wb && (Rd_mem_wb != 0) && (Rd_ex_mem != Rs2_id_ex) && (Rd_mem_wb == Rs2_id_ex))
			Selector_b_alu = 2'b01;		
	else 
		Selector_b_alu = 2'b00;	
	
end

endmodule