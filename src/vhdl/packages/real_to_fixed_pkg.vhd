LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

PACKAGE real_to_fixed_pkg IS

    ------------------------------------------------------------------------
    FUNCTION to_fixed (
        number : real;
        number_of_fractional_bits : INTEGER
    ) RETURN INTEGER;
    ------------------------------------------------------------------------
    FUNCTION to_real (
        number : INTEGER;
        number_of_fractional_bits : INTEGER
    ) RETURN real;
    ------------------------------------------------------------------------
    FUNCTION to_fixed (
        number : real;
        bit_width : NATURAL;
        number_of_fractional_bits : INTEGER
    ) RETURN signed;
    ----------
    FUNCTION to_fixed (
        number : real;
        bit_width : NATURAL;
        number_of_fractional_bits : INTEGER
    ) RETURN STD_LOGIC_VECTOR;
    ------------------------------------------------------------------------
    FUNCTION to_real (
        number : signed;
        number_of_fractional_bits : INTEGER
    ) RETURN real;
    ----------
    FUNCTION to_real (
        number : STD_LOGIC_VECTOR;
        number_of_fractional_bits : INTEGER
    ) RETURN real;
    ------------------------------------------------------------------------

END PACKAGE real_to_fixed_pkg;

PACKAGE BODY real_to_fixed_pkg IS

    ------------------------------------------------------------------------
    FUNCTION to_fixed
    (
        number : real;
        number_of_fractional_bits : INTEGER
    )
        RETURN INTEGER
        IS
    BEGIN
        RETURN INTEGER(number * 2.0 ** number_of_fractional_bits);
    END to_fixed;
    ------------------------------------------------------------------------
    FUNCTION to_real
    (
        number : INTEGER;
        number_of_fractional_bits : INTEGER
    )
        RETURN real
        IS
    BEGIN
        RETURN real(number)/2.0 ** (number_of_fractional_bits);
    END to_real;
    ------------------------------------------------------------------------
    FUNCTION to_real
    (
        number : signed;
        number_of_fractional_bits : INTEGER
    )
        RETURN real
        IS
        VARIABLE retval : real := 0.0;
        VARIABLE temp : signed(number'RANGE) := ABS(number);

    BEGIN
        FOR i IN number'high - 1 DOWNTO number'low LOOP
            IF temp(i) = '1' THEN
                retval := retval + 2.0 ** (i);
            END IF;
        END LOOP;

        IF number(number'high) = '1' THEN
            retval := - retval;
        END IF;

        RETURN retval/2.0 ** number_of_fractional_bits;
    END to_real;
    ------------------------------------------------------------------------
    FUNCTION to_real (
        number : STD_LOGIC_VECTOR;
        number_of_fractional_bits : INTEGER)
        RETURN real
        IS
    BEGIN
        RETURN to_real(signed(number), number_of_fractional_bits);
    END to_real;
    ------------------------------------------------------------------------
    FUNCTION to_fixed
    (
        number : real;
        bit_width : NATURAL;
        number_of_fractional_bits : INTEGER
    )
        RETURN signed
        IS
        VARIABLE retval : signed(bit_width - 1 DOWNTO 0) := (OTHERS => '0');
        VARIABLE temp : real := ABS(number) * 2.0 ** number_of_fractional_bits;
    BEGIN

        FOR i IN INTEGER RANGE bit_width - 2 DOWNTO 0 LOOP
            IF temp >= 2.0 ** i THEN
                temp := temp - 2.0 ** i;
                retval(i) := '1';
            ELSE
                retval(i) := '0';
            END IF;

        END LOOP;

        IF number < 0.0 THEN
            retval := - retval;
        END IF;

        RETURN retval;

    END to_fixed;
    ------------------------------------------------------------------------
    FUNCTION to_fixed
    (
        number : real;
        bit_width : NATURAL;
        number_of_fractional_bits : INTEGER
    )
        RETURN STD_LOGIC_VECTOR IS
        VARIABLE retval : signed(bit_width - 1 DOWNTO 0) := (OTHERS => '0');
    BEGIN
        retval := to_fixed(number, bit_width, number_of_fractional_bits);
        RETURN STD_LOGIC_VECTOR(retval);
    END to_fixed;

END PACKAGE BODY real_to_fixed_pkg;