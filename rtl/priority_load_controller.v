// Priority-based greedy power allocator
// L1 demand=5 (highest priority), L2 demand=4, L3 demand=3.
// P is an unsigned 4-bit available-power value (0..15).
module priority_load_controller (
    input  wire [3:0] P,
    input  wire       R1,
    input  wire       R2,
    input  wire       R3,
    output wire       A1,
    output wire       A2,
    output wire       A3
);
    wire T3, T4, T5, T7, T8, T9, T12;

    assign T3  = (P >= 4'd3);
    assign T4  = (P >= 4'd4);
    assign T5  = (P >= 4'd5);
    assign T7  = (P >= 4'd7);
    assign T8  = (P >= 4'd8);
    assign T9  = (P >= 4'd9);
    assign T12 = (P >= 4'd12);

    assign A1 = R1 & T5;
    assign A2 = R2 & ((A1 & T9) | (~A1 & T4));
    assign A3 = R3 & ((A1 & A2 & T12)
                    | (A1 & ~A2 & T8)
                    | (~A1 & A2 & T7)
                    | (~A1 & ~A2 & T3));
endmodule
