library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity topLevel is
    port(CLK : in std_logic;
         MISO : in std_logic;
         RESET : in std_logic;
         
         CLK_SPI : out std_logic;
         MOSI : out std_logic;
         SS : out std_logic;
         
         anode : out std_logic_vector(7 downto 0);
         affch : out std_logic_vector(6 downto 0));
end topLevel;

architecture Behavioral of topLevel is
    
    signal ACCEL_X_OUT_TL           : std_logic_vector (8 downto 0);
    signal ACCEL_Y_OUT_TL           : std_logic_vector (8 downto 0);
    signal ACCEL_MAG_OUT_TL         : std_logic_vector (11 downto 0);
    signal ACCEL_TMP_OUT_TL         : std_logic_vector (11 downto 0);
    signal commande_mux8            : std_logic_vector (2 downto 0);
    signal aff0                     : std_logic_vector(6 downto 0);
    signal aff1                     : std_logic_vector(6 downto 0);
    signal aff2                     : std_logic_vector(6 downto 0);
    signal aff3                     : std_logic_vector(6 downto 0);
    signal aff4                     : std_logic_vector(6 downto 0);
    signal aff5                     : std_logic_vector(6 downto 0);
    signal aff6                     : std_logic_vector(6 downto 0);
    signal aff7                     : std_logic_vector(6 downto 0);
    signal CE_aff                   : std_logic;
    signal ACCEL_MAG_OUT_TL_FILTRE  : std_logic_vector (11 downto 0);
    signal ACCEL_TMP_OUT_TL_FILTRE  : std_logic_vector (11 downto 0);
    signal compteur_val             : std_logic_vector (13 downto 0);
    
    component AccelerometerCtl
        generic(
           SYSCLK_FREQUENCY_HZ : integer := 108000000;
           SCLK_FREQUENCY_HZ   : integer := 1000000;
           NUM_READS_AVG       : integer := 16;
           UPDATE_FREQUENCY_HZ : integer := 1000
        );
        port(
         SYSCLK     : in STD_LOGIC; -- System Clock
         RESET      : in STD_LOGIC;
        
         -- Spi interface Signals
         SCLK       : out STD_LOGIC;
         MOSI       : out STD_LOGIC;
         MISO       : in STD_LOGIC;
         SS         : out STD_LOGIC;
        
        -- Accelerometer data signals
         ACCEL_X_OUT    : out STD_LOGIC_VECTOR (8 downto 0);
         ACCEL_Y_OUT    : out STD_LOGIC_VECTOR (8 downto 0);
         ACCEL_MAG_OUT  : out STD_LOGIC_VECTOR (11 downto 0);
         ACCEL_TMP_OUT  : out STD_LOGIC_VECTOR (11 downto 0)
        );
    end component;
    
    component mux8    
    	port(command_entree : in  std_logic_vector(2 downto 0);
		     E0_entree      : in  std_logic_vector(6 downto 0);
		     E1_entree      : in  std_logic_vector(6 downto 0);
		     E2_entree      : in  std_logic_vector(6 downto 0);
		     E3_entree      : in  std_logic_vector(6 downto 0);
		     E4_entree      : in  std_logic_vector(6 downto 0);
             E5_entree      : in  std_logic_vector(6 downto 0);
		     E6_entree      : in  std_logic_vector(6 downto 0);		 
		     E7_entree      : in  std_logic_vector(6 downto 0);
		     S_sortie       : out std_logic_vector(6 downto 0));		 
    end component;
    
    component mod8 
        port(clk_entree      : in std_logic;
             reset           : in std_logic;
             clk_perc_entree : in std_logic;
             anode_sortie    : out std_logic_vector(7 downto 0);
             choix_afficheur : out std_logic_vector(2 downto 0));
    end component;
    
    
    component ges_freq is
        port(CLK   : in std_logic;
             RESET : in std_logic;
             CE    : out std_logic);
    end component;
    
    component filtre 
        port(entree  : in  std_logic_vector(11 downto 0);
             sortie : out std_logic_vector(11 downto 0));
    end component;

    component transcodeur 
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
    end component;

    component peakDetector is
        port(CLK    : in std_logic;
             entree : in std_logic_vector(11 downto 0);
             sortie: out std_logic_vector(13 downto 0));
    end component;
 
begin    
    
    AccelerometerCtl_DUT : AccelerometerCtl port map(SYSCLK => CLK,
                                                     RESET => RESET,
                                                     SCLK => CLK_SPI,
                                                     MOSI => MOSI,
                                                     MISO => MISO,
                                                     SS => SS,
                                                     ACCEL_X_OUT => ACCEL_X_OUT_TL,
                                                     ACCEL_Y_OUT => ACCEL_Y_OUT_TL,
                                                     ACCEL_MAG_OUT => ACCEL_MAG_OUT_TL,
                                                     ACCEL_TMP_OUT => ACCEL_TMP_OUT_TL);
    

    mux8_DUT : mux8 port map(command_entree => commande_mux8,
                             E0_entree => aff0,
                             E1_entree => aff1,
                             E2_entree => aff2,
                             E3_entree => aff3,
                             E4_entree => aff4,
                             E5_entree => aff5,
                             E6_entree => aff6,
                             E7_entree => aff7,
                             S_sortie => affch);
                           
    mod8_DUT    : mod8 port map(clk_entree       => CLK,
                                reset           => RESET,
                                clk_perc_entree => CE_aff,
                                anode_sortie    => anode,
                                choix_afficheur => commande_mux8);                        
                            
    ges_freq_DUT : ges_freq port map(CLK       => CLK,
                                     RESET           => RESET,
                                     CE => CE_aff);
                    
    transcodeur_DUT : transcodeur port map(compteur_valeur => compteur_val,  
                                           temperature_valeur => ACCEL_MAG_OUT_TL_FILTRE,
                                           sortie_rien        => aff1,
                                           sortie_uni_comp    => aff4,
                                           sortie_dez_comp    => aff5,
                                           sortie_cen_comp    => aff6,
                                           sortie_mil_comp    => aff7,
                                           sortie_uni_temp    => aff2,
                                           sortie_dez_temp    => aff3,
                                           sortie_C           => aff0);
                                     
    filtre_1_DUT : filtre port map(entree => ACCEL_MAG_OUT_TL,
                                  sortie => ACCEL_MAG_OUT_TL_FILTRE);
                                
    filtre_2_DUT : filtre port map(entree => ACCEL_TMP_OUT_TL,
                                  sortie => ACCEL_TMP_OUT_TL_FILTRE);
                                  
    peakDetector_DUT : peakDetector port map(CLK    => CLK,
                                             entree => ACCEL_MAG_OUT_TL_FILTRE,
                                             sortie => compteur_val);
 
                                  
end architecture;                            
