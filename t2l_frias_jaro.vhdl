-- Authors:	FRIAS, Mon Cedrick G.
--		JARO, Jeriel G.
-- Section: 	CMSC 132 T-2L

-- Library Statements
library IEEE; use IEEE.std_logic_1164.all;

--Entity Definition
entity t2l_frias_jaro is
	port(alarm: out std_logic; -- 1 bit output
	buzzer_in: in std_logic_vector(2 downto 0);-- 3 in buzzers for boggis, bunce, and bean respectively
	buzzer_out: in std_logic_vector(2 downto 0));-- 3 out buzzers for boggis, bunce, and bean respectively
end entity t2l_frias_jaro;

-- Architecture Definition
architecture t2l_frias_jaro of t2l_frias_jaro is
begin
	process (buzzer_in(2), buzzer_in(1), buzzer_in(0), buzzer_out(2), buzzer_out(1), buzzer_out(0)) is -- activate when any input changes
	begin
		-- conditions that will make the alarm ON.
		if(buzzer_in(0)='1' and buzzer_out(0)='1') then alarm <= '1'; --    TRUTH TABLE: 0 0 1 0 0 1
		elsif(buzzer_in(0)='1' and buzzer_out(1)='1') then alarm <= '1'; -- TRUTH TABLE: 0 0 1 0 1 X
		elsif(buzzer_in(0)='1' and buzzer_out(2)='1') then alarm <= '1'; -- TRUTH TABLE: 0 0 1 1 X X
		elsif(buzzer_in(1)='1' and buzzer_out(0)='1') then alarm <= '1'; -- TRUTH TABLE: 0 1 X 0 0 1
		elsif(buzzer_in(1)='1' and buzzer_out(1)='1') then alarm <= '1'; -- TRUTH TABLE: 0 1 X 0 1 X
		elsif(buzzer_in(1)='1' and buzzer_out(2)='1') then alarm <= '1'; -- TRUTH TABLE: 0 1 X 1 X X
		elsif(buzzer_in(2)='1' and buzzer_out(0)='1') then alarm <= '1'; -- TRUTH TABLE: 1 X X 0 0 1
		elsif(buzzer_in(2)='1' and buzzer_out(1)='1') then alarm <= '1'; -- TRUTH TABLE: 1 X X 0 1 X
		elsif(buzzer_in(2)='1' and buzzer_out(2)='1') then alarm <= '1'; -- TRUTH TABLE: 1 X X 1 X X
		else alarm <= '0'; -- otherwise, the alarm is OFF
		end if;
	end process;
end architecture t2l_frias_jaro; 

