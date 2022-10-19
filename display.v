module display(clk, rst_n, adata, sel, seg, clk_slow);
	input clk;
	input rst_n;
	
	input[19:0] adata;
	output reg[2:0] sel;
	output reg[7:0] seg;
	output reg clk_slow;
	wire[19:0] data;
	reg[15:0] cnt;
	reg[3:0] segdata;
	
	assign data = adata;
	
	always @(posedge clk)
	begin
			if(!rst_n)
			begin
					cnt <= 0;
					clk_slow <= 1;
			end
			else
			begin
					cnt <= cnt +1;
					clk_slow <= cnt[12];
			end
	end
	
	always @(posedge clk_slow or negedge rst_n)
	begin
			if(!rst_n)
			begin
					sel <= 0;
			end
			else
			begin
					sel <= sel + 1;
					if(sel >= 5)
							sel <= 0;
			end
	end
	
	always @ (*)
	begin
			if(!rst_n)
				segdata <= 0;
			else
			begin
				case(sel)
					5: segdata <= data[3:0];
					4: segdata <= data[7:4];
					3: segdata <= data[11:8];
					2: segdata <= data[15:12];
					1: segdata <= data[19:16];
				default: segdata <= 0;
				endcase
			end
	end
	
	always @ (*)
		begin
			if(!rst_n)
				begin
					seg <= 8`hff;
				end
			else
				begin				
					case(segdata)	
						0 : seg <= 8'b11000000;      //数字0的显示码
						1 : seg <= 8'b11111001;      //数字1的显示码
						2 : seg <= 8'b10100100;      //数字2的显示码
						3 : seg <= 8'b10110000;      //数字3的显示码
						4 : seg <= 8'b10011001;      //数字4的显示码
						5 : seg <= 8'b10010010;      //数字5的显示码
						6 : seg <= 8'b10000010;      //数字6的显示码
						7 : seg <= 8'b11111000;      //数字7的显示码
						8 : seg <= 8'b10000000;      //数字8的显示码
						9 : seg <= 8'b10010000;      //数字9的显示码
						default : seg <= 8'b11111111;	 //熄灭码
					endcase		
	end
end
	
	endmodule