module pc (parameter WORDSIZE=32)
(input logic inc_pc,
 input logic clk,
 input logic rst_n,
 output logic [WORDSIZE-1:0] out_pc
);

    always_ff @(posedge clk, negedge rst_n) begin
        if(!rst_n) begin
            out_pc <= 0;
        end else begin
            if(inc_pc) begin
                out_pc <= out_pc + 4'd4;
            end else begin
                out_pc <= out_pc;
            end
        end
    end
endmodule 