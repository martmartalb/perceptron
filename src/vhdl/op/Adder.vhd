LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Adder IS
    GENERIC (
        nbits_in : NATURAL := 8
    );
    PORT (
        in1 : IN STD_LOGIC_VECTOR (nbits_in - 1 DOWNTO 0);
        in2 : IN STD_LOGIC_VECTOR (nbits_in - 1 DOWNTO 0);
        dout : OUT STD_LOGIC_VECTOR (nbits_in DOWNTO 0)
    );
END Adder;

ARCHITECTURE Behavioral OF Adder IS

    SIGNAL tmp_in1, tmp_in2, tmp_dout : signed(nbits_in DOWNTO 0);

BEGIN

    tmp_in1 <= resize(signed(in1), nbits_in + 1);
    tmp_in2 <= resize(signed(in2), nbits_in + 1);
    tmp_dout <= tmp_in1 + tmp_in2;
    dout <= STD_LOGIC_VECTOR(tmp_dout);

END Behavioral;