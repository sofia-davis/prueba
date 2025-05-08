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

module RISC_V_Pipeline
#(
	parameter PROGRAM_MEMORY_DEPTH = 256,
	parameter DATA_MEMORY_DEPTH = 160
)

(
	// Inputs
	input clk,
	input reset,
	input [8:0] gpio_port_in,
	
	output [8:0] gpio_port_out

);
//******************************************************************/
//******************************************************************/




//******************************************************************/
//******************************************************************/
/* Signals to connect modules*/

/**Control**/
wire alu_src_w;
wire reg_write_w;
wire [1:0] mem_to_reg_w;
wire mem_write_w;
wire mem_read_w;
wire branch_w;
wire auipc_w;
wire [1:0]jal_w;
wire [2:0] alu_op_w;

wire [12:0]control_w;

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

/**Multiplexer jal**/
wire [31:0] read_data_1_or_pc_jal_w;

/**ALU Control**/
wire [3:0] alu_operation_w;

/**Instruction Bus**/	
wire [31:0] instruction_bus_w;

/**Decodificado**/	
wire Mem_write_ram_w;
wire Mem_write_gpio_w;
wire Mem_read_ram_w;
wire Mem_read_gpio_w;
wire selector_gpio_w;
wire [31:0]address_gpio_w;
wire [31:0]address_ram_w;

/**MUX GPIO**/	
wire [31:0]write_data_gpio_or_ram_w;

/**MUX DEPENDENCIAS**/	
wire [1:0]selector_a_alu_w;
wire [1:0]selector_b_alu_w;
wire [31:0]alu_a_w;
wire [31:0]alu_b_w;

/**GPIO**/	
wire [31:0]gpio_out_w;

/**Pipeline IF_ID**/	
wire [31:0]pc_if_id_w;
wire [31:0]pc_plus_4_if_id_w;
wire [31:0]instruction_bus_if_id_w;

/**Pipeline ID_EX**/	
wire reg_write_id_ex_w;
wire [1:0]mem_to_reg_id_ex_w;
wire branch_id_ex_w;
wire [1:0]jal_id_ex_w;
wire mem_write_id_ex_w;
wire mem_read_id_ex_w;
wire auipc_id_ex_w;
wire alu_src_id_ex_w;
wire [2:0]alu_op_id_ex_w;
wire [31:0]pc_id_ex_w;
wire [31:0]pc_plus_4_id_ex_w;
wire [31:0]read_data_1_id_ex_w;
wire [31:0]read_data_2_id_ex_w;
wire [31:0]inmmediate_data_id_ex_w;
wire [2:0]funct_3_id_ex_w;
wire [6:0]funct_7_id_ex_w;
wire [4:0]write_register_id_ex_w;
wire [4:0]rs1_id_ex_w;
wire [4:0]rs2_id_ex_w;

/**Pipeline EX_MEM**/	
wire reg_write_ex_mem_w;
wire [1:0]mem_to_reg_ex_mem_w;
wire branch_ex_mem_w;
wire jal_ex_mem_w;
wire mem_write_ex_mem_w;
wire mem_read_ex_mem_w;
wire [31:0]pc_plus_imm_ex_mem_w;
wire [31:0]pc_plus_4_ex_mem_w;
wire zero_ex_mem_w;
wire [31:0]alu_result_ex_mem_w;
wire [31:0]read_data_2_ex_mem_w;
wire [4:0]write_register_ex_mem_w;

/**Pipeline MEM_WB**/	
wire reg_write_mem_wb_w;
wire [1:0]mem_to_reg_mem_wb_w;
wire [31:0]pc_plus_4_mem_wb_w;
wire [31:0]read_data_mem_wb_w;
wire [31:0]alu_result_mem_wb_w;
wire [4:0]write_register_mem_wb_w;

/**Hazard Detection Unit**/
wire pc_enable_w;
wire if_id_enable_w;
wire selector_hazard_w;

//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/

Hazard_Unit
HAZARD_DETECTION_UNIT
(
	.Rs1_if_id(instruction_bus_if_id_w[19:15]),
	.Rs2_if_id(instruction_bus_if_id_w[24:20]),
	.Rd_id_ex(write_register_id_ex_w),
	.Rs1_id_ex(rs1_id_ex_w),
	.mem_read_id_ex(mem_read_id_ex_w),
	.mem_read_if_id(mem_read_w),
	.mem_write_id_ex(mem_write_id_ex_w),
	
	.pc_enable(pc_enable_w),
	.if_id_enable(if_id_enable_w),
	.selector_hazard(selector_hazard_w)
);

