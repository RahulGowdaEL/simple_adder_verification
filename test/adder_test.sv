//TEST Case	
		
	`include "normal_add_env.sv"	
class normal_add_test extends uvm_test;
	`uvm_component_utils(normal_add_test)
	
//declare instance of env and seq	
normal_add_env add_test_env;
normal_add_sequence seq_txn1;

function new(string name = "normal_add_test", uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase)
	super.build_phase(phase);
	
	// Create an instance of the enviroment
	add_test_env = normal_add_env::type_id::create("add_test_en", this);
	endfunction

task run_phase(uvm_phase phase);
   phase.raise_objection(this);  
   seq_txn1 = normal_add_sequence::type_id::create("seq_txn1", this); 
   seq_txn1.start(add_test_env.agent.add_seq);  //Start the seq on the seqr within the agent 
   phase.drop_objection(this);   //Drop objection to allow the simulation to proceed

   phase.phase_done.set_drain_time(this, 50);
   endtask
endclass   
