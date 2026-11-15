module top_module #(
    parameter integer STEP_CYCLES = 50000000,
    parameter integer REFRESH_CYCLES = 50000,
    parameter ACTIVE_LOW_DISPLAY = 1'b1
) (
    input  wire       clk,
    input  wire       reset,
    input  wire [4:0] available_power,
    input  wire [4:0] load_request,

    output wire [5:0] total_demand,
    output reg  [4:0] allocated_power,
    output wire [4:0] load_status,
    output wire       overload,
    output wire       normal,
    output wire       buzzer,
    output wire       busy,
    output wire [1:0] state,
    output wire [6:0] seg,
    output wire [1:0] an
);
    wire [4:0] target_status;
    wire [4:0] target_allocated;

    demand_calculator u_demand (
        .load_request(load_request),
        .total_demand(total_demand)
    );

    overload_detector u_overload (
        .total_demand(total_demand),
        .available_power(available_power),
        .overload(overload)
    );

    priority_controller u_priority (
        .available_power(available_power),
        .load_request(load_request),
        .target_status(target_status),
        .target_allocated(target_allocated)
    );

    load_fsm #(
        .STEP_CYCLES(STEP_CYCLES)
    ) u_load_fsm (
        .clk(clk),
        .reset(reset),
        .target_status(target_status),
        .load_status(load_status),
        .state(state),
        .busy(busy)
    );

    // Calculate power actually being supplied by the current load states.
    always @(*) begin
        allocated_power = 5'd0;
        if (load_status[4]) allocated_power = allocated_power + 5'd5;
        if (load_status[3]) allocated_power = allocated_power + 5'd4;
        if (load_status[2]) allocated_power = allocated_power + 5'd3;
        if (load_status[1]) allocated_power = allocated_power + 5'd4;
        if (load_status[0]) allocated_power = allocated_power + 5'd2;
    end

    assign normal = ~overload;

    buzzer_controller u_buzzer (
        .overload(overload),
        .buzzer(buzzer)
    );

    display_controller #(
        .REFRESH_CYCLES(REFRESH_CYCLES),
        .ACTIVE_LOW(ACTIVE_LOW_DISPLAY)
    ) u_display (
        .clk(clk),
        .value({1'b0, allocated_power}),
        .seg(seg),
        .an(an)
    );
endmodule
