-- Authors:	FRIAS, Mon Cedrick G.
--		JARO, Jeriel G.
-- Section: 	CMSC 132 T-2L

-- Library Statements
library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Entity Definition
entity t2l_frias_jaro_tb is -- constants are defined here
	constant MAX_COMB: integer := 64; -- number of input combinations (4 bits)
	constant DELAY: time := 10 ns; --delay value in testing
end entity t2l_frias_jaro_tb;

-- Architecture Definition
architecture t2l_frias_jaro_tb of t2l_frias_jaro_tb is
	signal alarm: std_logic; -- the unary encoded data output from the UUT
	signal buzzer_in: std_logic_vector(2 downto 0); -- inputs to UUT
	signal buzzer_out: std_logic_vector(2 downto 0); -- inputs to UUT
	
	-- Component Definition
	component t2l_frias_jaro is
		port(alarm: out std_logic; -- unary encoded output
	buzzer_in: in std_logic_vector(2 downto 0); -- 3 in buzzers for boggis, bunce, and bean respectively
	buzzer_out: in std_logic_vector(2 downto 0)); -- 3 out buzzers for boggis, bunce, and bean respectively
	end component t2l_frias_jaro;
	
begin -- begin main body of the tb architecture
	-- instantiate the UUT (Unit Under Test)
	UUT: component t2l_frias_jaro port map(alarm, buzzer_in, buzzer_out);
	
	-- main process: generate test vectors and check results
	main: process is
		variable temp: unsigned(5 downto 0); -- used in calculations
		variable expected_alarm: std_logic; -- expected alarm state
		variable error_count: integer := 0; -- number of simulation errors
		
	begin
		report "Start Simulation.";
		
		--generate all possible input values, since max = 15
		for count in 0 to 63 loop
			temp := TO_UNSIGNED(count, 6);
			buzzer_in(2) <= std_logic(temp(5)); -- 6th bit
			buzzer_in(1) <= std_logic(temp(4)); -- 5th bit
			buzzer_in(0) <= std_logic(temp(3)); -- 4th bit
			buzzer_out(2) <= std_logic(temp(2)); -- 3rd bit
			buzzer_out(1) <= std_logic(temp(1)); -- 2nd bit
			buzzer_out(0) <= std_logic(temp(0)); -- 1st bit
			
			-- compute expected values
			if(count=0) then
				expected_alarm := '0';
			else
				if(count>=9 and count<=15) then expected_alarm := '1'; --     0 0 1 0 0 1 -> 0 0 1 1 1 1
				elsif(count>=17 and count<=23) then expected_alarm := '1'; -- 0 1 0 0 0 1 -> 0 1 0 1 1 1
				elsif(count>=25 and count<=31) then expected_alarm := '1'; -- 0 1 1 0 0 1 -> 0 1 1 1 1 1
				elsif(count>=33 and count<=39) then expected_alarm := '1'; -- 1 0 0 0 0 1 -> 1 0 0 1 1 1
				elsif(count>=41 and count<=47) then expected_alarm := '1'; -- 1 0 1 0 0 1 -> 1 0 1 1 1 1
				elsif(count>=49 and count<=55) then expected_alarm := '1'; -- 1 1 0 0 0 1 -> 1 1 0 1 1 1
				elsif(count>=57 and count<=63) then expected_alarm := '1'; -- 1 1 1 0 0 1 -> 1 1 1 1 1 1
				else expected_alarm := '0';
				end if; -- of checks with i > 0
			end if; -- of if(i=0) .. else
			
			wait for DELAY; -- wait, and then compare with UUT outputs
			
			--check if output of circuit is the same as the expected value
			assert (expected_alarm = alarm)
				report "ERROR: Expected alarm " &
				std_logic'image(expected_alarm) &
				" at time " & time'image(now);
				
			-- increment number of errors
			if(expected_alarm /= alarm) then
				error_count := error_count + 1;
			end if;
		end loop;
		
		wait for DELAY;
		
		-- report errors
		assert (error_count=0)
			report "ERROR: There were " &
				integer'image(error_count) & " errors!";
				
		-- there are no errors
		if(error_count = 0) then
			report "Simulation completed with NO errors.";
		end if;
		
		wait; -- terminate the simulation
	end process;
end architecture t2l_frias_jaro_tb;
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
