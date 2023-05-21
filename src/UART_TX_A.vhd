architecture UART_TX_A of UART_TX_E is 

	type U_STATE is 
		(IDLE,START_TRANSMISSION,TRANSMITTING,STOP_BIT) ;  
	signal current_state : u_state := IDLE ;
	signal next_state : u_state ;
	signal shift_count : integer := 0 ; 
	signal st_s : std_logic_vector (2 downto 0) := "000" ;  
	  
	
begin

	Next_Stage_Logic : process (current_state,br_i)
	begin
		case current_state is  
			when IDLE =>
				if tx_start = '1' then
					next_state <= START_TRANSMISSION;
					st_s <= "001";
				else
					next_state <= IDLE;
					st_s <= "000";
				end if;
			when START_TRANSMISSION =>
				next_state <= TRANSMITTING;
				st_s <= "010";
			when TRANSMITTING =>
				if shift_count < 7 then
					next_state <= TRANSMITTING;
					st_s <= "010";
				else
					next_state <= STOP_BIT;
					st_s <= "011";
				end if;
			when STOP_BIT =>
				next_state <= IDLE;
				st_s <= "000";
			when OTHERS =>
				next_state <= IDLE;
				st_s <= "000";
		end case ;
	end process Next_Stage_Logic;
	
	Output_logic : process (br_i)
	begin
		if br_i'event and br_i = '1' then
			if current_state = IDLE then
			elsif current_state = START_TRANSMISSION then
				tx_dv_o <= '1';
			elsif current_state = TRANSMITTING then
				d_o <= d_n_i(shift_count);
				if shift_count < 7 then
					shift_count <= shift_count + 1;
				else 
					shift_count <= 0;
				end if;
			elsif current_state = STOP_BIT then
				shift_count <=  0;
				tx_dv_o     <= '0';		
			end if ;  
		end if;
	end process Output_logic;
	
	State_Register : process (rst_n_i,br_i)
	begin
		if rst_n_i = '1' then
			current_state <= IDLE;
			st_o <= "000";
		elsif br_i'event and br_i = '1' then
			current_state <= next_state;
			st_o <= st_s;
		end if ;
	end process State_Register; 
end architecture UART_TX_A;
