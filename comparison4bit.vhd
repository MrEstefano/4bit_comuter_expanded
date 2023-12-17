--
-- comparison section for 4-bit computer
-- group 2
--
library ieee;                 --import library
use ieee.std_logic_1164.all;  --use standard logic from library
use ieee.numeric_std.all;
--
-- entity section
--
entity comparison4bit is
    port (
        -- define inputs and outputs
        number1 : in std_logic_vector(3 downto 0);  -- sw3,2,1,0
        number2 : in std_logic_vector(3 downto 0);  -- sw 7,6,5,4
        sw9, sw8 : in std_logic;
        C : out std_logic_vector(9 downto 0)
    );
end comparison4bit;
--
-- architecture section
--
architecture rtl of comparison4bit is
    -- internal signals
    SIGNAL E, G, L : std_logic;         -- E (equal), G (Greater than), L  (Less than)
    SIGNAL M: std_logic_vector (3 downto 0);
begin
    -- comparitor
    process (number1, number2, sw8, sw9) is
        begin
            -- do comparison logic
            -- equal
            if (number2 = number1) then
                E <= '1';
            else
                E <= '0';
            end if;
            -- greater than
            if (number2 > number1) then
                G <= '1';
            else
                G <= '0';
            end if;
            -- less than
            if (number2 < number1) then
                L <= '1';
            else
                L <= '0';
            end if;
            -- max
            if (number2 > number1) then
                M <= number2;
            else
                M <= number1;
            end if;
            if (sw8 ='0' and sw9 = '0') then
                C <= ("000000000" & E);
            elsif (sw8 ='1' and sw9 = '0') then
                C <= ("000000000" & G);
            elsif (sw8 ='0' and sw9 = '1') then
                C <= ("000000000" & L);
            else
                C <= ("000000" &  M);     -- max number
            end if;
    end process;
end rtl;
