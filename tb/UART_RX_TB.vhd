library  ieee ;
use ieee.std_logic_1164.all;

entity UART_RX_TB_E is

end entity UART_RX_TB_E;

architecture UART_RX_TB_A of UART_RX_TB_E is 
	signal clk_s   : std_logic ;  
	signal rst_s   : std_logic := '0' ;
	signal br_s    : std_logic ; 
	signal d_s     : std_logic ; 
	signal d_o_s   : std_logic_vector (7 downto 0) ;  
	signal rx_dv_s : std_logic ;  
	signal dum_d   : std_logic_vector (0 to 7) := "11110000" ; 
	signal st_s    : std_logic_vector ( 2 downto 0); 
	
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
	
	u_UART_RX_E : ENTITY work.UART_RX_E
		port map (
			rst_n_i => rst_s,
			br_i    => br_s,
			d_n_i   => d_s,
			d_o     => d_o_s,
			rx_dv_o => rx_dv_s,
			st_o    => st_s
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
		wait until rx_dv_s = '1';
		rst_s <= '1';
		wait;
	end process tb;
	
  
end architecture UART_RX_TB_A;


