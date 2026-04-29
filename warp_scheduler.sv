
// warp_scheduler.sv
//
// Simple in-order warp scheduler for a minimal FPGA GPU
// 16 warps, 8 regs per warp, single ALU execution unit
//
// -------------------------------------------------------
// PARAMETERS
// -------------------------------------------------------
// NUM_WARPS    = 16
// NUM_REGS     = 8
// PC_WIDTH     = 12
// DATA_WIDTH   = 32
//
// -------------------------------------------------------
// WARP TABLE  (16 entries, one per warp)
// -------------------------------------------------------
// pc           [PC_WIDTH-1:0]  -- current instruction pointer
// scoreboard   [NUM_REGS-1:0]  -- one bit per reg, set when write pending
// status       [1:0]           -- ACTIVE / WAITING / DONE
// stall_ctr    [3:0]           -- cycles left on multi-cycle op
//
// -------------------------------------------------------
// FSM STATES
// -------------------------------------------------------
// IDLE         -- no active warps, wait for dispatch signal
// SELECT       -- round-robin scan for next eligible warp
//                 eligible = ACTIVE and no scoreboard conflict on src regs
//                 if none found, stay here until one clears
// FETCH        -- read instruction memory at warp_pc
// DECODE       -- crack opcode, extract src/dst regs, check scoreboard
//                 if hazard detected, skip warp, go back to SELECT
// ISSUE        -- set scoreboard bit for dst reg, send op to EU
// WAIT_EU      -- decrement stall_ctr each cycle until 0
//                 1 cycle for ALU, fixed N for memory (fake latency for now)
// WRITEBACK    -- clear scoreboard bit, write result to register file
// ADVANCE      -- increment PC, if warp has more instructions go back to SELECT
//                 else mark warp DONE
//
// -------------------------------------------------------
// ROUND ROBIN POINTER
// -------------------------------------------------------
// rr_ptr [3:0] -- advances to next warp after each successful issue
//                 wraps at 16
//
// -------------------------------------------------------
// REGISTER FILE
// -------------------------------------------------------
// regfile [NUM_WARPS][NUM_REGS][DATA_WIDTH]
// indexed as regfile[warp_id][reg_id]
// single read port (src A, src B) and single write port (dst)
// reads in DECODE, write in WRITEBACK
//
// -------------------------------------------------------
// INSTRUCTION FORMAT  (figure this out before writing decode)
// -------------------------------------------------------
// suggestion: fixed 32-bit encoding
//   [31:28] opcode   -- ADD, SUB, MUL, LD, ST, NOP
//   [27:24] dst reg
//   [23:20] src A
//   [19:16] src B
//   [15:0]  immediate (if needed)
//
// -------------------------------------------------------
// EXECUTION UNIT INTERFACE
// -------------------------------------------------------
// outputs: eu_valid, eu_op, eu_src_a, eu_src_b, eu_dst, eu_warp_id
// inputs:  eu_done, eu_result
// for now one EU, one op in flight at a time
//
// -------------------------------------------------------
// DISPATCH INTERFACE  (how warps get loaded in)
// -------------------------------------------------------
// dispatch_valid, dispatch_warp_id, dispatch_start_pc
// on dispatch, set warp status to ACTIVE, load PC, clear scoreboard
//
// -------------------------------------------------------
// TODO ORDER
// -------------------------------------------------------
// 1. define parameters and typedefs, state enum
// 2. declare warp table arrays
// 3. write SELECT round-robin logic
// 4. write FETCH (just index into instruction memory)
// 5. write DECODE and scoreboard hazard check
// 6. write ISSUE and EU output signals
// 7. write WAIT_EU counter
// 8. write WRITEBACK and regfile write
// 9. write ADVANCE and PC increment
// 10. hook up dispatch interface
// 11. simulate with 2-3 warps, simple ADD sequence, check scoreboard clears
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
