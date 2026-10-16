module serializer(
    input wire serial_clk,
    input wire rst,
    input wire [9:0] encodedcolor0,
    input wire [9:0] encodedcolor1,
    input wire [9:0] encodedcolor2,
    output reg [1:0] serial_out0,
    output reg [1:0] serial_out1,
    output reg [1:0] serial_out2,
    output reg [1:0] serial_out3
);
    reg [3:0] i;
    reg [9:0] encodingcolor1;
    reg [9:0] encodingcolor2;
    reg [9:0] encodingcolor3;
    reg [9:0] encodingcolor4;
    always @(posedge serial_clk) begin
        if (rst == 1) begin
            i <= 0;
            encodingcolor1 <= 10'b0000000000;
            encodingcolor2 <= 10'b0000000000;
            encodingcolor3 <= 10'b0000000000;
            encodingcolor4 <= 10'b0000000000;
        end else if (i == 4) begin
            encodingcolor1 <= encodedcolor0;
            encodingcolor2 <= encodedcolor1;
            encodingcolor3 <= encodedcolor2;
            encodingcolor4 <= 10'b0000011111;
            i <= 0;
        end else begin
            i <= i + 1;
        end
        if (rst == 1) begin
            serial_out0 <= 2'b00;
            serial_out1 <= 2'b00;
            serial_out2 <= 2'b00;
            serial_out3 <= 2'b00;
        end else begin
            serial_out0[0] <= encodingcolor1[2 * i];
            serial_out0[1] <= encodingcolor1[2 * i + 1];
            serial_out1[0] <= encodingcolor2[2 * i];
            serial_out1[1] <= encodingcolor2[2 * i + 1];
            serial_out2[0] <= encodingcolor3[2 * i];
            serial_out2[1] <= encodingcolor3[2 * i + 1];
            serial_out3[0] <= encodingcolor4[2 * i];
            serial_out3[1] <= encodingcolor4[2 * i + 1];
        end
        
    end  
endmodule