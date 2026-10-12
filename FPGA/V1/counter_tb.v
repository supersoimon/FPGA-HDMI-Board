`timescale 1ns / 1ps

module counter_tb;

    reg clk;
    reg rst;
    wire [3:0] out;
    counter uut (
        .clk(clk),
        .rst(rst),
        .out(out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, counter_tb);

        clk = 0;
        rst = 1;

        #20;
        rst = 0; 
        
        #150;
        rst = 1;
        #20;

        $finish;
    end

endmodule
