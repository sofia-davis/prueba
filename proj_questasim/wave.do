onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /RISC_V_Single_Cycle_TB/clk_tb
add wave -noupdate /RISC_V_Single_Cycle_TB/reset_tb
add wave -noupdate -expand -group ALU_UNIT /RISC_V_Single_Cycle_TB/DUV/ALU_UNIT/ALU_Operation_i
add wave -noupdate -expand -group ALU_UNIT /RISC_V_Single_Cycle_TB/DUV/ALU_UNIT/A_i
add wave -noupdate -expand -group ALU_UNIT /RISC_V_Single_Cycle_TB/DUV/ALU_UNIT/B_i
add wave -noupdate -expand -group ALU_UNIT /RISC_V_Single_Cycle_TB/DUV/ALU_UNIT/Zero_o
add wave -noupdate -expand -group ALU_UNIT /RISC_V_Single_Cycle_TB/DUV/ALU_UNIT/ALU_Result_o
add wave -noupdate -group CONTROL_UNIT /RISC_V_Single_Cycle_TB/DUV/CONTROL_UNIT/OP_i
add wave -noupdate -group CONTROL_UNIT /RISC_V_Single_Cycle_TB/DUV/CONTROL_UNIT/Auipc_o
add wave -noupdate -group CONTROL_UNIT /RISC_V_Single_Cycle_TB/DUV/CONTROL_UNIT/Branch_o
add wave -noupdate -group CONTROL_UNIT /RISC_V_Single_Cycle_TB/DUV/CONTROL_UNIT/Mem_Read_o
add wave -noupdate -group CONTROL_UNIT /RISC_V_Single_Cycle_TB/DUV/CONTROL_UNIT/Mem_to_Reg_o
add wave -noupdate -group CONTROL_UNIT /RISC_V_Single_Cycle_TB/DUV/CONTROL_UNIT/Mem_Write_o
add wave -noupdate -group CONTROL_UNIT /RISC_V_Single_Cycle_TB/DUV/CONTROL_UNIT/ALU_Src_o
add wave -noupdate -group CONTROL_UNIT /RISC_V_Single_Cycle_TB/DUV/CONTROL_UNIT/Reg_Write_o
add wave -noupdate -group CONTROL_UNIT /RISC_V_Single_Cycle_TB/DUV/CONTROL_UNIT/ALU_Op_o
add wave -noupdate -expand -group PC_UNIT /RISC_V_Single_Cycle_TB/DUV/PC_UNIT/Next_PC
add wave -noupdate -expand -group PC_UNIT /RISC_V_Single_Cycle_TB/DUV/PC_UNIT/PC_Value
add wave -noupdate -expand -group DATA_MEMORY /RISC_V_Single_Cycle_TB/DUV/DATA_MEMORY_UNIT/Mem_Write_i
add wave -noupdate -expand -group DATA_MEMORY /RISC_V_Single_Cycle_TB/DUV/DATA_MEMORY_UNIT/Mem_Read_i
add wave -noupdate -expand -group DATA_MEMORY /RISC_V_Single_Cycle_TB/DUV/DATA_MEMORY_UNIT/Write_Data_i
add wave -noupdate -expand -group DATA_MEMORY /RISC_V_Single_Cycle_TB/DUV/DATA_MEMORY_UNIT/Address_i
add wave -noupdate -expand -group DATA_MEMORY /RISC_V_Single_Cycle_TB/DUV/DATA_MEMORY_UNIT/Read_Data_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 60
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
WaveRestoreZoom {0 ns} {1205 ns}
