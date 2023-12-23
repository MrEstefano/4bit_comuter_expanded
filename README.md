# 4bit_comuter_expanded_VHDL
The 4bit computer project written in VHDL running on DE10 Lite FPGA expanded with debounced push button, 2bit counter to manipulate 4to1_MUX, knight rider effect in magic2clk, result displayed not only in binary but in decimal utilizing BCD(Binary coded decimal) algorithm 

1. Introduction:
This lab is about implementing VHDL code of the 4 bit computer which is given in assignment paper. Students task is to compile the program files in Quartus Prime software, then flashing the code to DE10-lite FPGA board with a multiple VHDL program files. The exercise purpose is to give an individual the experience working with Quartus Prime software, implementing VHDL language code, troubleshooting and testing the 4 bit computer written by Ryan ZumBrunnen [1]. There are four functions, each output is individually displayed utilizing 4to1 multiplexer concept. The general high level design can be seen below in Figure 1..
 
2. Methodology
The experiment utilizes Quartus software tools, which interfaces DE10-Lite development board. The software platform supports various file formats, in which student can implement block diagram given in lab requirements paper and test it on the development board. The project contains the 4bit_computer file which is set as top hierarchy file and the component files are created in same project one by one, considered as sub functions. The top hierarchy file is manipulating various component inputs and outputs among the whole project. The 4bit computer name is derived from its design to take two inputs in 4 bit binary format. There are four activities: arithmetic, comparison, logic and magic2 clock. The activity operation is controlled by combined SW8 and SW9 logic state 1 or 0. When 2 bit combination is selected by KEY0 and KEY1 the result is displayed on LED’s in 8bit binary format. All peripherals are assigned to respective pin location on FPGA


2.1. Four bit input
There are two input variables, num1 and num2, these are set by switches num1( SW0 to SW3 ) and num2 (SW4 to SW7) in 4 bit binary number. Each input value is displayed on LED’s respectively. In parallel the input value is then displayed on Seven segment 0 and Seven segment 1 in hex format. The Seven segment component code can be seen in appendix
2.2. Arithmetic activity
By selection of 2 bit combination of SW8 and SW9 each is assigned respectively. The arithmetic activity code can be seen in appendix
Arithmetic activity has four functions : 
•	Addition,
•	Subtraction,
•	Multiplication,
•	Division. 

2.3. Comparison activity
By selection of 2 bit combination of SW8 and SW9 each is assigned respectively. The comparison activity code can be seen in appendix
Comparison activity has four functions : 
•	Equality,
•	Greater, 
•	Lesser,
•	Max number, 


2.4. Logic activity
By selection of 2 bit combination of SW8 and SW9 each is assigned respectively. The logic activity code can be seen in appendix
Logic activity has four functions : 
•	Equality,
•	Greater, 
•	Lesser,
•	Max number, 
 

2.5. Magic2 activity
The magic2 activity turns ON and OFF all 10 LED’s in timed interval. The magic2 activitycode can be seen in appendix

2.6. Output
These activities which are manipulating numbers have result output on raw of LED’s in binary format (Magic2 is only LED sequence effect) respectively to state of KEY0 and KEY1 push buttons. When user presses 2 bit combination on KEY0 and KEY1 the output/result is displayed associated with chosen activity

2.7. Upgrading activity selection and Debouncing the pushbutton
Through the rigorous testing the computer project, the new challenges raised up to enhance the functionality and effects of given project. Switching among activities is little bit inconvenient, therefore 2bit asynchronous counter has been researched at Basic electronics tutorials [2] and coded within mux_10_4.vhdl file. By use of one push button instead of two, the choice of desired activity became fixed and convenient, but the push button was switching through 2bit sequence to fast, due to the unwanted bouncing between logic states. For this reason “Debounce” algorithm is developed and implemented in same mux_10_4.vhdl file. 

2.8. Upgrading the magic2 file to generate “Knight Rider” effect
Regarding to the author of the project, he states that magic2 file generates “Knight Rider” effect on 10 LED’s. But the assignment file has provided only basic code to flash on/off all LED’s. In order to modify the computer function, the VHDL was imported from open source and implemented in the magic2 function. The effect can be observed in result section

3. Results
3.1. Before upgrade
In this section the performance of the 4 bit computer can be observed in Online Video 1. Below. As default activity is magic2clk with flashing effect of all output/LED’s. The next short Online Video 2. demonstrates how arithmetic function is activated, where two inputs are set, as following: num1  is “8” and num2 is “7”. By pushing to pushbuttons KEY0 and KEY1, the result can be observed on four LED’s (0 to 3)

