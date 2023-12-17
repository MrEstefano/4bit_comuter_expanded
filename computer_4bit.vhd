--------------------------------------------------------------
-- program to implement the overall 4 bit computer based on
-- unit entities defined for logic, arithmetic, comparison, magic
-- to run on DE10 Lite Board
--
-- inputs
-- Key0, Key1 (push buttons) to choose one of the main function  - std_logic;
-- SW9,SW8 (to choose the operation in the individual function) - std_logic;
-- SW7,6,5,4 (4 bit input number1) - std_logic_vector
-- SW3,2,1,9 (4 bit input number2) - std_logic_vector
-- Max10_CLK1_50 - onboard 50MHz clock for magic 
--
-- outputs
-- Hex0, Hex1 - two seven segment displays - std_logic_vector(6 downto 0)
-- LEDR9,8,...0 - Ten output leds - 
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
--
-- define top level entity
--
entity computer_4bit is 
    port (
			  KEY0, KEY1 : in std_logic;
			  number1 : in std_logic_vector (3 Downto 0);  -- SW 3,2,1,0
			  number2 : in std_logic_vector (3 Downto 0);  -- SW 7,6,5,4
			  SW9, SW8 : in std_logic;
			  clock50 : in std_logic;
			 -- bcd : out std_logic_vector (7 downto 0);
			  number_out : out std_logic_vector (9 downto 0);
			  -- led9, led8, led7, led6, led5 : out STD_LOGIC;
			  -- led4, led3, led2, led1, led0 : out STD_LOGIC;
			  hex0 : out std_logic_vector (6 Downto 0);    -- 7 segment display
			  hex1 : out std_logic_vector (6 Downto 0);     -- 7 segment display
			  hex3 : out std_logic_vector (6 Downto 0) ;    -- 7 segment display
			  hex4 : out std_logic_vector (6 Downto 0) ;    -- 7 segment display			  
			  hex5 : out std_logic_vector (6 Downto 0)     -- 7 segment display
			);
end computer_4bit;

architecture behaviour of computer_4bit is
--
-- add signals here
    signal A,C,L,K : std_logic_vector (9 downto 0);
	 signal bcd : std_logic_vector (11 downto 0);
	 signal number : std_logic_vector (9 downto 0) ;
	 
-- add components here
   
component arithmetic is
    port(
        number1 : in std_logic_vector(3 downto 0);
        number2 : in std_logic_vector(3 downto 0);
        SW9,SW8 : in std_logic;
        A: out std_logic_vector(9 downto 0) 
    );
    end component;

component logical is
    port(
        number1 :  in std_logic_vector(3 downto 0);
        number2 :  in std_logic_vector(3 downto 0);
        SW8,SW9:  in std_logic;
        L    :  out std_logic_vector(9 downto 0)
        );
    end component;

component comparison4bit is
    port (
			  -- define inputs and outputs
			  number1 : in std_logic_vector(3 downto 0);  -- sw3,2,1,0
			  number2 : in std_logic_vector(3 downto 0);  -- sw 7,6,5,4
			  SW8, SW9 : in std_logic;
			  C : out std_logic_vector(9 downto 0)
			);
end component;

component magic2clk is
    port ( 
           refclk : in  std_logic;
           K : out std_logic_vector (9 downto 0)
			);
 end component;

component hexToSevenSegment is
    port	(
			  hexNumber : in std_logic_vector(3 downto 0);
			  sevenSegmentActiveLow, sevenSegmentActiveHigh : out std_logic_vector(6 downto 0)
			);
end component;

component mux10_4 is
    port(
			 A,L,C,K: in std_logic_vector(9 downto 0); -- 4 10-bit inputs
			 KEY1, KEY0: in std_logic;                  -- selectors (2-bit)
			 M: out std_logic_vector(9 downto 0)  ;    -- 1 10-bit output
			 N: out std_logic_vector(7 downto 0)  ;    -- 1 10-bit output
			 refclk: in std_logic; -- clock input
			reset: in std_logic; -- reset input 
			counter: out std_logic_vector(1 downto 0) -- output 4-bit counter
			);
 end component;
 
  
  component bin8bcd is
    port	(
			  bin : in std_logic_vector(9 downto 0):="0000000000";
			  bcd : out std_logic_vector(11 downto 0)  
			  
			);
end component;

begin
    -- can use components here with map command   <= "00" &
    -- maps signals/ports in component to signals/ports in this program
	 
	  --number <= (std_logic_vector(number_out));
    -- arithm= ticnumber_outnumber_outnumber_outnumber_out
    arith: entity work.arithmetic port map ( 
        number1 => number1, 
        number2 => number2,  
        SW9 => SW9, 
        SW8 => SW8, 
        A => A);
    -- logical
    logic: entity work.logical port map ( 
        number1 => number1, 
        number2 => number2,  
        SW9 => SW9, 
        SW8 => SW8, 
        L => L);
        -- comparison
    compa: entity work.comparison4bit port map ( 
        number1 => number1, 
        number2 => number2,  
        SW9 => SW9, 
        SW8 => SW8, 
        C => C);    
    -- magic
    magic: entity work.magic2clk port map (
        refclk => clock50,
        K => K);   
    -- multiplexor
    mux10: entity work.mux10_4 port map (
        A => A,
        L => L,
        C => C,
        K => K,
        KEY1 => KEY1,
		  refclk => clock50,
        M => number_out ,
		  N => number
		  );
		  
		--m_x1: mux10_4 port map(M => number);
		  
		bin8_to_bcd: entity work.bin8bcd port map (
        
		  --refclk => clock50,
        bin => number,
		  bcd => bcd
		  );
      
    -- hex digits - map to the two input 4 bit numbers
	     hex70: entity work.hexToSevenSegment port map (
        hexNumber => number1,
        sevenSegmentActiveLow => hex0);
		  
		  hex71: entity work.hexToSevenSegment port map (
        hexNumber => number2,
        sevenSegmentActiveLow => hex1);
		  
		  hex73: entity work.hexToSevenSegment port map (
        hexNumber => bcd(3 downto 0) ,
        sevenSegmentActiveLow => hex3);
		  
		  hex74: entity work.hexToSevenSegment port map (
        hexNumber => bcd(7 downto 4) ,
        sevenSegmentActiveLow => hex4);
		  
		  hex75: entity work.hexToSevenSegment port map (
        hexNumber => bcd(11 downto 8) ,
        sevenSegmentActiveLow => hex5);
  
end behaviour;