module pwm_tester(
    input CLK,
    input faster_button,
    input slower_button,
    output PWM_led,
    output JA1,
    output JB1
    );

parameter DUTYLOW = 26;
parameter DUTYHIGH = 51;
parameter DUTYSTEP = 1;
parameter DUTYWIDTH = 8;

parameter PRESCALER = 12;
parameter PRESCALER_ADJUST = 95;

parameter PRESCALER_MAX = ( 2 ** PRESCALER ) * PRESCALER_ADJUST / 100;
 
wire s_up, s_dn;
debouncer d1(.CLK (CLK), .switch_input (faster_button), .trans_up (s_up));
debouncer d2(.CLK (CLK), .switch_input (slower_button), .trans_up (s_dn));
 
reg [DUTYWIDTH - 1:0] duty = DUTYLOW;
reg [PRESCALER - 1:0] prescaler = PRESCALER;
pwm #(.DUTYWIDTH(DUTYWIDTH)) p(.pwm_clk (prescaler[PRESCALER - 1]), .duty (duty), .PWM_led (PWM_led), .PWM_pin(JA1), .PWM_CLK_pin(JB1));


always @(posedge CLK)
begin
  
  if (prescaler > PRESCALER_MAX )
    prescaler <= 0;
  else
    prescaler <= prescaler + 1;
  if (s_up && duty < DUTYHIGH )
  begin
    duty <= duty + DUTYSTEP;
  end
  if (s_dn && duty >= DUTYLOW)
  begin
    duty <= duty - DUTYSTEP;
  end  
end

endmodule
