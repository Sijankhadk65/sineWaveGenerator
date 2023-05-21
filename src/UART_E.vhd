library ieee ; 
use ieee.std_logic_1164.all;

entity UART_E is
	port( 
		d_n_i     : IN  std_logic;
		rst_n_i   : IN  std_logic;
		br_i      : IN  std_logic;
		d_o       : OUT std_logic;
		tx_dv_o   : OUT std_logic;
		rx_st_o   : OUT std_logic_vector (2 downto 0);
		tx_st_o   : OUT std_logic_vector (2 downto 0)
	);
end entity UART_E;
 

