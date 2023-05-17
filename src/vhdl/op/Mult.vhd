library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Mult is
  Generic ( 
           n_bits_in : natural := 4;
           neuron : integer := 0;
           layer : natural := 1;
           n_bits_weights : natural := 3
           );
    Port ( 
          input_mult : in signed (n_bits_in - 1 downto 0);
          weight_mult : in signed (n_bits_weights - 1 downto 0);
          output_mult : out signed (n_bits_in + n_bits_weights - 1 downto 0)
          );
end Mult;

architecture Behavioral of Mult is

begin

output_mult <= input_mult * weight_mult;


end Behavioral;