3.2. After upgrade
3.2.1. Magic2clk “Knight rider” effect
In the section result shows the outcome from upgrading the code and enhanced performance within magic2clk activity where instead all LED’s flashing, the knight rider effect can be observed in Online Video 3

3.2.2. Move through activities with debounced pushbutton

The part of upgrade is moving through activities by pressing on pushbutton KEY1 which acts as clock pulse to manipulate two registers and achieve sequence of 2 bit asynchronous counter. By exercising the counter, it has been observed that it moves from one state of counter to another too fast as it is suspected, the clock speed of FPGA is 50 Mhz, which means that there are many rising edges at one push of the button also called bouncing signal. Therefore debounce algorithm has been added to 4_10mux file resourced at Invent Logics [3]. Moving among computer activities become much more convenient and predictable. The sequence it moves is K -> A -> C -> L . Following short Online Video 4. Proves how to move to next activity called Arithmetic in addition mode

3.2.3. Computed result in decimal – BCD/7segment
The greatest achievement in upgrading computer VHDL program code is expanding the code with new component called 8bit to binary conversion. Coded in decimal number encoder algorithm utilizing three seven segments to display result in user friendly manner. The VHDL code was resourced at Stack Overflow [4] and ported over to general project. Binary Coded Decimal algorithm is based on “Double Dable” component(add3), which shifts the partition of the binary number in order to transform the whole 8bit binary number into three digit decimal numbers in range of 0 to 255 (2 in power of 8) utilizing Seven segment component function.

3.2.4. Arithmetic activity
The arithmetic operations can be observed in Online Video 5. Calculated result is shown in binary on LED’s and on 7segments in decimal. Adding and subtracting algorithm is working fine besides some miscalculation, one of the students has noticed same issue with original code, By rewriting the addition and subtraction logic, student college has resolved the issue and addition and subtraction calculations work 100%. Credits to: Mr.x

3.2.5. Comparison activity
In Online Video 6. Shown below The Comparison activity Is presented with range of functions. Calculated result is shown in binary on LED’s and on 7segments in decimal.

3.2.1. Logic activity
In Online Video 7. Shown below The Comparison activity Is presented with range of functions explored. Calculated result is shown in binary on LED’s and on 7segments in decimal

4. Conclusion
By exercising the behavior of 4bit computer on the DE10 lite development board, the functions are behaving as expected at each setting. But it has been noticed that switch SW0 to SW9 are little bit sticky, the state does not changed at some occasions. The issue was investigated, switches may needs to be exercised back and forward to achieve desired value. This could be overcome by debouncing each switch SWx. 
In General the program code we received in the beginning was not easy to understand, but while troubleshooting and improving the code. Progressively the understanding of whole concept came naturally clear. The challenges to improve the 4 bit computer project, led to deeper understanding of how to create different components under the top of hierarchy file and how to reuse outputs from one component to other, in order to reach desired result.  To make the computer perform in convenient way in terms of setting desired values, new concepts of logic where researched and implemented in code.
The exercise provided a great experience how to use Quartus software with implementation of components aka subfunctions in order to gain expected results. Programing in VHDL language provides excellent skill for the student, who may serve as an advantage in professional career. The general outcome from this lab is the understanding how individual components interact with each other within the main program.

5. References


[1] 	R. ZumBrunnen, "Learning electrical engineering one project at a time," 27 September 2019. [Online]. Available: https://ryanzumbrunnen.wordpress.com/2018/03/04/4-bit-fpga-cpu/.
[2] 	"BASIC ELECTRONICS TUTORIALS," [Online]. Available: https://www.electronics-tutorial.net/VHDL/Counters/synchronous-asynchronous-counters/.
[3] 	"Inven logics," 23 January 2015. [Online]. Available: https://allaboutfpga.com/vhdl-code-for-debounce-circuit-in-fpga/.
[4] 	"Stack Overflow," May 2014. [Online]. Available: https://stackoverflow.com/questions/23871792/convert-8bit-binary-number-to-bcd-in-vhdl.
[5] 	M. Sossevent, "geeks for geeks," 31 June 2023. [Online]. Available: https://www.geeksforgeeks.org/differences-between-synchronous-and-asynchronous-counter/.




