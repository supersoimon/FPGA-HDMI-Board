module timing (
    input wire pixel_clk,
    input wire rst,
    output reg [9:0] horizontal_pos,
    output reg [9:0] vertical_pos, 
    output reg hsync,
    output reg vsync,
    output reg de
);
    reg [9:0] horizontal;
    reg [9:0] vertical;
    always @(posedge pixel_clk) begin
        if (rst) begin
                    horizontal <= 0;
                    vertical <= 0;
                    hsync <= 1;
                    vsync <= 1;
                      horizontal_pos <= 0;
                    vertical_pos <= 0;
                    de <= 0;
                end
        else begin
        if (horizontal < 799) begin
            horizontal <= horizontal + 1;
        end else begin
            horizontal <= 0;
            if (vertical < 524) begin
                vertical <= vertical + 1;
            end else begin
                vertical <= 0;
            end
        end
        
                    horizontal_pos <= horizontal;
                    vertical_pos <= vertical;
                if (horizontal < 640 && vertical < 480) begin
                    de <= 1; 
                end else begin
                    de <= 0;
                end
                if (horizontal >= 656 && horizontal <= 751) begin
                    hsync <= 0; 
                end else begin
                    hsync <= 1;
                end
                if (vertical <= 491 && vertical >= 490) begin
                    vsync <= 0; 
                end else begin
                    vsync <= 1;
                end
    end
    end

endmodule