create_clock -period 10.000 -name sysClk -waveform {0.000 5.000} [get_ports -filter { NAME =~  "*CLK*" && DIRECTION == "IN" }]
