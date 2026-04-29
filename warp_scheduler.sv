
module warp_scheduler (
input logic clk,
input logic reset_n,
input logic [11:0] pc,
output logic state);

enum logic [8:0] IDLE, SELECT, conflict, FETCH, DECODE, EXECUTE, ISSUE, WAIT_EU, WRITEBACK, ADVANCE;

always_ff @(posedge clk, negedge reset_n) begin
    if(!reset_n) begin
        
    end
end






endmodule
