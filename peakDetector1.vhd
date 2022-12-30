library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity peakDetector1 is
    port(CLK    : in std_logic;
         CE     : in std_logic;
		 reset  : in std_logic;
         entree : in std_logic_vector(11 downto 0);
         sortie : out std_logic_vector(13 downto 0));
end entity;


architecture peakDetector1_arch of peakDetector1 is
	
	-- Constants
	constant peakValue  : integer := 199;
	-- Signal declaration
    signal buff     : unsigned(14 downto 0) := to_unsigned(0, 15);   
    signal CE_P     : std_logic := '0';

begin
    
    -- Counter process
    process(CLK, reset, CE)
    begin       
        -- Asynchronous reset
        if (reset = '1') then
            sortie <= std_logic_vector(to_unsigned(0, 14));
            buff <= to_unsigned(0, 15);
            
        -- Check for clock change --------------------------
        elsif (CLK'event) and (CLK = '1') then  
                    
            -- Check for new change --------------------------------
            if (CE = '1') and (CE_P = '0') then -- If there is some input change                
                if (entree > std_logic_vector(to_unsigned(peakValue, 11))) then -- Check for a peak  
                    buff <= buff + 1;        
                end if;   
            end if;            
            ----------------------------------------------------------- 
            
            CE_P <= CE;
            sortie <= std_logic_vector(buff(14 downto 1));
        end if;   
        -----------------------------------------------------
        
    end process;
    
end architecture;