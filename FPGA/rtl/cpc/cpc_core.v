/*
 * cpc_core - the top level CPC rtl
 *
 * This is the actual CPC rtl
 *
 * Part of the CPC2 project: http://intelligenttoasters.blog
 *
 * Copyright (C)2017  Intelligent.Toasters@gmail.com
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, you can find a copy here:
 * https://www.gnu.org/licenses/gpl-3.0.en.html
 *
 */
`timescale 1ns/1ns

`define LO 1'b0
`define HI 1'b1

module cpc_core ( 
		input 			clk_16,
		input 			clk_4,
		input 			clk_1,
		input 			nreset_i,
		// UART Connection to Supervisor
		output uart_tx_o,
		input uart_rx_i,
		// Video signals
		input 			video_clk_i,
		input [15:0] 	video_A_o,
		output [7:0]	video_D_o,
		output [15:0]	video_offset_o,
		// Keyboard signals
		input	[79:0] keyboard_i,
		output [7:0] audio_o,
		// Shared ROM data
		input [7:0] romram_data_i,
		output [7:0] romram_data_o,
		output /*reg*/ [23:0] romram_addr_o,
		output romram_enable_o,
		output romram_rd_o,
		output romram_wr_o,
		input romram_valid_i,
		input [63:0] romflags_i,	// Which ROMs are populated?
		// FDC Interface
		output reg fdc_motor = 0,
		output fdc_activity,
		// Support CPU Signals for FDC
		input 			S_clk_i,
		input [3:0]		S_A_i,
		input [7:0]		S_D_i,
		output [7:0]		S_D_o,
		input				S_rd_i,
		input				S_wr_i,
		input				S_enable_i,
		output			S_fdc_int_o,
		// Debug trigger connection
		output [7:0] debug_trigger_o
	);

	// Wire definitions ===========================================================================
	wire [15:0] A;
	wire [7:0] DO, DI, u_rom_o, u_rom0_o, ram_o, vram_o, Dpio, D8255_o, Dfdc;
	wire [7:0] ppia_o, ppia_i, ppic_o, u_rom5_o, u_rom6_o, u_rom7_o, fdc_o;
	wire nWR, nRD, nMREQ, nIORQ, nROMEN, nM1, cpu_int, l_rom_e, u_rom_e, ram_e, u_ram_e, fdc_e;
	wire vsync_signal, hsync_signal;
	wire nIORD = (nIORQ | nRD);
	wire nIOWR = (nIORQ | nWR);
	wire nMEMRD = (nMREQ | nRD);
	wire nMEMWR = (nMREQ | nWR);
	wire [5:0] romsel_o;				// TODO: Expanded by 1 bit to 64 pages of rom (1M)
	wire [8:0] ramsel_o;				// Expanded by 3 bits to 256 pages of ram (4M)
	wire [7:0] ram_page;				// Mapping to actual ram page
	// CRTC / Video data
	wire [13:0]MA;
	wire [4:0]RA;
	wire [23:0] color_dat;
	wire video_border;
	wire [2:0] pixel_num;
	// PIO signals
	wire printer_port_e = (A[12] == `LO);
	wire [1:0] pio_selected_port;
	wire [7:0] portc_dat;	// Used to split port
	wire D8255_e = ( A[11] == `LO );
	
	// Registers ==================================================================================
//	reg BUSWAIT = 1'b1;
	reg [4:0] clockdiv = 0;
	reg [7:0] ramrom_D_store;
	
	// Assignments ================================================================================
	assign romram_data_o = DO;
	assign romram_enable_o = ~nMREQ & ((u_rom_e & romflags_i[romsel_o]) | l_rom_e | u_ram_e);
	assign romram_rd_o = ~nMEMRD;
	assign romram_wr_o = ~nMEMWR;
	
	// Extended RAM, including 4M expansion	
	assign ram_page = ( ramsel_o[8] ) ? ramsel_o[7:0] : 
							5'd0;	// TODO: More!!!
	// Rules for paging in extended RAM
	assign u_ram_e = ~nMREQ & 
						(ramsel_o[8] & (A[15:14] == 2'b01));

	// Module connections =========================================================================
	
	// Simulation branches and control ============================================================
	
	// Other logic ================================================================================
//	always @(negedge clk_16)
//		BUSWAIT <= (u_rom_e & ~romram_valid_i) && (romsel_o != 5'd0) && romflags_i[romsel_o];	// TODO: Removed
	
	// Record the ROM address
	//always @(negedge clk_16)
	assign	romram_addr_o = {1'd0, u_rom_e | l_rom_e, (u_rom_e) ? {2'b00, romsel_o} : (l_rom_e) ? 8'h40 : ram_page, A[13:0]};
// TODO:WAS		romram_addr_o <= {1'd0, u_rom_e, (u_rom_e) ? {2'b00, romsel_o} : ram_page, A[13:0]};
//TODO:HERE - LOOK AT ME - LAST CHANGE 20181125
	
//	tv80s cpu(
	tv80n cpu(
		// Clock and reset control
		.clk(clk_4),
		.reset_n( nreset_i ),
		// System lines
		.int_n(cpu_int),
		.nmi_n(1'b1),
		.busrq_n(1'b1),
		.wait_n(1'b1/*~BUSWAIT*/),	// TODO: Removed wait - will this work?????
		// Data and address lines
		.di(DI),
		.dout(DO),
		.A(A),
		// control  lines
		.wr_n(nWR),
		.rd_n(nRD),
		.mreq_n(nMREQ),
		.iorq_n(nIORQ),
		.m1_n(nM1),
		.rfsh_n(),
		.halt_n(),
		.busak_n()
		);
/*
// TODO: Debug module - check romram stability
wire mrq = ~nMREQ & ~nRD;
reg [15:0] startA;
reg [7:0] startD;
reg faultA = 0, faultD = 0;
always @(negedge nMREQ) startA <= A;
always @(posedge romram_valid_i) startD <= DI;

assign debug_trigger_o[0] = faultA;
assign debug_trigger_o[1] = faultD;

always @(posedge nMREQ) if(startA != A) faultA = 1'b1; else faultA = 1'b0;
always @(negedge mrq) if(startD != DI) faultD = 1'b1; else faultD = 1'b0;
// END TODO		
*/		/*
	reg track_memrd, track_valid;
	wire memrd_rise, valid_rise;
	wire memrd = ~nMREQ & ~nRD;
	assign memrd_rise = ({track_memrd,memrd} == 2'b01);
	assign valid_rise = ({track_valid,(memrd_rise) ? 1'b0 : romram_valid_i } == 2'b01);
	
	always @(posedge clk_16) track_memrd <= memrd;
	always @(posedge clk_16) track_valid <= (memrd_rise) ? 1'b0 : romram_valid_i;
		
	always @(negedge clk_16) if( valid_rise ) ramrom_D_store <= romram_data_i;
assign debug_trigger_o[0] = memrd_rise;
assign debug_trigger_o[1] = valid_rise;
	*/
	// Data bus arbiter, data latched on falling edge
	dat_i_arbiter di_arbiter(
		.clock_i( clk_16 ),
		.D( DI ),
		// LROM
		.l_rom(/*ramrom_D_store*/romram_data_i),
		.l_rom_e(l_rom_e),
		// UROM
		.u_rom(u_rom_o),
		.u_rom_e(u_rom_e),
		// Extended RAM
		.eram(/*ramrom_D_store*/romram_data_i),
		.u_ram_e(u_ram_e),
		// RAM
		.ram(ram_o),
		.ram_e(ram_e),
		// PIO
		.pio8255(D8255_o),
		.pio8255_e( /*~nIORD &*/ D8255_e ),
		// Printer
		.io(Dpio),
		.io_e(/*~nIORD &*/ printer_port_e),
		// FDC
		.fdc(fdc_o),
		.fdc_e(/*~nIORD &*/ fdc_e)
		);
		
	// Arbiter rules
	assign ram_e = ~nMREQ; //~nMEMRD;
	assign l_rom_e = (A[15:14] == 2'b00) && (nROMEN == 0) && ram_e;
	assign u_rom_e = (A[15:14] == 2'b11) && (nROMEN == 0) && ram_e;
	assign fdc_e = (A[15:1] == (16'hfb7f>>1)) && ~nIORD;
	
	// CPC Ram
	dpram cpc_ram(
		.address_a(A),
		.address_b(video_A_o),
		.data_a(DO),
		.data_b(8'b0),
		.clock_a(clk_16),
		.clock_b(video_clk_i),
		.wren_a(nMEMWR == `LO),
		.wren_b(1'b0),
		.q_a(ram_o),
		.q_b(video_D_o)
		);	
