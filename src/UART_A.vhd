architecture UART_A of UART_E is 

	signal data_register : std_logic_vector (0 to 7) ;
	signal dv_s : std_logic ;  
	
	signal d_o_s : std_logic;
	signal tx_dv_s : std_logic;
	
	signal rx_st : std_logic_vector (2 downto 0) ;  
	signal tx_st : std_logic_vector (2 downto 0) ;
begin

	u_UART_RX_E : ENTITY work.UART_RX_E
		port map(
			rst_n_i => rst_n_i,
			br_i    => br_i,
			d_n_i   => d_n_i,
			d_o     => data_register,
			rx_dv_o => dv_s,
			st_o    => rx_st
		);
	
	u_UART_TX_E : ENTITY work.UART_TX_E
		port map(
			rst_n_i  => rst_n_i,
			br_i     => br_i,
			d_n_i    => data_register,
			d_o      => d_o_s,
			tx_start => dv_s,
			tx_dv_o  => tx_dv_s,
			st_o     => tx_st
		);
		
		d_o     <= d_o_s;
		tx_dv_o <= tx_dv_s;
		rx_st_o <= rx_st;
		tx_st_o	<= tx_st;
  
end architecture UART_A;
