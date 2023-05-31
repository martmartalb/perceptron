library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity Adder is
    generic (
        n_bits_in : natural := 8
    );
    port (
        in1  : in signed (n_bits_in - 1 downto 0);
        in2  : in signed (n_bits_in - 1 downto 0);
        dout : out signed (n_bits_in downto 0)
    );
end Adder;

architecture Behavioral of Adder is

begin

    dout <= resize(in1, n_bits_in + 1) + resize(in2, n_bits_in + 1);

end Behavioral;