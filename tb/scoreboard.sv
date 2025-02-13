//Scoreboard

`uvm_analysis_imp_decl(_before)
`uvm_analysis_imp_decl(_after)

class normal_adder_score extends uvm_scoreboard;
`uvm_component_utils(normal_adder_score);	

function new(string name = "normal_adder_score", uvm_component parent);
	super.new(name, parent);
endfunction

uvm_analysis_export#(normal_adder_txn) add_sc_before;  //used to send txn to the scoreboard
uvm_analysis_export#(normal_adder_txn) add_sc_after;
	
//declare tlm fifo's to store the xtn
uvm_tlm_analysis_fifo#(normal_adder_txn) add_f_sc;
uvm_tlm_analysis_fifo#(normal_adder_txn) ref_add_tlm_sc;

//Declare transaction variables to store the incoming trxns
normal_adder_txn add_f_before;
normal_adder_txn ref_add_f_after;

function void build_phase(uvm_phase phase);
add_f_before = normal_adder_xtn::type_id::create("add_f_before");
ref_add_f_after = normal_adder_txn::type_id::create("ref_add_f_after");

//Create analysis ports for sending transaction
add_sc_before = new("add_sc_before", this);
add_f_sc = new("add_f_sc", this);
ref_add_sc_after = new("ref_add_sc_after", this);
ref_add_tlm_sc = new("ref_add_tlm_sc", this);
endfunction	

//Connect analysis exports to TLM fifos
function void connect_phase(uvm_phase phase);
	add_sc_before.connect(add_f_sc.analysis_export);
	ref_add_sc_after.connect(ref_add_tlm_sc.analysis_export);
endfunction : connect_phase

task run_phase(uvm_phase phase);
	forever begin
		add_f_sc.get(add_f_before);
		ref_add_tlm_sc.get(ref_add_f_after);
		
		if (add_f_before.sum_out == ref_add_f_after.sum_out)
			`uvm_info("compare", {"Test: PASS"}, UVM_LOW)
		else
			`uvm_info("compare", {"Test: Fail"}, UVM_LOW)
		end
	endtask
endclass : normal_add_score
