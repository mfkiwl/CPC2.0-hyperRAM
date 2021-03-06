/*
 * super_memory_if - interface between the memory and 
 * the data bus of the supervisor CPU
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

module support_memory_if //#( parameter wp_address = 0 )
(
	input clk,
	input [7:0] wp_address,		// Upper 8-bits of non-write protected space
	// ============= Internal support Ram =============
	input [15:0] 	support_A,
	input [7:0] 	support_Din,
	output [7:0] 	support_Dout,
	input 			support_wr,
	// ============= Internal support Ram - Write interface =============
	input				sys_en,
	input [15:0] 	sys_A,
	input [7:0] 	sys_data,
	input 			sys_wr
);

	wire allow_write = (support_A[15:8] >= wp_address);
	
	wire [15:0] adr;
	wire [7:0]	dat;
	wire			wr;
	
	assign adr = (sys_en) ? sys_A : support_A;
	assign dat = (sys_en) ? sys_data : support_Din;
	assign wr = (sys_en) ? sys_wr : support_wr;

//	Single port RAM
	ram support_core_memory (
		.address(adr),
		.clock(clk),
		.data(dat),
		// Write protect doesn't apply to system interface
		.wren(wr & (allow_write | sys_en)),	
		.q(support_Dout)
		);	
endmodule
