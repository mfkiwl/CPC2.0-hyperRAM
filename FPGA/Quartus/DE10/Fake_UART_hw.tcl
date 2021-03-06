# TCL File Generated by Component Editor 14.0
# Sun May 28 12:08:20 EST 2017
# DO NOT MODIFY


# 
# Fake_UART "Fake UART" v1.0
#  2017.05.28.12:08:20
# 
# 

# 
# request TCL package from ACDS 14.0
# 
package require -exact qsys 14.0


# 
# module Fake_UART
# 
set_module_property DESCRIPTION ""
set_module_property NAME Fake_UART
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME "Fake UART"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL fake_uart
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file fake_uart.v VERILOG PATH fake_uart.v TOP_LEVEL_FILE


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock_sink
# 
add_interface clock_sink clock end
set_interface_property clock_sink clockRate 0
set_interface_property clock_sink ENABLED true
set_interface_property clock_sink EXPORT_OF ""
set_interface_property clock_sink PORT_NAME_MAP ""
set_interface_property clock_sink CMSIS_SVD_VARIABLES ""
set_interface_property clock_sink SVD_ADDRESS_GROUP ""

add_interface_port clock_sink clk_i clk Input 1


# 
# connection point reset_sink
# 
add_interface reset_sink reset end
set_interface_property reset_sink associatedClock ""
set_interface_property reset_sink synchronousEdges NONE
set_interface_property reset_sink ENABLED true
set_interface_property reset_sink EXPORT_OF ""
set_interface_property reset_sink PORT_NAME_MAP ""
set_interface_property reset_sink CMSIS_SVD_VARIABLES ""
set_interface_property reset_sink SVD_ADDRESS_GROUP ""

add_interface_port reset_sink reset_i reset Input 1


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock clock_sink_1
set_interface_property conduit_end associatedReset ""
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end CMSIS_SVD_VARIABLES ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end uart_tx_o tx_o Output 1
add_interface_port conduit_end uart_rx_i rx_i Input 1
add_interface_port conduit_end reset_o reset_o Output 1


# 
# connection point fake_uart
# 
add_interface fake_uart avalon end
set_interface_property fake_uart addressUnits WORDS
set_interface_property fake_uart associatedClock clock_sink
set_interface_property fake_uart associatedReset reset_sink
set_interface_property fake_uart bitsPerSymbol 8
set_interface_property fake_uart burstOnBurstBoundariesOnly false
set_interface_property fake_uart burstcountUnits WORDS
set_interface_property fake_uart explicitAddressSpan 0
set_interface_property fake_uart holdTime 0
set_interface_property fake_uart linewrapBursts false
set_interface_property fake_uart maximumPendingReadTransactions 0
set_interface_property fake_uart maximumPendingWriteTransactions 0
set_interface_property fake_uart readLatency 0
set_interface_property fake_uart readWaitTime 1
set_interface_property fake_uart setupTime 0
set_interface_property fake_uart timingUnits Cycles
set_interface_property fake_uart writeWaitTime 0
set_interface_property fake_uart ENABLED true
set_interface_property fake_uart EXPORT_OF ""
set_interface_property fake_uart PORT_NAME_MAP ""
set_interface_property fake_uart CMSIS_SVD_VARIABLES ""
set_interface_property fake_uart SVD_ADDRESS_GROUP ""

add_interface_port fake_uart data_i writedata Input 32
add_interface_port fake_uart data_o readdata Output 32
add_interface_port fake_uart write_i write Input 1
add_interface_port fake_uart addr_i address Input 6
add_interface_port fake_uart read_i read Input 1
set_interface_assignment fake_uart embeddedsw.configuration.isFlash 0
set_interface_assignment fake_uart embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment fake_uart embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment fake_uart embeddedsw.configuration.isPrintableDevice 0


# 
# connection point clock_sink_1
# 
add_interface clock_sink_1 clock end
set_interface_property clock_sink_1 clockRate 50000000
set_interface_property clock_sink_1 ENABLED true
set_interface_property clock_sink_1 EXPORT_OF ""
set_interface_property clock_sink_1 PORT_NAME_MAP ""
set_interface_property clock_sink_1 CMSIS_SVD_VARIABLES ""
set_interface_property clock_sink_1 SVD_ADDRESS_GROUP ""

add_interface_port clock_sink_1 uart_clk_i clk Input 1

