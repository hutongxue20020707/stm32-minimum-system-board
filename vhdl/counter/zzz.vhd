library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity zzz is
    port (
        clk        : in  std_logic;
        rst_n      : in  std_logic;
        part_in    : in  std_logic;
        pack_flag  : out std_logic
    );
end entity zzz;

architecture behave of zzz is
    -- 定义个位、十位计数信号（4位足够表示0~9）
    signal cnt_unit : std_logic_vector(3 downto 0) := (others => '0');
    signal cnt_ten  : std_logic_vector(3 downto 0) := (others => '0');
begin

    process(clk)
        variable j : integer range 0 to 1;  -- Loop循环变量（控制进位逻辑）
    begin
        if rising_edge(clk) then
            if rst_n = '0' then
                cnt_unit <= (others => '0');
                cnt_ten <= (others => '0');
                pack_flag <= '0';
            else
                pack_flag <= '0';
                if part_in = '1' then
                    -- For...Loop实现个位十位的进位计数（循环2次：先处理个位，再处理十位）
                    for j in 0 to 1 loop
                        case j is
                            when 0 =>  -- 第1次循环：处理个位计数
                                if cnt_unit = 9 then
                                    cnt_unit <= (others => '0');  -- 个位清零，准备进位
                                else
                                    cnt_unit <= cnt_unit + 1;  -- 个位加1
                                end if;
                            when 1 =>  -- 第2次循环：处理十位计数（仅当个位清零时进位）
                                if cnt_unit = 0 and cnt_ten = 9 then
                                    -- 个位为0且十位为9（即99），触发打包并清零
                                    cnt_ten <= (others => '0');
                                    pack_flag <= '1';
                                elsif cnt_unit = 0 then
                                    -- 仅个位清零时，十位加1
                                    cnt_ten <= cnt_ten + 1;
                                end if;
                        end case;
                    end loop;
                end if;
            end if;
        end if;
    end process;

end architecture behave;