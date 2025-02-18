module tt_um_up_down_counter (
    input wire clk,
    input wire rst_n,
    input wire ena,
    input wire set,
    input wire [3:0] set_value,
    input wire up_down, // 1 for up, 0 for down
    output wire [3:0] count
);

reg [3:0] count_reg;

always @(posedge clk or posedge rst_n) begin
    if (rst_n) begin
        count_reg <= 4'b0000;
    end else if (set) begin
        count_reg <= set_value; // Set to the provided set_value
    end else if (ena) begin
        if (up_down) begin
            count_reg <= count_reg + 1;
        end else begin
            count_reg <= count_reg - 1;
        end
    end
end

assign count = count_reg;

endmodule