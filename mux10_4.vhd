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
END COMPONENT;

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



process(sig1,sig0 )
variable count_q0 : STD_LOGIC;
begin
if (sig0  = '0') then
	count_q0 := '0';
elsif (RISING_EDGE(sig1)) then
	count_q0 := (NOT(count_q0) AND sig0 ) OR (count_q0 AND (NOT(sig0 )));
end if;
	JKFF <= count_q0;
end process;


PROCESS(sig2,sig0 )
VARIABLE count_q1 : STD_LOGIC;
BEGIN
IF (sig0  = '0') THEN
	count_q1 := '0';
ELSIF (RISING_EDGE(sig2)) THEN
	count_q1 := (NOT(count_q1) AND sig0 ) OR (count_q1 AND (NOT(sig0 )));
END IF;
	q1 <= count_q1;
END PROCESS;


PROCESS(refclk,sig0 )
BEGIN
IF (sig0  = '0') THEN
	sig4  <= '0';
ELSIF (RISING_EDGE(refclk)) THEN
	sig4  <= sig3;
END IF;
END PROCESS;


PROCESS(refclk,sig0 )
BEGIN
IF (sig0  = '0') THEN
	sig3 <= '0';
ELSIF (RISING_EDGE(refclk)) THEN
	sig3 <= KEY1;
END IF;
END PROCESS;


sig1 <= sig3 AND sig4  AND DFF;


PROCESS(refclk,sig0 )
BEGIN
IF (sig0  = '0') THEN
	DFF <= '0';
ELSIF (RISING_EDGE(refclk)) THEN
	DFF <= sig4 ;
END IF;
END PROCESS;

M <= 		A when ((q0 = '0') and (q1 = '0')) 
   else  L when ((q0 = '0') and (q1 = '1')) 
   else  C when ((q0 = '1') and (q1 = '0')) 
   else  K;
N<= 		A when ((q0 = '0') and (q1 = '0')) 
		else  L when ((q0 = '0') and (q1 = '1')) 
		else  C when ((q0 = '1') and (q1 = '0')) 
		else  K;
	
b2v_inst6 : exp
PORT MAP(A_IN => JKFF,
		 A_OUT => sig2);


	  
END bdf_type;

