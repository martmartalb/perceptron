library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity Adder is
    generic (
        nbits_in : natural := 8;
        nbits_out : natural := 9
    );
    port (
        in1  : in signed (nbits_in - 1 downto 0);
        in2  : in signed (nbits_in - 1 downto 0);
        dout : out signed (nbits_out - 1 downto 0)
    );
end Adder;

architecture Behavioral of Adder is

begin

    dout <= resize(in1, nbits_out) + resize(in2, nbits_out);

end Behavioral;