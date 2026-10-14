module encoder(
    input wire pixel_clk,
    input wire rst,
    input wire [7:0] color,
    input wire de,
    input wire [1:0] control,
    output reg [9:0] encodedcolor,
    output reg signed [4:0] pastdisparity
);
    integer i;
    integer c;
    integer d;
    integer b;
    integer f;
    reg [3:0] count;
    reg [9:0] encoded1;
    reg signed [4:0] imbalance;
    reg signed [4:0] newcount;
    always @(posedge pixel_clk) begin
        count = 0;
        newcount = 0;
        for (i = 0; i < 8; i = i + 1) begin
            count = count + color[i];
        end
        if (rst == 1) begin
            pastdisparity <= 0;
            imbalance = 0;
            encodedcolor <= 10'b0000000000;
        end else begin
            if (de == 1) begin
                if (count > 4 || (count == 4 && color[0] == 0)) begin
                    encoded1[0] = color[0];
                    for (b = 1; b < 8; b = b + 1) begin
                        encoded1[b] = encoded1[b - 1] ~^ color[b];
                    end
                    encoded1[8] = 1'b0;
                end else begin
                    encoded1[0] = color[0];
                    for (c = 1; c < 8; c = c + 1) begin
                        encoded1[c] = encoded1[c - 1] ^ color[c];
                    end
                    encoded1[8] = 1'b1;
                end
                for (f = 0; f < 8; f = f + 1) begin
                    newcount = newcount + encoded1[f];
                end
                imbalance = newcount * 2 - 8;
                newcount = 0;
            
                if (pastdisparity == 0 || imbalance == 0) begin
                    if (encoded1[8] == 1'b1) begin
                        encoded1[9] = 1'b0;
                    end else begin
                        encoded1[9] = 1'b1;
                        encoded1[7:0] = ~encoded1[7:0];
                    end
                end else if (pastdisparity[4] == imbalance[4]) begin
                    encoded1[9] = 1'b1;
                    encoded1[7:0] = ~encoded1[7:0];
                end else begin
                    encoded1[9] = 1'b0;
                end
                encodedcolor <= encoded1;
                for (d = 0; d < 10; d = d + 1) begin
                    newcount = newcount + encoded1[d];
                end
                pastdisparity <= pastdisparity +  newcount * 2 - 10;
            end
            else begin
                pastdisparity <= 0;
                case(control)
                    2'b00: encodedcolor <= 10'b1101010100;
                    2'b01: encodedcolor <= 10'b0010101011;
                    2'b10: encodedcolor <= 10'b0101010100;
                    2'b11: encodedcolor <= 10'b1010101011;
                endcase
            end
        end
    end
endmodule