library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;

library perceptron;
use perceptron.rom.all;

entity Bias is

    generic (
        nbits_bias : natural := 4;
        layer      : natural := 1;
        neuron     : integer := 0
    );
    port (
        clk    : in std_logic;
        enable : in std_logic;
        dout   : out signed (nbits_bias - 1 downto 0)
    );

end Bias;

architecture Behavioral of Bias is

    constant rom_size : natural := 1;

    constant MLP_Bias : rom_type(0 to (rom_size - 1))((nbits_bias - 1) downto 0) := read_rom_file("bias.dat", nbits_bias, rom_size);
begin

    process (clk) is
    begin
        if rising_edge(clk) then
        	if enable = '1' then
            	dout <= signed(MLP_Bias(0));
            else
            	dout <= (others => 'Z'); 
            end if;
        end if;
    end process;

end Behavioral;