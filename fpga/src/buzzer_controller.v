module buzzer_controller (
    input  wire overload,
    output wire buzzer
);
    // Active-high buzzer control. Check the lab buzzer's driver requirements.
    assign buzzer = overload;
endmodule
