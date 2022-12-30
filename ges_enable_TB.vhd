library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ges_enable_TB is
end entity;

architecture ges_enable_TB of ges_enable_TB is

	signal clk_TB : std_logic; 
	signal reset_TB : std_logic; 
	signal ce_TB : std_logic; 
	
	component ges_enable
        port(CLK   : in std_logic;
             RESET : in std_logic;
             CE    : out std_logic);
	end component;
	
begin

    DUT1 : ges_enable port map(CLK => clk_TB,
                               RESET => reset_TB,
                               CE => ce_TB);
                             
    CLK : process
    begin
        clk_TB <= '0';
        wait for 5 ns;
        clk_TB <= '1';
        wait for 5 ns;
    end process;
	
	RST : process
    begin
        reset_TB <= '1';
        wait for 10 ns;
        reset_TB <= '0';
        wait for 1 ms;
    end process;
    
end architecture;