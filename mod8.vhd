library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity mod8 is
	port(clk_entree      : in std_logic;
		 reset           : in std_logic;
	     clk_perc_entree : in std_logic;
	     anode_sortie    : out std_logic_vector(7 downto 0);
		 choix_afficheur : out std_logic_vector(2 downto 0));
end entity;

architecture mod8_arch of mod8 is
	
	signal buf_anode : unsigned(7 downto 0) := "00000001";
	signal buf_choix : unsigned(2 downto 0) := "000";
	
begin
	
	process(clk_entree)
		variable buf_aux : std_logic; -- Buffer auxiliary variable
	begin 
	
		if clk_entree'event and (clk_entree = '1') then
		
		    if (reset = '1') then
		       buf_choix <= "000";
		       buf_anode <= "00000001";
		      
			elsif (clk_perc_entree = '1') then
			
				if (buf_choix /= "111") then
					buf_choix <= buf_choix + 1;
				else
					buf_choix <= "000";
				end if;
				
				buf_aux := buf_anode(0);
				buf_anode(0) <= buf_anode(1);
				buf_anode(1) <= buf_anode(2);
				buf_anode(2) <= buf_anode(3);
				buf_anode(3) <= buf_anode(4);
				buf_anode(4) <= buf_anode(5);
				buf_anode(5) <= buf_anode(6);
				buf_anode(6) <= buf_anode(7);
				buf_anode(7) <= buf_aux;
			end if;
			
			choix_afficheur <= std_logic_vector(buf_choix);
			anode_sortie <= std_logic_vector(buf_anode);
		end if;
		
	end process;
	
end architecture;