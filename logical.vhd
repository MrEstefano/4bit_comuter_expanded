--
-- implements logic section in 4 bit computer
-- group 3
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity logical is
 port(
     number1 :  IN STD_LOGIC_VECTOR (3 DOWNTO 0);
     number2 :  IN STD_LOGIC_VECTOR (3 DOWNTO 0);
     SW9, SW8:  IN STD_LOGIC;
     L    :  OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
  );
end logical;
 
architecture bv of logical is
begin
process (number1, number2, SW9, SW8) is
begin
  if (SW9 ='0' and SW8 = '0') then
      L <= "000000" & (number1 and number2);
  elsif (SW9 ='0' and SW8 = '1') then
      L <= "000000" & (number1 OR number2);
  elsif (SW9 ='1' and SW8 = '0') then
      L <= "000000" & (number1 XOR number2);
  else
      L <= "00" & (NOT(number1) & NOT(number2));
  end if;
 
end process;
end bv;


