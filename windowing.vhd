library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity windowing is
    port(CLK          : in std_logic;
         CE           : in std_logic;
		 reset        : in std_logic;
         entree       : in std_logic_vector(11 downto 0);
         sortie       : out std_logic_vector(11 downto 0);
         CE_windowing : out std_logic);
end entity;


architecture windowing_arch of windowing is
	
	-- Constants
	constant WindowWidth  : integer := 262144;
	--constant WindowWidth : integer := 524288;
	constant WindowWidth2  : integer := 131057;
	constant WindowBits   : integer := 18;
	
	-- Constants pour la simulaiton du test bench (une fen?tre plus petite)
	--constant WindowWidth2  : integer := 128;
	--constant WindowWidth : integer := 256;
	--constant WindowBits   : integer := 8;
	
	-- Signal declaration
    signal counter_fenetre : unsigned(WindowBits-1 downto 0)          := to_unsigned(WindowWidth-1, WindowBits);
    signal buff            : unsigned(WindowBits+11 downto 0)         := to_unsigned(0, WindowBits+12);

begin
    
    -- Counter process
    process(CLK, reset, CE)
    begin       
        -- Asynchronous reset
        if (reset = '1') then
            sortie <= std_logic_vector(to_unsigned(0, 12));
            counter_fenetre <= to_unsigned(0, WindowBits);
            CE_windowing <= '0';
            
        elsif (CLK'event) and (CLK = '1') then              
            -- Check for new change --------------------------------
            if (CE = '1') then -- If there is some input change
                -- Check if it is the window's end ------------------------------------------------
                if (counter_fenetre = to_unsigned(WindowWidth-1, WindowBits)) then      
                    CE_windowing <= '1';        
                    sortie <= std_logic_vector(buff(WindowBits+11 downto WindowBits));
                    buff <= to_unsigned(0, WindowBits+12);
                elsif (counter_fenetre = to_unsigned(WindowWidth2-1, WindowBits)) then 
                    CE_windowing <= '0';
                else
                    buff <= buff + (to_unsigned(0, WindowBits) + unsigned(entree));
                end if;   
                counter_fenetre <= counter_fenetre + 1;                 
                -----------------------------------------------------------------------------------
            end if;
            ----------------------------------------------------------- 
        end if;   
        
    end process;
    
end architecture;