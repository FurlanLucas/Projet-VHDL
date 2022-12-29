-- Transcorder module that takes a number from 0 to 9 and returns
-- the vector that describes the 7 segments dysplay inputs (cathodes).
-- The above diagram shows the position of each segments, with the output
-- vector beeing [CG, CF, CE, CD, CC, CB, CA], activated low.
--
--
--       CA
--      ---  
--  CF |   | CB
--      ---      <- CG
--  CE |   | CC
--      ---  .
--       CD
--
--  Decimal Point = CP

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity transcodeurUnit is
	port(entree : in  std_logic_vector(3 downto 0);
		 sortie : out std_logic_vector(6 downto 0));
end entity;

architecture transcodeurUnit_arch of transcodeurUnit is
begin
	process(entree)
	begin
		case entree is
		    -- CA, CB, CC, CD, CE, CF on (entree = 0)
			when "0000" => sortie <= "1000000";
			
			-- CB, CC on (entree = 1)
			when "0001" => sortie <= "1111001"; 
	
			-- AA, AB, AG, AE, AD on (entree = 2)
			when "0010" => sortie <= "0100100"; 
			
			-- AA, AB, AC, AD, AG on (entree = 3)
			when "0011" => sortie <= "0110000";
			
			-- AB, AC, AG, AF on (entree = 4)
			when "0100" => sortie <= "0011001";
			
			-- AA, AB, AG, AE, AD on (entree = 5)
			when "0101" => sortie <= "0010010";
			
			-- AA, AC, AD, AE, AF, AG on (entree = 6)
			when "0110" => sortie <= "0000010";
			
			-- AA, AB, AC on (entree = 7)
			when "0111" => sortie <= "1111000";
			
			-- AA, AB, AC, AD, AE, AF, AG on (entree = 8)
			when "1000" => sortie <= "0000000";
			
			-- AA, AB, AC, AD, AF, AG, on (entree = 9)
			when "1001" => sortie <= "0010000";
			
			-- Other cases
			when others => sortie <= "1111111";
		end case;
	end process;

end architecture;