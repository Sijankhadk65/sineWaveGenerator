library  ieee ;
use ieee.std_logic_1164.all;

entity UART_TX_TB_E is

end entity UART_TX_TB_E;

architecture UART_TX_TB_A of UART_TX_TB_E is 
	signal clk_s   : std_logic ;  
	signal rst_s   : std_logic := '0' ;
	signal br_s    : std_logic ; 
	signal d_o_s   : std_logic;  
	signal tx_dv_s : std_logic; 
	signal tx_start_s : std_logic; 
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
	
	u_UART_TX_E : ENTITY work.UART_TX_E
		port map (
			rst_n_i  => rst_s,
			br_i     => br_s,
			d_n_i    => dum_d,
			d_o      => d_o_s,
			tx_start => tx_start_s,
			tx_dv_o  => tx_dv_s,
			st_o     => st_s
		);
	
	tb : process is
	begin
		tx_start_s <= '0';
		wait until br_s = '1';
		tx_start_s <= '1';
		wait until tx_dv_s = '1';
		wait until tx_dv_s = '0';
		rst_s <= '1';
		wait;
	end process tb;
	
  
end architecture UART_TX_TB_A;


