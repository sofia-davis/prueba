/******************************************************************
* Description
*	This is the control unit for the ALU. It receves a signal called 
*	ALUOp from the control unit and signals called funct7 and funct3  from
*	the instruction bus.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	16/08/2021
******************************************************************/
module ALU_Control
(
	input [5:0] funct7_i, 
	input [2:0] ALU_Op_i,
	input [2:0] funct3_i,
	

	output [3:0] ALU_Operation_o

);

localparam R_Type_ADD 	= 12'b000000_000_000;
localparam I_Type_ADDI 	= 12'bxxxxxx_001_000;
localparam U_Type_AUIPC	= 12'bxxxxxx_010_xxx;
localparam U_Type_LUI	= 12'bxxxxxx_110_xxx;
localparam I_Type_LW		= 12'bxxxxxx_011_010;
localparam S_Type_SW		= 12'bxxxxxx_100_010;
localparam B_Type_BNE	= 12'bxxxxxx_101_001;
localparam B_Type_BEQ	= 12'bxxxxxx_101_000;
localparam B_Type_BGE	= 12'bxxxxxx_101_101;
localparam I_Type_SLLI 	= 12'b000000_001_001;
localparam R_Type_SUB	= 12'b100000_000_000;
localparam R_Type_OR		= 12'b000000_000_110;
localparam R_Type_AND	= 12'b000000_000_111;
localparam R_Type_XOR	= 12'b000000_000_100;
localparam R_Type_SLL	= 12'b000000_000_001;
localparam R_Type_SRL	= 12'b000000_000_101;
localparam R_Type_MUL	= 12'b000001_000_000;
localparam I_Type_ORI	= 12'bxxxxxx_001_110;
localparam I_Type_ANDI	= 12'bxxxxxx_001_111;
localparam I_Type_XORI	= 12'bxxxxxx_001_100;
//localparam I_Type_JALR	= 12'bxxxxxx_111_000;


reg [3:0] alu_control_values;
wire [11:0] selector;

assign selector = {funct7_i, ALU_Op_i, funct3_i};

always@(selector)begin
	casex(selector)
	
		R_Type_ADD:  	alu_control_values = 4'b0000; 
		I_Type_ADDI: 	alu_control_values = 4'b0000;
		//U_Type_AUIPC:	alu_control_values = 4'b0001;
		U_Type_AUIPC:	alu_control_values = 4'b0000;
		U_Type_LUI:		alu_control_values = 4'b1011;
		I_Type_LW:		alu_control_values = 4'b0000;
		S_Type_SW:		alu_control_values = 4'b0000;
		B_Type_BNE:		alu_control_values = 4'b0010;
		B_Type_BEQ:		alu_control_values = 4'b1001;
		B_Type_BGE:		alu_control_values = 4'b1010;
		I_Type_SLLI:	alu_control_values = 4'b0011;
		R_Type_SUB: 	alu_control_values = 4'b0001;
		R_Type_OR:		alu_control_values = 4'b0100;
		R_Type_AND:		alu_control_values = 4'b0101;
		R_Type_XOR:		alu_control_values = 4'b0110;
		R_Type_SLL:		alu_control_values = 4'b0011;
		R_Type_SRL:		alu_control_values = 4'b0111;
		R_Type_MUL:		alu_control_values = 4'b1000;
		I_Type_ORI:		alu_control_values = 4'b0100;
		I_Type_ANDI:	alu_control_values = 4'b0101;
		I_Type_XORI: 	alu_control_values = 4'b0110;
		//I_Type_JALR: 	alu_control_values = 4'b0000;

		
		
		default: alu_control_values = 4'b00_00;
	endcase
end


assign ALU_Operation_o = alu_control_values;



endmodule
