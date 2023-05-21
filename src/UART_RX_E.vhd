library ieee ;
use ieee.std_logic_1164.all;

entity UART_RX_E is
	port( 
		rst_n_i : IN std_logic;
		br_i  : IN std_logic;
		d_n_i   : IN std_logic;
		d_o     : OUT std_logic_vector ( 7 downto 0);
		rx_dv_o : OUT std_logic;
		st_o    : OUT std_logic_vector ( 2 downto 0)
	);
end entity UART_RX_E;
 
