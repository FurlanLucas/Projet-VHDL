library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity mod8_TB is
end entity;

architecture mod8_TB_arch of mod8_TB is

	signal clk_entree_TB      : std_logic;
	signal reset_TB           : std_logic;
	signal clk_perc_entree_TB : std_logic;
	signal anode_sortie_TB    : std_logic_vector(7 downto 0);
	signal choix_afficheur_TB : std_logic_vector(2 downto 0);

	component mod8
		port(clk_entree      : in std_logic;
			 reset           : in std_logic;
			 clk_perc_entree : in std_logic;
			 anode_sortie    : out std_logic_vector(7 downto 0);
			 choix_afficheur : out std_logic_vector(2 downto 0));
	end component;
	
begin

	DUT1 : mod8 port map(clk_entree => clk_entree_TB,
						 reset => reset_TB,
						 clk_perc_entree => clk_perc_entree_TB,
						 anode_sortie => anode_sortie_TB,
						 choix_afficheur => choix_afficheur_TB);
						
	CLK : process
	begin
		clk_entree_TB <= '1';
		wait for 5 ns;
		clk_entree_TB <= '0';
		wait for 5 ns;
	end process;
	
	RST : process
	begin
		reset_TB <= '1';
		wait for 20 ns;
		reset_TB <= '0';
		wait for 5000 ns;
	end process;
	
	STIMULUS : process
	begin
		clk_perc_entree_TB <= '1';
		wait for 10 ns;
		clk_perc_entree_TB <= '0';
		wait for 300 ns;
		
	end process;
	
end architecture;