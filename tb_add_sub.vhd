LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_add_sub IS
END tb_add_sub;

ARCHITECTURE testbench OF tb_add_sub IS
    CONSTANT N : INTEGER := 4;
    
    SIGNAL a_tb, b_tb, s_tb : STD_LOGIC_VECTOR (N-1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL addn_sub_tb : STD_LOGIC := '0';
    SIGNAL cout_tb : STD_LOGIC;

    COMPONENT add_sub
        GENERIC (N : INTEGER := 4);
        PORT (
            a        : IN  STD_LOGIC_VECTOR (N-1 DOWNTO 0);
            b        : IN  STD_LOGIC_VECTOR (N-1 DOWNTO 0);
            addn_sub : IN  STD_LOGIC;
            s        : OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0);
            cout     : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN
    -- Instanciar el adder-subtractor
    UUT: add_sub 
        GENERIC MAP (N => 4)
        PORT MAP (
            a        => a_tb,
            b        => b_tb,
            addn_sub => addn_sub_tb,
            s        => s_tb,
            cout     => cout_tb
        );

    -- Proceso de prueba
    PROCESS
    BEGIN
        -- Caso 1: Suma normal -> 3 + 2 = 5
        a_tb <= "0011";  -- 3
        b_tb <= "0010";  -- 2
        addn_sub_tb <= '0';  -- Modo suma
        WAIT FOR 10 ns;

        -- Caso 2: Suma con carry -> 7 + 9 = 16 (Carry esperado)
        a_tb <= "0111";  -- 7
        b_tb <= "1001";  -- 9
        addn_sub_tb <= '0';  -- Modo suma
        WAIT FOR 10 ns;

        -- Caso 3: Suma con overflow -> 6 + 7 = 13 (sin overflow en 4 bits)
        a_tb <= "0110";  -- 6
        b_tb <= "0111";  -- 7
        addn_sub_tb <= '0';  -- Modo suma
        WAIT FOR 10 ns;

        -- Caso 4: Suma con overflow -> 8 + 8 = 16 (Carry esperado)
        a_tb <= "1000";  -- 8
        b_tb <= "1000";  -- 8
        addn_sub_tb <= '0';  -- Modo suma
        WAIT FOR 10 ns;

        -- Caso 5: Resta normal -> 10 - 5 = 5
        a_tb <= "1010";  -- 10
        b_tb <= "0101";  -- 5
        addn_sub_tb <= '1';  -- Modo resta
        WAIT FOR 10 ns;

        -- Caso 6: Resta normal -> 14 - 9 = 5
        a_tb <= "1110";  -- 14
        b_tb <= "1001";  -- 9
        addn_sub_tb <= '1';  -- Modo resta
        WAIT FOR 10 ns;

        -- Caso 7: Resta con resultado negativo -> 6 - 7 = -1 (Carry esperado)
        a_tb <= "0110";  -- 6
        b_tb <= "0111";  -- 7
        addn_sub_tb <= '1';  -- Modo resta
        WAIT FOR 10 ns;

        -- Caso 8: Resta con resultado negativo -> 3 - 5 = -2 (Carry esperado)
        a_tb <= "0011";  -- 3
        b_tb <= "0101";  -- 5
        addn_sub_tb <= '1';  -- Modo resta
        WAIT FOR 10 ns;

        -- Caso 9: Resta con resultado negativo -> 0 - 1 = -1 (Carry esperado)
        a_tb <= "0000";  -- 0
        b_tb <= "0001";  -- 1
        addn_sub_tb <= '1';  -- Modo resta
        WAIT FOR 10 ns;

        -- Caso 10: Resta con resultado negativo -> 1 - 15 = -14 (Carry esperado)
        a_tb <= "0001";  -- 1
        b_tb <= "1111";  -- 15
        addn_sub_tb <= '1';  -- Modo resta
        WAIT FOR 10 ns;

        -- Detener la simulación
        WAIT;
    END PROCESS;
END testbench;
	