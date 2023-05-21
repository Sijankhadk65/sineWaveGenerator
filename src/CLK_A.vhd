architecture CLK_A of CLK_E is 
	signal clk_s : std_logic := '0'; 
	
	constant clk_period : time := 1e3 ms ;  
	constant clk_ferequency : integer := 12e6 ;  
	
begin
	clk_s <= not clk_s after 1 us;
	
	clk_o <= clk_s;
	
end architecture CLK_A;
