`timescale 1ns/1ps
module tb_overload_detector;
    reg [5:0] total_demand;
    reg [4:0] available_power;
    wire overload;

    overload_detector dut (
        .total_demand(total_demand),
        .available_power(available_power),
        .overload(overload)
    );

    initial begin
        $monitor("t=%0t demand=%0d available=%0d overload=%b",
                 $time, total_demand, available_power, overload);
        total_demand = 18; available_power = 20; #10;
        total_demand = 18; available_power = 18; #10;
        total_demand = 18; available_power = 15; #10;
        total_demand = 10; available_power = 5;  #10;
        total_demand = 0;  available_power = 0;  #10;
        $finish;
    end
endmodule
