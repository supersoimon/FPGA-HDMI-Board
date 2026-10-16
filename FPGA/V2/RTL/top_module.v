module top_module (
    input wire clk,
    output wire [3:0] gpdi_dp,
    output wire [3:0] gpdi_dn
);
    wire pixel_clk; 
    wire serial_clk;
    wire [9:0] x_position, y_position, encoded_red, encoded_green, encoded_blue;
    wire [7:0] red, green, blue;
    wire [1:0] _red, _green, _blue, _clock;
    wire hsync, vsync, de;
    wire pll_locked;
    wire reset = !pll_locked;
    
    EHXPLLL #(
        .CLKI_DIV(2),
        .CLKFB_DIV(5),
        .CLKOP_DIV(5),
        .CLKOP_ENABLE("ENABLED"),
        .CLKOS_DIV(25),
        .CLKOS_ENABLE("ENABLED"),
        .CLKOP_CPHASE(2),
        .CLKOS_CPHASE(2),
        .CLKOP_FPHASE(0),
        .CLKOS_FPHASE(0),
        .CLKOS2_ENABLE("DISABLED"),
        .CLKOS3_ENABLE("DISABLED"),
        .CLKOUT_BYPASS("DISABLED"),
        .FEEDBK_PATH("CLKOP")
    ) pll_inst (
        .CLKI(clk),    
        .CLKFB(serial_clk),   
        .PHASESEL1(1'b0),
        .PHASESEL0(1'b0),
        .PHASEDIR(1'b0),
        .PHASESTEP(1'b0),
        .PHASELOADREG(1'b0),
        .STDBY(1'b0),
        .PLLWAKESYNC(1'b0),
        .RST(1'b0),      
        .ENCLKOP(1'b1),
        .ENCLKOS(1'b1),
        .ENCLKOS2(1'b0),
        .ENCLKOS3(1'b0),
        .CLKOP(serial_clk), 
        .CLKOS(pixel_clk),    
        .CLKOS2(),
        .CLKOS3(),
        .LOCK(pll_locked)      
    );
    timing timingg (
        .pixel_clk(pixel_clk),
        .rst(reset),
        .horizontal_pos(x_position),
        .vertical_pos(y_position),
        .hsync(hsync),
        .vsync(vsync),
        .de(de)
    );
    testpattern testpatternn (
        .horizontal_pos(x_position),
        .vertical_pos(y_position),
        .de(de),
        .testpatterninput(2'b11), 
        .red(red),
        .green(green),
        .blue(blue)
    );
    encoder encoder_blue (
        .pixel_clk(pixel_clk),
        .rst(reset),
        .color(blue),
        .de(de),
        .control({vsync, hsync}),
        .encodedcolor(encoded_blue)
    );
    encoder encoder_red (
        .pixel_clk(pixel_clk),
        .rst(reset),
        .color(red),
        .de(de),
        .control(2'b00),
        .encodedcolor(encoded_red)
    );
    encoder encoder_green (
        .pixel_clk(pixel_clk),
        .rst(reset),
        .color(green),
        .de(de),
        .control(2'b00),
        .encodedcolor(encoded_green)
    );

    serializer serializerr (
        .serial_clk(serial_clk),
        .rst(reset),
        .encodedcolor0(encoded_blue),
        .encodedcolor1(encoded_green),
        .encodedcolor2(encoded_red),
        .serial_out0(_blue),
        .serial_out1(_green),
        .serial_out2(_red),
        .serial_out3(_clock)
    );
    ODDRX1F output_blue (
        .SCLK(serial_clk),
        .RST(reset),
        .D0(_blue[0]), 
        .D1(_blue[1]),
        .Q(gpdi_dp[0])
    );
    ODDRX1F output_green (
        .SCLK(serial_clk),
        .RST(reset),
        .D0(_green[0]), 
        .D1(_green[1]),
        .Q(gpdi_dp[1])
    );
    ODDRX1F output_red (
        .SCLK(serial_clk),
        .RST(reset),
        .D0(_red[0]), 
        .D1(_red[1]),
        .Q(gpdi_dp[2])
    );
    ODDRX1F output_clock (
        .SCLK(serial_clk),
        .RST(reset),
        .D0(_clock[0]), 
        .D1(_clock[1]),
        .Q(gpdi_dp[3])
    );
endmodule