library IEEE;
 use IEEE.STD_LOGIC_1164.ALL;
 use IEEE.numeric_std.all;
 
 
 entity magic2clk is
    Port ( 
           refclk : in  std_logic;  -- 50 MHz clock
           K : out std_logic_vector (9 downto 0)
    );
 end magic2clk;
 
 
 
 architecture RTL of magic2clk is
			signal shift_reg: STD_LOGIC_VECTOR (9 downto 0) := "0000000001";
         signal sayac:      integer range 0 to 50000000;
         signal yonsec:     std_logic:= '0';
         signal pulse:     std_logic:= '0';
			signal Rst : std_logic;
 begin
	
	 Rst <= '0';

	 -- 0 to max_count counter
	 compteur : process(refclk, Rst)
		  --variable count : natural range 0 to max_count;
	 begin
		  if Rst = '1' then
				--sayac := 0;
				K <= "1111111111";
		  elsif rising_edge(refclk) then
                        if (sayac < 50000000) then 

                                sayac <= sayac + 4 ;
                        else

                                sayac <= 0;
                                          pulse <= '1';
				if (pulse = '1') then                         

                    if (yonsec = '0') then

                        shift_reg <= shift_reg (8 downto 0) & '0';

                        if (shift_reg(8) = '1') then

                            yonsec <= '1';

                            end if;

                    elsif (yonsec = '1') then

                        shift_reg <= '0' & shift_reg (9 downto 1);

                            if (shift_reg(1) = '1') then

                                yonsec <= not yonsec;

                        end if;

                    end if;

                end if;

            end if;

        end if;

    
	 K <= shift_reg;
	 end process compteur; 
 end RTL;
