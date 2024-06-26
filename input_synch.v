module input_synch
(
	input wire clk,
	input wire reset,
	output wire sync_reset,
	input wire sync_in,
	output wire sync_out
);
	reg [1:0] chain0, chain1;
	
	// the reset output is asynchronous when activated and becomes synchronous when deactivated because of the chain0 pipeline
	always @ (posedge clk)
	begin
		chain0[1:0] <= {(chain0[0] & !reset), reset};
		chain1[1:0] <= {chain1[0], sync_in};
	end	

	assign sync_reset = (chain0[1] & !reset);
	assign sync_out	= (chain1[1] & !reset);
	
endmodule
