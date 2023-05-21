library ieee ;
use ieee.std_logic_1164.all;

entity UART_TX_E is
	port( 
		rst_n_i  : IN std_logic;
		br_i     : IN std_logic;
		d_n_i    : IN std_logic_vector  (0 to 7);
		d_o      : OUT std_logic;
		tx_start : IN std_logic;
		tx_dv_o  : OUT std_logic;
		st_o     : OUT std_logic_vector (2 downto 0)
	);
end entity UART_TX_E;
 
