//SEQUENCES

class normal_adder_seq extends uvm_sequence#(normal_adder_txn);
  `uvm_object_utils(normal_adder_seq)
  
 function new(string name = "normal_adder_seq");
	super.new(name);
endfunction 

virtual task body();
	normal_adder_seq add_txn1;   //Declare the instance of the adder_txn
	repeat(8) begin
	add_txn1 = normal_adder_seq::type_id::create("add_txn1");
	
	//Start the txn item
	start_item(add_txn1);  //thinking that dirver has already asked using req through seqr
	
	//Randomize the txn
	assert(add_txn1.randomize());
	finish_item(req);
	endtask
endclass   //end of the seq