/*
	// Fast ROM - Default to CPC464+Basic1.0
	rom_builtin	rom_builtin (
	.rdclock ( clk_16 ),
	.rdaddress ( {~l_rom_e,A[13:0]} ),
	.q ( l_rom_o ),
	// Write port for replacement of ROM - TODO: Write New Rom
	.wrclock ( 1'b0 ),
	.wraddress ( 15'd0 ),
	.wren ( 1'b0 ),
	.data ( )
	);
*/	
	// Rom data if not rom zero
	assign u_rom_o = 	(romflags_i[romsel_o]) ? /*ramrom_D_store*/romram_data_i : 8'hff; 
	
	// CRTC 6845
	reg crtc_e = 1'b1;
	always @(negedge clk_1) crtc_e <= (nIORD & nIOWR);
	crtc6845 crtc(
		.I_CLK(clk_1),
		.I_RSTn(nreset_i),
		.I_CSn(A[14]),
		.I_RWn(A[9]),
		.I_RS(A[8]),
		.I_E(!(nIORD & nIOWR)/*crtc_e*/),
		.I_DI(DO),
		.O_RA(RA), 
		.O_MA(MA), 
		// TODO: Fix this
		.O_H_SYNC(hsync_signal), 
		.O_V_SYNC(vsync_signal), 
		.O_DISPTMG(),
		.video_offset_o(video_offset_o)
		);

	// Amstrad gate array emulator	
	a40010 gate_array (
		.nreset_i(nreset_i),
		.clk_i(clk_16),
//		.slowclk_i(clk_1),
		.a_i(A),
		.d_i( DO ),
		.dv_i( video_D_o ),
		.nWR_i(nWR),
		.nRD_i(nRD),
		.nMREQ_i(nMREQ),
		.nIORQ_i(nIORQ),
		.nM1(nM1),			// TODO: Added to enable lower rom on int ack
		.nint_o(cpu_int),
		.nROMEN_o(nROMEN),
		.romsel_o(romsel_o[5:0]),
		.ramsel_o(ramsel_o),
		.video_pixel_i(pixel_num),
		.border_i(video_border),
		.color_dat_o(color_dat),
		.vsync_i(vsync_signal),
		.hsync_i(hsync_signal)
		);

