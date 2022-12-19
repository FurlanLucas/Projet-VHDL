library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity filtre is
    port(entree  : in  std_logic_vector(11 downto 0);
         sortie : out std_logic_vector(11 downto 0));
end entity;


architecture filtre_arch of filtre is

	constant DataWidth : integer := 14;
	
    signal mag1 : std_logic_vector(11 downto 0);
    signal mag2 : std_logic_vector(11 downto 0);
    signal mag3 : std_logic_vector(11 downto 0);
	signal mag4 : std_logic_vector(11 downto 0);
    signal mag5 : std_logic_vector(11 downto 0);
    signal mag6 : std_logic_vector(11 downto 0);
	signal mag7 : std_logic_vector(11 downto 0);
    signal buf : unsigned(DataWidth downto 0);
    
begin

    process(entree)
    begin
            mag1 <= entree;
            mag2 <= mag1;
            mag3 <= mag2;
			mag4 <= mag3;
            mag5 <= mag4;
			mag6 <= mag5;
            mag7 <= mag6;
           
            buf <= (to_unsigned(0, DataWidth-11) & unsigned(entree)) + 
			       (to_unsigned(0, DataWidth-11) & unsigned(mag1)) +
			       (to_unsigned(0, DataWidth-11) & unsigned(mag2)) + 
				   (to_unsigned(0, DataWidth-11) & unsigned(mag3)) +
				   (to_unsigned(0, DataWidth-11) & unsigned(mag4)) + 
				   (to_unsigned(0, DataWidth-11) & unsigned(mag5)) +
			       (to_unsigned(0, DataWidth-11) & unsigned(mag6)) + 
				   (to_unsigned(0, DataWidth-11) & unsigned(mag7));
            
            sortie <= std_logic_vector(buf(DataWidth downto 3));
        
    end process;

end architecture;