module fpga_top (

    input wire clk,
    input wire [15:0] sw,
    input wire [4:0] pb,

    output wire [15:0] led

);

    wire [4:0] available_power;
    wire [4:0] load_request;

    wire [5:0] total_demand;
    wire [4:0] allocated_power;
    wire [4:0] load_status;

    wire overload;
    wire normal;
    wire busy;

    wire [1:0] state;

    // Map physical switches to controller inputs
    assign available_power = sw[4:0];
    assign load_request = sw[9:5];

    // Main priority-based load controller
    top_module #(
        .STEP_CYCLES(50000000),
        .REFRESH_CYCLES(50000),
        .ACTIVE_LOW_DISPLAY(1'b1)
    ) MAIN (

        .clk(clk),
        .reset(pb[4]),

        .available_power(available_power),
        .load_request(load_request),

        .total_demand(total_demand),
        .allocated_power(allocated_power),
        .load_status(load_status),

        .overload(overload),
        .normal(normal),

        .busy(busy),
        .state(state),

        .seg(),
        .an()

    );

    // Load status LEDs
    assign led[4:0] = load_status;

    // System status LEDs
    assign led[5] = overload;
    assign led[6] = normal;
    assign led[7] = busy;

    // Display total demand in binary
    assign led[13:8] = total_demand;

    // Unused LEDs
    assign led[15:14] = 2'b00;

endmodule
