// megafunction wizard: %ALTIOBUF%VBB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altiobuf_bidir 

// ============================================================
// File Name: bidirbuf.v
// Megafunction Name(s):
// 			altiobuf_bidir
//
// Simulation Library Files(s):
// 			cyclonev
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 14.0.0 Build 200 06/17/2014 SJ Web Edition
// ************************************************************

//Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, the Altera Quartus II License Agreement,
//the Altera MegaCore Function License Agreement, or other 
//applicable license agreement, including, without limitation, 
//that your use is for the sole purpose of programming logic 
//devices manufactured by Altera and sold by Altera or its 
//authorized distributors.  Please refer to the applicable 
//agreement for further details.

module bidirbuf (
	datain,
	oe,
	dataio,
	dataout)/* synthesis synthesis_clearbox = 1 */;

	input	[15:0]  datain;
	input	[15:0]  oe;
	inout	[15:0]  dataio;
	output	[15:0]  dataout;

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: CONSTANT: enable_bus_hold STRING "FALSE"
// Retrieval info: CONSTANT: left_shift_series_termination_control STRING "FALSE"
// Retrieval info: CONSTANT: number_of_channels NUMERIC "16"
// Retrieval info: CONSTANT: open_drain_output STRING "FALSE"
// Retrieval info: CONSTANT: use_differential_mode STRING "FALSE"
// Retrieval info: CONSTANT: use_dynamic_termination_control STRING "FALSE"
// Retrieval info: CONSTANT: use_termination_control STRING "FALSE"
// Retrieval info: USED_PORT: datain 0 0 16 0 INPUT NODEFVAL "datain[15..0]"
// Retrieval info: USED_PORT: dataio 0 0 16 0 BIDIR NODEFVAL "dataio[15..0]"
// Retrieval info: USED_PORT: dataout 0 0 16 0 OUTPUT NODEFVAL "dataout[15..0]"
// Retrieval info: USED_PORT: oe 0 0 16 0 INPUT NODEFVAL "oe[15..0]"
// Retrieval info: CONNECT: @datain 0 0 16 0 datain 0 0 16 0
// Retrieval info: CONNECT: @oe 0 0 16 0 oe 0 0 16 0
// Retrieval info: CONNECT: dataio 0 0 16 0 @dataio 0 0 16 0
// Retrieval info: CONNECT: dataout 0 0 16 0 @dataout 0 0 16 0
// Retrieval info: GEN_FILE: TYPE_NORMAL bidirbuf.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL bidirbuf.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL bidirbuf.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL bidirbuf.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL bidirbuf_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL bidirbuf_bb.v TRUE
// Retrieval info: LIB_FILE: cyclonev