// Fake Keyboard Handler
assign ppia_i = (ppic_o[3:0] == 4'd0) ? keyboard_i[7:0] :
					 (ppic_o[3:0] == 4'd1) ? keyboard_i[15:8] :
					 (ppic_o[3:0] == 4'd2) ? keyboard_i[23:16]:
					 (ppic_o[3:0] == 4'd3) ? keyboard_i[31:24] :
					 (ppic_o[3:0] == 4'd4) ? keyboard_i[39:32] :
					 (ppic_o[3:0] == 4'd5) ? keyboard_i[47:40] :
					 (ppic_o[3:0] == 4'd6) ? keyboard_i[55:48] :
					 (ppic_o[3:0] == 4'd7) ? keyboard_i[63:56] :
					 (ppic_o[3:0] == 4'd8) ? keyboard_i[71:64] :
					 (ppic_o[3:0] == 4'd9) ? keyboard_i[79:72] :
						8'd255;

	// Fake PPIO - fixed directional ports
	ppi_fake ppi8255(
		.nreset_i(nreset_i),
		.clk_i(clk_16),
		.nCS_i(A[11]),
		.a0(A[8]),
		.a1(A[9]),
		.nIORD_i(nIORD),
		.nIOWR_i(nIOWR),
		.d_i(DO),
		.d_o(D8255_o),
		.a_i(ppia_i),
		.a_o(ppia_o),
		.b_i({7'd127,vsync_signal}),	// Tape in, printer busy, ~EXP pin, 4xManufacturer, syncin
		.c_o(ppic_o)	
		);

// HDMI Module driver
/*
hdmi_video video(
	.CLOCK_50_i(CLOCK_50_B6A),
	.reset_i( !nreset_i ),
	.hdmi_clk_o(HDMI_TX_CLK),
	.hdmi_de_o(HDMI_TX_DE),
	.hdmi_vs_o(HDMI_TX_VS),
	.hdmi_hs_o(HDMI_TX_HS),
	.hdmi_d_o(HDMI_TX_D),
	.a_o(Av),
	.vram_clk_o(vram_clk),
	.color_dat_i(color_dat),
	.video_pixel_o(pixel_num),
	.border_o(video_border),
	.video_offset_i(video_offset)
	);

*/	
`ifndef SIM
// Sound / keyboard module	
YM2149 sounddev(
  // data bus
  .I_DA(ppia_o),			// Output only, keyboard doesn't go through the sound module
  .O_DA(),
  .O_DA_OE_L(),
  // control
  .I_A9_L(`LO),			// Not used
  .I_A8(`HI),				// Not used
  .I_BDIR(ppic_o[7]),
  .I_BC2(`HI),
  .I_BC1(ppic_o[6]),
  .I_SEL_L(`HI),			// Default - clock divisor select - none

  .O_AUDIO(audio_o),
  // port a
  .I_IOA(8'hff),
  .O_IOA(),
  .O_IOA_OE_L(),
  // port b
  .I_IOB(8'hff),
  .O_IOB(),
  .O_IOB_OE_L(),
  //
  .ENA(`HI),          // Check this clock enable for higher speed operation
  .RESET_L(nreset_i),
  .CLK(clk_1)
  );
`endif

	// FDC Logic
	fdc floppy (
		// CPC Interface
		.clk_i(clk_4),
		.reset_i(~nreset_i),
		.enable_i(A[15:1] == (16'hfb7f>>1)),
		.data_i(DO),
		.data_o(fdc_o),
		.regsel_i(A[0]),
		.rd_i(!nIORD),
		.wr_i(!nIOWR),
		.activity_o(fdc_activity),
		.motor_i(fdc_motor),
		// Drive interface
		.sup_clk_i(S_clk_i),
		.A(S_A_i),
		.D_i(S_D_i),
		.D_o(S_D_o),
		.sup_rd_i(S_rd_i),
		.sup_wr_i(S_wr_i),
		.sup_enable_i(S_enable_i),
		.sup_int_o(S_fdc_int_o)	// Interrupt		
	);


	// Motor control
	reg [1:0] track_motor_rise = 2'd0;

	always @(posedge clk_16)
		track_motor_rise = {track_motor_rise[0], !nIOWR && (A[15:0] == 16'hfa7e)};
	
	wire motor_rise = (track_motor_rise == 2'b01);
	
	always @(negedge clk_16)
		if( motor_rise ) fdc_motor <= DO[0];

endmodule

