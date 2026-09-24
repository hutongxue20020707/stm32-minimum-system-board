-- 60进制计数器（异步复位，同步使能）
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity jinzhi60 is
    port (
        clk     : in  std_logic;  -- 时钟信号（建议实验箱接分频后1Hz）
        rst_n   : in  std_logic;  -- 异步复位（低有效，接实验箱按键）
        en      : in  std_logic;  -- 计数使能（高有效，接实验箱按键）
        cnt0    : out std_logic_vector(3 downto 0);  -- 个位（0-9，4位二进制）
        cnt1    : out std_logic_vector(2 downto 0);  -- 十位（0-5，3位二进制）
        cout    : out std_logic   -- 进位输出（计到59时置1，接实验箱LED）
    );
end jinzhi60;

architecture behavioral of jinzhi60 is
    signal cnt0_reg : std_logic_vector(3 downto 0) := "0000";  -- 个位寄存器
    signal cnt1_reg : std_logic_vector(2 downto 0) := "000";   -- 十位寄存器
begin
    -- 计数逻辑进程
    process(clk, rst_n)
    begin
        if rst_n = '0' then  -- 异步复位：清零
            cnt0_reg <= "0000";
            cnt1_reg <= "000";
            cout <= '0';
        elsif rising_edge(clk) then  -- 时钟上升沿触发
            cout <= '0';  -- 默认进位清零
            if en = '1' then  -- 使能有效时计数
                if cnt0_reg = 9 then  -- 个位到9，清零并十位+1
                    cnt0_reg <= "0000";
                    if cnt1_reg = 5 then  -- 十位到5且个位到9，整体清零+进位
                        cnt1_reg <= "000";
                        cout <= '1';  -- 计到59，进位置1
                    else
                        cnt1_reg <= cnt1_reg + 1;
                    end if;
                else  -- 个位未到9，仅个位+1
                    cnt0_reg <= cnt0_reg + 1;
                end if;
            end if;
        end if;
    end process;

    -- 输出赋值
    cnt0 <= cnt0_reg;
    cnt1 <= cnt1_reg;
end behavioral;