library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_textio.ALL;

library STD;
use std.textio.all;

package rom is
    
    type rom_type is array (natural range <>) of std_logic_vector;
    impure function read_rom_file(filename : in string; data_length : in natural; rom_size : in natural) return rom_type;
                            
end package;

package body rom is
    
    impure function read_rom_file(filename : in string; data_length : in natural; rom_size : in natural) return rom_type is
		file rf : text open read_mode is filename;
		variable v_l : line;
		variable v_i : bit_vector(data_length-1 downto 0); 
		variable v_rom  : rom_type(0 to rom_size)((data_length -1) downto 0);
	begin
		for i in 0 to rom_size loop 
			assert false report integer'image(data_length) severity NOTE;
			readline (rf, v_l);
			read (v_l, v_i);
			v_rom(i) :=  to_stdlogicvector(v_i);
		end loop;
		return v_rom;
	end function; 

end rom;