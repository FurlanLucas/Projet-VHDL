-- Library declaration
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity topLevel is
    port(CLK   : in std_logic; -- Clock input
         MISO  : in std_logic; -- MISO (Master input slave output) input
         RESET : in std_logic; -- Reset input (activates high)
         
         CLK_SPI       : out std_logic; 
         MOSI          : out std_logic; -- MOSI (Master output slave input) output
         SS            : out std_logic; -- Chip select output       
         anode         : out std_logic_vector(7 downto 0); -- Anode output for 7 segments display
         affch         : out std_logic_vector(6 downto 0); -- Cathode output for 7 segments display
		 led           : out std_logic_vector(11 downto 0); -- Led output (output of acceleration module)	 
		 LED_windowing : out std_logic); -- Led that indicates the end of a windowing
end entity;

architecture Behavioral of topLevel is
    
    -- Signals declaration -----------------------------------------------------------------------------------------
    signal accel_mod                : std_logic_vector (11 downto 0); -- Output from acceleration module
    signal accel_mod_filtered       : std_logic_vector (11 downto 0); -- Acceleration absolute value filtered
    signal accel_mod_windowing      : std_logic_vector (11 downto 0); -- Acceleration absolute value after windowing
    signal commande_mux8            : std_logic_vector (2 downto 0); -- Command for eigth input multiplexer
    signal aff0                     : std_logic_vector(6 downto 0); -- Input for the eighth display digit
    signal aff1                     : std_logic_vector(6 downto 0); -- Input for the seventh display digit
    signal aff2                     : std_logic_vector(6 downto 0); -- Input for the sixth display digit
    signal aff3                     : std_logic_vector(6 downto 0); -- Input for the fifith display digit
    signal aff4                     : std_logic_vector(6 downto 0); -- Input for the fourth display digit
    signal aff5                     : std_logic_vector(6 downto 0); -- Input for the third display digit
    signal aff6                     : std_logic_vector(6 downto 0); -- Input for the second display digit
    signal aff7                     : std_logic_vector(6 downto 0); -- Input for the first display digit
    signal CE_aff                   : std_logic; -- Clock enable for display
    signal CE_input                 : std_logic; -- Clock enable for windowing (activates LED_windowing)
    signal SPI_CLK                  : std_logic; -- Clock for SPI communication
    signal compteur_val             : std_logic_vector (13 downto 0); -- Podometer buffer counter
    signal LED_windowing_signal     : std_logic;
    ----------------------------------------------------------------------------------------------------------------
    
    
    -- Components declarations -------------------------------------------------------------------------------------
    component AccelerometerCtl is -- Accelerometer module
        generic(SYSCLK_FREQUENCY_HZ : integer := 108000000;
                SCLK_FREQUENCY_HZ   : integer := 1000000;
                NUM_READS_AVG       : integer := 16;
                UPDATE_FREQUENCY_HZ : integer := 1000);
        port(SYSCLK     : in STD_LOGIC;
             RESET      : in STD_LOGIC;
             SCLK       : out STD_LOGIC;
             MOSI       : out STD_LOGIC;
             MISO       : in STD_LOGIC;
             SS         : out STD_LOGIC;
             ACCEL_X_OUT    : out STD_LOGIC_VECTOR (8 downto 0);
             ACCEL_Y_OUT    : out STD_LOGIC_VECTOR (8 downto 0);
             ACCEL_MAG_OUT  : out STD_LOGIC_VECTOR (11 downto 0);
             ACCEL_TMP_OUT  : out STD_LOGIC_VECTOR (11 downto 0));
    end component;
    
    component mux8 is -- Eight inputs multiplexer
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
    
    component mod8 is -- Counter eigth (for display)
        port(clk_entree      : in std_logic;
             reset           : in std_logic;
             clk_perc_entree : in std_logic;
             anode_sortie    : out std_logic_vector(7 downto 0);
             choix_afficheur : out std_logic_vector(2 downto 0));
    end component;
    
    
    component ges_freq is -- Counter that generates a clock enable for display
        port(CLK   : in std_logic;
             RESET : in std_logic;
             CE    : out std_logic);
    end component;
    
    component ges_enable is -- Counter that generates a clock enable for windowing
        port(CLK   : in std_logic;
             RESET : in std_logic;
             CE    : out std_logic);
    end component;
    
    component filter is -- Filter that takes the mean value for a number of successive input values
        port(CLK : in std_logic;
             CE : in std_logic;
             entree  : in  std_logic_vector(11 downto 0);
             sortie : out std_logic_vector(11 downto 0));
    end component;

    component transcodeur is -- Transcoder module
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
    end component;
    
    component windowing is -- Module for windowing
        port(CLK          : in std_logic;
             CE           : in std_logic;
             reset        : in std_logic;
             entree       : in std_logic_vector(11 downto 0);
             sortie       : out std_logic_vector(11 downto 0);
             CE_windowing : out std_logic);
    end component;
    
    component peakDetector2 is -- Peak detector module (can be modified for peakDetector or peakDetector2)
        port(CLK    : in std_logic;
             CE     : in std_logic;
             reset  : in std_logic;
             entree : in std_logic_vector(11 downto 0);
             sortie : out std_logic_vector(13 downto 0));
    end component;
    ----------------------------------------------------------------------------------------------------------------
 
begin    
    
    -- Port maps ---------------------------------------------------------------------------------------------------
    AccelerometerCtl_DUT : AccelerometerCtl port map(SYSCLK => CLK,
                                                     RESET => RESET,
                                                     SCLK => SPI_CLK,
                                                     MOSI => MOSI,
                                                     MISO => MISO,
                                                     SS => SS,
                                                     ACCEL_X_OUT => open,
                                                     ACCEL_Y_OUT => open,
                                                     ACCEL_MAG_OUT => accel_mod,
                                                     ACCEL_TMP_OUT => open);
    

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
                                     
    ges_enable_DUT : ges_enable port map(CLK    => SPI_CLK,
                                         RESET  => RESET,
                                         CE     => CE_input);                                 
                    
    transcodeur_DUT : transcodeur port map(compteur_valeur => compteur_val,  
                                           mod_valeur => accel_mod_filtered,
                                           sortie_uni_comp    => aff4,
                                           sortie_dez_comp    => aff5,
                                           sortie_cen_comp    => aff6,
                                           sortie_mil_comp    => aff7,
                                           sortie_uni_mod    => aff0,
                                           sortie_dez_mod    => aff1,
                                           sortie_cen_mod    => aff2,
                                           sortie_mil_mod    => aff3);
                                     
    filter_DUT : filter port map(CLK => CLK,
                                 CE => CE_input,
                                 entree => accel_mod,
                                 sortie => accel_mod_filtered);                               
                                  
    peakDetector_DUT : peakDetector2 port map(CLK    => CLK,
                                              CE => LED_windowing_signal,
                                              reset => RESET,
                                              entree => accel_mod_windowing,
                                              sortie => compteur_val); 
           
    windowing_DUT : windowing port map(CLK    => CLK,
                                       CE => CE_input,
                                       reset => RESET,
                                       entree => accel_mod_filtered,
                                       sortie => accel_mod_windowing,
                                       CE_windowing => LED_windowing_signal);                                                                              
    ----------------------------------------------------------------------------------------------------------------
    
    
    
    -- Wire connection ---------------------------------------------------------------------------------------------
    led <= std_logic_vector(accel_mod);
    LED_windowing <= LED_windowing_signal;
    CLK_SPI <= SPI_CLK;
    ----------------------------------------------------------------------------------------------------------------
       
end architecture;                            
