library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity peakDetector is
    port(CLK    : in std_logic;
		 reset  : in std_logic;
         entree : in std_logic_vector(11 downto 0);
         sortie : out std_logic_vector(13 downto 0));
end entity;


architecture peakDetector_arch of peakDetector is
	
	constant WindowWidth : integer := 16;
	constant WindowWidthBits : integer := 4;
	
	
    signal buff : unsigned(11+WindowWidthBits downto 0) := to_unsigned(0, 12+WindowWidthBits);
    signal moyenne : unsigned(11 downto 0);
    signal moyenne_precedent : unsigned(11 downto 0);
    signal counter_fenetre : unsigned(WindowWidthBits-1 downto 0) := 
	                                      to_unsigned(WindowWidth-1, WindowWidthBits);
    signal buff_out : unsigned(13 downto 0) := to_unsigned(0, 14);
    	
	

begin

    process(entree)
    begin
		if (reset = '0') then
			buff <= buff + (to_unsigned(0,WindowWidthBits) & unsigned(entree));
			
			if (counter_fenetre = to_unsigned(WindowWidth-1,WindowWidthBits)) then
				counter_fenetre <= to_unsigned(0,WindowWidthBits);
				moyenne <= buff(11+WindowWidthBits downto WindowWidthBits);
				buff <= (to_unsigned(0,WindowWidthBits) & unsigned(entree));
			else 
				counter_fenetre <= counter_fenetre + 1;
			end if;
		end if;
		
    end process;
    
    process(moyenne)
    begin
	
        if(moyenne < moyenne_precedent) then
            buff_out <= buff_out + 1;
            
        end if;
        moyenne_precedent <= moyenne;
		
    end process;

    sortie <= std_logic_vector(buff_out);
    
end architecture;