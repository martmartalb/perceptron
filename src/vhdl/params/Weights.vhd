library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.ALL;

library STD;
use std.textio.all;

entity Weights is

    Generic (
        n_bits_weights : natural := 3;
        layer : natural := 1;
        neuron : integer := 0;
        size_prev_layer : natural := 100);
        
    Port ( Cuenta : in integer range 0 to size_prev_layer-1;
           dout : out signed (n_bits_weights-1 downto 0));
           
end Weights;

architecture Behavioral of Weights is

constant size_rom : natural := size_prev_layer-1;

type rom_type is array (0 to size_rom) of signed (n_bits_weights-1 downto 0); 

impure function weight_rom(rfn : in string) return rom_type is
    file rf : text open read_mode is rfn;
    variable v_l : line;
    variable v_i : bit_vector(n_bits_weights-1 downto 0); 
    variable v_rom  : rom_type;
begin
    for i in 0 to size_rom loop 
        assert false report integer'image(n_bits_weights) severity NOTE;
        readline (rf, v_l);
        read (v_l, v_i);
        v_rom(i) :=  signed(to_stdlogicvector(v_i));
    end loop;
    return v_rom;
end function; 

function create_file_name (neuron : in integer) return string is
begin
    return "MLP_weights" & "_" & integer'image(layer) & "_" & integer'image(neuron) & ".txt";
end function;

constant MLP_weights : rom_type := weight_rom(create_file_name(neuron));

begin
 	
dout <= MLP_weights(Cuenta);

end Behavioral;