class qspi_virtual_sequence extends uvm_sequence #(seq_item);
    apb_CONTROL_FILL_sequence control_write;
    apb_CONTROL_READ_sequence control_read;
    `uvm_object_utils(qspi_virtual_sequence)
    `uvm_declare_p_sequencer(virtual_sequencer)
    function new(string name="qspi_virtual_sequence");
        super.new(name);
    endfunction
    task body();
        `uvm_info(get_type_name(),
                  "qspi_virtual_sequence: Inside Body",
                  UVM_LOW);
        control_write =apb_CONTROL_FILL_sequence::type_id::create("control_write");
        control_read =apb_CONTROL_READ_sequence::type_id::create("control_read");
        control_write.start(p_sequencer.seqr_apb);
        control_read.start(p_sequencer.seqr_apb);
    endtask
endclass
