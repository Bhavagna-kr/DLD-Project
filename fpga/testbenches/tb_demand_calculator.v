`timescale 1ns/1ps
module tb_demand_calculator;
    reg [4:0] load_request;
    wire [5:0] total_demand;

    demand_calculator dut (
        .load_request(load_request),
        .total_demand(total_demand)
    );

    initial begin
        $monitor("t=%0t request=%b demand=%0d",
                 $time, load_request, total_demand);
        load_request = 5'b00000; #10;
        load_request = 5'b10000; #10;
        load_request = 5'b11000; #10;
        load_request = 5'b11100; #10;
        load_request = 5'b11111; #10;
        load_request = 5'b10101; #10;
        $finish;
    end
endmodule
