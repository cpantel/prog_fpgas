module counter(
    input BTNC,
    output reg [3:0] Q
    );
	 
always @(posedge BTNC)
begin
	Q <= Q + 1;
end

endmodule
