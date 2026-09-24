--------------------------------------------------------------------------------
-- 模块名   : sel8_1_tb
-- 功能     : 8 选 1 数据选择器的自检测试平台（testbench）
-- 测试内容 :
--   阶段 1：s 遍历 "000"~"111"，每次只把被选中的那一路数据置 '1'，
--           检查输出 y 是否为 '1'（验证选择逻辑）；
--   阶段 2：固定数据 "1011_0100"，s 遍历 8 路，检查 y 是否等于对应的数据位
--           （验证数据通路）；
--   全过程打印 PASS / FAIL，并统计错误数。
-- 运行方法 : vsim -do sim.do   （或在 ModelSim 中先编译再做功能仿真）
-- 日期     : 2025-12
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sel8_1_tb is
end entity sel8_1_tb;

architecture sim of sel8_1_tb is
    signal d       : std_logic_vector(7 downto 0) := (others => '0');
    signal s       : std_logic_vector(2 downto 0) := (others => '0');
    signal y       : std_logic;
    signal err_cnt : integer := 0;
begin
    -- 例化被测模块
    uut : entity work.sel8_1
        port map (
            d => d,
            s => s,
            y => y
        );

    stim : process
        variable d_v  : std_logic_vector(7 downto 0);
        variable exp  : std_logic;
        variable errs : integer := 0;
    begin
        report "===== sel8_1 自检开始 =====" severity note;

        -- 阶段 1：逐路选择检查
        for i in 0 to 7 loop
            d_v := (others => '0');
            d_v(i) := '1';
            d <= d_v;
            s <= std_logic_vector(to_unsigned(i, 3));
            wait for 10 ns;
            if y /= '1' then
                errs := errs + 1;
                report "FAIL: s=" & integer'image(i) &
                       " 未选中 d(" & integer'image(i) & ")，实际 y=" & std_logic'image(y)
                    severity error;
            else
                report "PASS: s=" & integer'image(i) &
                       " 选中 d(" & integer'image(i) & ")" severity note;
            end if;
        end loop;

        -- 阶段 2：固定数据模式下的数据通路检查
        d_v := "10110100";
        d   <= d_v;
        for i in 0 to 7 loop
            s <= std_logic_vector(to_unsigned(i, 3));
            wait for 10 ns;
            exp := d_v(i);
            if y /= exp then
                errs := errs + 1;
                report "FAIL: d=10110100, s=" & integer'image(i) &
                       " 期望 y=" & std_logic'image(exp) & "，实际 y=" & std_logic'image(y)
                    severity error;
            else
                report "PASS: d=10110100, s=" & integer'image(i) &
                       " 输出 y=" & std_logic'image(exp) severity note;
            end if;
        end loop;

        err_cnt <= errs;
        if errs = 0 then
            report "===== 16 组用例全部通过，sel8_1 功能正确 =====" severity note;
        else
            report "===== 测试失败，错误数 = " & integer'image(errs) & " =====" severity error;
        end if;

        wait;  -- 结束激励
    end process stim;
end architecture sim;
