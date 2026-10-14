`timescale 1ns / 1ps

module encoder_tb;

    reg pixel_clk;
    reg rst;
    reg [7:0] color;
    reg de;
    reg [1:0] control;
    wire [9:0] encodedcolor;
    wire [4:0] pastdisparity;
    
    encoder dut (
        .pixel_clk(pixel_clk),
        .rst(rst),
        .color(color),
        .de(de),
        .control(control),
        .encodedcolor(encodedcolor),
        .pastdisparity(pastdisparity)
    );

    always begin
        #19.861 pixel_clk = ~pixel_clk;
    end

    initial begin
        $dumpfile("encoder.vcd");
        $dumpvars(0, encoder_tb);
        pixel_clk = 0;
        de = 0;
        rst = 0;
        control = 2'b00;
        color = 8'h00;

        #100;
        de = 1;
        
        #1000;
        color = 8'h00;
        #500;
        color = 8'hFF;
        #500;
        color = 8'h01;
        #500;
        rst = 1;
        #1000;
        rst = 0;
        de = 0;
        #1000;
        control = 2'b00;
        #1000;
        control = 2'b01;
        #1000;
        control = 2'b10;
        #1000;
        control = 2'b11;
        #1000;

        $finish;
    end
endmodule