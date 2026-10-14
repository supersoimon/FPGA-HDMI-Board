module testpattern (
    input wire [9:0] horizontal_pos,
    input wire [9:0] vertical_pos,
    input wire de,
    input wire [1:0] testpatterninput,
    output reg [7:0] red,
    output reg [7:0] green,
    output reg [7:0] blue
);
    always @(*) begin
        if (de) begin
            case (testpatterninput)
                2'b00: begin
                    red = (vertical_pos * 255) / 480;
                    green = 8'b0;
                    blue = 8'b0;
                end
                2'b01: begin
                    if (horizontal_pos[6] == 1'b1) begin
                        red = 8'b0; 
                        green = 8'b0; 
                        blue = 8'b0; 
                    end else begin
                        red = 8'b11111111; 
                        green = 8'b11111111; 
                        blue = 8'b11111111; 
                    end
                end
                2'b10: begin
                    if (horizontal_pos < 160 && vertical_pos < 160) begin
                        red = 8'h00; 
                        green = 8'h00; 
                        blue = 8'hFF; 
                    end
                    else if (horizontal_pos > 480 && horizontal_pos < 640 && vertical_pos < 160) begin
                        red = 8'hFF; 
                        green = 8'h00; 
                        blue = 8'h00; 
                    end 
                    else if (horizontal_pos < 160 && vertical_pos > 320 && vertical_pos < 480) begin
                        red = 8'h00; 
                        green = 8'hFF; 
                        blue = 8'h00; 
                    end 
                    else if (horizontal_pos > 480 && horizontal_pos < 640 && vertical_pos > 320 && vertical_pos < 480) begin
                        red = 8'hFF; 
                        green = 8'hFF; 
                        blue = 8'hFF; 
                    end 
                    else begin
                        red = 8'h00; 
                        green = 8'h00; 
                        blue = 8'h00; 
                    end
                end
                2'b11: begin
                    red = 8'hFF; 
                    green = 8'hFF; 
                    blue = 8'hFF; 
                end
                default: begin
                    red = 8'h00; 
                    green = 8'h00; 
                    blue = 8'h00; 
                end
            endcase
        end else begin
            red = 8'b0;
            green = 8'b0;
            blue = 8'b0;
        end
    end
endmodule