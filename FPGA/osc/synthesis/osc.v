// osc.v

// Generated using ACDS version 14.0 200 at 2016.12.29.18:16:41

`timescale 1 ps / 1 ps
module osc (
		input  wire  oscena, // oscena.oscena
		output wire  clkout  // clkout.clkout
	);

	osc_int_osc_0 int_osc_0 (
		.oscena (oscena), // oscena.oscena
		.clkout (clkout)  // clkout.clkout
	);

endmodule
