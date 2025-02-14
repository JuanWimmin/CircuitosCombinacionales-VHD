LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY processing_unit_tb IS
END ENTITY processing_unit_tb;

ARCHITECTURE behavior OF processing_unit_tb IS
    -- Parámetro de tamaño de datos
    CONSTANT N : INTEGER := 8;

    -- Señales de prueba con sufijo _tb
    SIGNAL dataa_tb, datab_tb, result_tb : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    SIGNAL sel_tb : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL cout_tb : STD_LOGIC;

    -- Instancia del DUT (Device Under Test)
BEGIN
    DUT: ENTITY work.processing_unit
        GENERIC MAP (N => N)
        PORT MAP (
            Dataa  => dataa_tb,
            Datab  => datab_tb,
            sel    => sel_tb,
            result => result_tb,
            cout   => cout_tb
        );

    -- Proceso de estímulo
    STIMULUS: PROCESS
    BEGIN
        -- Caso 1: Suma (5 + 3)
        dataa_tb <= "00000101"; -- 5
        datab_tb <= "00000011"; -- 3
        sel_tb <= "00";
        WAIT FOR 20 ns;

        -- Caso 2: Suma (-4 + 7)
        dataa_tb <= "11111100"; -- -4 (Comp. A2)
        datab_tb <= "00000111"; -- 7
        sel_tb <= "00";
        WAIT FOR 20 ns;

        -- Caso 3: Resta (10 - 6)
        dataa_tb <= "00001010"; -- 10
        datab_tb <= "00000110"; -- 6
        sel_tb <= "01";
        WAIT FOR 20 ns;

        -- Caso 4: Resta (-5 - 3)
        dataa_tb <= "11111011"; -- -5
        datab_tb <= "00000011"; -- 3
        sel_tb <= "01";
        WAIT FOR 20 ns;

        -- Caso 5: Negación complemento a 2 (-7)
        datab_tb <= "00000111"; -- 7
        sel_tb <= "10";
        WAIT FOR 20 ns;

        -- Caso 6: Negación complemento a 2 (-(-10))
        datab_tb <= "11110110"; -- -10
        sel_tb <= "10";
        WAIT FOR 20 ns;

        -- Caso 7: Incremento (4 + 1)
        datab_tb <= "00000100"; -- 4
        sel_tb <= "11";
        WAIT FOR 20 ns;

        -- Caso 8: Incremento (-1 + 1)
        datab_tb <= "11111111"; -- -1
        sel_tb <= "11";
        WAIT FOR 20 ns;

        -- Caso 9: Suma con carry (127 + 1)
        dataa_tb <= "01111111"; -- 127
        datab_tb <= "00000001"; -- 1
        sel_tb <= "00";
        WAIT FOR 20 ns;

        -- Caso 10: Resta con carry (-128 - 1)
        dataa_tb <= "10000000"; -- -128
        datab_tb <= "00000001"; -- 1
        sel_tb <= "01";
        WAIT FOR 20 ns;

        -- Finaliza la simulación
        WAIT;
    END PROCESS STIMULUS;

END ARCHITECTURE behavior;
