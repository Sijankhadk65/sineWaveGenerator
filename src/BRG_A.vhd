architecture BRG_A of BRG_E is 

	constant clk_frequency : integer := 1e6 ;
	constant tick_count : integer := integer(clk_frequency / 9600);
	signal count : integer := 0 ;   
	
	signal br_s : std_logic := '0';  
	
begin

	brg : process (rst_n_i, clk_n_i)
	begin
		if rst_n_i = '1' then
			count <= 0;
		elsif clk_n_i'event and clk_n_i = '1' then
			if count >= tick_count then
			    count <= 0;
			else
				count <= count + 1;
			end if ;
		end if ;  
	end process brg;
	 
	counter : process (count)
	begin
		if count = tick_count then
		  br_s <= not br_s;
		end if ;  
	end process counter;
	
	br_o <= br_s;
	
 
end architecture BRG_A;
