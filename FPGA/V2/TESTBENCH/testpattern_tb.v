`timescale 1ns / 1ps

module testpattern_tb;

    reg [9:0] horizontal_pos;
    reg [9:0] vertical_pos;
    reg de;

    reg [1:0] testpatterninput;
    wire [7:0] red;
    wire [7:0] green;
    wire [7:0] blue;
    
    testpattern dut (
        .horizontal_pos(horizontal_pos),
        .vertical_pos(vertical_pos),
        .de(de),
        .testpatterninput(testpatterninput),
        .red(red),
        .green(green),
        .blue(blue)
    );


    initial begin
        $dumpfile("testpattern.vcd");
        $dumpvars(0, testpattern_tb);

        horizontal_pos = 0;
        vertical_pos = 0;
        de = 0;
        testpatterninput = 2'b00;

        #100;
        de = 1;
        
        #100;
        vertical_pos = 60;

        #100;
        vertical_pos = 120;

        #100;
        vertical_pos = 180;

        #100;
        vertical_pos = 240; 
        #100; 
        testpatterninput = 2'b01;

        horizontal_pos = 60;
        #100;
        horizontal_pos = 120;
        #100;
        horizontal_pos = 180;
        #100;
        horizontal_pos = 240; 
        #100; 
        testpatterninput = 2'b10;
        
        horizontal_pos = 60;
        vertical_pos = 60;
        #100;
        horizontal_pos = 600;
        vertical_pos = 60;
        #100;
        horizontal_pos = 600;
        vertical_pos = 420;
        #100;
        horizontal_pos = 60; 
        vertical_pos = 420;

        testpatterninput = 2'b11;
         horizontal_pos = 600;
        vertical_pos = 420;
        #100;

        $finish;
    end
endmodule