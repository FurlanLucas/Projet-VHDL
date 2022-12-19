library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity transcodeur is
	port(compteur_valeur    : in  std_logic_vector(13 downto 0);
		 temperature_valeur : in  std_logic_vector(11 downto 0);
		 sortie_rien        : out std_logic_vector(6 downto 0);
		 sortie_uni_comp    : out std_logic_vector(6 downto 0);
		 sortie_dez_comp    : out std_logic_vector(6 downto 0);
		 sortie_cen_comp    : out std_logic_vector(6 downto 0);
		 sortie_mil_comp    : out std_logic_vector(6 downto 0);
		 sortie_uni_temp    : out std_logic_vector(6 downto 0);
		 sortie_dez_temp    : out std_logic_vector(6 downto 0);
		 sortie_C           : out std_logic_vector(6 downto 0));
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
	
	signal temp_uni : std_logic_vector(11 downto 0) := "000000000000";
	signal temp_dez : std_logic_vector(3 downto 0) := "0000";
	
begin

	COMP_UNI_DUT : transcodeurUnit port map(entree => comp_uni(3 downto 0),
										    sortie => sortie_uni_comp);
	
	COMP_DEZ_DUT : transcodeurUnit port map(entree => comp_dez,
										    sortie => sortie_dez_comp);
											
	COMP_CEN_DUT : transcodeurUnit port map(entree => comp_cen,
										    sortie => sortie_cen_comp);
											
	COMP_MIL_DUT : transcodeurUnit port map(entree => comp_mil,
										    sortie => sortie_mil_comp);

	TEMP_UNI_DUT : transcodeurUnit port map(entree => temp_uni(3 downto 0),
										    sortie => sortie_uni_temp);
	
	TEMP_DEZ_DUT : transcodeurUnit port map(entree => temp_dez,
										    sortie => sortie_dez_temp);
											
	sortie_C <= "1000110";
	sortie_rien <= "1111111";
											
	process(compteur_valeur)
		variable sobra    : std_logic_vector(13 downto 0);
	begin
	     
        -- Take the first digit
        if (unsigned(compteur_valeur) < 1000) then
            sobra := compteur_valeur;
            comp_mil <= "0000";
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
            comp_cen <= "0000";
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
            comp_dez <= "0000";
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
	
	process(temperature_valeur)
	begin	
		-- Take the first and second digits
        if (unsigned(temperature_valeur) < 10) then
            temp_uni <= temperature_valeur;
            temp_dez <= "0000";
        elsif (unsigned(temperature_valeur) < 20) then
            temp_uni <= temperature_valeur - 10;
            temp_dez <= "0001";
        elsif (unsigned(temperature_valeur) < 30) then
            temp_uni <= temperature_valeur - 20;
            temp_dez <= "0010";
        elsif (unsigned(temperature_valeur) < 40) then
            temp_uni <= temperature_valeur - 30;
            temp_dez <= "0011";
        elsif (unsigned(temperature_valeur) < 50) then
            temp_uni <= temperature_valeur - 40;
            temp_dez <= "0100";
        elsif (unsigned(temperature_valeur) < 60) then
            temp_uni <= temperature_valeur - 50;
            temp_dez <= "0101";
        elsif (unsigned(temperature_valeur) < 70) then
            temp_uni <= temperature_valeur - 60;
            temp_dez <= "0110";
		elsif (unsigned(temperature_valeur) < 80) then
            temp_uni <= temperature_valeur - 70;
            temp_dez <= "0111";
		elsif (unsigned(temperature_valeur) < 90) then
            temp_uni <= temperature_valeur - 80;
            temp_dez <= "1000";
		elsif (unsigned(temperature_valeur) < 100) then
            temp_uni <= temperature_valeur - 90;
            temp_dez <= "1001";
        end if;
		 
	end process;
	
end architecture;