module Pipeline_Register_MEM_WB
#(
	parameter N = 32,
	parameter valor_reset = 0
)
(
	input clk,
	input reset,
	input [N-1:0] PCPlus4Input,
	input [N-1:0] ReadDataInput,
	input [N-1:0] ALUResultInput,
	input [4:0] WriteRegisterInput,
	input [1:0] MemtoRegInput,	
	input RegWriteInput,	

	output reg  [N-1:0] PCPlus4Output,
	output reg  [N-1:0] ReadDataOutput,
	output reg  [N-1:0] ALUResultOutput,
	output reg  [4:0] WriteRegisterOutput,
	output reg  [1:0] MemtoRegOutput,	
	output reg  RegWriteOutput
);

always@(negedge reset or negedge clk) begin
	if(reset==0) begin
		ReadDataOutput <= valor_reset;
		ALUResultOutput <= valor_reset;
		WriteRegisterOutput <= valor_reset;
		MemtoRegOutput <= valor_reset;
		RegWriteOutput <= valor_reset;
		PCPlus4Output <= valor_reset;
		
	end else begin
		ReadDataOutput <= ReadDataInput;
		ALUResultOutput <= ALUResultInput;
		WriteRegisterOutput <= WriteRegisterInput;
		MemtoRegOutput <= MemtoRegInput;
		RegWriteOutput <= RegWriteInput;
		PCPlus4Output <= PCPlus4Input;
	end

end

endmodule