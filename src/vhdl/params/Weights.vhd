library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;

library perceptron;
use perceptron.rom.all;

entity Weights is

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

end Weights;

architecture Behavioral of Weights is

	constant rom_size : natural := size_prev_layer;
	--constant file_name : string := "MLP_weights" & "_" & integer'image(layer) & "_" & integer'image(neuron) & ".txt";
	constant MLP_weights : rom_type(0 to (rom_size - 1))((nbits_weights - 1) downto 0) := read_rom_file("weights.dat", nbits_weights, rom_size);

begin

	process (clk) is
	begin
		if (rising_edge(clk) and enable = '1') then
			dout <= signed(MLP_weights(weight_idx));
		end if;
	end process;

end Behavioral;