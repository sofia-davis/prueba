module Multiplexer_3_to_1
#(
    parameter NBits = 32
)
(
    input [1:0] Selector_i,
    input [NBits-1:0] Mux_Data_0_i,
    input [NBits-1:0] Mux_Data_1_i,
    input [NBits-1:0] Mux_Data_2_i,

    output reg [NBits-1:0] Mux_Output_o
);

    always @(Selector_i, Mux_Data_0_i, Mux_Data_1_i, Mux_Data_2_i) begin
        case (Selector_i)
            2'b00: Mux_Output_o = Mux_Data_0_i;
            2'b01: Mux_Output_o = Mux_Data_1_i;
            2'b10: Mux_Output_o = Mux_Data_2_i;
            default: Mux_Output_o = {NBits{1'b0}}; // Salida cero si es inválido
        endcase
    end

endmodule
