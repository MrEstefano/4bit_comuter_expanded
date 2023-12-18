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

component exp
	port(
	     A_IN : IN STD_LOGIC;
	     A_OUT : OUT STD_LOGIC
	    );
end component;

signal    q1 :  STD_LOGIC;
signal    q0 :  STD_LOGIC;
signal	sig0 :  STD_LOGIC;
signal	sig1 :  STD_LOGIC;
signal	sig2 :  STD_LOGIC;
signal	sig3 :  STD_LOGIC;
signal	sig4 :  STD_LOGIC;
signal   DFF :  STD_LOGIC;
signal	JKFF :  STD_LOGIC;


begin 
q0 <= JKFF;
sig0  <= '1';



process(sig1,sig0)
variable count_q0 : STD_LOGIC;
begin
if (sig0  = '0') then
	count_q0 := '0';
elsif (RISING_EDGE(sig1)) then
	count_q0 := (NOT(count_q0) AND sig0 ) OR (count_q0 AND (NOT(sig0 )));
end if;
	JKFF <= count_q0;
end process;


process(sig2,sig0 )
variable count_q1 : STD_LOGIC;
begin
if (sig0  = '0') then
	count_q1 := '0';
elsif (RISING_EDGE(sig2)) then
	count_q1 := (NOT(count_q1) AND sig0 ) OR (count_q1 AND (NOT(sig0 )));
end if;
	q1 <= count_q1;
end process;


process(refclk,sig0 )
begin
if (sig0  = '0') then
	sig4  <= '0';
elsif (RISING_EDGE(refclk)) then
	sig4  <= sig3;
end if;
end process;


process(refclk,sig0 )
begin
if (sig0  = '0') then
	sig3 <= '0';
elsif (RISING_EDGE(refclk)) then
	sig3 <= KEY1;
end if;
end process;


sig1 <= sig3 AND sig4  AND DFF;


process(refclk,sig0 )
begin
if (sig0  = '0') then
	DFF <= '0';
elsif (RISING_EDGE(refclk)) then
	DFF <= sig4 ;
end if;
end process;

M <= 	A when ((q0 = '0') and (q1 = '0')) else
	L when ((q0 = '0') and (q1 = '1')) else  
	C when ((q0 = '1') and (q1 = '0')) else
	K;
N <= 	A when ((q0 = '0') and (q1 = '0')) else
	L when ((q0 = '0') and (q1 = '1')) else  
	C when ((q0 = '1') and (q1 = '0')) else
	K;
	
b2v_inst6 : exp
port map(A_IN => JKFF,
		 A_OUT => sig2);
	  
end bdf_type;


