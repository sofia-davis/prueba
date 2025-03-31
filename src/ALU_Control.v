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
	input funct7_i, 
	input [2:0] ALU_Op_i,
	input [2:0] funct3_i,
	

	output [3:0] ALU_Operation_o

);

localparam R_Type_ADD 	= 7'b0_000_000;
localparam I_Type_ADDI 	= 7'bx_001_000;
localparam U_Type_AUIPC	= 7'bx_010_xxx;
localparam I_Type_LW		= 7'bx_011_010;
localparam S_Type_SW		= 7'bx_100_010;
localparam B_Type_BNE	= 7'bx_101_001;
localparam I_Type_SLLI 	= 7'b0_001_001;


reg [3:0] alu_control_values;
wire [6:0] selector;

assign selector = {funct7_i, ALU_Op_i, funct3_i};

always@(selector)begin
	casex(selector)
	
		R_Type_ADD:  	alu_control_values = 4'b0000; 
		I_Type_ADDI: 	alu_control_values = 4'b0000;
		//U_Type_AUIPC:	alu_control_values = 4'b0001;
		U_Type_AUIPC:	alu_control_values = 4'b0000;
		I_Type_LW:		alu_control_values = 4'b0000;
		S_Type_SW:		alu_control_values = 4'b0000;
		B_Type_BNE:		alu_control_values = 4'b0010;
		I_Type_SLLI:	alu_control_values = 4'b0011;
		
		
		default: alu_control_values = 4'b00_00;
	endcase
end


assign ALU_Operation_o = alu_control_values;



endmodule
