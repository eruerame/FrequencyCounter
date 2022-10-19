module fre(clk,rst_n,seg,sel,signal);
	input clk;
	input rst_n;
	input signal;
	
	output [2:0] sel;
	output [7:0] seg;
	
	wire clk_slow;
	wire [15:0] freq;
	wire [19:0] bcd; 
	
	
	
	
	FreqCounter u1(.clk(clk),
						.signal(signal),
						.freq(freq)			
	);
	
	bin2bcd u2(.clk(clk_slow),
					.rst_n(rst_n),
					.bin(freq),
					.bcd(bcd)
	);
	
	display u3(.clk(clk),
					.rst_n(rst_n),
					.adata(bcd),
					.sel(sel),
					.seg(seg),
					.clk_slow(clk_slow)
	);
	
endmodule
