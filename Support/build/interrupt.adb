M:interrupt
S:Linterrupt.spiWrite$data$1$8({1}SC:U),B,1,4
F:G$nmi_handler$0$0({2}DF,SV:S),C,0,0,0,0,0
F:G$int_handler$0$0({2}DF,SV:S),C,0,0,0,0,0
S:Linterrupt.int_handler$int_src$1$50({1}SC:U),R,0,0,[l]
S:Linterrupt.int_handler$__00020001$5$55({1}SC:U),R,0,0,[]
T:Finterrupt$global_vars[({0}S:S$channel_handler_p$0$0({32}DA16d,DC,DF,SV:S),Z,0,0)({32}S:S$spi_in_use$0$0({1}SC:U),Z,0,0)({33}S:S$spi_processed_n$0$0({1}SC:U),Z,0,0)({34}S:S$spi_channel$0$0({1}SC:U),Z,0,0)({35}S:S$inbound_comm_buffer$0$0({512}DA512d,SC:U),Z,0,0)({547}S:S$outbound_comm_buffer$0$0({512}DA512d,SC:U),Z,0,0)]
S:G$OUT$0$0({2}DF,SV:S),C,0,0
S:G$IN$0$0({2}DF,SC:U),C,0,0
S:G$OUTI$0$0({2}DF,SV:S),C,0,0
S:G$INI$0$0({2}DF,SV:S),C,0,0
S:G$NOP$0$0({2}DF,SV:S),C,0,0
S:G$HALT$0$0({2}DF,SV:S),C,0,0
S:G$spiWrite$0$0({2}DF,SV:S),C,0,0
S:G$spiRead$0$0({2}DF,SC:U),C,0,0
S:G$spiReady$0$0({2}DF,SV:S),C,0,0
S:G$spiFlush$0$0({2}DF,SV:S),C,0,0
S:G$spiStatus$0$0({2}DF,SC:U),C,0,0
S:G$spiMasterReady$0$0({2}DF,SC:U),C,0,0
S:G$spiEmptyIn$0$0({2}DF,SC:U),C,0,0
S:G$spiEmptyOut$0$0({2}DF,SC:U),C,0,0
S:G$spiGetInUse$0$0({2}DF,SC:U),C,0,0
S:G$spiGetProcessed$0$0({2}DF,SC:U),C,0,0
S:G$spiSetInUse$0$0({2}DF,SV:S),C,0,0
S:G$spiSetProcessed$0$0({2}DF,SV:S),C,0,0
S:G$spiSetHandler$0$0({2}DF,SV:S),C,0,0
S:G$spiProcessEvents$0$0({2}DF,SV:S),C,0,0
S:G$spiLock$0$0({2}DF,SC:U),C,0,0
S:G$spiGetOutBuffer$0$0({2}DF,DG,SV:S),C,0,0
S:G$spiGetInBuffer$0$0({2}DF,DG,SV:S),C,0,0
S:G$spiExchange$0$0({2}DF,SV:S),C,0,0
S:G$globals$0$0({2}DF,DG,STglobal_vars:S),C,0,0
S:G$process_events$0$0({2}DF,SV:S),C,0,0
S:G$console$0$0({2}DF,SV:S),C,0,0
S:G$ul$0$0({2}DF,SV:S),C,0,0
S:G$stdio_init$0$0({2}DF,SV:S),C,0,0
S:G$spi_puts$0$0({2}DF,SV:S),C,0,0
S:G$putchar$0$0({2}DF,SV:S),C,0,0
S:G$putchari$0$0({2}DF,SV:S),C,0,0
S:G$getchar$0$0({2}DF,SC:U),C,0,0
S:G$spi_avail$0$0({2}DF,SC:U),C,0,0
S:G$inbound_flush$0$0({2}DF,SV:S),C,0,0
S:G$outbound_flush$0$0({2}DF,SV:S),C,0,0
S:G$spi_connected$0$0({2}DF,SC:U),C,0,0
S:G$nmi_handler$0$0({2}DF,SV:S),C,0,0
S:G$int_handler$0$0({2}DF,SV:S),C,0,0
