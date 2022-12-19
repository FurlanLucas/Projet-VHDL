library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity ges_freq is
    port(CLK   : in std_logic;
         RESET : in std_logic;
         CE    : out std_logic);
end entity;

architecture ges_freq_arch of ges_freq is

        signal buff : unsigned(11 downto 0);
        signal CE_buff : std_logic := '0';
        signal CE_buff_previous : std_logic := '0';
    
begin
    -- Main process (counter)
    process(CLK)

    begin
        if CLK'event and (CLK = '1') then
            -- Reset option
            if (RESET = '1') then
                buff <= "000000000000";
                
            -- Counter reset
            elsif (buff = to_unsigned(2266, 12)) then
                CE_buff <= not CE_buff;
                buff <= "000000000000";
                
            -- Count (plus one)
            else
                buff <= buff + 1;
            end if;
            
            -- Change the output value
            if (CE_buff_previous = '0') and (CE_buff = '1') then
                CE <= '1';
            else 
				CE <= '0';
            end if;
                
            -- Save the result for the previous state of CE_buff
            CE_buff_previous <= CE_buff;
            
            
        end if; 
    end process;
   

end architecture;