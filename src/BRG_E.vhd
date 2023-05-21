library ieee ; 
use ieee.std_logic_1164.all ; 

entity BRG_E is
	port( 
		clk_n_i : IN std_logic;
		rst_n_i : IN std_logic;
		br_o    : OUT std_logic
	);
end entity BRG_E;


