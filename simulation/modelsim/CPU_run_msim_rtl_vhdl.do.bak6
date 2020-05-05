transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/user/Desktop/Uni/Q4/Arq/PR4G/Arquitectura-de-computadors/UnitatControl.vhd}
vcom -93 -work work {C:/Users/user/Desktop/Uni/Q4/Arq/PR4G/Arquitectura-de-computadors/sum4.vhd}
vcom -93 -work work {C:/Users/user/Desktop/Uni/Q4/Arq/PR4G/Arquitectura-de-computadors/reg_32Bits.vhd}
vcom -93 -work work {C:/Users/user/Desktop/Uni/Q4/Arq/PR4G/Arquitectura-de-computadors/PC.vhd}
vcom -93 -work work {C:/Users/user/Desktop/Uni/Q4/Arq/PR4G/Arquitectura-de-computadors/mux2x1_32bits.vhd}
vcom -93 -work work {C:/Users/user/Desktop/Uni/Q4/Arq/PR4G/Arquitectura-de-computadors/mux2x1_5bits.vhd}
vcom -93 -work work {C:/Users/user/Desktop/Uni/Q4/Arq/PR4G/Arquitectura-de-computadors/memInst.vhd}
vcom -93 -work work {C:/Users/user/Desktop/Uni/Q4/Arq/PR4G/Arquitectura-de-computadors/memDada.vhd}
vcom -93 -work work {C:/Users/user/Desktop/Uni/Q4/Arq/PR4G/Arquitectura-de-computadors/IR.vhd}
vcom -93 -work work {C:/Users/user/Desktop/Uni/Q4/Arq/PR4G/Arquitectura-de-computadors/extSig.vhd}
vcom -93 -work work {C:/Users/user/Desktop/Uni/Q4/Arq/PR4G/Arquitectura-de-computadors/CPU.vhd}
vcom -93 -work work {C:/Users/user/Desktop/Uni/Q4/Arq/PR4G/Arquitectura-de-computadors/ControlALU.vhd}
vcom -93 -work work {C:/Users/user/Desktop/Uni/Q4/Arq/PR4G/Arquitectura-de-computadors/Cond_salt.vhd}
vcom -93 -work work {C:/Users/user/Desktop/Uni/Q4/Arq/PR4G/Arquitectura-de-computadors/BancRegistres.vhd}
vcom -93 -work work {C:/Users/user/Desktop/Uni/Q4/Arq/PR4G/Arquitectura-de-computadors/ALU32.vhd}

vcom -93 -work work {C:/Users/user/Desktop/Uni/Q4/Arq/PR4G/Arquitectura-de-computadors/simulation/modelsim/CPU_vhd_tst.vht}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive -L rtl_work -L work -voptargs="+acc"   CPU_vhd_tst

add wave *
view structure
view signals
run -all
