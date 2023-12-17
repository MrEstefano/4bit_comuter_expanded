--
-- arithmetic section for 4-bit computer
-- group 1
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;   -- Needed for shifts
USE ieee.std_logic_unsigned.all;          
--
-- entity section
--
entity arithmetic is
port(
    number1, number2 : in std_logic_vector(3 downto 0);
    SW9,SW8 : in std_logic;
    A: out std_logic_vector(9 downto 0) 
);
end arithmetic;
--
-- architecture
--
architecture  arith of arithmetic is
signal c0,c1,c2,c3, d :std_logic;
signal b0,b1,b2,b3 :std_logic;
signal part : unsigned(3 downto 0);
signal mb : unsigned(3 downto 0);

begin
    process(number1, number2, SW9,SW8) is
    begin
        if(SW9 = '0' and SW8 = '0') then          -- add two numbers
            A(0) <= number1 (0) xor number2(0);
            c0 <= number1(0) and number2(0);
            A(1) <= number1 (1) xor number2(1) xor c0;
            c1 <= number1(1) and number2(1);
            A(2) <= number1 (2) xor number2(2) xor c1;
            c2 <= number1(2) and number2(2);
            A(3) <= number1 (3) xor number2(3) xor c2;
            c3 <= number1(3) and number2(3);
            A(4) <= c3;

        elsif(SW9='0' and SW8='1') then           -- subtract two numbers
        d <= '1';
        b0 <= not number2(0);
        b1 <= not number2(1);
        b2 <= not number2(2);
        b3 <= not number2(3);
        A(0) <= number1(0) xor b0 xor d;
            c0 <= (number1(0) and b0) or (number1(0) and d) or (b0 and d);
            A(1) <= number1 (1) xor b1 xor c0;
            c1 <= (number1(1) and b1) or (number1(1) and d) or (b1 and d);
            A(2) <= number1 (2) xor b2 xor c1;
            c2 <= (number1(2) and b2) or (number1(2) and d) or (b2 and d);
            A(3) <= number1 (3) xor b3 xor c2;

        elsif(SW9='1' and SW8='0') then           -- multiply two numbers
            A <= "00" & (std_logic_vector(unsigned(number1) * unsigned(number2)));
        elsif(SW9='1' and SW8='1') then           -- divide two numbers
            A <= "00" & (std_logic_vector(to_unsigned(to_integer(unsigned(number1) / unsigned(number2)),8)));
        end if;
    end process;
end arith;
