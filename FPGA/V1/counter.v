module counter (
    input wire clk,      
    input wire rst,      
    output reg [3:0] out 
);

    always @(posedge clk) begin
        if (rst) begin
            out <= 4'b0000; // Reset count to 0
        end else begin
            out <= out + 1; // Increment count
        end
    end

endmodule
