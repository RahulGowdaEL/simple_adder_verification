//DUT design description

module normal_adder(dut_if1 dut_if);
`include "uvm_macros.svh"

always_comb begin
	if(dut_if.reset)  begin
	dut_if.sum_out = 0;
	dut_if.carry_out = 0;
	end
	else begin
	dut_if.sum_out = (dut_if.a_in ^ dut_if.b_in ^dut_if.c_in);
	dut_if.carry_out = ((dut_if.a_in & dut_if.b_in) | (dut_if.b_in & dut_if.c_in) | (dut_if.c_in & dut_if.a_in));
	
	$display("The value of a_in=%0d, b_in=%0d, dut_if.c_in, dut_if.sum_out, dut_if.carry_out);
	end
endmodule
