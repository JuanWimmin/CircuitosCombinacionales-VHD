library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity full_adder is
    Port (	
			x 		: in std_logic;
			y 		: in  std_logic;
			cin	: in std_logic;
			s		: out std_logic;
			cout	: out std_logic);
	
end full_adder;

architecture gate_level of full_adder is
begin
    -- Implementación a nivel de compuertas
    s    <= x XOR y XOR cin;
    cout <= (x AND y) OR (x AND cin) OR (y AND cin);
	 
end gate_level;

