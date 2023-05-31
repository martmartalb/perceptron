library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Mult is
    generic (
        n_bits_in : natural := 4
    );
    port (
        in1  : in signed (n_bits_in - 1 downto 0);
        in2  : in signed (n_bits_in - 1 downto 0);
        dout : out signed (n_bits_in * 2 - 1 downto 0)
    );
end Mult;

architecture Behavioral of Mult is

begin

    dout <= in1 * in2;

end Behavioral;