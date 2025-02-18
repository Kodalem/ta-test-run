`timescale 1ns / 1ps

`define assert(signal, value) \
        if (signal !== value) begin \
            $display("ASSERTION FAILED in %m: signal != value"); \
            $finish; \
        end

module tt_um_up_down_counter_tb;

    // Inputs
    reg clk;
    reg reset;
    reg ena;
    reg set;
    reg [3:0] set_value;
    reg up_down;

    // Outputs
    wire [3:0] count;

    // Instantiate the Unit Under Test (UUT)
    tt_um_up_down_counter dut (
        .clk(clk),
        .reset(reset),
        .ena(ena),
        .set(set),
        .set_value(set_value),
        .up_down(up_down),
        .count(count)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0, dut);
        // Initialize Inputs
        clk = 0;
        reset = 0;
        ena = 0;
        set = 0;
        set_value = 4'b0000;
        up_down = 0;
        `assert(set, 0);

        // Apply reset
        reset = 1;
        #10;
        reset = 0;
        `assert(count, 4'b0000);

        // Test set functionality
        set_value = 4'b1010;
        set = 1;
        #10;
        set = 0;
        `assert(count, 4'b1010);

        // Test enable and up counting
        ena = 1;
        up_down = 1; // Count up
        #50;
        `assert(count, 4'b1111);

        // Test down counting
        up_down = 0; // Count down
        #50;

        // Test disable counting
        ena = 0;
        #20;

        // Test reset during operation
        reset = 1;
        #10;
        reset = 0;
        `assert(count, 4'b0000);
        ena = 1;
        up_down = 1; // Count up
        #50;

        // Finish simulation
        $finish;
    end

endmodule