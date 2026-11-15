`timescale 1ns/1ps
module tb_priority_controller;
    reg [4:0] available_power;
    reg [4:0] load_request;
    wire [4:0] target_status;
    wire [4:0] target_allocated;

    priority_controller dut (
        .available_power(available_power),
        .load_request(load_request),
        .target_status(target_status),
        .target_allocated(target_allocated)
    );

    initial begin
        $monitor("t=%0t available=%0d request=%b target=%b allocated=%0d",
                 $time, available_power, load_request,
                 target_status, target_allocated);
        available_power = 18; load_request = 5'b11111; #10;
        available_power = 16; load_request = 5'b11111; #10;
        available_power = 12; load_request = 5'b11111; #10;
        available_power = 5;  load_request = 5'b11111; #10;
        available_power = 10; load_request = 5'b11001; #10;
        available_power = 15; load_request = 5'b00000; #10;
        $finish;
    end
endmodule
