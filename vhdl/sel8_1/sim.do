# ModelSim 仿真脚本 —— 8 选 1 数据选择器自检测试
# 用法：在本目录下执行   vsim -do sim.do
#      （Quartus 自带的 ModelSim-Altera Starter Edition 即可）

vlib work
vmap work work

vcom -93 sel8_1.vhd
vcom -93 sel8_1_tb.vhd

vsim -c work.sel8_1_tb
run -all
quit -f
