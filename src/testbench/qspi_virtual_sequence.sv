class qspi_virtual_sequence extends uvm_sequence#(seq_item);
	apb_write_sequence aws;
	apb_read_sequence ars;
	ahb_read_Sequence ahrs;

	apb_sequencer seqr_apb;
	ahb_sequencer seqr_ahb;
        //qspi_sequencer seqr_qspi_io;
	`uvm_object_utils(qspi_virtual_sequence)
	`uvm_declare_p_sequencer(virtual_sequencer)

	function new(string name="qspi_virtual_sequence");
		super.new(name);
	endfunction

	task body();
		`uvm_info(get_type_name(),"qspi_virtual_sequence:Inside Body",UVM_LOW);
		aws=apb_write_sequence::type_id::create("aws");
		ars=apb_read_sequence::type_id::create("ars");
		ahrs=ahb_read_sequence::type_id::create("ahrs");

		aws.start(p_sequencer.seqr_apb);
		ars.start(p_sequencer.seqr_apb);
		ahrs.start(p_sequencer.seqr_ahb);
	endatsk
endclass
