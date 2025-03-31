module Clock_Divider (
    input clk,      
    input reset,       
    output reg clk_div     
);

    reg [19:0] count;

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            count <= 0;
            clk_div <= 0;
        end else if (count == 20'd250000) begin // 50 MHz / 1 MHz = 50 ciclos
            count <= 0;
            clk_div <= ~clk_div;
        end else begin
            count <= count + 1'b1;
        end
    end

endmodule


