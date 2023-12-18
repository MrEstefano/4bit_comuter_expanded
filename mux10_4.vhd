library ieee;
use ieee.std_logic_1164.all;
library work;

entity mux10_4 is
	   port(
	     	A,L,C,K: in std_logic_vector(9 downto 0); -- 4 10-bit inputs
	      	M: out std_logic_vector(9 downto 0);      -- 1 10-bit output
		N: out std_logic_vector(9 downto 0);      -- 1 10-bit output
		KEY1 :  IN  STD_LOGIC;
		refclk :  IN  STD_LOGIC		
		);	
	
end mux10_4;

architecture bdf_type of mux10_4 is 

component exp port(
	    	A_IN : IN STD_LOGIC;
	    	A_OUT : OUT STD_LOGIC
	    	);
end component;

signal     q1 :  STD_LOGIC;
signal     q0 :  STD_LOGIC;
signal	sig_a :  STD_LOGIC;
signal	sig_b :  STD_LOGIC;
signal	KEY1_Debounced :  STD_LOGIC;
signal	sig0 :  STD_LOGIC;
signal	sig1 :  STD_LOGIC;
signal  sig3 :  STD_LOGIC;
signal	 Vdd :  STD_LOGIC;

begin

b2v : exp port map(
	A_IN => Vdd,
	A_OUT => sig_b
	);
	
------------------------------------ Debouncing KEY1 ---------------------------------------
	
process(refclk,sig_a)                                    -- D flip flop 1
	begin
		if (sig_a  = '0') then
			sig0 <= '0';
		elsif (RISING_EDGE(refclk)) then
			sig0 <= KEY1;
		end if;
	end process;
			
process(refclk,sig_a)                                    -- D flip flop 2
	begin
		if (sig_a  = '0') then
			sig1  <= '0';
		elsif (RISING_EDGE(refclk)) then
			sig1  <= sig0;
		end if;
	end process;

process(refclk,sig_a)                                    -- D flip flop 3
	begin
		if (sig_a  = '0') then
			sig3 <= '0';
		elsif (RISING_EDGE(refclk)) then
			sig3 <= sig1 ;
		end if;
	end process;

KEY1_Debounced <= sig0 AND sig1  AND sig3;  -- AND-ing three delays to generate one rising edge

---------------------------- 2bit counter -------------------------------------
		
process(KEY1_Debounced,sig_a)
variable count_q0 : STD_LOGIC;
	begin
		if (sig_a  = '0') then
			count_q0 := '0';
		elsif (RISING_EDGE(KEY1_Debounced)) then
			count_q0 := (NOT(count_q0) AND sig_a ) OR (count_q0 AND (NOT(sig_a )));
		end if;
			Vdd <= count_q0;
	end process;


process(sig_b,sig_a )
variable count_q1 : STD_LOGIC;
	begin
		if (sig_a  = '0') then
			count_q1 := '0';
		elsif (RISING_EDGE(sig_b)) then
			count_q1 := (NOT(count_q1) AND sig_a ) OR (count_q1 AND (NOT(sig_a )));
		end if;
			q1 <= count_q1;
	end process;

q0 <= Vdd;
sig_a  <= '1';

M <= 	A when ((q0 = '0') and (q1 = '0')) else
	L when ((q0 = '0') and (q1 = '1')) else  
	C when ((q0 = '1') and (q1 = '0')) else
	K;
N <= 	A when ((q0 = '0') and (q1 = '0')) else
	L when ((q0 = '0') and (q1 = '1')) else  
	C when ((q0 = '1') and (q1 = '0')) else
	K;	
	  
end bdf_type;


