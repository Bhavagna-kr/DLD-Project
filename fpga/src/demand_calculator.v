module demand_calculator (
    input  wire [4:0] load_request,   // [4]=L1 ... [0]=L5
    output reg  [5:0] total_demand
);
    always @(*) begin
        total_demand = 6'd0;
        if (load_request[4]) total_demand = total_demand + 6'd5;
        if (load_request[3]) total_demand = total_demand + 6'd4;
        if (load_request[2]) total_demand = total_demand + 6'd3;
        if (load_request[1]) total_demand = total_demand + 6'd4;
        if (load_request[0]) total_demand = total_demand + 6'd2;
    end
endmodule
