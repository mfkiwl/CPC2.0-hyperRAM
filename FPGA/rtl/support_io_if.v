/*
 * super_io_if - interface between the cpu and 
 * up to 16 devices. Essentially a big switch :)
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

module support_io_if(
	// CPU Interface
	input 			clk_i,
	input [7:0] 	A_i,
	input [7:0] 	D_i,
	output [7:0] 	D_o,
	input				nrd_i,
	input				nwr_i,
	input				niorq_i,
	// IO Interface
	output			clk_o,
	output [3:0]	A_o,
	output [15:0]	nrd_o,		// One read line per device
	output [15:0]	nwr_o,		// One write line per device
	output [7:0]	io_o,		// Shared data out
	input [8*16-1:0] io_i	// Merged data path - 16 streams
);

	// Wire definitions ==================================================
	wire io_nwr, io_nrd;
	wire [3:0] a_decode, b_decode;
	wire [15:0] four_to_sixteen;
	
	// Registers ==================================================
	
	// Assignments ==================================================
	assign clk_o = clk_i;	// Passthrough
	assign io_nwr = niorq_i | nwr_i;
	assign io_nrd = niorq_i | nrd_i;
	assign a_decode = A_i[7:4];
	assign b_decode = A_i[3:0];
	assign io_o = D_i;
	// 4-16 line converter
	assign four_to_sixteen = {
				(a_decode != 4'd15),
				(a_decode != 4'd14),
				(a_decode != 4'd13),
				(a_decode != 4'd12),
				(a_decode != 4'd11),
				(a_decode != 4'd10),
				(a_decode != 4'd9),
				(a_decode != 4'd8),
				(a_decode != 4'd7),
				(a_decode != 4'd6),
				(a_decode != 4'd5),
				(a_decode != 4'd4),
				(a_decode != 4'd3),
				(a_decode != 4'd2),
				(a_decode != 4'd1),
				(a_decode != 4'd0)
			};
	assign nwr_o = (io_nwr) ? 16'hffff : four_to_sixteen;
	assign nrd_o = (io_nrd) ? 16'hffff : four_to_sixteen;
	assign A_o = b_decode;		// Pass low bits
	assign D_o = (!four_to_sixteen[0]) ? io_i[16*8-1:15*8] :
					 (!four_to_sixteen[1]) ? io_i[15*8-1:14*8] :
					 (!four_to_sixteen[2]) ? io_i[14*8-1:13*8] :
					 (!four_to_sixteen[3]) ? io_i[13*8-1:12*8] :
					 (!four_to_sixteen[4]) ? io_i[12*8-1:11*8] :
					 (!four_to_sixteen[5]) ? io_i[11*8-1:10*8] :
					 (!four_to_sixteen[6]) ? io_i[10*8-1:9*8] :
					 (!four_to_sixteen[7]) ? io_i[9*8-1:8*8] :
					 (!four_to_sixteen[8]) ? io_i[8*8-1:7*8] :
					 (!four_to_sixteen[9]) ? io_i[7*8-1:6*8] :
					 (!four_to_sixteen[10]) ? io_i[6*8-1:5*8] :
					 (!four_to_sixteen[11]) ? io_i[5*8-1:4*8] :
					 (!four_to_sixteen[12]) ? io_i[4*8-1:3*8] :
					 (!four_to_sixteen[13]) ? io_i[3*8-1:2*8] :
					 (!four_to_sixteen[14]) ? io_i[2*8-1:1*8] :
					 (!four_to_sixteen[15]) ? io_i[1*8-1:0*8] :
					 8'hff;
	// Module connections ==================================================
	
	// Simulation branches and control ==================================================
	
	// Other logic	==================================================
	
endmodule
