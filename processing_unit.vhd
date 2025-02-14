LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY processing_unit IS
    GENERIC ( N : INTEGER := 8 );
    PORT (
        Dataa    : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        Datab    : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        sel      : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
        result   : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        cout     : OUT STD_LOGIC
    );
END ENTITY processing_unit;

ARCHITECTURE behavior OF processing_unit IS
    SIGNAL res_0, res_1, res_2, res_3 : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    SIGNAL cout_0, cout_1, cout_2, cout_3 : STD_LOGIC;
BEGIN
    -- Instancia del sumador (Dataa + Datab)
    ADDER_0: ENTITY work.add_sub
        GENERIC MAP (N => N)
        PORT MAP (
            a        => Dataa,
            b        => Datab,
            addn_sub => '0',
            s        => res_0,
            cout     => cout_0
        );

    -- Instancia del restador (Dataa - Datab)
    SUBTRACTOR_1: ENTITY work.add_sub
        GENERIC MAP (N => N)
        PORT MAP (
            a        => Dataa,
            b        => Datab,
            addn_sub => '1',
            s        => res_1,
            cout     => cout_1
        );

    -- Instancia de negación en complemento a 2 (-Datab)
    NEGATE_2: ENTITY work.add_sub
        GENERIC MAP (N => N)
        PORT MAP (
            a        => (OTHERS => '0'), -- Se usa 0 como entrada A
            b        => Datab,
            addn_sub => '1',
            s        => res_2,
            cout     => cout_2
        );

    -- Instancia del incremento (Datab + 1)
    INCREMENT_3: ENTITY work.add_sub
    GENERIC MAP (N => N)
    PORT MAP (
        a        => Datab,         -- Usamos Datab como entrada A
        b        => "00000001",  -- Vector con solo el bit menos significativo en '1'
        addn_sub => '0',           -- Modo suma
        s        => res_3,
        cout     => cout_3
    );

    -- Multiplexor para seleccionar la salida
    WITH sel SELECT
        result <= res_0 WHEN "00",
                  res_1 WHEN "01",
                  res_2 WHEN "10",
                  res_3 WHEN "11",
                  (OTHERS => '0') WHEN OTHERS;

    WITH sel SELECT
        cout <= cout_0 WHEN "00",
                cout_1 WHEN "01",
                cout_2 WHEN "10",
                cout_3 WHEN "11",
                '0' WHEN OTHERS;

END ARCHITECTURE behavior;
