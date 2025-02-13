class normal_adder_txn extends uvm_sequence_item;
`uvm_object_utils(normal_adder_txn)

function new(string name = "normal_adder_txn");
	super.new(name);
endfunction

//Randomization variables fro the transaction
rand bit a_in, b_in, c_in;
bit sum_out;
bit carry_out;

//UVM macros to print the info

/* `uvm_object_utils_begin(normal_adder_txn)
	`uvm_field_int(a_in, UVM_ALL_ON);
	`uvm_field_int(b_in, UVM_ALL_ON);
	`uvm_field_int(sum_out, UVM_ALL_ON); */
	
endclass
