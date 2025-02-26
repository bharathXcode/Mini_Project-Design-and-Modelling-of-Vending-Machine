module tbvm;
reg clk;
	reg reset;
	reg [3:0] coin_input;
	reg feed;
	reg [2:0] product_input;
	wire [3:0]coin_count;

	
	wire [7:0] led_output;
	wire change_led;
	wire [7:0] inventory;
	wire [3:0] change_return;
	wire inventory_empty;

	// Instantiate the Unit Under Test (UUT)
	sk_vm uut (
		.clk(clk), 
		.reset(reset), 
		.coin_input(coin_input),
      .coin_count(coin_count),		
		.feed(feed), 
		.product_input(product_input), 
		.led_output(led_output), 
		.change_led(change_led), 
		.inventory(inventory), 
		.change_return(change_return), 
		.inventory_empty(inventory_empty)
	);

	initial 
clk = 0;
		reset =1;
		coin_input = 0;
		feed = 0;
		product_input = 1;
		#20 reset=0;
		
		#25 feed=1;
		coin_input=1;
		#10 coin_input=2;
		# 10 coin_input=2;
		# 20 coin_input=0;
		feed=0;
		

		#10 product_input=2;
	
		#25 feed=1;
		coin_input=1;
		#10 coin_input=2;
		# 20 coin_input=0;
			feed=0;
		
		end


		always
		#5 clk=~clk;
      
endmodule