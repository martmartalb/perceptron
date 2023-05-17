library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.ALL;

library STD;
use std.textio.all;

entity Bias is

  Generic (
           n_bits_bias : natural := 3;
           layer : natural := 1;
           neuron : integer := 0
           );
           
   Port (  
           dout : out signed (n_bits_bias-1 downto 0));
           
end Bias;

architecture Behavioral of Bias is

constant size_rom : natural := 0;

type rom_type is array (0 to size_rom) of signed (n_bits_bias-1 downto 0); 

impure function bias_rom(rfn : in string) return rom_type is
    file rf : text open read_mode is rfn;
    variable v_l : line;
    variable v_i : bit_vector(n_bits_bias-1 downto 0); 
    variable v_rom  : rom_type;
begin
    for i in 0 to size_rom loop 
        assert false report integer'image(n_bits_bias) severity NOTE;
        readline (rf, v_l);
        read (v_l, v_i);
        v_rom(i) :=  signed(to_stdlogicvector(v_i));
    end loop;
    return v_rom;
end function; 

function create_file_name (neuron : in integer) return string is
begin
    return "MLP_Bias" & "_" & integer'image(layer) & "_" &  integer'image(neuron) & ".txt";
end function;

constant MLP_Bias : rom_type := bias_rom(create_file_name(neuron));

begin

dout <= MLP_Bias(0);

end Behavioral;