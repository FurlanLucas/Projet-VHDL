library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity filter_TB is
end entity;

architecture filter_TB_arch of filter_TB is
    
    signal CLK_TB    : std_logic;
    signal CE_TB     : std_logic;
    signal RESET_TB  : std_logic;
    signal entree_TB : std_logic_vector(11 downto 0);
    signal sortie_TB : std_logic_vector(11 downto 0);
    
    component filter
        port(CLK    : in std_logic;
             RESET  : in std_logic;
             CE     : in std_logic;
             entree : in  std_logic_vector(11 downto 0);
             sortie : out std_logic_vector(11 downto 0));
    end component;
    
begin

    DUT1 : filter port map(CLK => CLK_TB,
                           RESET => RESET_TB,
                           CE => CE_TB,
                           entree => entree_TB,
                           sortie => sortie_TB);
    RESET : process
    begin
        RESET_TB <= '1';
        wait for 50 ns;
        RESET_TB <= '0';
        wait for 50 ms;
    end process;
    
    CLK : process
    begin
        CLK_TB <= '1';
        wait for 5 ns;
        CLK_TB <= '0';
        wait for 5 ns;
    end process;
    
    CE : process
    begin
        CE_TB <= '0';
        wait for 30 ns;
        CE_TB <= '1';
        wait for 10 ns;
    end process;
    

    
    stimulus : process
    begin
        wait for 50 ns;
        entree_TB <= std_logic_vector(to_unsigned(120, 12));
        wait for 40 ns;
        entree_TB <= std_logic_vector(to_unsigned(100, 12));
        wait for 40 ns;
        entree_TB <= std_logic_vector(to_unsigned(180, 12));
        wait for 40 ns;
        entree_TB <= std_logic_vector(to_unsigned(200, 12));
        wait for 40 ns;
        entree_TB <= std_logic_vector(to_unsigned(120, 12));
        wait for 40 ns;
        entree_TB <= std_logic_vector(to_unsigned(240, 12));
        wait for 40 ns;
        entree_TB <= std_logic_vector(to_unsigned(120, 12));
        wait for 40 ns;
        entree_TB <= std_logic_vector(to_unsigned(100, 12));
        wait for 40 ns;
        entree_TB <= std_logic_vector(to_unsigned(150, 12));
        wait for 40 ns;
        entree_TB <= std_logic_vector(to_unsigned(170, 12));
        wait for 40 ns;
        entree_TB <= std_logic_vector(to_unsigned(100, 12));
		wait for 40 ns;
        entree_TB <= std_logic_vector(to_unsigned(160, 12));
        wait for 40 ns;
        entree_TB <= std_logic_vector(to_unsigned(100, 12));
        wait for 40 ns;
        entree_TB <= std_logic_vector(to_unsigned(180, 12));
    end process;
    
end architecture;