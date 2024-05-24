LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY test_Weights IS
    -- port ();
END test_Weights;

ARCHITECTURE arch OF test_Weights IS

    -- COMPONENTS
    COMPONENT Weights
        GENERIC (
            nbits_weights : NATURAL := 3;
            layer : NATURAL := 1;
            neuron : INTEGER := 0;
            size_prev_layer : NATURAL := 100
        );
        PORT (
            clk : IN STD_LOGIC;
            enable : IN STD_LOGIC;
            weight_idx : IN INTEGER RANGE 0 TO size_prev_layer - 1;
            dout : OUT signed (nbits_weights - 1 DOWNTO 0)
        );
    END COMPONENT;

    -- CONSTANTS
    CONSTANT CLK_FREQ : INTEGER := 100000000; -- 100Mhz
    CONSTANT CLK_PERIOD : TIME := (real(1E9)/real(CLK_FREQ)) * 1 ns;
    CONSTANT SIZE_PREV_LAYER : NATURAL := 4;
    CONSTANT DATA_LENGTH : NATURAL := 4;

    -- SIGNALS
    SIGNAL sig_clk : STD_LOGIC := '0';
    SIGNAL sig_enable : STD_LOGIC := '1';
    SIGNAL sig_weights_idx : INTEGER RANGE 0 TO size_prev_layer - 1 := 0;
    SIGNAL sig_dout : signed(DATA_LENGTH - 1 DOWNTO 0);

BEGIN

    dev_to_test : Weights
    GENERIC MAP(
        nbits_weights => DATA_LENGTH,
        layer => 1,
        neuron => 0,
        size_prev_layer => SIZE_PREV_LAYER
    )
    PORT MAP(
        clk => sig_clk,
        enable => sig_enable,
        weight_idx => sig_weights_idx,
        dout => sig_dout
    );

    clk_stimulus : PROCESS
    BEGIN
        WAIT FOR CLK_PERIOD/2;
        sig_clk <= NOT sig_clk;
    END PROCESS;

    address_increase : PROCESS
    BEGIN
        WAIT FOR 4 * (CLK_PERIOD/2);
        IF sig_weights_idx < size_prev_layer - 1 THEN
            sig_weights_idx <= sig_weights_idx + 1;
        ELSE
            sig_weights_idx <= 0;
        END IF;
    END PROCESS;

    enable_stimulus : PROCESS
    BEGIN
        WAIT FOR 16 * (CLK_PERIOD/2);
        sig_enable <= NOT sig_enable;
    END PROCESS;

END ARCHITECTURE;