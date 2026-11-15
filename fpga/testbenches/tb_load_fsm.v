`timescale 1ns/1ps
module tb_load_fsm;
    reg clk;
    reg reset;
    reg [4:0] target_status;
    wire [4:0] load_status;
    wire [1:0] state;
    wire busy;

    load_fsm #(.STEP_CYCLES(4)) dut (
        .clk(clk),
        .reset(reset),
        .target_status(target_status),
        .load_status(load_status),
        .state(state),
        .busy(busy)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        $monitor("t=%0t target=%b status=%b state=%b busy=%b",
                 $time, target_status, load_status, state, busy);
        reset = 1'b1;
        target_status = 5'b00000;
        #12;
        reset = 1'b0;

        target_status = 5'b11111; // restore L1 through L5
        #250;
        target_status = 5'b11100; // shed L5 then L4
        #150;
        target_status = 5'b11111; // restore L4 then L5
        #150;
        target_status = 5'b10000; // shed L5, L4, L3, L2
        #200;
        $finish;
    end
endmodule
