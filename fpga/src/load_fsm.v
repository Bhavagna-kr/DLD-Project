module load_fsm #(
    parameter integer STEP_CYCLES = 50000000
) (
    input  wire       clk,
    input  wire       reset,          // active-high asynchronous reset
    input  wire [4:0] target_status,
    output reg  [4:0] load_status,
    output reg  [1:0] state,
    output wire       busy
);
    localparam IDLE      = 2'b00;
    localparam SHEDDING  = 2'b01;
    localparam RESTORING = 2'b10;

    integer counter;
    wire [4:0] shed_mask    = load_status & ~target_status;
    wire [4:0] restore_mask = ~load_status & target_status;

    assign busy = (|shed_mask) || (|restore_mask);

    // A change is made only once every STEP_CYCLES clock cycles.
    // Shedding order: L5, L4, L3, L2, L1.
    // Restoration order: L1, L2, L3, L4, L5.
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            load_status <= 5'b00000;
            state       <= IDLE;
            counter     <= 0;
        end else begin
            if (|shed_mask) begin
                state <= SHEDDING;
                if (counter >= STEP_CYCLES - 1) begin
                    counter <= 0;
                    if      (shed_mask[0]) load_status[0] <= 1'b0;
                    else if (shed_mask[1]) load_status[1] <= 1'b0;
                    else if (shed_mask[2]) load_status[2] <= 1'b0;
                    else if (shed_mask[3]) load_status[3] <= 1'b0;
                    else if (shed_mask[4]) load_status[4] <= 1'b0;
                end else begin
                    counter <= counter + 1;
                end
            end else if (|restore_mask) begin
                state <= RESTORING;
                if (counter >= STEP_CYCLES - 1) begin
                    counter <= 0;
                    if      (restore_mask[4]) load_status[4] <= 1'b1;
                    else if (restore_mask[3]) load_status[3] <= 1'b1;
                    else if (restore_mask[2]) load_status[2] <= 1'b1;
                    else if (restore_mask[1]) load_status[1] <= 1'b1;
                    else if (restore_mask[0]) load_status[0] <= 1'b1;
                end else begin
                    counter <= counter + 1;
                end
            end else begin
                state   <= IDLE;
                counter <= 0;
            end
        end
    end
endmodule
