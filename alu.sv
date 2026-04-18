module alu(parameter WORDSIZE = 32)
(input logic [WORDSIZE-1:0] in_a,
 input logic [WORDSIZE-1:0] in_b,
 input logic [4:0] which_op,
 output logic [WORDSIZE-1:0] out_c);

logic [WORDSIZE-1:0] intermedite_calc
always_comb begin
    case(which_op):
        4'd1: intermediate_calc = in_a + in_b;
        4'd2: intermediate_calc = in_a - in_b;
        4'd3: intermediate_calc = in_a | in_b;
        4'd4: intermediate_calc = in_a & in_b;
        4'd5: intermediate_calc = in_a ^ in_b;
        4'd6: intermediate_calc = in_a
        4'd7: intermediate_calc = in_b
    endcase
end

assign out_c = intermediate_calc;

endmodule