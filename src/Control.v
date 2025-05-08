/******************************************************************
* Description
*	This is control unit for the RISC-V Microprocessor. The control unit is 
*	in charge of generation of the control signals. Its only input 
*	corresponds to opcode from the instruction bus.
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	16/08/2021
******************************************************************/
module Control
(
	input [6:0]OP_i,
	
	output [1:0]Jal_o,
	output Auipc_o,
	output Branch_o,
	output Mem_Read_o,
	output [1:0]Mem_to_Reg_o,
	output Mem_Write_o,
	output ALU_Src_o,
	output Reg_Write_o,
	output [2:0]ALU_Op_o
);



localparam R_Type 		= 7'h33;
localparam I_Type_LOGIC = 7'h13;
localparam U_Type 		= 7'h17;
localparam I_Type 		= 7'h3;
localparam S_Type 		= 7'h23;
localparam B_Type 		= 7'h63;
localparam J_Type 		= 7'h6f;
localparam I_Type_jalr 	= 7'h67;
localparam U_Type_lui 	= 7'h37;

reg [12:0] control_values;

always@(OP_i) begin							// 11_1	
	case(OP_i)//                           21_09_87_6_54_3_210
		R_Type: 			control_values = 13'b00_00_10_1_00_0_000;
		I_Type_LOGIC: 	control_values = 13'b00_00_10_1_00_1_001;
		U_Type:			control_values = 13'b00_10_10_1_00_1_010;
		I_Type:			control_values = 13'b00_00_01_1_10_1_011;
		S_Type:			control_values = 13'b00_00_01_1_01_1_100;
		B_Type:			control_values = 13'b00_01_xx_0_00_0_101;
		J_Type: 			control_values = 13'b10_00_00_1_00_x_xxx;
		I_Type_jalr:	control_values = 13'b11_00_00_1_00_x_xxx;
		U_Type_lui: 	control_values = 13'b00_10_10_1_00_1_110;

		default:
			control_values= 13'b000_00_000;
		endcase
end	

assign Jal_o = control_values[12:11];

assign Auipc_o = control_values[10];

assign Branch_o = control_values[9];

assign Mem_to_Reg_o = control_values[8:7];

assign Reg_Write_o = control_values[6];

assign Mem_Read_o = control_values[5];

assign Mem_Write_o = control_values[4];

assign ALU_Src_o = control_values[3];

assign ALU_Op_o = control_values[2:0];	

endmodule


