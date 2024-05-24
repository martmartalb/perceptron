LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE IEEE.std_logic_textio.ALL;

LIBRARY STD;
USE std.textio.ALL;

PACKAGE rom IS

	TYPE rom_type IS ARRAY (NATURAL RANGE <>) OF STD_LOGIC_VECTOR;
	IMPURE FUNCTION read_rom_file(filename : IN STRING; data_length : IN NATURAL; rom_size : IN NATURAL) RETURN rom_type;

END PACKAGE;

PACKAGE BODY rom IS

	IMPURE FUNCTION read_rom_file(filename : IN STRING; data_length : IN NATURAL; rom_size : IN NATURAL) RETURN rom_type IS
		FILE rf : text OPEN read_mode IS filename;
		VARIABLE v_l : line;
		VARIABLE v_i : bit_vector(data_length - 1 DOWNTO 0);
		VARIABLE v_rom : rom_type(0 TO (rom_size - 1))((data_length - 1) DOWNTO 0);
	BEGIN
		FOR i IN 0 TO (rom_size - 1) LOOP
			ASSERT false REPORT INTEGER'image(data_length) SEVERITY NOTE;
			readline (rf, v_l);
			read (v_l, v_i);
			v_rom(i) := to_stdlogicvector(v_i);
		END LOOP;
		RETURN v_rom;
	END FUNCTION;

END rom;