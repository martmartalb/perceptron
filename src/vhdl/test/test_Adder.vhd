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
            nbits_in : natural := 8;
            nbits_out : natural := 9
        );
        port (
            in1  : in signed (nbits_in - 1 downto 0);
            in2  : in signed (nbits_in - 1 downto 0);
            dout : out signed (nbits_out - 1 downto 0)
        );
    end component;

    -- CONSTANTS
    constant CLK_FREQ   : integer := 100000000; -- 100Mhz
    constant CLK_PERIOD : time    := (real(1E9)/real(CLK_FREQ)) * 1 ns;
    constant N_BITS_IN  : natural := 4;
    constant N_BITS_OUT  : natural := 4;

    -- SIGNALS
    signal sig_in1  : signed(N_BITS_IN - 1 downto 0) := "1010";
    signal sig_in2  : signed(N_BITS_IN - 1 downto 0) := (others => '0');
    signal sig_dout : signed(N_BITS_OUT - 1 downto 0);

begin

    dev_to_test : Adder
    generic map(
        nbits_in => N_BITS_IN,
        nbits_out => N_BITS_OUT
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