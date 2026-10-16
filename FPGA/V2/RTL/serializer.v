module serializer(
    input wire serial_clk,
    input wire rst,
    input wire [9:0] encodedcolor0,
    input wire [9:0] encodedcolor1,
    input wire [9:0] encodedcolor2,
    output reg serial_out0,
    output reg serial_out1,
    output reg serial_out2
);
    integer i;
    reg [9:0] encodingcolor1;
    reg [9:0] encodingcolor2;
    reg [9:0] encodingcolor3;
    always @(posedge serial_clk) begin
        if (rst == 1) begin
            i <= 0;
            encodingcolor1 <= 10'b0000000000;
            encodingcolor2 <= 10'b0000000000;
            encodingcolor3 <= 10'b0000000000;
        end else if (i == 9) begin
            encodingcolor1 <= encodedcolor0;
            encodingcolor2 <= encodedcolor1;
            encodingcolor3 <= encodedcolor2;
            i <= 0;
        end else begin
            i <= i + 1;
        end
        if (rst == 1) begin
            serial_out0 <= 0;
            serial_out1 <= 0;
            serial_out2 <= 0;
        end else begin
            serial_out0 <= encodingcolor1[i];
            serial_out1 <= encodingcolor2[i];
            serial_out2 <= encodingcolor3[i];
        end
        
    end  
endmodule