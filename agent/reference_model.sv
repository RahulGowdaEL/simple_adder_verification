//REF MONITOR

class ref_monitor_after extends uvm_monitor;
   `uvm_component_utils(ref_monitor_after)

normal_adder_txn xtn;  
virtual dut_if1 dut_vif;

uvm_analysis_port#(normal_adder_txn) ref_monitor_after;

function new(string name = "ref_monitor_after", uvm_component);
	super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db#(virtual dut_if1)::get(this, "", "dut_vif", dut_vif)
			`uvm_error("", "Unable to get th inferace at ref monitor")
			ref_monitor = new("ref_monitor_after", this);
endfunction		
	
task run_phase(uvm_phase phase);
xtn = normal_adder_txn::type_id::create("xtn");

forever begin
@(dut_vif.a_in, dut_vif.b_in, dut_vif.c_in) begin
xtn.a_in = dut_vif.a_in;
xtn.b_in = dut_vif.b_in;
xtn.c_in = dut_vif.c_in;

//Calculate ref result and update the txn item
add_mon_ref_add_result();

ref_mon_a_after.write(add_mon_ref_xtn);
end
end
endtask : run_phase

virtual function void add_mon_ref_add_result();
bit[1:0] sum_res;
sum_res = add_mon_ref_txn.a_in + add_mon_ref_txn.b_in + add_mon_ref_txn.c_in;

//Update the txn item with the calculatd sum and carry output
add_mon_ref_xtn.sum_out = sum_res[0];
add_mon_ref_txn.carry_out = sum_res[1];
endfunction
endclass
