library ieee ; 
use ieee.std_logic_1164.all;

entity CLK_TB_E is

end entity CLK_TB_E;

architecture CLKS_TB_A of CLK_TB_E is 
	signal clk_s : std_logic ;  
begin
  	u_CLK_E: entity work.CLK_E
  		port map( 
  			clk_o => clk_s
  		 );
  		 
  	tb_process : process is
  	begin
  		wait for 1000 ms; 
  		wait;
  	end process tb_process;
  	
  		
end architecture CLKS_TB_A;

