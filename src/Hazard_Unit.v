module Hazard_Unit
(
	input [4:0]Rs1_if_id,
	input [4:0]Rs2_if_id,
	input [4:0]Rd_id_ex,
	input [4:0]Rs1_id_ex,
	input mem_read_id_ex,
	input mem_read_if_id,
	input mem_write_id_ex,
	
	output reg pc_enable,
	output reg if_id_enable,
	output reg selector_hazard
);

always@(*) begin

	if (mem_read_id_ex && ((Rd_id_ex == Rs1_if_id) | (Rd_id_ex == Rs2_if_id))) begin 
		selector_hazard = 1'b1;
		pc_enable = 1'b0;
		if_id_enable = 1'b0;
	
	end 
	
	else if ((mem_write_id_ex && mem_read_if_id) && (Rs1_id_ex == Rs1_if_id)) begin 
		selector_hazard = 1'b1;
		pc_enable = 1'b0;
		if_id_enable = 1'b0;
	
	end
	
	else begin
		selector_hazard = 1'b0;
		pc_enable = 1'b1;
		if_id_enable = 1'b1;
		
	end
	
end

endmodule