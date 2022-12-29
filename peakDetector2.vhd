library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity peakDetector2 is
    port(CLK    : in std_logic;
         CE     : in std_logic;
		 reset  : in std_logic;
         entree : in std_logic_vector(11 downto 0);
         sortie : out std_logic_vector(13 downto 0));
end entity;


architecture peakDetector2_arch of peakDetector2 is
	
	-- Constants
	constant peakValue  : integer := 175;
	-- Signal declaration
    signal buff     : unsigned(14 downto 0) := to_unsigned(0, 15);   
    signal CE_P     : std_logic := '0';
	signal entreeP  : std_logic_vector(11 downto 0) := std_logic_vector(to_unsigned(0, 12));
	signal entreePP : std_logic_vector(11 downto 0) := std_logic_vector(to_unsigned(0, 12));

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
                if (entreeP > entreePP) and (entreeP > entree) then -- Check for a peak  
                    buff <= buff + 1;        
                end if;
				entreePP <= entreeP;
				entreeP <= entree;
            end if;            
            ----------------------------------------------------------- 
            
            CE_P <= CE;
            sortie <= std_logic_vector(buff(13 downto 0));
        end if;   
        -----------------------------------------------------
        
    end process;
    
end architecture;