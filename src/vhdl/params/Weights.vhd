LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_textio.ALL;

LIBRARY perceptron;
USE perceptron.rom.ALL;

ENTITY Weights IS

	GENERIC (
		nbits_weights : NATURAL := 4;
		layer : NATURAL := 1;
		neuron : INTEGER := 0;
		size_prev_layer : NATURAL := 4
	);
	PORT (
		clk : IN STD_LOGIC;
		enable : IN STD_LOGIC;
		weight_idx : IN INTEGER RANGE 0 TO size_prev_layer - 1;
		dout : OUT signed (nbits_weights - 1 DOWNTO 0)
	);

END Weights;

ARCHITECTURE Behavioral OF Weights IS

	CONSTANT rom_size : NATURAL := size_prev_layer;
	--constant file_name : string := "MLP_weights" & "_" & integer'image(layer) & "_" & integer'image(neuron) & ".txt";
	CONSTANT MLP_weights : rom_type(0 TO (rom_size - 1))((nbits_weights - 1) DOWNTO 0) := read_rom_file("weights.dat", nbits_weights, rom_size);

BEGIN

	PROCESS (clk) IS
	BEGIN
		IF rising_edge(clk) THEN
			IF enable = '1' THEN
				dout <= signed(MLP_weights(weight_idx));
			ELSE
				dout <= (OTHERS => 'Z');
			END IF;
		END IF;
	END PROCESS;

END Behavioral;