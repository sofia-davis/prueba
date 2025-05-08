module Pipeline_Register_IF_ID
#(
	parameter N = 32,
	parameter valor_reset = 0
)
(
	input clk,
	input reset,
	input enable,
	input [N-1:0] PCInput,
	input [N-1:0] InstructionInput,
	input [N-1:0] PCPlus4Input,
	
	output reg [N-1:0] PCOutput,
	output reg [N-1:0] PCPlus4Output,
	output reg [N-1:0] InstructionOutput
	
);

always@(negedge reset or negedge clk) begin
	if(reset==0) begin
		PCOutput <= valor_reset;
		InstructionOutput <= valor_reset;
		PCPlus4Output <= valor_reset;
		
	end else	if (enable==1) begin
		PCOutput<=PCInput;
		InstructionOutput<=InstructionInput;
		PCPlus4Output<=PCPlus4Input;
	end
	
end

endmodule