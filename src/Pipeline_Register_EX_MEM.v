module Pipeline_Register_EX_MEM
#(
	parameter N = 32,
	parameter valor_reset = 0
)
(
	input clk,
	input reset,
	input [N-1:0] PCPlusImmInput,
	input [N-1:0] PCPlus4Input,
	input [N-1:0] ReadData2Input,
	input [N-1:0] ALUResultInput,
	input [4:0] WriteRegisterInput,
	input JalInput,
	input [1:0] MemtoRegInput,	
	input RegWriteInput,
	input BranchInput,
	input MemWriteInput,
	input MemreadInput,
	input ZeroInput,

	output reg  [N-1:0] PCPlusImmOutput,
	output reg  [N-1:0] PCPlus4Output,
	output reg  [N-1:0] ReadData2Output,
	output reg  [N-1:0] ALUResultOutput,
	output reg  [4:0] WriteRegisterOutput,
	output reg  JalOutput,
	output reg  [1:0] MemtoRegOutput,	
	output reg  RegWriteOutput,
	output reg  BranchOutput,
	output reg  MemWriteOutput,
	output reg  MemreadOutput,
	output reg  ZeroOutput
);

always@(negedge reset or negedge clk) begin
	if(reset==0) begin
		PCPlusImmOutput <= valor_reset;
		ReadData2Output <= valor_reset;
		ALUResultOutput <= valor_reset;
		WriteRegisterOutput <= valor_reset;
		JalOutput <= valor_reset;
		MemtoRegOutput <= valor_reset;
		RegWriteOutput <= valor_reset;
		BranchOutput <= valor_reset;
		MemWriteOutput <= valor_reset;
		MemreadOutput <= valor_reset;
		ZeroOutput <= valor_reset;
		PCPlus4Output <= valor_reset;
		
	end else begin
		PCPlusImmOutput <= PCPlusImmInput;
		ReadData2Output <= ReadData2Input;
		ALUResultOutput <= ALUResultInput;
		WriteRegisterOutput <= WriteRegisterInput;
		JalOutput <= JalInput;
		MemtoRegOutput <= MemtoRegInput;
		RegWriteOutput <= RegWriteInput;
		BranchOutput <= BranchInput;
		MemWriteOutput <= MemWriteInput;
		MemreadOutput <= MemreadInput;
		ZeroOutput <= ZeroInput;
		PCPlus4Output <= PCPlus4Input;
	end
	
end

endmodule