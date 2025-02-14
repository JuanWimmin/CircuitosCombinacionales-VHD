library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
ENTITY nbit_adder IS 
	GENERIC (N : INTEGER :=8); 
	PORT( 	
		a, b 	: IN STD_LOGIC_VECTOR (N-1 DOWNTO 0); 
		cin 	: IN STD_LOGIC; 
		S		: OUT  STD_LOGIC_VECTOR (N-1 DOWNTO 0); 
		cout 	: OUT STD_LOGIC); 
		
END ENTITY nbit_adder; 

ARCHITECTURE rt1 OF nbit_adder IS 

	SIGNAL carry: STD_LOGIC_VECTOR (N-1 DOWNTO 0); 
BEGIN 
	adder: FOR i in N-1 DOWNTO 0 GENERATE 
		BITO: IF i=0 GENERATE 
				BO: ENTITY work.full_adder PORT MAP (a(i), b(i),cin,s(i), carry(i)); 
			END GENERATE;  
		BITN: IF i/=0 GENERATE 
				BN: ENTITY work.full_adder PORT MAP (a(i),b(i),carry(i-1),s(i),carry(i));
			END GENERATE; 
	END GENERATE; 
cout <= carry (carry'LEFT); 

END ARCHITECTURE;
	
	