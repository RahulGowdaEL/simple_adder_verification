//Package

`include "normal_adder_seq";
`include "adder_monitor";
`include "adder_driver";
`inclde "adder_seqr";

//Agent
class normal_add_agent extends uvm_agent;
	`uvm_component_utils(normal_add_agent)
	//declare analysis port for sending txn to analysis component
uvm_analysis_port#(normal_adder_txn) agent_a_port_before;
uvm_analysis_port#(normal_adder_txn) agent_a_port_after;	

//declare instance of seqr, monitor, and driver
normal_add_seqr add_seqr;
normal_addr_monitor_before add_mon_before;
normal_addr_monitor_after  add_mon_after;
normal_add_driver  addr_driver;

function new(string name = "normal_add_agent", uvm_component parent);
	super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		add_seqr = normal_add_seqr::type_id::create("add_seqr", this);
		add_mon_before = normal_addr_monitor_before::::type_id::create("normal_addr_monitor_before", this);
		add_mon_after = normal_addr_monitor_after::::type_id::create("normal_addr_monitor_after", this);
		add_driver = normal_add_driver::type_id::create("add_driver", this);
		
		//create analysis port for sending txn
		agent_a_port_before = new("agent_a_port_before",  this);
		agent_a_port_after = mew("agent_a_port_after", this);
endfunction

function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		add_driv.seq_item_port.connect(add_seq.seq_item_port)  //connecting drv to seqr
		add_mon_before.mon_a_port_before.connect(agent_a_port_before);
		//connect ref monitor to the ref analysis port 
		add_mon_ref_after.ref_mon_a_after.connect(ref_agent_a_port_after);
		endfunction
	endclass
