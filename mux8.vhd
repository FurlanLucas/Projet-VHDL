library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity mux8 is
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
end entity;

architecture mux8_arch of mux8 is
begin

	process(command_entree,E0_entree,E1_entree,E2_entree,E3_entree,E4_entree,E5_entree,E6_entree,E7_entree)
	begin 
		case command_entree is
			when "000" => S_sortie <= E0_entree;
			when "001" => S_sortie <= E1_entree;
			when "010" => S_sortie <= E2_entree;
			when "011" => S_sortie <= E3_entree;
			when "100" => S_sortie <= E4_entree;
			when "101" => S_sortie <= E5_entree;
			when "110" => S_sortie <= E6_entree;
			when "111" => S_sortie <= E7_entree;
			when others => S_sortie <= "1111111";
		end case;
	end process;
	
end architecture;