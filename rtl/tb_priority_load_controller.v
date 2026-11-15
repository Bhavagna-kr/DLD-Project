`timescale 1ns/1ps
module tb_priority_load_controller;
    reg [3:0] P;
    reg R1, R2, R3;
    wire A1, A2, A3;
    integer p, requests;
    integer remaining;
    reg e1, e2, e3;

    priority_load_controller dut (
        .P(P), .R1(R1), .R2(R2), .R3(R3),
        .A1(A1), .A2(A2), .A3(A3)
    );

    initial begin
        for (p = 0; p < 16; p = p + 1) begin
            for (requests = 0; requests < 8; requests = requests + 1) begin
                P = p[3:0];
                R1 = requests[0];
                R2 = requests[1];
                R3 = requests[2];

                remaining = p;
                e1 = 1'b0; e2 = 1'b0; e3 = 1'b0;

                if (R1 && remaining >= 5) begin
                    e1 = 1'b1;
                    remaining = remaining - 5;
                end
                if (R2 && remaining >= 4) begin
                    e2 = 1'b1;
                    remaining = remaining - 4;
                end
                if (R3 && remaining >= 3) begin
                    e3 = 1'b1;
                    remaining = remaining - 3;
                end

                #1;
                if ({A3, A2, A1} !== {e3, e2, e1}) begin
                    $display("FAIL P=%0d R1=%b R2=%b R3=%b got=%b%b%b expected=%b%b%b",
                             p, R1, R2, R3, A3, A2, A1, e3, e2, e1);
                    $fatal(1);
                end
            end
        end
        $display("PASS: all 128 input combinations verified.");
        $finish;
    end
endmodule
