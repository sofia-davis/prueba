/******************************************************************
* Description
*	This module performs a sign extension operation that is need with
*	in instruction like andi and constructs the immediate constant.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	16/08/2021
******************************************************************/
module Immediate_Unit
(   
	input [6:0] op_i,
	input [31:0]  Instruction_bus_i,
	
   output reg [31:0] Immediate_o
);

always @(*) begin
    case (op_i)
        7'h17: Immediate_o = {Instruction_bus_i[31:12], 12'b0}; // U format AUIPC
        7'h13: Immediate_o = {{20{Instruction_bus_i[31]}}, Instruction_bus_i[31:20]}; // I format ADDI SLLI
        7'h3:  Immediate_o = {{20{Instruction_bus_i[31]}}, Instruction_bus_i[31:20]}; // I format LW
        7'h23: Immediate_o = {{20{Instruction_bus_i[31]}}, Instruction_bus_i[31:25], Instruction_bus_i[11:7]}; // S format SW
        7'h63: Immediate_o = {{19{Instruction_bus_i[31]}}, Instruction_bus_i[31], Instruction_bus_i[7], Instruction_bus_i[30:25], Instruction_bus_i[11:8], 1'b0}; // B format BNE
        default: Immediate_o = 0;
    endcase
end


/*
always@(*) begin

	if(op_i == 7'h13)
		Immediate_o = {{20{Instruction_bus_i[31]}},Instruction_bus_i[31:20]};// I format
		
	else
		Immediate_o = {{12{Instruction_bus_i[31]}},Instruction_bus_i[31:12]};// U format
end
*/
endmodule // signExtend
