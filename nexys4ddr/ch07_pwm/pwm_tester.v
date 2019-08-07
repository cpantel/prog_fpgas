module pwm_tester(
    input CLK,
    input faster_button,
    input slower_button,
    output PWM_led,
    output JA1,
    output JB1
    );

wire s_up, s_dn;
debouncer d1(.CLK (CLK), .switch_input (faster_button), .trans_up (s_up));
debouncer d2(.CLK (CLK), .switch_input (slower_button), .trans_up (s_dn));

reg [8:0] duty = 0;
reg [7:0] prescaler = 0;
pwm p(.pwm_clk (prescaler[7]), .duty (duty), .PWM_led (PWM_led), .PWM_pin(JA1), .PWM_CLK_pin(JB1));

always @(posedge CLK)
begin
  prescaler <= prescaler + 1;
  if (s_up)
  begin
    duty <= duty + 5;
  end
  if (s_dn)
  begin
    duty <= duty - 5;
  end  
end

endmodule
