module priority_controller (
    input  wire [4:0] available_power,
    input  wire [4:0] load_request,
    output reg  [4:0] target_status,
    output reg  [4:0] target_allocated
);
    integer remaining_power;

    always @(*) begin
        target_status    = 5'b00000;
        target_allocated = 5'd0;
        remaining_power  = available_power;

        // Strict priority: L1 > L2 > L3 > L4 > L5.
        // A load is accepted only if its complete demand fits.
        if (load_request[4] && remaining_power >= 5) begin
            target_status[4] = 1'b1;
            remaining_power = remaining_power - 5;
            target_allocated = target_allocated + 5'd5;
        end

        if (load_request[3] && remaining_power >= 4) begin
            target_status[3] = 1'b1;
            remaining_power = remaining_power - 4;
            target_allocated = target_allocated + 5'd4;
        end

        if (load_request[2] && remaining_power >= 3) begin
            target_status[2] = 1'b1;
            remaining_power = remaining_power - 3;
            target_allocated = target_allocated + 5'd3;
        end

        if (load_request[1] && remaining_power >= 4) begin
            target_status[1] = 1'b1;
            remaining_power = remaining_power - 4;
            target_allocated = target_allocated + 5'd4;
        end

        if (load_request[0] && remaining_power >= 2) begin
            target_status[0] = 1'b1;
            remaining_power = remaining_power - 2;
            target_allocated = target_allocated + 5'd2;
        end
    end
endmodule
