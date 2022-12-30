library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity transcodeurUnit_TB is
end entity;

architecture transcodeurUnit_arch_TB of transcodeurUnit_TB is
	
	signal entree_TB : std_logic_vector(3 downto 0);
	signal sortie_TB : std_logic_vector(6 downto 0);
	
	component transcodeurUnit
		port(entree : in std_logic_vector(3 downto 0);
			 sortie : out std_logic_vector(6 downto 0));
	end component;
	
begin 

	DUT1 : transcodeurUnit port map(entree => entree_TB,
								    sortie => sortie_TB);
									
	SIM1: process
	begin
		-- Input = 0;
		entree_TB <= "0000";
		wait for 5 ns;
		
		-- Input = 1;
		entree_TB <= "0001";
		wait for 5 ns;
		
		-- Input = 2;
		entree_TB <= "0010";
		wait for 5 ns;
		
		-- Input = 3;
		entree_TB <= "0011";
		wait for 5 ns;
		
		-- Input = 4;
		entree_TB <= "0100";
		wait for 5 ns;
		
		-- Input = 5;
		entree_TB <= "0101";
		wait for 5 ns;
		
		-- Input = 6;
		entree_TB <= "0110";
		wait for 5 ns;
		
		-- Input = 7;
		entree_TB <= "0111";
		wait for 5 ns;
		
		-- Input = 8;
		entree_TB <= "1000";
		wait for 5 ns;
		
		-- Input = 9;
		entree_TB <= "1001";
		wait for 5 ns;
		
		-- Others
		entree_TB <= "1111";
		wait for 5 ns;
		
	end process;
	
end architecture;