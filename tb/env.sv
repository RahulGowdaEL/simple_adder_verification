//ENV
`include "normal_add_agent.sv";
`include "normal_add_score.sv";

class normal_add_env extends uvm_env;
`uvm_component_utils(normal_add_env)

normal_add_agent agent;
normal_add_score scoreboard;

function new(string name = "normal_add_env", uvm_component parent);
	super.new(name, parent);
endfunction

agent = normal_add_agent::type_id::create("agent", this);
scoreboard = normal_add_score::type_id::create("scoreboard"	, this);
endfunction : build_phase

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	agent.agent_a_port_before.connect(scoreboard.add_sc_before);
	agent.agent_a_port_after.connect(scoreboard.add_sc_after);
	endfunction : connect_phase
endclass : normal_add_env
