module Pipeline_Register_ID_EX
#(
	parameter N = 32,
	parameter valor_reset = 0
)
(
	input clk,
	input reset,
	input [N-1:0] PCInput,
	input [N-1:0] PCPlus4Input,
	input [N-1:0] ReadData1Input,
	input [N-1:0] ReadData2Input,
	input [N-1:0] ImmInput,
	input [2:0] Funct3Input,
	input [6:0] Funct7Input,
	input [4:0] WriteRegisterInput,
	input [1:0] JalInput,
	input [1:0] MemtoRegInput,
	input RegWriteInput,
	input BranchInput,
	input MemWriteInput,
	input MemreadInput,
	input AuipcInput,
	input [2:0]ALUOPInput,
	input ALUSrcInput,
	input [4:0] Register_Rs1_Input,
	input [4:0] Register_Rs2_Input,

	output reg [N-1:0] PCOutput,
	output reg [N-1:0] PCPlus4Output,
	output reg [N-1:0] ReadData1Output,
	output reg [N-1:0] ReadData2Output,
	output reg [N-1:0] ImmOutput,
	output reg [2:0] Funct3Output,
	output reg [6:0] Funct7Output,
	output reg [4:0] WriteRegisterOutput,
	output reg [1:0] JalOutput,
	output reg [1:0] MemtoRegOutput,
	output reg RegWriteOutput,
	output reg BranchOutput,
	output reg MemWriteOutput,
	output reg MemreadOutput,
	output reg AuipcOutput,
	output reg [2:0]ALUOPOutput,
	output reg ALUSrcOutput,
	output reg [4:0] Register_Rs1_Output,
	output reg [4:0] Register_Rs2_Output
);

always@(negedge reset or negedge clk) begin
	if(reset==0) begin
		PCOutput <= valor_reset;
		ReadData1Output <= valor_reset;
		ReadData2Output <= valor_reset;
		ImmOutput <= valor_reset;
		Funct3Output <= valor_reset;
		Funct7Output <= valor_reset;
		WriteRegisterOutput <= valor_reset;
		JalOutput <= valor_reset;
		MemtoRegOutput <= valor_reset;
		RegWriteOutput <= valor_reset;
		BranchOutput <= valor_reset;
		MemWriteOutput <= valor_reset;
		MemreadOutput <= valor_reset;
		AuipcOutput <= valor_reset;
		ALUOPOutput <= valor_reset;
		ALUSrcOutput <= valor_reset;
		PCPlus4Output <= valor_reset;
		Register_Rs1_Output <= valor_reset;
		Register_Rs2_Output <= valor_reset;
		
	end else	begin
		PCOutput <= PCInput;
		ReadData1Output <= ReadData1Input;
		ReadData2Output <= ReadData2Input;
		ImmOutput <= ImmInput;
		Funct3Output <= Funct3Input;
		Funct7Output <= Funct7Input;
		WriteRegisterOutput <= WriteRegisterInput;
		JalOutput <= JalInput;
		MemtoRegOutput <= MemtoRegInput;
		RegWriteOutput <= RegWriteInput;
		BranchOutput <= BranchInput;
		MemWriteOutput <= MemWriteInput;
		MemreadOutput <= MemreadInput;
		AuipcOutput <= AuipcInput;
		ALUOPOutput <= ALUOPInput;
		ALUSrcOutput <= ALUSrcInput;
		PCPlus4Output <= PCPlus4Input;
		Register_Rs1_Output <= Register_Rs1_Input;
		Register_Rs2_Output <= Register_Rs2_Input;
	end
	
end

endmodule