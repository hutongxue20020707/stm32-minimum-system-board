library ieee;
use ieee.std_logic_1164.all;

entity yima3_8 is
    port (
        E0, E1, E2 : in std_logic;          -- 使能端
        A0, A1, A2 : in std_logic;          -- 数据输入端
        Y : out std_logic_vector(7 downto 0) -- 数据输出端
    );
end entity yima3_8;

architecture behavioral of yima3_8 is
    signal input_sel : std_logic_vector(2 downto 0); -- 输入选择信号
begin
    -- 组合输入信号
    input_sel <= A2 & A1 & A0;
    
    -- 使用条件信号赋值语句实现3-8译码器
    Y <= "11111110" when (E0 = '1' and E1 = '0' and E2 = '0') and (input_sel = "000") else
         "11111101" when (E0 = '1' and E1 = '0' and E2 = '0') and (input_sel = "001") else
         "11111011" when (E0 = '1' and E1 = '0' and E2 = '0') and (input_sel = "010") else
         "11110111" when (E0 = '1' and E1 = '0' and E2 = '0') and (input_sel = "011") else
         "11101111" when (E0 = '1' and E1 = '0' and E2 = '0') and (input_sel = "100") else
         "11011111" when (E0 = '1' and E1 = '0' and E2 = '0') and (input_sel = "101") else
         "10111111" when (E0 = '1' and E1 = '0' and E2 = '0') and (input_sel = "110") else
         "01111111" when (E0 = '1' and E1 = '0' and E2 = '0') and (input_sel = "111") else
         "11111111"; -- 默认情况（芯片未使能）
end architecture behavioral;