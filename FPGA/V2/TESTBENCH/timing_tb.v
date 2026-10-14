`timescale 1ns / 1ps

module timing_tb;

    reg pixel_clk;
    reg rst;
    
    wire [9:0] horizontal_pos;
    wire [9:0] vertical_pos;
    wire hsync;
    wire vsync;
    wire de;

    timing dut (
        .pixel_clk(pixel_clk),
        .rst(rst),
        .horizontal_pos(horizontal_pos),
        .vertical_pos(vertical_pos),
        .hsync(hsync),
        .vsync(vsync),
        .de(de)
    );

    always begin
        #19.861 pixel_clk = ~pixel_clk;
    end
    initial begin
        $dumpfile("timing.vcd");
        $dumpvars(0, timing_tb);

        pixel_clk = 0;
        rst = 1;

        #100;
        rst = 0; 
        
        #70000000;
        rst = 1;
        #20;

        $finish;
    end
endmodule