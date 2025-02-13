module adder_testbench;
import uvm_pkg::*;

dut_if1 intf1();  //as it's a static need to pass in dynamic (obj type) testbench

normal_adder dut_tb(.dut_if(intf1));

initial begin
	uvm_config_db#(virtual dut_if1)::set(null, "*", "dut_vif", intf1);
	run_test("normal_adder_test");
	end
	
	initial begin
	intf1.clock = 1 ;
	inf1.reset = 1;
	end
	
	//Toggle every 5time units
	initial  begin
	   forever #5 inf1.clock = ~inf1.clock;
	   end
	   
	initial begin
		$dumpfile("dump.vcd");
		$dumpvars(0, normal_addr);
		end
endmodule : testbench
