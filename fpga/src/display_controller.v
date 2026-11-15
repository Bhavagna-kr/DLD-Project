module display_controller #(
    parameter integer REFRESH_CYCLES = 50000,
    parameter ACTIVE_LOW = 1'b1
) (
    input  wire       clk,
    input  wire [5:0] value,       // decimal value 0..63
    output reg  [6:0] seg,         // segment order: a,b,c,d,e,f,g
    output reg  [1:0] an           // two digit enables
);
    integer refresh_counter;
    reg digit_select;
    wire [3:0] ones = value % 10;
    wire [3:0] tens = value / 10;

    function [6:0] decode_digit;
        input [3:0] digit;
        reg [6:0] active_high_pattern;
        begin
            // 1 means segment ON; order is a,b,c,d,e,f,g.
            case (digit)
                4'd0: active_high_pattern = 7'b1111110;
                4'd1: active_high_pattern = 7'b0110000;
                4'd2: active_high_pattern = 7'b1101101;
                4'd3: active_high_pattern = 7'b1111001;
                4'd4: active_high_pattern = 7'b0110011;
                4'd5: active_high_pattern = 7'b1011011;
                4'd6: active_high_pattern = 7'b1011111;
                4'd7: active_high_pattern = 7'b1110000;
                4'd8: active_high_pattern = 7'b1111111;
                4'd9: active_high_pattern = 7'b1111011;
                default: active_high_pattern = 7'b0000001;
            endcase

            if (ACTIVE_LOW)
                decode_digit = ~active_high_pattern;
            else
                decode_digit = active_high_pattern;
        end
    endfunction

    initial begin
        refresh_counter = 0;
        digit_select = 1'b0;
    end

    always @(posedge clk) begin
        if (refresh_counter >= REFRESH_CYCLES - 1) begin
            refresh_counter <= 0;
            digit_select <= ~digit_select;
        end else begin
            refresh_counter <= refresh_counter + 1;
        end
    end

    always @(*) begin
        if (digit_select == 1'b0) begin
            seg = decode_digit(ones);
            an  = ACTIVE_LOW ? 2'b10 : 2'b01;
        end else begin
            seg = decode_digit(tens);
            an  = ACTIVE_LOW ? 2'b01 : 2'b10;
        end
    end
endmodule
