module overload_detector (
    input  wire [5:0] total_demand,
    input  wire [4:0] available_power,
    output wire       overload
);
    assign overload = (total_demand > {1'b0, available_power});
endmodule
