library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity filter is
    port(CLK    : in std_logic;
         RESET  : in std_logic;
         CE     : in std_logic;
         entree : in  std_logic_vector(11 downto 0);
         sortie : out std_logic_vector(11 downto 0));
end entity;


architecture filter_arch of filter is

	constant DataWidth : integer := 16;
	
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
    signal buf : unsigned(DataWidth-1 downto 0) := to_unsigned(0, DataWidth);
    
begin

    process(CLK, CE, RESET)
    begin
        
        -- Reset assynchronous
        if (RESET = '1') then
            mag01 <= "000000000000";
            mag02 <= "000000000000";
            mag03 <= "000000000000";
			mag04 <= "000000000000";
            mag05 <= "000000000000";
			mag06 <= "000000000000";
            mag07 <= "000000000000";
            mag08 <= "000000000000";
            mag09 <= "000000000000";
			mag10 <= "000000000000";
            mag11 <= "000000000000";
			mag12 <= "000000000000";
            mag13 <= "000000000000";
            mag14 <= "000000000000";
            mag15 <= "000000000000";
            sortie <= "000000000000";
        
        elsif (CLK'event) and (CLK = '1') and (CE = '1') then   
            
            -- Sum the previous values to take the mean       
            buf <= (to_unsigned(0, DataWidth-12) & unsigned(entree)) + 
			       (to_unsigned(0, DataWidth-12) & unsigned(mag01)) +
			       (to_unsigned(0, DataWidth-12) & unsigned(mag02)) + 
				   (to_unsigned(0, DataWidth-12) & unsigned(mag03)) +
				   (to_unsigned(0, DataWidth-12) & unsigned(mag04)) + 
				   (to_unsigned(0, DataWidth-12) & unsigned(mag05)) +
			       (to_unsigned(0, DataWidth-12) & unsigned(mag06)) +
			       (to_unsigned(0, DataWidth-12) & unsigned(mag07)) +
			       (to_unsigned(0, DataWidth-12) & unsigned(mag08)) + 
				   (to_unsigned(0, DataWidth-12) & unsigned(mag09)) +
				   (to_unsigned(0, DataWidth-12) & unsigned(mag10)) +
				   (to_unsigned(0, DataWidth-12) & unsigned(mag11)) +
			       (to_unsigned(0, DataWidth-12) & unsigned(mag12)) +
				   (to_unsigned(0, DataWidth-12) & unsigned(mag13)) +
			       (to_unsigned(0, DataWidth-12) & unsigned(mag14)) +
				   (to_unsigned(0, DataWidth-12) & unsigned(mag15));            
            ---------------------------------------------------------
            
            -- Update the previous values ---------------------------
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
            ---------------------------------------------------------
        
        sortie <= std_logic_vector(buf(DataWidth-1 downto 4));
        
        end if;
 
    end process;

end architecture;