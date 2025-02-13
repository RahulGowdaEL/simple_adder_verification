//Driver

class adder_driver extends uvm_driver#(normal_adder_txn);
	`uvm_component_utils(adder_driver)

virtual dut_if1 dut_vif;

function new(string name = "adder_driver", uvm_component parent);
	super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (!(uvm_config_db#(virtual dut_if1)::get(this, "", "dut_vif", dut_vif))
		`uvm_error("", "uvm_config_db::get failed")
endfunction	: build_phase

task run_phase(uvm_phase phase);
normal_adder_txn txn;
//Assert and de-assert reset signals
dut_vif.reset = 1;
#5 dut_vif.reset = 0;

forever begin
//req for the trxn as long as seqr gives from seqr
seq_item_port.get_next_item(addr_txn);

dut_vif.a_in = addr_txn.a_in;
dut_vif.b_in = addr_txn.b_in; 
dut_vif.c_in = addr_txn.c_in;

//Notify the seqr that each time a txn was forwarded it's done driving.
seq_item_port.item_done();
end
endtask
endclass : adder_driver
