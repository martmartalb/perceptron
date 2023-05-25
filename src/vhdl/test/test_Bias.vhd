library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_Bias is
    -- port ();
end test_Bias;

architecture arch of test_Bias is

    -- COMPONENTS
    component Bias
        generic (
            nbits_bias : natural := 4;
            layer      : natural := 1;
            neuron     : integer := 0
        );
        port (
            clk    : in std_logic;
            enable : in std_logic;
            dout   : out signed (nbits_bias - 1 downto 0)
        );
    end component;

    -- CONSTANTS
    constant CLK_FREQ    : integer := 100000000; -- 100Mhz
    constant CLK_PERIOD  : time    := (real(1E9)/real(CLK_FREQ)) * 1 ns;
    constant DATA_LENGTH : natural := 4;

    -- SIGNALS
    signal sig_clk    : std_logic := '0';
    signal sig_enable : std_logic := '1';
    signal sig_dout   : signed(DATA_LENGTH - 1 downto 0);

begin

    dev_to_test : Bias
    generic map(
        nbits_bias => DATA_LENGTH,
        layer      => 1,
        neuron     => 0
    )
    port map(
        clk    => sig_clk,
        enable => sig_enable,
        dout   => sig_dout
    );

    clk_stimulus : process
    begin
        wait for CLK_PERIOD/2;
        sig_clk <= not sig_clk;
    end process;

    enable_stimulus : process
    begin
        wait for 3 * (CLK_PERIOD/2);
        sig_enable <= not sig_enable;
    end process;

end architecture;