library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity filtre_TB is
end entity;

architecture filtre_TB_arch of filtre_TB is
    
    signal entree_TB : std_logic_vector(11 downto 0);
    signal sortie_TB : std_logic_vector(11 downto 0);
    
    component filtre
        port(entree  : in  std_logic_vector(11 downto 0);
             sortie : out std_logic_vector(11 downto 0));
    end component;
    
begin

    DUT1 : filtre port map(entree => entree_TB,
                           sortie => sortie_TB);

    
    stimulus : process
    begin
        entree_TB <= std_logic_vector(to_unsigned(120, 12));
        wait for 10 ns;
        entree_TB <= std_logic_vector(to_unsigned(100, 12));
        wait for 10 ns;
        entree_TB <= std_logic_vector(to_unsigned(180, 12));
        wait for 10 ns;
        entree_TB <= std_logic_vector(to_unsigned(200, 12));
        wait for 10 ns;
        entree_TB <= std_logic_vector(to_unsigned(120, 12));
        wait for 10 ns;
        entree_TB <= std_logic_vector(to_unsigned(240, 12));
        wait for 10 ns;
        entree_TB <= std_logic_vector(to_unsigned(120, 12));
        wait for 10 ns;
        entree_TB <= std_logic_vector(to_unsigned(100, 12));
        wait for 10 ns;
        entree_TB <= std_logic_vector(to_unsigned(150, 12));
        wait for 10 ns;
        entree_TB <= std_logic_vector(to_unsigned(170, 12));
        wait for 10 ns;
        entree_TB <= std_logic_vector(to_unsigned(100, 12));
		wait for 10 ns;
        entree_TB <= std_logic_vector(to_unsigned(160, 12));
        wait for 10 ns;
        entree_TB <= std_logic_vector(to_unsigned(100, 12));
        wait for 10 ns;
        entree_TB <= std_logic_vector(to_unsigned(180, 12));
    end process;
    
end architecture;