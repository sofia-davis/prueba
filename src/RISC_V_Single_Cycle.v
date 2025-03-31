/******************************************************************
* Description
*	This is the top-level of a RISC-V Microprocessor that can execute the next set of instructions:
*		add
*		addi
* This processor is written Verilog-HDL. It is synthesizabled into hardware.
* Parameter MEMORY_DEPTH configures the program memory to allocate the program to
* be executed. If the size of the program changes, thus, MEMORY_DEPTH must change.
* This processor was made for computer organization class at ITESO.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	16/08/2021
******************************************************************/

module RISC_V_Single_Cycle
#(
	parameter PROGRAM_MEMORY_DEPTH = 64,
	parameter DATA_MEMORY_DEPTH = 128
)

(
	// Inputs
	input clk,
	input reset,
	output clk_led,
	output [7:0] gpio_port_out,
	output [7:0] gpio_port_in

);
//******************************************************************/
//******************************************************************/

wire clk_div_w;

PLL_Test
PLL
(
	.clk(clk),
	.reset(reset),
	
	.clk_pll(clk_div_w)
);


assign clk_led = clk_div_w;



//******************************************************************/
//******************************************************************/
/* Signals to connect modules*/

/**Control**/
wire alu_src_w;
wire reg_write_w;
wire mem_to_reg_w;
wire mem_write_w;
wire mem_read_w;
wire branch_w;
wire auipc_w;
wire [2:0] alu_op_w;

/** Program Counter**/
wire [31:0] pc_next_w;
wire [31:0] pc_w;


/**Register File**/
wire [31:0] read_data_1_w;
wire [31:0] read_data_2_w;

/**Data Memory**/
wire [31:0] read_data_w;

/**Inmmediate Unit**/
wire [31:0] inmmediate_data_w;

/**ALU**/
wire [31:0] alu_result_w;
wire zero_w;

/**Adder 32b bits**/
wire [31:0] pc_plus_imm_w;
wire [31:0] pc_plus_4_w;

/**Multiplexer MUX_DATA_OR_IMM_FOR_ALU**/
wire [31:0] read_data_2_or_imm_w;

/**Multiplexer Mem to Reg**/
wire [31:0] read_data_or_alu_result_w;

/**Multiplexer Auipc**/
wire [31:0] read_data_1_or_pc_w;

/**Multiplexer Pc scr**/
wire [31:0] pc_plus_4_or_pc_plus_imm_w;

/**ALU Control**/
wire [3:0] alu_operation_w;

/**Instruction Bus**/	
wire [31:0] instruction_bus_w;


//******************************************************************/
//******************************************************************/

// GPIO Memory Mapping Logic


//******************************************************************/
//******************************************************************/
//******************************************************************/
Control
CONTROL_UNIT
(
	/****/
	.OP_i(instruction_bus_w[6:0]),
	/** outputus**/
	.ALU_Op_o(alu_op_w),
	.ALU_Src_o(alu_src_w),
	.Reg_Write_o(reg_write_w),
	.Mem_to_Reg_o(mem_to_reg_w),
	.Mem_Read_o(mem_read_w),
	.Mem_Write_o(mem_write_w),
	.Branch_o(branch_w),
	.Auipc_o(auipc_w)
);

PC_Register
PC_UNIT
(
	.clk(clk_div_w),
	.reset(reset),
	.Next_PC(pc_plus_4_or_pc_plus_imm_w[31:0]),
	
	
	.PC_Value(pc_w[31:0])
);

Data_Memory
DATA_MEMORY_UNIT
(
	.clk(clk_div_w),
	.Mem_Write_i(mem_write_w),
	.Mem_Read_i(mem_read_w),
	.Write_Data_i(read_data_2_w),
	.Address_i(alu_result_w),

	.Read_Data_o(read_data_w),
	.gpio_port_out(gpio_port_out)

);

Program_Memory
#(
	.MEMORY_DEPTH(PROGRAM_MEMORY_DEPTH)
)
PROGRAM_MEMORY
(
	.Address_i(pc_w),
	.Instruction_o(instruction_bus_w)
);


Adder_32_Bits
PC_PLUS_4
(
	.Data0(pc_w[31:0]),
	.Data1(4),
	
	.Result(pc_plus_4_w[31:0])
);

Adder_32_Bits
PC_PLUS_IMM
(
	.Data0(pc_w[31:0]),
	.Data1(inmmediate_data_w[31:0]),
	
	.Result(pc_plus_imm_w[31:0])
);

//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/



Register_File
REGISTER_FILE_UNIT
(
	.clk(clk_div_w),
	.reset(reset),
	.Reg_Write_i(reg_write_w),
	.Write_Register_i(instruction_bus_w[11:7]),
	.Read_Register_1_i(instruction_bus_w[19:15]),
	.Read_Register_2_i(instruction_bus_w[24:20]),
	.Write_Data_i(alu_result_w),
	.Read_Data_1_o(read_data_1_w),
	.Read_Data_2_o(read_data_2_w)

);



Immediate_Unit
IMM_UNIT
(  .op_i(instruction_bus_w[6:0]),
   .Instruction_bus_i(instruction_bus_w),
   .Immediate_o(inmmediate_data_w)
);



Multiplexer_2_to_1
#(
	.NBits(32)
)
MUX_DATA_OR_IMM_FOR_ALU
(
	.Selector_i(alu_src_w),
	.Mux_Data_0_i(read_data_2_w),
	.Mux_Data_1_i(inmmediate_data_w),
	
	.Mux_Output_o(read_data_2_or_imm_w)

);

Multiplexer_2_to_1
#(
	.NBits(32)
)
MUX_MEM_TO_REG
(
	.Selector_i(mem_to_reg_w),
	.Mux_Data_0_i(alu_result_w),
	.Mux_Data_1_i(read_data_w),
	
	.Mux_Output_o(read_data_or_alu_result_w)

);

Multiplexer_2_to_1
#(
	.NBits(32)
)
MUX_DATA_OR_PC_FOR_ALU
(
	.Selector_i(auipc_w),
	.Mux_Data_0_i(read_data_1_w),
	.Mux_Data_1_i(pc_w),
	
	.Mux_Output_o(read_data_1_or_pc_w)

);

Multiplexer_2_to_1
#(
	.NBits(32)
)
MUX_PC_PLUS_4_OR_PC_PLUS_IMM
(
	.Selector_i(branch_w && zero_w),
	.Mux_Data_0_i(pc_plus_4_w[31:0]),
	.Mux_Data_1_i(pc_plus_imm_w[31:0]),
	
	.Mux_Output_o(pc_plus_4_or_pc_plus_imm_w[31:0])

);


ALU_Control
ALU_CONTROL_UNIT
(
	.funct7_i(instruction_bus_w[30]),
	.ALU_Op_i(alu_op_w),
	.funct3_i(instruction_bus_w[14:12]),
	.ALU_Operation_o(alu_operation_w)

);



ALU
ALU_UNIT
(
	.ALU_Operation_i(alu_operation_w),
	.A_i(read_data_1_or_pc_w),
	.B_i(read_data_2_or_imm_w),
	.ALU_Result_o(alu_result_w),
	.Zero_o(zero_w)
);

endmodule