Forward_Unit
FORWARDING_UNIT
(
	.Rs1_id_ex(rs1_id_ex_w),
	.Rs2_id_ex(rs2_id_ex_w),
	.Rd_ex_mem(write_register_ex_mem_w),
	.Rd_mem_wb(write_register_mem_wb_w),
	.reg_write_ex_mem(reg_write_ex_mem_w),
	.reg_write_mem_wb(reg_write_mem_wb_w),
	
	.Selector_a_alu(selector_a_alu_w),
	.Selector_b_alu(selector_b_alu_w)
);

Pipeline_Register_IF_ID
IF_ID
(
	.clk(clk),
	.reset(reset),
	.enable(if_id_enable_w),
	.PCInput(pc_w),
	.InstructionInput(instruction_bus_w),
	.PCPlus4Input(pc_plus_4_w),
	
	.PCOutput(pc_if_id_w),
	.InstructionOutput(instruction_bus_if_id_w),
	.PCPlus4Output(pc_plus_4_if_id_w)

);

Pipeline_Register_ID_EX
ID_EX
(
	.clk(clk),
	.reset(reset),
	.PCInput(pc_if_id_w),
	.PCPlus4Input(pc_plus_4_if_id_w),
	.ReadData1Input(read_data_1_w),
	.ReadData2Input(read_data_2_w),
	.ImmInput(inmmediate_data_w),
	.Funct3Input(instruction_bus_if_id_w[14:12]),
	.Funct7Input(instruction_bus_if_id_w[31:25]),
	.WriteRegisterInput(instruction_bus_if_id_w[11:7]),
	.JalInput(control_w[4:3]),
	.MemtoRegInput(control_w[10:9]),
	.RegWriteInput(control_w[11]),
	.BranchInput(control_w[6]),
	.MemWriteInput(control_w[8]),
	.MemreadInput(control_w[7]),
	.AuipcInput(control_w[5]),
	.ALUOPInput(control_w[2:0]),
	.ALUSrcInput(control_w[12]),
	.Register_Rs1_Input(instruction_bus_if_id_w[19:15]),
	.Register_Rs2_Input(instruction_bus_if_id_w[24:20]),

	.PCOutput(pc_id_ex_w),
	.PCPlus4Output(pc_plus_4_id_ex_w),
	.ReadData1Output(read_data_1_id_ex_w),
	.ReadData2Output(read_data_2_id_ex_w),
	.ImmOutput(inmmediate_data_id_ex_w),
	.Funct3Output(funct_3_id_ex_w),
	.Funct7Output(funct_7_id_ex_w),
	.WriteRegisterOutput(write_register_id_ex_w),
	.JalOutput(jal_id_ex_w),
	.MemtoRegOutput(mem_to_reg_id_ex_w),
	.RegWriteOutput(reg_write_id_ex_w),
	.BranchOutput(branch_id_ex_w),
	.MemWriteOutput(mem_write_id_ex_w),
	.MemreadOutput(mem_read_id_ex_w),
	.AuipcOutput(auipc_id_ex_w),
	.ALUOPOutput(alu_op_id_ex_w),
	.ALUSrcOutput(alu_src_id_ex_w),
	.Register_Rs1_Output(rs1_id_ex_w),
	.Register_Rs2_Output(rs2_id_ex_w)
);

Pipeline_Register_EX_MEM
EX_MEM
(
	.clk(clk),
	.reset(reset),
	.PCPlusImmInput(pc_plus_imm_w),
	.PCPlus4Input(pc_plus_4_id_ex_w),
	.ReadData2Input(alu_b_w),
	.ALUResultInput(alu_result_w),
	.WriteRegisterInput(write_register_id_ex_w),
	.JalInput(jal_id_ex_w[1]),
	.MemtoRegInput(mem_to_reg_id_ex_w),	
	.RegWriteInput(reg_write_id_ex_w),
	.BranchInput(branch_id_ex_w),
	.MemWriteInput(mem_write_id_ex_w),
	.MemreadInput(mem_read_id_ex_w),
	.ZeroInput(zero_w),
	
	.PCPlusImmOutput(pc_plus_imm_ex_mem_w),
	.PCPlus4Output(pc_plus_4_ex_mem_w),
	.ReadData2Output(read_data_2_ex_mem_w),
	.ALUResultOutput(alu_result_ex_mem_w),
	.WriteRegisterOutput(write_register_ex_mem_w),
	.JalOutput(jal_ex_mem_w),
	.MemtoRegOutput(mem_to_reg_ex_mem_w),	
	.RegWriteOutput(reg_write_ex_mem_w),
	.BranchOutput(branch_ex_mem_w),
	.MemWriteOutput(mem_write_ex_mem_w),
	.MemreadOutput(mem_read_ex_mem_w),
	.ZeroOutput(zero_ex_mem_w)

);

