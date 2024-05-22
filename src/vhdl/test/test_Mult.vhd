library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_Mult is
    -- port (
    --     clock
    -- );
end test_Mult;

architecture arch of test_Mult is

    -- COMPONENT
    component Mult
        generic (
            nbits_in  : natural := 4;
            nbits_out : natural := nbits_in * 2
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
    constant NBITS_IN   : natural := 4;
    constant NBITS_OUT  : natural := 8;

    -- SIGNALS
    signal sig_in1  : signed(NBITS_IN - 1 downto 0) := "1000";
    signal sig_in2  : signed(NBITS_IN - 1 downto 0) := (others => '0');
    signal sig_dout : signed(NBITS_OUT - 1 downto 0);

begin

    dev_to_test : Mult
    generic map(
        nbits_in  => NBITS_IN,
        nbits_out => NBITS_OUT
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