`default_nettype none
`timescale 1ns / 1ps

/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/
module tb ();

  // Wire up the inputs and outputs:

    // Inputs
    reg clk;
    reg reset;
    reg enable;
    reg set;
    reg [3:0] set_value;
    reg up_down;

    // Outputs
    wire [3:0] count;

  // Replace tt_um_example with your module name:
  tt_um_up_down_counter user_project (

        // Inputs:
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .set(set),
        .set_value(set_value),
        .up_down(up_down),

        // Outputs:
        .count(count)

  );

endmodule

