//MONITOR
class adder_monitor extends from uvm_monitor;
	`uvm_component_utils(adder_monitor)
	
//Declare an analysis port for sending txn
uvm_analysis_port#(normal_adder_txn) mon_a_port_before;

normal_adder_txn xtn;
virtual dut_if1 dut_vif;

function new(string name = "adder_monitor", uvm_component parent);
	super.new(name, parent);
endfunction

function build_phase(uvm_phase phase);
		super.build_phase(phase);
		mon_a_port_before = new("mon_a_port_before", this);
		
//Get the viratual interface setted in the tb_top		
if(!(uvm_config_db#(viratual dut_if1)::get(this,"","dut_vif",dut_vif))
	`uvm_error("", "Monitor is unable to get the interface")
	end
	endfunction : build_phase
	
//Get the txn and send to the analysis component

task run_phase(uvm_phase phase);

addr_txn = normal_adder_txn::type_id::create("xtn",this);
forever begin
//Wait for the change in the signals a_in, b_in and c_in
@(dut_vif.a_in, dut_vif.b_in, dut_vif.c_in) begin
//Populate the txn item with the signal values
xtn.a_in = dut_vif.a_in;
xtn.b_in = dut_vif.b_in;
xtn.c_in = dut_vif.c_in;
xtn.sum_out = dut_vif.sum_out;
xtn.carry_out = dut_vif.carry_out;

mon_a_port_before.write(xtn);
end  end  endtask : run_phase
endclass
