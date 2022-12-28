library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity transcodeur is
	port(compteur_valeur    : in  std_logic_vector(13 downto 0);
		 mod_valeur         : in  std_logic_vector(11 downto 0);
		 sortie_uni_comp    : out std_logic_vector(6 downto 0);
		 sortie_dez_comp    : out std_logic_vector(6 downto 0);
		 sortie_cen_comp    : out std_logic_vector(6 downto 0);
		 sortie_mil_comp    : out std_logic_vector(6 downto 0);
		 sortie_uni_mod     : out std_logic_vector(6 downto 0);
		 sortie_dez_mod     : out std_logic_vector(6 downto 0);
		 sortie_cen_mod     : out std_logic_vector(6 downto 0);
		 sortie_mil_mod     : out std_logic_vector(6 downto 0));
end entity;

architecture transcodeur_arch of transcodeur is

	component transcodeurUnit
		port(entree : in std_logic_vector(3 downto 0);
			 sortie : out std_logic_vector(6 downto 0));
	end component;

	signal comp_uni : std_logic_vector(13 downto 0) := "00000000000000";
	signal comp_dez : std_logic_vector(3 downto 0)  := "0000";
	signal comp_cen : std_logic_vector(3 downto 0)  := "0000";
	signal comp_mil : std_logic_vector(3 downto 0)  := "0000";
	
	signal mod_uni : std_logic_vector(11 downto 0) := "000000000000";
	signal mod_dez : std_logic_vector(3 downto 0)  := "0000";
	signal mod_cen : std_logic_vector(3 downto 0)  := "0000";
	signal mod_mil : std_logic_vector(3 downto 0)  := "0000";
	
