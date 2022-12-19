library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity mux8_TB is
end entity;

architecture mux8_TB_arch of mux8_TB is

	signal command_entree_TB : std_logic_vector(2 downto 0);
	signal E0_entree_TB      : std_logic_vector(6 downto 0);
	signal E1_entree_TB      : std_logic_vector(6 downto 0);
	signal E2_entree_TB      : std_logic_vector(6 downto 0);
	signal E3_entree_TB      : std_logic_vector(6 downto 0);
	signal E4_entree_TB      : std_logic_vector(6 downto 0);
	signal E5_entree_TB      : std_logic_vector(6 downto 0);
	signal E6_entree_TB      : std_logic_vector(6 downto 0);		 
	signal E7_entree_TB      : std_logic_vector(6 downto 0);
	signal S_sortie_TB       : std_logic_vector(6 downto 0);
	
	component mux8
		port(command_entree : in  std_logic_vector(2 downto 0);
			 E0_entree      : in  std_logic_vector(6 downto 0);
			 E1_entree      : in  std_logic_vector(6 downto 0);
			 E2_entree      : in  std_logic_vector(6 downto 0);
			 E3_entree      : in  std_logic_vector(6 downto 0);
			 E4_entree      : in  std_logic_vector(6 downto 0);
			 E5_entree      : in  std_logic_vector(6 downto 0);
			 E6_entree      : in  std_logic_vector(6 downto 0);		 
			 E7_entree      : in  std_logic_vector(6 downto 0);
			 S_sortie       : out std_logic_vector(6 downto 0));
	end component;
	
begin

	DUT1 : mux8 port map(command_entree => command_entree_TB,
						 E0_entree => E0_entree_TB,
						 E1_entree => E1_entree_TB,
						 E2_entree => E2_entree_TB,
						 E3_entree => E3_entree_TB,
						 E4_entree => E4_entree_TB,
						 E5_entree => E5_entree_TB,
						 E6_entree => E6_entree_TB,
						 E7_entree => E7_entree_TB,
						 S_sortie => S_sortie_TB);
						 
	SIM1 : process
	begin 
		-- Initialisation des entrées
		E0_entree_TB <= "0000000";
		E1_entree_TB <= "0000001";
		E2_entree_TB <= "0000010";
		E3_entree_TB <= "0000011";
		E4_entree_TB <= "0000100";
		E5_entree_TB <= "0000101";
		E6_entree_TB <= "0000110";
		E7_entree_TB <= "0000111";
		
		command_entree_TB <= "000";
		wait for 10 ns;
		
		command_entree_TB <= "001";
		wait for 10 ns;
		
		command_entree_TB <= "010";
		wait for 10 ns;
		
		command_entree_TB <= "011";
		wait for 10 ns;
		
		command_entree_TB <= "100";
		wait for 10 ns;
		
		command_entree_TB <= "101";
		wait for 10 ns;
		
		command_entree_TB <= "110";
		wait for 10 ns;
		
		command_entree_TB <= "111";
		wait for 10 ns;
		
	end process;

end architecture;