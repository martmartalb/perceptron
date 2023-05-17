library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MLP_Neuron is
  Generic ( 
           n_bits_bias : natural := 3; 
           n_bits_weights : natural := 3;
           n_bits_in : natural := 4;
           longitud: natural  := 12;
           neuron : integer := 0;
           layer : natural := 1;
           size_prev_layer : natural := 1024
           );
    Port ( 
          clk : in STD_LOGIC;
          clear : in STD_LOGIC;
          reset : in STD_LOGIC;
          Update : in STD_LOGIC;
          Cuenta : in integer range 0 to size_prev_layer-1;
          input_neuron : in signed (n_bits_in - 1 downto 0);
          output_neuron : out signed (longitud - 1 downto 0)
          );
end MLP_Neuron;

architecture Behavioral of MLP_Neuron is

component Bias is
Generic (
         n_bits_bias : natural := 3;
         layer : natural := 1;
         neuron : integer := 0
         );
 Port (    
       dout : out signed (n_bits_bias-1 downto 0)
       );
           
end component;

component Weights is
    Generic (
        n_bits_weights : natural := 3;
        layer : natural := 1;
        neuron : integer := 1;
        size_prev_layer : natural := 784);
    Port ( Cuenta : in integer range 0 to size_prev_layer-1;
           dout : out signed (n_bits_weights-1 downto 0));
end component;

component Mult is
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
end component;

component Adder is
  Generic ( 
        n_bits_bias : natural := 3;
        n_bits_in : natural := 7;
        layer : natural := 1;
        neuron : integer := 1;
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
end component;

signal s_Bias: signed (n_bits_bias-1 downto 0);

signal s_M_to_S: signed (n_bits_in + n_bits_weights - 1 downto 0);
signal s_W_to_M : signed (n_bits_weights-1 downto 0);

begin

layers: for i in layer to layer generate
    neurons: for i in neuron to neuron generate

        Weights_Comp: Weights
        Generic map( 
                   size_prev_layer => size_prev_layer,
                   neuron => neuron,
                   layer => layer,
                   n_bits_weights => n_bits_weights
                   )
         Port map( 
                  Cuenta => Cuenta,
                  dout => s_W_to_M
                  );

        M_Comp: Mult
        Generic map( 
                   n_bits_in => n_bits_in,
                   neuron => neuron,
                   layer => layer,
                   n_bits_weights => n_bits_weights
                   )
         Port map( 
                  input_mult => input_neuron,
                  weight_mult => s_W_to_M,
                  output_mult => s_M_to_S
                  );        
                  
        Bias_Comp: Bias
        Generic map( 
                     n_bits_bias => n_bits_bias,
                     layer => layer,
                     neuron =>  neuron)
        Port map(  
                     dout => s_Bias);
                  
        Adder_Comp: Adder
        Generic map( 
                   n_bits_in => n_bits_in + n_bits_weights,
                   n_bits_bias => n_bits_bias,
                   neuron => neuron,
                   longitud => longitud,
                   layer => layer
                   )
         Port map( 
                  clk => clk,
                  Bias => s_Bias,
                  clear => clear,
                  reset => reset,
                  Update => Update,
                  input_mult => s_M_to_S,
                  output_sum => output_neuron
                  );        
    end generate;
end generate;
end Behavioral;