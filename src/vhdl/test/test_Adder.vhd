LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

LIBRARY perceptron;
USE perceptron.real_to_fixed_pkg.ALL;

ENTITY test_Adder IS
    -- port (
    --     clock
    -- );
END test_Adder;

ARCHITECTURE arch OF test_Adder IS

    -- COMPONENT
    COMPONENT Adder
        GENERIC (
            nbits_in : NATURAL := 8
        );
        PORT (
            in1 : IN STD_LOGIC_VECTOR (nbits_in - 1 DOWNTO 0);
            in2 : IN STD_LOGIC_VECTOR (nbits_in - 1 DOWNTO 0);
            dout : OUT STD_LOGIC_VECTOR (nbits_in DOWNTO 0)
        );
    END COMPONENT;

    -- CONSTANTS
    CONSTANT CLK_FREQ : INTEGER := 100000000; -- 100Mhz
    CONSTANT CLK_PERIOD : TIME := (real(1E9)/real(CLK_FREQ)) * 1 ns;
    CONSTANT N_BITS_IN : NATURAL := 8;
    CONSTANT N_FRANCTIONAL_PART : NATURAL := 4;

    -- SIGNALS
    SIGNAL in1 : STD_LOGIC_VECTOR(N_BITS_IN - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL in2 : STD_LOGIC_VECTOR(N_BITS_IN - 1 DOWNTO 0) := "10110000";
    SIGNAL dout : STD_LOGIC_VECTOR(N_BITS_IN DOWNTO 0);

    SIGNAL real_in1 : real := 0.0;
    SIGNAL real_int2 : real := 0.0;
    SIGNAL real_dount : real;
    SIGNAL delta_in1 : real := 1.1;

BEGIN

    dev_to_test : Adder
    GENERIC MAP(
        nbits_in => N_BITS_IN
    )
    PORT MAP(
        in1 => in1,
        in2 => in2,
        dout => dout
    );

    real_in1 <= to_real(to_integer(signed(in1)), N_FRANCTIONAL_PART);
    real_int2 <= to_real(to_integer(signed(in2)), N_FRANCTIONAL_PART);
    real_dount <= to_real(to_integer(signed(dout)), N_FRANCTIONAL_PART);

    sig_in1_stimulus : PROCESS
    BEGIN
        WAIT FOR CLK_PERIOD/2;
        in1 <= STD_LOGIC_VECTOR(to_signed(to_integer(signed(in1)) + to_fixed(delta_in1, N_FRANCTIONAL_PART), in1'LENGTH));

    END PROCESS;

END ARCHITECTURE;