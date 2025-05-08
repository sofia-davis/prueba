onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /RISC_V_Pipeline_TB/clk_tb
add wave -noupdate /RISC_V_Pipeline_TB/reset_tb
add wave -noupdate /RISC_V_Pipeline_TB/clk_tb
add wave -noupdate /RISC_V_Pipeline_TB/reset_tb
add wave -noupdate -expand -group PC /RISC_V_Pipeline_TB/DUV/PC_UNIT/PC_Value
add wave -noupdate -expand -group s0 /RISC_V_Pipeline_TB/DUV/REGISTER_FILE_UNIT/Register_s0_fp/DataOutput
add wave -noupdate -expand -group s1 /RISC_V_Pipeline_TB/DUV/REGISTER_FILE_UNIT/Register_s1/DataOutput
add wave -noupdate -expand -group a0 /RISC_V_Pipeline_TB/DUV/REGISTER_FILE_UNIT/Register_a0/DataOutput
add wave -noupdate -expand -group a2 /RISC_V_Pipeline_TB/DUV/REGISTER_FILE_UNIT/Register_a2/DataOutput
add wave -noupdate -expand -group a1 /RISC_V_Pipeline_TB/DUV/REGISTER_FILE_UNIT/Register_a1/DataOutput
add wave -noupdate -expand -group s2 /RISC_V_Pipeline_TB/DUV/REGISTER_FILE_UNIT/Register_s2/DataOutput
add wave -noupdate -expand -group REG_FILE /RISC_V_Pipeline_TB/DUV/REGISTER_FILE_UNIT/Read_Data_2_o
add wave -noupdate -expand -group ID_EX /RISC_V_Pipeline_TB/DUV/ID_EX/ReadData2Input
add wave -noupdate -expand -group ID_EX /RISC_V_Pipeline_TB/DUV/ID_EX/ReadData2Output
add wave -noupdate -expand -group MUX_RD2_OR_IMM /RISC_V_Pipeline_TB/DUV/MUX_DATA_OR_IMM_FOR_ALU/Selector_i
add wave -noupdate -expand -group MUX_RD2_OR_IMM /RISC_V_Pipeline_TB/DUV/MUX_DATA_OR_IMM_FOR_ALU/Mux_Data_0_i
add wave -noupdate -expand -group MUX_RD2_OR_IMM /RISC_V_Pipeline_TB/DUV/MUX_DATA_OR_IMM_FOR_ALU/Mux_Data_1_i
add wave -noupdate -expand -group MUX_RD2_OR_IMM /RISC_V_Pipeline_TB/DUV/MUX_DATA_OR_IMM_FOR_ALU/Mux_Output_o
add wave -noupdate -expand -group DATA_MEMORY /RISC_V_Pipeline_TB/DUV/DATA_MEMORY_UNIT/Mem_Write_i
add wave -noupdate -expand -group DATA_MEMORY /RISC_V_Pipeline_TB/DUV/DATA_MEMORY_UNIT/Mem_Read_i
add wave -noupdate -expand -group DATA_MEMORY /RISC_V_Pipeline_TB/DUV/DATA_MEMORY_UNIT/Write_Data_i
add wave -noupdate -expand -group DATA_MEMORY /RISC_V_Pipeline_TB/DUV/DATA_MEMORY_UNIT/Address_i
add wave -noupdate -expand -group DATA_MEMORY /RISC_V_Pipeline_TB/DUV/DATA_MEMORY_UNIT/Read_Data_o
add wave -noupdate -expand -group MUX_ALU_B /RISC_V_Pipeline_TB/DUV/MUX_ALU_B/Selector_i
add wave -noupdate -expand -group MUX_ALU_B /RISC_V_Pipeline_TB/DUV/MUX_ALU_B/Mux_Data_0_i
add wave -noupdate -expand -group MUX_ALU_B /RISC_V_Pipeline_TB/DUV/MUX_ALU_B/Mux_Data_1_i
add wave -noupdate -expand -group MUX_ALU_B /RISC_V_Pipeline_TB/DUV/MUX_ALU_B/Mux_Data_2_i
add wave -noupdate -expand -group MUX_ALU_B /RISC_V_Pipeline_TB/DUV/MUX_ALU_B/Mux_Output_o
add wave -noupdate -expand -group ALU_UNIT /RISC_V_Pipeline_TB/DUV/ALU_UNIT/ALU_Operation_i
add wave -noupdate -expand -group ALU_UNIT /RISC_V_Pipeline_TB/DUV/ALU_UNIT/A_i
add wave -noupdate -expand -group ALU_UNIT /RISC_V_Pipeline_TB/DUV/ALU_UNIT/B_i
add wave -noupdate -expand -group ALU_UNIT /RISC_V_Pipeline_TB/DUV/ALU_UNIT/Zero_o
add wave -noupdate -expand -group ALU_UNIT /RISC_V_Pipeline_TB/DUV/ALU_UNIT/ALU_Result_o
add wave -noupdate -expand -group HAZARD_UNIT /RISC_V_Pipeline_TB/DUV/HAZARD_DETECTION_UNIT/Rs1_if_id
add wave -noupdate -expand -group HAZARD_UNIT /RISC_V_Pipeline_TB/DUV/HAZARD_DETECTION_UNIT/Rs2_if_id
add wave -noupdate -expand -group HAZARD_UNIT /RISC_V_Pipeline_TB/DUV/HAZARD_DETECTION_UNIT/Rd_id_ex
add wave -noupdate -expand -group HAZARD_UNIT /RISC_V_Pipeline_TB/DUV/HAZARD_DETECTION_UNIT/mem_read_id_ex
add wave -noupdate -expand -group HAZARD_UNIT /RISC_V_Pipeline_TB/DUV/HAZARD_DETECTION_UNIT/pc_enable
add wave -noupdate -expand -group HAZARD_UNIT /RISC_V_Pipeline_TB/DUV/HAZARD_DETECTION_UNIT/if_id_enable
add wave -noupdate -expand -group HAZARD_UNIT /RISC_V_Pipeline_TB/DUV/HAZARD_DETECTION_UNIT/selector_hazard
add wave -noupdate -expand -group MUX_MEM_TO_REG /RISC_V_Pipeline_TB/DUV/MUX_MEM_TO_REG/Selector_i
add wave -noupdate -expand -group MUX_MEM_TO_REG /RISC_V_Pipeline_TB/DUV/MUX_MEM_TO_REG/Mux_Data_0_i
add wave -noupdate -expand -group MUX_MEM_TO_REG /RISC_V_Pipeline_TB/DUV/MUX_MEM_TO_REG/Mux_Data_1_i
add wave -noupdate -expand -group MUX_MEM_TO_REG /RISC_V_Pipeline_TB/DUV/MUX_MEM_TO_REG/Mux_Data_2_i
add wave -noupdate -expand -group MUX_MEM_TO_REG /RISC_V_Pipeline_TB/DUV/MUX_MEM_TO_REG/Mux_Output_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {12 ns} {41 ns}
