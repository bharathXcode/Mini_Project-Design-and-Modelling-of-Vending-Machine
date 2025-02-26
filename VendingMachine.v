module sk_vm(
  input  clk,
  input  reset,
  input  [3:0] coin_input,
  input feed,
  input [2:0] product_input,
  output reg [3:0]coin_count=4'd0,
  output reg[7:0] led_output,
  output reg change_led=0,
  output reg [7:0] inventory,
  output reg [3:0] change_return,
  output reg inventory_empty=0
);
 
  reg [7:0] product_price;
  reg [3:0] coin_value;
  reg [2:0] inventory_count[0:7] ;
   
  always @(posedge clk)
  begin
    if (reset) 
	 begin
      product_price <= 8'b0;
      change_return <= 4'b0;
      led_output<=0;
      change_return<= 4'b0;
		inventory=8'b11111111;
		inventory_count[0]=3'd5;
		inventory_count[1]=3'd5;
		inventory_count[2]=3'd5;
		inventory_count[3]=3'd5;
		inventory_count[4]=3'd5;
		inventory_count[5]=3'd5;
		inventory_count[6]=3'd5;
		inventory_count[7]=3'd5;
    end 
	 
	 else 
	 
	 begin	   
      case (product_input)
        3'b000: product_price <= 3;   // Price of product 0
        3'b001: product_price <= 4;   // Price of product 1
        3'b010: product_price <= 6;   // Price of product 2
        3'b011: product_price <= 7;   // Price of product 3
        3'b100: product_price <= 9;   // Price of product 4
        3'b101: product_price <= 11;  // Price of product 5
        3'b110: product_price <= 12;  // Price of product 6
        3'b111: product_price <= 14;  // Price of product 7
        default: product_price <= 0;
      endcase
  end
 
	case (coin_input)
        4'b0001: coin_value <= 1;
        4'b0010: coin_value <= 2;
        4'b0100: coin_value <= 5;
        4'b1000: coin_value <= 10;
        default: coin_value <= 0;
      endcase

	if(feed==1)
		coin_count=coin_count+coin_value;
		else
		begin
		if ((coin_count == product_price) &&( inventory_count[product_input] > 0))
		begin
        led_output = (1<< product_input);
        change_return = coin_count - product_price;
        inventory_count[product_input] = inventory_count[product_input] - 1;
		  change_led=1'b0;
		  coin_count=0;
		end 
		else if((coin_count > product_price) &&( inventory_count[product_input] > 0))
				begin
        led_output = (1<< product_input);
        change_return = coin_count - product_price;
        inventory_count[product_input] = inventory_count[product_input] - 1;
		  change_led=1'b1;
		  coin_count=0;
		end 

		else if(coin_count<product_price)
		begin
			change_return = coin_count;
			change_led=1'b1;
			coin_count=0;
		end
	   if	(inventory_count[product_input] == 0)
      begin
		inventory_empty =1 ;
		inventory_count[product_input]=3'b101;
	   inventory[product_input]=0;
		end
		       // if (led_output != 8'b0)
      //  inventory_full[product_input] <= (inventory_count[product_input] == 5);
    //end
end

  //always@(fill)
  //begin
  //inventory_count[product_input]=3'b101;
 end
endmodule
