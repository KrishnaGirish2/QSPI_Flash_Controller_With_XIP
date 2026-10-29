class qspi_sequencer extends uvm_sequencer #(output_seq_item);
	`uvm_component_utils(qspi_sequencer)
	function new(string name="qspi_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction
endclass
