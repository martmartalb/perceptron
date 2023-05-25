library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_Weights is
    -- port ();
end test_Weights;

architecture arch of test_Weights is

    -- COMPONENTS
    component Weights
        generic (
            nbits_weights   : natural := 3;
            layer           : natural := 1;
            neuron          : integer := 0;
            size_prev_layer : natural := 100
        );
        port (
            clk        : in std_logic;
            enable     : in std_logic;
            weight_idx : in integer range 0 to size_prev_layer - 1;
            dout       : out signed (nbits_weights - 1 downto 0)
        );
    end component;

    -- CONSTANTS
    constant CLK_FREQ        : integer := 100000000; -- 100Mhz
    constant CLK_PERIOD      : time    := (real(1E9)/real(CLK_FREQ)) * 1 ns;
    constant SIZE_PREV_LAYER : natural := 4;
    constant DATA_LENGTH     : natural := 4;

    -- SIGNALS
    signal sig_clk         : std_logic                              := '0';
    signal sig_enable      : std_logic                              := '1';
    signal sig_weights_idx : integer range 0 to size_prev_layer - 1 := 0;
    signal sig_dout        : signed(DATA_LENGTH - 1 downto 0);

begin

    dev_to_test : Weights
    generic map(
        nbits_weights   => DATA_LENGTH,
        layer           => 1,
        neuron          => 0,
        size_prev_layer => SIZE_PREV_LAYER
    )
    port map(
        clk        => sig_clk,
        enable     => sig_enable,
        weight_idx => sig_weights_idx,
        dout       => sig_dout
    );

    clk_stimulus : process
    begin
        wait for CLK_PERIOD/2;
        sig_clk <= not sig_clk;
    end process;

    address_increase : process
    begin
        wait for 4 * (CLK_PERIOD/2);
        if sig_weights_idx < size_prev_layer - 1 then
            sig_weights_idx <= sig_weights_idx + 1;
        else
            sig_weights_idx <= 0;
        end if;
    end process;

    enable_stimulus : process
    begin
        wait for 16 * (CLK_PERIOD/2);
        sig_enable <= not sig_enable;
    end process;

end architecture;