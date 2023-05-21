library  ieee ; 
use ieee.std_logic_1164.all ;

entity UART_TB_E is
	
end entity UART_TB_E;

architecture UART_TB_A of UART_TB_E is 
	
	signal clk_s : std_logic ;  
	signal rst_s : std_logic ; 
	
	signal br_s : std_logic ; 
	
	signal d_s : std_logic ; 
	signal dum_d : std_logic_vector (0 to 7) := "11110000" ;
	
	signal d_o_s : std_logic; 
	signal tx_dv_s : std_logic;
	
	signal rx_st_s : std_logic_vector (2 downto 0);
	signal tx_st_s : std_logic_vector (2 downto 0);
begin

	u_CLK_E : ENTITY work.CLK_E
		port map (
			clk_o => clk_s
		);
	
	u_BRG_E : ENTITY work.BRG_E
		port map (
			clk_n_i => clk_s,
			rst_n_i => rst_s,
			br_o    => br_s
		);
		
	u_UART_E : ENTITY work.UART_E
		port map (
			rst_n_i  => rst_s,
			br_i     => br_s,
			d_n_i    => d_s,
			d_o      => d_o_s,
			tx_dv_o  => tx_dv_s,
			rx_st_o  => rx_st_s,
			tx_st_o  => tx_st_s
		);
	
	tb : process is
	begin
		d_s <= '1';
		wait until br_s = '1';
		d_s <= '0';
		wait until br_s = '1';
		for i in 0 to 7 loop 
		  d_s <= dum_d(i);
		  wait until br_s = '1';
		end loop ;
		d_s <= '1';
		wait until tx_dv_s = '1';
		rst_s <= '1';
		wait;
	end process tb;
	
  
end architecture UART_TB_A;

 