Pipeline_Register_MEM_WB
MEM_WB
(
	.clk(clk),
	.reset(reset),
	.PCPlus4Input(pc_plus_4_ex_mem_w),
	.ReadDataInput(read_data_w),
	.ALUResultInput(alu_result_ex_mem_w),
	.WriteRegisterInput(write_register_ex_mem_w),
	.MemtoRegInput(mem_to_reg_ex_mem_w),	
	.RegWriteInput(reg_write_ex_mem_w),	

	.PCPlus4Output(pc_plus_4_mem_wb_w),
	.ReadDataOutput(read_data_mem_wb_w),
	.ALUResultOutput(alu_result_mem_wb_w),
	.WriteRegisterOutput(write_register_mem_wb_w),
	.MemtoRegOutput(mem_to_reg_mem_wb_w),	
	.RegWriteOutput(reg_write_mem_wb_w)

);




Control
CONTROL_UNIT
(
	/****/
	.OP_i(instruction_bus_if_id_w[6:0]),
	/** outputus**/
	.ALU_Op_o(alu_op_w),
	.ALU_Src_o(alu_src_w),
	.Reg_Write_o(reg_write_w),
	.Mem_to_Reg_o(mem_to_reg_w[1:0]),
	.Mem_Read_o(mem_read_w),
	.Mem_Write_o(mem_write_w),
	.Branch_o(branch_w),
	.Auipc_o(auipc_w),
	.Jal_o(jal_w[1:0])
);

PC_Register
PC_UNIT
(
	.clk(clk),
	.reset(reset),
	.enable(pc_enable_w),
	.Next_PC(pc_plus_4_or_pc_plus_imm_w[31:0]),
	
	
	.PC_Value(pc_w[31:0])
);


Data_Memory
DATA_MEMORY_UNIT
(
	.clk(clk),
	.Mem_Write_i(Mem_write_ram_w),
	.Mem_Read_i(Mem_read_ram_w),
	.Write_Data_i(read_data_2_ex_mem_w),
	.Address_i(address_ram_w),

	.Read_Data_o(read_data_w)
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
	.Data0(read_data_1_or_pc_jal_w[31:0]),
	.Data1(inmmediate_data_id_ex_w[31:0]),
	
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
	.clk(clk),
	.reset(reset),
	.Reg_Write_i(reg_write_mem_wb_w),
	.Write_Register_i(write_register_mem_wb_w),
	.Read_Register_1_i(instruction_bus_if_id_w[19:15]),
	.Read_Register_2_i(instruction_bus_if_id_w[24:20]),
	.Write_Data_i(write_data_gpio_or_ram_w),
	.Read_Data_1_o(read_data_1_w),
	.Read_Data_2_o(read_data_2_w)

);



Immediate_Unit
IMM_UNIT
(  .op_i(instruction_bus_if_id_w[6:0]),
   .Instruction_bus_i(instruction_bus_if_id_w),
   .Immediate_o(inmmediate_data_w)
);



Multiplexer_2_to_1
#(
	.NBits(32)
)
MUX_DATA_OR_IMM_FOR_ALU
(
	.Selector_i(alu_src_id_ex_w),
	.Mux_Data_0_i(alu_b_w),
	.Mux_Data_1_i(inmmediate_data_id_ex_w),
	
	.Mux_Output_o(read_data_2_or_imm_w)

);

Multiplexer_3_to_1
#(
	.NBits(32)
)
MUX_MEM_TO_REG
(
	.Selector_i(mem_to_reg_mem_wb_w),
	.Mux_Data_0_i(pc_plus_4_mem_wb_w),
	.Mux_Data_1_i(read_data_mem_wb_w),
	.Mux_Data_2_i(alu_result_mem_wb_w),
	
	.Mux_Output_o(read_data_or_alu_result_w)

);

