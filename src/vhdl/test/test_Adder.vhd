library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_Adder is
    -- port (
    --     clock
    -- );
end test_Adder;

architecture arch of test_Adder is

    -- COMPONENT
    component Adder
        generic (
            n_bits_in : natural := 8
        );
        port (
            in1  : in signed (n_bits_in - 1 downto 0);
            in2  : in signed (n_bits_in - 1 downto 0);
            dout : out signed (n_bits_in downto 0)
        );
    end component;

    -- CONSTANTS
    constant CLK_FREQ   : integer := 100000000; -- 100Mhz
    constant CLK_PERIOD : time    := (real(1E9)/real(CLK_FREQ)) * 1 ns;
    constant N_BITS_IN  : natural := 4;

    -- SIGNALS
    signal sig_in1  : signed(N_BITS_IN - 1 downto 0) := "1010";
    signal sig_in2  : signed(N_BITS_IN - 1 downto 0) := (others => '0');
    signal sig_dout : signed(N_BITS_IN downto 0);

begin

    dev_to_test : Adder
    generic map(
        n_bits_in => N_BITS_IN
    )
    port map(
        in1  => sig_in1,
        in2  => sig_in2,
        dout => sig_dout
    );

    sig_in1_stimulus : process
    begin
        wait for CLK_PERIOD/2;
        sig_in2 <= sig_in2 + 1;
    end process;

end architecture;