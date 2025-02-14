library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_nbit_adder is
end tb_nbit_adder;

architecture testbench of tb_nbit_adder is
    constant N : integer := 4;
    signal a_tb, b_tb, s_tb : STD_LOGIC_VECTOR (N-1 downto 0) := (others => '0');
    signal cin_tb, cout_tb : STD_LOGIC := '0';

    component nbit_adder
        generic (N : integer := 4);
        port (
            a, b  : in  STD_LOGIC_VECTOR (N-1 downto 0);
            cin   : in  STD_LOGIC;
            S     : out STD_LOGIC_VECTOR (N-1 downto 0);
            cout  : out STD_LOGIC
        );
    end component;

begin
    UUT: nbit_adder generic map (N => 4)
        port map (a => a_tb, b => b_tb, cin => cin_tb, s => s_tb, cout => cout_tb);

    process
    begin
        -- Test vector 1: 0 + 0
        a_tb <= "0000"; b_tb <= "0000"; cin_tb <= '0'; wait for 10 ns;
        -- Test vector 2: 1 + 1
        a_tb <= "0001"; b_tb <= "0001"; cin_tb <= '0'; wait for 10 ns;
        -- Test vector 3: 4 + 13 (overflow)
        a_tb <= "0100"; b_tb <= "1101"; cin_tb <= '0'; wait for 10 ns;
        -- Test vector 4: 7 + 8(overflow)
        a_tb <= "0111"; b_tb <= "1000"; cin_tb <= '0'; wait for 10 ns;
        -- Test vector 5: 15 + 1 (overflow)
        a_tb <= "1111"; b_tb <= "0001"; cin_tb <= '0'; wait for 10 ns;
        -- Test vector 6: 10 + 10
        a_tb <= "1010"; b_tb <= "1010"; cin_tb <= '0'; wait for 10 ns;
        -- Test vector 7: 6 + 9
        a_tb <= "0110"; b_tb <= "1001"; cin_tb <= '0'; wait for 10 ns;
        -- Test vector 8: 14 + 2
        a_tb <= "1110"; b_tb <= "0010"; cin_tb <= '0'; wait for 10 ns;
        -- Test vector 9: 5 + 5
        a_tb <= "0101"; b_tb <= "0101"; cin_tb <= '0'; wait for 10 ns;
        -- Test vector 10: 12 + 3
        a_tb <= "1100"; b_tb <= "0011"; cin_tb <= '0'; wait for 10 ns;
        wait;
    end process;
end testbench;