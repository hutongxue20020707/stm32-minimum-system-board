library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity jinzhi6 is
    port (
        clk     : in  std_logic;  -- 时钟信号
        rst_n   : in  std_logic;  -- 异步复位（低有效）
        en      : in  std_logic;  -- 计数使能（高有效）
        cnt     : out std_logic_vector(2 downto 0);  -- 计数输出（0-5，3位二进制）
        cout    : out std_logic   -- 进位输出（计到5时置1）
    );
end jinzhi6;

architecture behavioral of jinzhi6 is
    signal cnt_reg : std_logic_vector(2 downto 0) := "000";  -- 计数寄存器
begin
    -- 计数逻辑进程（复用60进制十位的模6逻辑）
    process(clk, rst_n)
    begin
        if rst_n = '0' then  -- 异步复位
            cnt_reg <= "000";
            cout <= '0';
        elsif rising_edge(clk) then  -- 时钟上升沿
            cout <= '0';
            if en = '1' then
                if cnt_reg = 5 then  -- 计到5，清零+进位
                    cnt_reg <= "000";
                    cout <= '1';
                else  -- 未到5，计数+1
                    cnt_reg <= cnt_reg + 1;
                end if;
            end if;
        end if;
    end process;

    -- 输出赋值
    cnt <= cnt_reg;
end behavioral;