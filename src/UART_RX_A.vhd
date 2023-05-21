architecture UART_RX_A of UART_RX_E is 

	type U_STATE is 
		(IDLE,START_BIT,RECIEVING,STOP_BIT) ;  
	signal current_state : u_state := IDLE ;
	signal next_state : u_state ;
	
	signal shift_register : std_logic_vector (0 to 7):= (others => '0');  
	signal shift_count : integer := 0 ; 
	
	signal st_s : std_logic_vector (2 downto 0) := "000" ;  
	  
	
begin

	Next_Stage_Logic : process (current_state,br_i)
	begin
		case current_state is  
			when IDLE =>
				if d_n_i = '0' then
					next_state <= START_BIT;
					st_s <= "001";
				else
					next_state <= IDLE;
					st_s <= "000";
				end if;
			when START_BIT =>
				next_state <= RECIEVING;
				st_s <= "010";
			when RECIEVING =>
				if shift_count < 7 then
					next_state <= RECIEVING;
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
				shift_register <= (others => '0');
				rx_dv_o <= '0';	
			elsif current_state = START_BIT then
			elsif current_state = RECIEVING then
				shift_register(shift_count) <= d_n_i;
				if shift_count < 7 then
					shift_count <= shift_count + 1;
				else 
					shift_count <= 0;
				end if;
			elsif current_state = STOP_BIT then
				shift_count <= 0;
				rx_dv_o     <= '1';
				d_o         <= shift_register;		
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
end architecture UART_RX_A;
