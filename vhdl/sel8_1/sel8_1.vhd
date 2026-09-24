--------------------------------------------------------------------------------
-- 模块名   : sel8_1
-- 功能     : 8 选 1 数据选择器（八选一多路选择器）
-- 说明     : 3 位选择信号 s(2 downto 0) 选通 8 路数据输入 d(7 downto 0) 中的一路，
--            输出到 y。采用 process + if-elsif 优先级分支（顺序语句）实现，
--            s = "000" 时输出 d(0)，s = "111" 时输出 d(7)。
-- 工具     : Quartus II 13.0 SP1（目标器件 Cyclone IV E EP4CE40F29C6）
-- 日期     : 2025-12
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity sel8_1 is
    port (
        d : in  std_logic_vector(7 downto 0);  -- 8 路数据输入
        s : in  std_logic_vector(2 downto 0);  -- 3 位选择信号
        y : out std_logic                      -- 选中数据输出
    );
end entity sel8_1;

architecture rtl of sel8_1 is
begin
    -- 组合逻辑：按选择信号优先级选通一路数据
    nn : process (d, s)
    begin
        if s = "000" then
            y <= d(0);
        elsif s = "001" then
            y <= d(1);
        elsif s = "010" then
            y <= d(2);
        elsif s = "011" then
            y <= d(3);
        elsif s = "100" then
            y <= d(4);
        elsif s = "101" then
            y <= d(5);
        elsif s = "110" then
            y <= d(6);
        else
            y <= d(7);
        end if;
    end process nn;
end architecture rtl;