Multiplexer_3_to_1
#(
	.NBits(32)
)
MUX_ALU_A
(
	.Selector_i(selector_a_alu_w),
	.Mux_Data_0_i(read_data_1_or_pc_w),
	.Mux_Data_1_i(read_data_or_alu_result_w),
	.Mux_Data_2_i(alu_result_ex_mem_w),
	
	.Mux_Output_o(alu_a_w)

);

Multiplexer_3_to_1
#(
	.NBits(32)
)
MUX_ALU_B
(
	.Selector_i(selector_b_alu_w),
	.Mux_Data_0_i(read_data_2_id_ex_w),
	.Mux_Data_1_i(read_data_or_alu_result_w),
	.Mux_Data_2_i(alu_result_ex_mem_w),
	
	.Mux_Output_o(alu_b_w)

);

Multiplexer_2_to_1
#(
	.NBits(32)
)
MUX_DATA_OR_PC_FOR_ALU
(
	.Selector_i(auipc_id_ex_w),
	.Mux_Data_0_i(read_data_1_id_ex_w),
	.Mux_Data_1_i(pc_id_ex_w), 
	
	.Mux_Output_o(read_data_1_or_pc_w)

);

Multiplexer_2_to_1
#(
	.NBits(32)
)
MUX_PC_PLUS_4_OR_PC_PLUS_IMM
(
	.Selector_i((branch_ex_mem_w && zero_ex_mem_w) | jal_ex_mem_w),
	.Mux_Data_0_i(pc_plus_4_w[31:0]),
	.Mux_Data_1_i(pc_plus_imm_ex_mem_w[31:0]),
	
	.Mux_Output_o(pc_plus_4_or_pc_plus_imm_w[31:0])

);

Multiplexer_2_to_1
#(
	.NBits(32)
)
MUX_IMM_OR_ALU_RESULT_JAL
(
	.Selector_i(jal_id_ex_w[0]),
	.Mux_Data_0_i(pc_id_ex_w),
	.Mux_Data_1_i(read_data_1_id_ex_w),
	
	.Mux_Output_o(read_data_1_or_pc_jal_w)

);

Multiplexer_2_to_1
#(
	.NBits(32)
)
MUX_GPIO_OR_RAM
(
	.Selector_i(selector_gpio_w),
	.Mux_Data_0_i(read_data_or_alu_result_w),
	.Mux_Data_1_i(gpio_out_w),
	
	.Mux_Output_o(write_data_gpio_or_ram_w)

);

Multiplexer_2_to_1
#(
	.NBits(13)
)
MUX_DATA_HAZARD
(
	.Selector_i(selector_hazard_w),
	.Mux_Data_0_i({alu_src_w, reg_write_w, mem_to_reg_w, mem_write_w, mem_read_w, branch_w, auipc_w, jal_w, alu_op_w}),
	.Mux_Data_1_i(0),
	
	.Mux_Output_o(control_w)

);

ALU_Control
ALU_CONTROL_UNIT
(
	.funct7_i(funct_7_id_ex_w),
	.ALU_Op_i(alu_op_id_ex_w),
	.funct3_i(funct_3_id_ex_w),
	.ALU_Operation_o(alu_operation_w)

);



ALU
ALU_UNIT
(
	.ALU_Operation_i(alu_operation_w),
	.A_i(alu_a_w),
	.B_i(read_data_2_or_imm_w),
	.ALU_Result_o(alu_result_w),
	.Zero_o(zero_w)
);

Decodificador
DECO_GPIO
(
	.Address_i(alu_result_ex_mem_w),
	.Mem_write_i(mem_write_ex_mem_w),
	.Mem_read_i(mem_read_ex_mem_w),
	
	.Mem_write_ram_o(Mem_write_ram_w),
	.Mem_write_gpio_o(Mem_write_gpio_w),
	.Mem_read_ram_o(Mem_read_ram_w),
	.Mem_read_gpio_o(Mem_read_gpio_w),
	.selector_gpio_o(selector_gpio_w),
	.address_gpio_o(address_gpio_w),
	.address_ram_o(address_ram_w)
);

GPIO
GPIO
(
	//.clk(clk_o_w),
	.clk(clk),
	.reset(reset),
	.Mem_Read_i(Mem_read_gpio_w),
	.Mem_Write_i(Mem_write_gpio_w),
	.gpio_addr_i(address_gpio_w),
	.gpio_in_i(read_data_2_ex_mem_w),
	.gpio_port_in_i(gpio_port_in),
	
	.gpio_out_o(gpio_out_w),
	.gpio_port_out_o(gpio_port_out)
);

endmodule
