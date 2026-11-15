`timescale 1ns/1ps
module tb_top_module;
    reg clk;
    reg reset;
    reg [4:0] available_power;
    reg [4:0] load_request;

    wire [5:0] total_demand;
    wire [4:0] allocated_power;
    wire [4:0] load_status;
    wire overload, normal, buzzer, busy;
    wire [1:0] state;
    wire [6:0] seg;
    wire [1:0] an;

    top_module #(
        .STEP_CYCLES(4),
        .REFRESH_CYCLES(4)
    ) dut (
        .clk(clk),
        .reset(reset),
        .available_power(available_power),
        .load_request(load_request),
        .total_demand(total_demand),
        .allocated_power(allocated_power),
        .load_status(load_status),
        .overload(overload),
        .normal(normal),
        .buzzer(buzzer),
        .busy(busy),
        .state(state),
        .seg(seg),
        .an(an)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        $monitor("t=%0t avail=%0d request=%b demand=%0d status=%b allocated=%0d overload=%b state=%b",
                 $time, available_power, load_request, total_demand,
                 load_status, allocated_power, overload, state);

        reset = 1'b1;
        available_power = 0;
        load_request = 0;
        #20;
        reset = 1'b0;

        available_power = 18; load_request = 5'b11111; #150;
        available_power = 16; #100;
        available_power = 12; #100;
        available_power = 5;  #150;
        available_power = 18; #150;
        load_request = 5'b00000; #150;
        available_power = 10; load_request = 5'b11001; #150;

        $finish;
    end
endmodule
