library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity transcodeur_TB is
end entity;

architecture transcodeur_TB_arch of transcodeur_TB is
    
    signal compteur_valeur_TB : std_logic_vector(13 downto 0);
    signal mod_valeur_TB      : std_logic_vector(11 downto 0);
    signal sortie_uni_comp_TB : std_logic_vector(6 downto 0);
    signal sortie_dez_comp_TB : std_logic_vector(6 downto 0);
    signal sortie_cen_comp_TB : std_logic_vector(6 downto 0);
    signal sortie_mil_comp_TB : std_logic_vector(6 downto 0);
    signal sortie_uni_mod_TB  : std_logic_vector(6 downto 0);
    signal sortie_dez_mod_TB  : std_logic_vector(6 downto 0);
    signal sortie_cen_mod_TB  : std_logic_vector(6 downto 0);
    signal sortie_mil_mod_TB  : std_logic_vector(6 downto 0);
    
    component transcodeur
        port(compteur_valeur : in  std_logic_vector(13 downto 0);
             mod_valeur      : in  std_logic_vector(11 downto 0);
		     sortie_uni_comp : out std_logic_vector(6 downto 0);
		     sortie_dez_comp : out std_logic_vector(6 downto 0);
		     sortie_cen_comp : out std_logic_vector(6 downto 0);
		     sortie_mil_comp : out std_logic_vector(6 downto 0);
		     sortie_uni_mod  : out std_logic_vector(6 downto 0);
		     sortie_dez_mod  : out std_logic_vector(6 downto 0);
		     sortie_cen_mod  : out std_logic_vector(6 downto 0);
		     sortie_mil_mod  : out std_logic_vector(6 downto 0));
	end component;	 
	
begin
 
    DUT1 : transcodeur port map(compteur_valeur => compteur_valeur_TB,
                                mod_valeur => mod_valeur_TB,
                                sortie_uni_comp => sortie_uni_comp_TB,
                                sortie_dez_comp => sortie_dez_comp_TB,
								sortie_cen_comp => sortie_cen_comp_TB,
                                sortie_mil_comp => sortie_mil_comp_TB,
                                sortie_uni_mod => sortie_uni_mod_TB,
                                sortie_dez_mod => sortie_dez_mod_TB,
								sortie_cen_mod => sortie_cen_mod_TB,
                                sortie_mil_mod => sortie_mil_mod_TB);
      
    SIM1 : process
    begin
    
        compteur_valeur_TB <= std_logic_vector(to_unsigned(0, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(1, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(2, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(3, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(4, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(5, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(6, 14)); 
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(7, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(8, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(9, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(10, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(11, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(12, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(13, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(14, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(15, 14));
        wait for 20 ns;
		compteur_valeur_TB <= std_logic_vector(to_unsigned(16, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(17, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(18, 14)); 
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(19, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(20, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(30, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(40, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(50, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(60, 14)); 
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(70, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(80, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(90, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(100, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(200, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(300, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(400, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(500, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(600, 14)); 
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(700, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(800, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(900, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(1000, 14)); 
        wait for 20 ns;
		compteur_valeur_TB <= std_logic_vector(to_unsigned(2000, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(3000, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(4000, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(5000, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(6000, 14)); 
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(7000, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(8000, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(9000, 14));
        wait for 20 ns;
        compteur_valeur_TB <= std_logic_vector(to_unsigned(9999, 14));
        wait for 20 ns;
       
    end process;
	
	SIM2 : process
    begin
    
        mod_valeur_TB <= std_logic_vector(to_unsigned(0, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(1, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(2, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(3, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(4, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(5, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(6, 12)); 
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(7, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(8, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(9, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(10, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(11, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(12, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(13, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(14, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(15, 12));
        wait for 20 ns;
		mod_valeur_TB <= std_logic_vector(to_unsigned(16, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(17, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(18, 12)); 
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(19, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(20, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(30, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(40, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(50, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(60, 12)); 
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(70, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(80, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(90, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(99, 12));
        wait for 20 ns;
        mod_valeur_TB <= std_logic_vector(to_unsigned(0, 12));
        wait for 20 ns;
       
    end process;

end architecture;