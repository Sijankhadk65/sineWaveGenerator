library ieee ;
use ieee.std_logic_1164.all ; 
 
entity BRG_TB_E is
	
end entity BRG_TB_E;


architecture BRG_TB_A of BRG_TB_E is 
	signal clk_s : std_logic ;  
	signal rst_s : std_logic ;
	signal br_s  : std_logic ;  
begin

	u_CLK_E : entity work.CLK_E
		port map(
			clk_o => clk_s
		);
	
	u_BRG_E : entity work.BRG_E
		port map(
			clk_n_i => clk_s,
			rst_n_i => rst_s,
			br_o    => br_s
		);
		
	tb : process is
	begin
		rst_s <= '0';
		wait for 500 ms;
		rst_s <= '1';
		wait;
	end process tb;
	
  
end architecture BRG_TB_A;
