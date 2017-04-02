M:stdio_spi
S:Lstdio_spi.spiWrite$data$1$8({1}SC:U),B,1,4
F:G$stdio_channel_handler$0$0({2}DF,SV:S),C,0,1,0,0,0
S:Lstdio_spi.stdio_channel_handler$buffer$1$67({2}DG,SC:U),B,1,4
S:Lstdio_spi.stdio_channel_handler$size$1$67({1}SC:U),B,1,6
S:Lstdio_spi.stdio_channel_handler$sz$1$68({1}SC:U),B,1,-2
S:Lstdio_spi.stdio_channel_handler$sloc0$1$0({1}:S),B,1,-1
F:G$stdio_init$0$0({2}DF,SV:S),Z,0,0,0,0,0
F:G$spi_puts$0$0({2}DF,SV:S),Z,0,2,0,0,0
S:Lstdio_spi.spi_puts$string$1$73({2}DG,SV:S),B,1,4
S:Lstdio_spi.spi_puts$size$1$74({2}SI:S),B,1,-2
F:G$putchari$0$0({2}DF,SV:S),Z,0,0,0,0,0
S:Lstdio_spi.putchari$data$1$75({1}SC:U),B,1,4
F:G$putchar$0$0({2}DF,SV:S),Z,0,0,0,0,0
S:Lstdio_spi.putchar$data$1$77({1}SC:U),B,1,4
F:G$outbound_flush$0$0({2}DF,SV:S),Z,0,0,0,0,0
F:G$spi_avail$0$0({2}DF,SC:U),Z,0,0,0,0,0
F:G$getchar$0$0({2}DF,SC:U),Z,0,0,0,0,0
S:Lstdio_spi.getchar$r$1$81({1}SC:U),R,0,0,[e]
F:G$inbound_flush$0$0({2}DF,SV:S),Z,0,0,0,0,0
F:G$spi_connected$0$0({2}DF,SC:U),Z,0,0,0,0,0
T:Fstdio_spi$global_vars[({0}S:S$channel_handler_p$0$0({32}DA16d,DC,DF,SV:S),Z,0,0)({32}S:S$spi_in_use$0$0({1}SC:U),Z,0,0)({33}S:S$spi_processed_n$0$0({1}SC:U),Z,0,0)({34}S:S$spi_channel$0$0({1}SC:U),Z,0,0)({35}S:S$inbound_comm_buffer$0$0({512}DA512d,SC:U),Z,0,0)({547}S:S$outbound_comm_buffer$0$0({512}DA512d,SC:U),Z,0,0)]
S:Fstdio_spi$stdio_connected$0$0({1}SC:U),E,0,0
S:Fstdio_spi$stdio_inbound_buffer$0$0({8}DA8d,SC:U),E,0,0
S:Fstdio_spi$stdio_outbound_buffer$0$0({82}DA82d,SC:U),E,0,0
S:Fstdio_spi$inbuffer_entries$0$0({1}SC:U),E,0,0
S:Fstdio_spi$outbuffer_entries$0$0({1}SC:U),E,0,0
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
S:G$memcpy$0$0({2}DF,DG,SV:S),C,0,0
S:G$memmove$0$0({2}DF,DG,SV:S),C,0,0
S:G$strcpy$0$0({2}DF,DG,SC:U),C,0,0
S:G$strncpy$0$0({2}DF,DG,SC:U),C,0,0
S:G$strcat$0$0({2}DF,DG,SC:U),C,0,0
S:G$strncat$0$0({2}DF,DG,SC:U),C,0,0
S:G$memcmp$0$0({2}DF,SI:S),C,0,0
S:G$strcmp$0$0({2}DF,SI:S),C,0,0
S:G$strncmp$0$0({2}DF,SI:S),C,0,0
S:G$strxfrm$0$0({2}DF,SI:U),C,0,0
S:G$memchr$0$0({2}DF,DG,SV:S),C,0,0
S:G$strchr$0$0({2}DF,DG,SC:U),C,0,0
S:G$strcspn$0$0({2}DF,SI:U),C,0,0
S:G$strpbrk$0$0({2}DF,DG,SC:U),C,0,0
S:G$strrchr$0$0({2}DF,DG,SC:U),C,0,0
S:G$strspn$0$0({2}DF,SI:U),C,0,0
S:G$strstr$0$0({2}DF,DG,SC:U),C,0,0
S:G$strtok$0$0({2}DF,DG,SC:U),C,0,0
S:G$memset$0$0({2}DF,DG,SV:S),C,0,0
S:G$strlen$0$0({2}DF,SI:U),C,0,0
S:G$stdio_channel_handler$0$0({2}DF,SV:S),C,0,1
