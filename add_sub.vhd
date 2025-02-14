-- add_sub.vhd (component):
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY add_sub IS
    GENERIC (N          : INTEGER :=8);
    PORT (  
        a         : IN  STD_LOGIC_VECTOR (N-1 DOWNTO 0);
        b         : IN  STD_LOGIC_VECTOR (N-1 DOWNTO 0);
        addn_sub  : IN  STD_LOGIC;
        s         : OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0);
        cout      : OUT STD_LOGIC
    );
END ENTITY add_sub;

ARCHITECTURE rtl OF add_sub IS
    SIGNAL bxor               : STD_LOGIC_VECTOR (N-1 DOWNTO 0);
    SIGNAL addn_sub_vector    : STD_LOGIC_VECTOR (N-1 DOWNTO 0);
BEGIN
    -- Create a vector with the value of addn_sub input
    vector_generation: FOR i IN N-1 DOWNTO 0 GENERATE
        addn_sub_vector(i) <= addn_sub;
    END GENERATE;

    bxor <= b XOR addn_sub_vector;

    -- Adder instantiation
    Adder: ENTITY work.nbit_adder
        GENERIC MAP (N => N)
        PORT MAP ( 
            a    => a,
            b    => bxor,
            cin  => addn_sub,
            s    => s,
            cout => cout
        );

END ARCHITECTURE;
