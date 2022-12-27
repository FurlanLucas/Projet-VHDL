library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity filtre is
    port(entree  : in  std_logic_vector(11 downto 0);
         sortie : out std_logic_vector(11 downto 0));
end entity;


architecture filtre_arch of filtre is

	constant DataWidth : integer := 15;
	
    signal mag01 : std_logic_vector(11 downto 0);
    signal mag02 : std_logic_vector(11 downto 0);
    signal mag03 : std_logic_vector(11 downto 0);
	signal mag04 : std_logic_vector(11 downto 0);
    signal mag05 : std_logic_vector(11 downto 0);
    signal mag06 : std_logic_vector(11 downto 0);
	signal mag07 : std_logic_vector(11 downto 0);
	signal mag08 : std_logic_vector(11 downto 0);
    signal mag09 : std_logic_vector(11 downto 0);
    signal mag10 : std_logic_vector(11 downto 0);
	signal mag11 : std_logic_vector(11 downto 0);
    signal mag12 : std_logic_vector(11 downto 0);
    signal mag13 : std_logic_vector(11 downto 0);
	signal mag14 : std_logic_vector(11 downto 0);
	signal mag15 : std_logic_vector(11 downto 0);
    signal buf : unsigned(DataWidth downto 0);
    
begin

    process(entree)
    begin
            mag01 <= entree;
            mag02 <= mag01;
            mag03 <= mag02;
			mag04 <= mag03;
            mag05 <= mag04;
			mag06 <= mag05;
            mag07 <= mag06;
            mag08 <= mag07;
            mag09 <= mag08;
			mag10 <= mag09;
            mag11 <= mag10;
			mag12 <= mag11;
            mag13 <= mag12;
            mag14 <= mag13;
            mag15 <= mag14;
                       
            buf <= (to_unsigned(0, DataWidth-11) & unsigned(entree)) + 
			       (to_unsigned(0, DataWidth-11) & unsigned(mag01)) +
			       (to_unsigned(0, DataWidth-11) & unsigned(mag02)) + 
				   (to_unsigned(0, DataWidth-11) & unsigned(mag03)) +
				   (to_unsigned(0, DataWidth-11) & unsigned(mag04)) + 
				   (to_unsigned(0, DataWidth-11) & unsigned(mag05)) +
			       (to_unsigned(0, DataWidth-11) & unsigned(mag06)) +
			       (to_unsigned(0, DataWidth-11) & unsigned(mag07)) +
			       (to_unsigned(0, DataWidth-11) & unsigned(mag08)) + 
				   (to_unsigned(0, DataWidth-11) & unsigned(mag09)) +
				   (to_unsigned(0, DataWidth-11) & unsigned(mag10)) +
				   (to_unsigned(0, DataWidth-11) & unsigned(mag11)) +
			       (to_unsigned(0, DataWidth-11) & unsigned(mag12)) +
				   (to_unsigned(0, DataWidth-11) & unsigned(mag13)) +
			       (to_unsigned(0, DataWidth-11) & unsigned(mag14)) +
				   (to_unsigned(0, DataWidth-11) & unsigned(mag15));
            
            sortie <= std_logic_vector(buf(DataWidth downto 4));
        
    end process;

end architecture;