begin

	COMP_UNI_DUT : transcodeurUnit port map(entree => comp_uni(3 downto 0),
										    sortie => sortie_uni_comp);
	
	COMP_DEZ_DUT : transcodeurUnit port map(entree => comp_dez,
										    sortie => sortie_dez_comp);
											
	COMP_CEN_DUT : transcodeurUnit port map(entree => comp_cen,
										    sortie => sortie_cen_comp);
											
	COMP_MIL_DUT : transcodeurUnit port map(entree => comp_mil,
										    sortie => sortie_mil_comp);

	TEMP_UNI_DUT : transcodeurUnit port map(entree => mod_uni(3 downto 0),
										    sortie => sortie_uni_mod);
	
	TEMP_DEZ_DUT : transcodeurUnit port map(entree => mod_dez,
										    sortie => sortie_dez_mod);
										    
	TEMP_CEN_DUT : transcodeurUnit port map(entree => mod_cen,
										    sortie => sortie_cen_mod);
										    										
	TEMP_MIL_DUT : transcodeurUnit port map(entree => mod_mil,
										    sortie => sortie_mil_mod);
										    
										    										
	process(compteur_valeur)
		variable sobra    : std_logic_vector(13 downto 0);
	begin
	     
        -- Take the first digit
        if (unsigned(compteur_valeur) < 1000) then
            sobra := compteur_valeur;
            comp_mil <= "1111";
        elsif (unsigned(compteur_valeur) < 2000) then
            sobra := compteur_valeur - 1000;
            comp_mil <= "0001";
        elsif (unsigned(compteur_valeur) < 3000) then
            sobra := compteur_valeur - 2000;
            comp_mil <= "0010";
        elsif (unsigned(compteur_valeur) < 4000) then
            sobra := compteur_valeur - 3000;
            comp_mil <= "0011";
        elsif (unsigned(compteur_valeur) < 5000) then
            sobra := compteur_valeur - 4000;
            comp_mil <= "0100";
        elsif (unsigned(compteur_valeur) < 6000) then
            sobra := compteur_valeur - 5000;
            comp_mil <= "0101";
        elsif (unsigned(compteur_valeur) < 7000) then
            sobra := compteur_valeur - 6000;
            comp_mil <= "0110";
		elsif (unsigned(compteur_valeur) < 8000) then
            sobra := compteur_valeur - 7000;
            comp_mil <= "0111";
		elsif (unsigned(compteur_valeur) < 9000) then
            sobra := compteur_valeur - 8000;
            comp_mil <= "1000";
		elsif (unsigned(compteur_valeur) < 10000) then
            sobra := compteur_valeur - 9000;
            comp_mil <= "1001";
        end if;
		
		-- Take the second digit
        if (unsigned(sobra) < 100) then
            if (unsigned(compteur_valeur) < 1000) then
                comp_cen <= "1111";
            else
                comp_cen <= "0000";
            end if;
        elsif (unsigned(sobra) < 200) then
            sobra := sobra - 100;
            comp_cen <= "0001";
        elsif (unsigned(sobra) < 300) then
            sobra := sobra - 200;
            comp_cen <= "0010";
        elsif (unsigned(sobra) < 400) then
            sobra := sobra - 300;
            comp_cen <= "0011";
        elsif (unsigned(sobra) < 500) then
            sobra := sobra - 400;
            comp_cen <= "0100";
        elsif (unsigned(sobra) < 600) then
            sobra := sobra - 500;
            comp_cen <= "0101";
        elsif (unsigned(sobra) < 700) then
            sobra := sobra - 600;
            comp_cen <= "0110";
		elsif (unsigned(sobra) < 800) then
            sobra := sobra - 700;
            comp_cen <= "0111";
		elsif (unsigned(sobra) < 900) then
            sobra := sobra - 800;
            comp_cen <= "1000";
		elsif (unsigned(sobra) < 1000) then
           sobra := sobra - 900;
           comp_cen <= "1001";
        end if;
		
		-- Take the third and fourth digits
        if (unsigned(sobra) < 10) then
            comp_uni <= sobra;
            if (unsigned(compteur_valeur) < 100) then
                comp_dez <= "1111";
            else
                comp_dez <= "0000";
            end if;
        elsif (unsigned(sobra) < 20) then
            comp_uni <= sobra - 10;
            comp_dez <= "0001";
        elsif (unsigned(sobra) < 30) then
            comp_uni <= sobra - 20;
            comp_dez <= "0010";
        elsif (unsigned(sobra) < 40) then
            comp_uni <= sobra - 30;
            comp_dez <= "0011";
        elsif (unsigned(sobra) < 50) then
            comp_uni <= sobra - 40;
            comp_dez <= "0100";
        elsif (unsigned(sobra) < 60) then
            comp_uni <= sobra - 50;
            comp_dez <= "0101";
        elsif (unsigned(sobra) < 70) then
            comp_uni <= sobra - 60;
            comp_dez <= "0110";
		elsif (unsigned(sobra) < 80) then
            comp_uni <= sobra - 70;
            comp_dez <= "0111";
		elsif (unsigned(sobra) < 90) then
            comp_uni <= sobra - 80;
            comp_dez <= "1000";
		elsif (unsigned(sobra) < 100) then
            comp_uni <= sobra - 90;
            comp_dez <= "1001";
        end if;
		 
	end process;
	
	process(mod_valeur)
		variable sobra2    : std_logic_vector(11 downto 0);
	begin
	     
        -- Take the first digit
        if (unsigned(mod_valeur) < 1000) then
            sobra2 := mod_valeur;
            mod_mil <= "1111";
        elsif (unsigned(mod_valeur) < 2000) then
            sobra2 := mod_valeur - 1000;
            mod_mil <= "0001";
        elsif (unsigned(mod_valeur) < 3000) then
            sobra2 := mod_valeur - 2000;
            mod_mil <= "0010";
        elsif (unsigned(mod_valeur) < 4000) then
            sobra2 := mod_valeur - 3000;
            mod_mil <= "0011";
        elsif (unsigned(mod_valeur) < 5000) then
            sobra2 := mod_valeur - 4000;
            mod_mil <= "0100";
        elsif (unsigned(mod_valeur) < 6000) then
            sobra2 := mod_valeur - 5000;
            mod_mil <= "0101";
        elsif (unsigned(mod_valeur) < 7000) then
            sobra2 := mod_valeur - 6000;
            mod_mil <= "0110";
		elsif (unsigned(mod_valeur) < 8000) then
            sobra2 := mod_valeur - 7000;
            mod_mil <= "0111";
		elsif (unsigned(mod_valeur) < 9000) then
            sobra2 := mod_valeur - 8000;
            mod_mil <= "1000";
		elsif (unsigned(mod_valeur) < 10000) then
            sobra2 := mod_valeur - 9000;
            mod_mil <= "1001";
        end if;
		
		-- Take the second digit
        if (unsigned(sobra2) < 100) then
            if (unsigned(mod_valeur) < 1000) then
                mod_cen <= "1111";
            else
                mod_cen <= "0000";
            end if;
        elsif (unsigned(sobra2) < 200) then
            sobra2 := sobra2 - 100;
            mod_cen <= "0001";
        elsif (unsigned(sobra2) < 300) then
            sobra2 := sobra2 - 200;
            mod_cen <= "0010";
        elsif (unsigned(sobra2) < 400) then
            sobra2 := sobra2 - 300;
            mod_cen <= "0011";
        elsif (unsigned(sobra2) < 500) then
            sobra2 := sobra2 - 400;
            mod_cen <= "0100";
        elsif (unsigned(sobra2) < 600) then
            sobra2 := sobra2 - 500;
            mod_cen <= "0101";
        elsif (unsigned(sobra2) < 700) then
            sobra2 := sobra2 - 600;
            mod_cen <= "0110";
		elsif (unsigned(sobra2) < 800) then
            sobra2 := sobra2 - 700;
            mod_cen <= "0111";
		elsif (unsigned(sobra2) < 900) then
            sobra2 := sobra2 - 800;
            mod_cen <= "1000";
		elsif (unsigned(sobra2) < 1000) then
           sobra2 := sobra2 - 900;
           mod_cen <= "1001";
        end if;
		
		-- Take the third and fourth digits
        if (unsigned(sobra2) < 10) then
            mod_uni <= sobra2;
            if (unsigned(mod_valeur) < 100) then
                mod_dez <= "1111";
            else
                mod_dez <= "0000";
            end if;
        elsif (unsigned(sobra2) < 20) then
            mod_uni <= sobra2 - 10;
            mod_dez <= "0001";
        elsif (unsigned(sobra2) < 30) then
            mod_uni <= sobra2 - 20;
            mod_dez <= "0010";
        elsif (unsigned(sobra2) < 40) then
            mod_uni <= sobra2 - 30;
            mod_dez <= "0011";
        elsif (unsigned(sobra2) < 50) then
            mod_uni <= sobra2 - 40;
            mod_dez <= "0100";
        elsif (unsigned(sobra2) < 60) then
            mod_uni <= sobra2 - 50;
            mod_dez <= "0101";
        elsif (unsigned(sobra2) < 70) then
            mod_uni <= sobra2 - 60;
            mod_dez <= "0110";
		elsif (unsigned(sobra2) < 80) then
            mod_uni <= sobra2 - 70;
            mod_dez <= "0111";
		elsif (unsigned(sobra2) < 90) then
            mod_uni <= sobra2 - 80;
            mod_dez <= "1000";
		elsif (unsigned(sobra2) < 100) then
            mod_uni <= sobra2 - 90;
            mod_dez <= "1001";
        end if;
		 
	end process;
	
end architecture;