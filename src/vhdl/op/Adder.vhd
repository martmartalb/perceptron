library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Adder is
  Generic ( 
        n_bits_bias : natural := 3;
        n_bits_in : natural := 7;
        layer : natural := 1;
        neuron : integer := 0;
        longitud : natural := 8
        );
  Port ( 
        clk : in STD_LOGIC;
        Bias : in signed (n_bits_bias-1 downto 0);
        clear : in STD_LOGIC;
        reset : in STD_LOGIC;
        Update : in STD_LOGIC;
        input_mult : in signed (n_bits_in-1 downto 0);
        output_sum : out signed (longitud-1 downto 0)
        );
end Adder;

architecture Behavioral of Adder is

signal sum, s_input: signed (longitud-1 downto 0):= (others => '0');

begin

s_input <= sum when clear = '0' else resize(Bias, longitud);  

Registros: process (clk,reset,Update)
begin

if rising_edge(clk) then
    if reset = '1' then
    
        sum <= (others => '0');
        
    elsif Update = '1' then

            sum <= resize(input_mult,longitud) + s_input;

        end if;
    end if;
end process;

output_sum <= sum;

end Behavioral;
