module display_7_seg(
    input CLK,
    input [11:0] digits,
    output [7:0] SEG,
    output reg [7:0] DIGIT
    );
	 
reg [3:0] digit_data;
reg [3:0] digit_posn;
reg [23:0] prescaler;
	 
decoder_7_seg decoder(.CLK (CLK), .SEG	(SEG), .D (digit_data));   

always @(posedge CLK)
begin
  prescaler <= prescaler + 24'd1;
  if (prescaler == 24'd50000) // 1 kHz
  begin
    prescaler <= 0;
    digit_posn <= digit_posn + 3'd1;
    case ( digit_posn )
      3'b000 : begin
        digit_data <= digits[3:0];
        DIGIT <= 8'b11111110;
      end
      3'b001 : begin
        digit_data <= digits[7:4];
        DIGIT <= 8'b11111101;
      end
      3'b010 : begin
        digit_data <= digits[11:8];
        DIGIT <= 8'b11111011;
      end
      3'b011 : begin
        digit_data <= digits[11:8];
        DIGIT <= 8'b11110111;
      end
      3'b100 : begin
        digit_data <= digits[11:8];
        DIGIT <= 8'b11101111;
      end
      3'b101 : begin
        digit_data <= digits[11:8];
        DIGIT <= 8'b11011111;
      end
      3'b110 : begin
        digit_data <= digits[11:8];
        DIGIT <= 8'b10111111;
      end
      3'b111 : begin
        digit_data <= digits[11:8];
        DIGIT <= 8'b01111111;
        digit_posn <= 0;
      end
      default: begin
      
      end
    endcase
  end
end
endmodule
