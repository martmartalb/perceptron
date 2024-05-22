library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Mult is
    generic (
        nbits_in  : natural := 4;
        nbits_out : natural := nbits_in * 2
    );
    port (
        in1  : in signed (nbits_in - 1 downto 0);
        in2  : in signed (nbits_in - 1 downto 0);
        dout : out signed (nbits_out - 1 downto 0)
    );
end Mult;

architecture Behavioral of Mult is

begin

    dout <= resize(in1 * in2, nbits_out);

end Behavioral;