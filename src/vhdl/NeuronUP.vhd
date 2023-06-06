library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

library perceptron;
use perceptron.bus_pkg.all;
entity NeuronUP is
    generic (
        nbits_bias      : natural := 4;
        nbits_weights   : natural := 4;
        nbits_in        : natural := 4;
        nbits_out       : natural := 8;
        neuron          : integer := 0;
        layer           : natural := 1;
        size_prev_layer : natural := 4
    );
    port (
        clk           : in std_logic;
        clear         : in std_logic;
        reset         : in std_logic;
        update        : in std_logic;
        counter       : in integer range 0 to size_prev_layer - 1;
        input_neuron  : in bus_array(0 to size_prev_layer - 1)(nbits_in - 1 downto 0);
        output_neuron : out signed (nbits_out - 1 downto 0)
    );
end NeuronUP;

architecture Behavioral of NeuronUP is

    -- COMPONENTS
    component Bias
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
    end component;

    component Weights
        generic (
            nbits_weights   : natural := 4;
            layer           : natural := 1;
            neuron          : integer := 0;
            size_prev_layer : natural := 4
        );
        port (
            clk        : in std_logic;
            enable     : in std_logic;
            weight_idx : in integer range 0 to size_prev_layer - 1;
            dout       : out signed (nbits_weights - 1 downto 0)
        );
    end component;

    component Adder
        generic (
            n_bits_in : natural := 8
        );
        port (
            in1  : in signed (n_bits_in - 1 downto 0);
            in2  : in signed (n_bits_in - 1 downto 0);
            dout : out signed (n_bits_in downto 0)
        );
    end component;

    component Mult
        generic (
            n_bits_in : natural := 4
        );
        port (
            in1  : in signed (n_bits_in - 1 downto 0);
            in2  : in signed (n_bits_in - 1 downto 0);
            dout : out signed (n_bits_in * 2 - 1 downto 0)
        );
    end component;

begin

end architecture;