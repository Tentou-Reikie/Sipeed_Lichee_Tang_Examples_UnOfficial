create_clock -name clk_24MHz -period 41.666 -waveform {0 20.833} [get_ports { clk_24MHz_i }]
create_clock -name clk_33MHz -period 30.000 -waveform {0 15.000} [get_nets  { pll_clk0_o  }]
