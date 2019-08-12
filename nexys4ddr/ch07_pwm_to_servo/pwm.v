module pwm #(  parameter DUTYWIDTH  = 8 ) (
    input pwm_clk,
    input [DUTYWIDTH - 1:0] duty,
    output reg PWM_led,
    output reg PWM_pin,
    output reg PWM_CLK_pin
    );

reg [DUTYWIDTH - 1:0] count = 0;

always @(posedge pwm_clk)
begin
  count <= count + 1;
  PWM_led <= (count < duty);
  PWM_pin <= (count < duty);
  PWM_CLK_pin <= ! PWM_CLK_pin;
end

endmodule
