module counter_7_seg(
    input CLK,
    input switch_up,
    input switch_clear,
    output [7:0] SEG,
    output [7:0] DIGIT
    );

wire s_up, s_clear;
debouncer d1(.CLK (CLK), .switch_input (switch_up), .trans_dn (s_up));
debouncer d2(.CLK (CLK), .switch_input (switch_clear), .trans_dn (s_clear));

reg [11:0] digits;

display_7_seg display(.CLK (CLK), 
		.digits(digits),
		.SEG (SEG), .DIGIT (DIGIT));

always @(posedge CLK)
begin
  if (s_up)
  begin
	digits[3:0] <= digits[3:0] + 1;
    if (digits[3:0] == 9) 
    begin
      digits[3:0] <= 0;
      digits[7:4] <= digits[7:4] + 1;
      if (digits[7:4] == 9) 
      begin
        digits[7:4] <= 0;
        digits[11:8] <= digits[11:8] + 1;
      end
    end		
  end
  if (s_clear)
  begin
    digits <= 0;
  end
end

endmodule
