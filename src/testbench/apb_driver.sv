class apb_driver extends uvm_driver #(seq_item);
  `uvm_component_utils(driver)
  virtual qspi_controller_if.apb_drv vif;
  config m_cfg;
  function new(string name="apb_driver", uvm_component parent=null);
 
    super.new(name,parent);
 
  endfunction
  function void build_phase(uvm_phase phase);
 
    super.build_phase(phase);
    if(!uvm_config_db#(config)::get(
 
        this,"","m_cfg",m_cfg))
 
      `uvm_fatal("APB Driver","APB Driver failed")
 
  endfunction
  task run_phase(uvm_phase phase);
 
    forever begin
 
      seq_item_port.get_next_item(req);
 
      drive_apb(req);
 
      seq_item_port.item_done();
 
    end
 
  endtask

  task drive_apb(seq_item tr);
 
    @(vif.apb_drv_cb);
    vif.apb_drv_cb.PSEL<=1'b0;
 
    vif.apb_drv_cb.PENABLE <= 1'b0;
 
    vif.apb_drv_cb.PWRITE  <= tr.PWRITE;
 
    vif.apb_drv_cb.PSTRB   <= tr.PWRITE ? tr.PSTRB : 4'b0000;
 
    vif.apb_drv_cb.PADDR   <= tr.PADDR;
 
    vif.apb_drv_cb.PWDATA  <= tr.PWDATA;
    if(tr.PWRITE) begin
        case(req.PADDR) 
            8'h04: begin
                uvm_config_db #(bit [16:0])::set(this,"*","control",tr.PWDATA[16:0]);
                if(tr.PWDATA[0])
                    uvm_config_db #(bit)::set(this,"*","apb_start",1);
            end
            8'h14: begin
                uvm_config_db #(bit [7:0])::set(this,"*","dummy",tr.PWDATA[7:0]);
            end
            8'h18: begin
                uvm_config_db #(bit [7:0])::set(this,"*","dummy",tr.PWDATA[7:0]);
            end
        endcase
    end

    @(vif.apb_drv_cb);
    vif.apb_drv_cb.PSEL<=1'b1;
    @(vif.apb_drv_cb);
    vif.apb_drv_cb.PENABLE<=1'b1;
    do begin
 
      @(vif.apb_drv_cb);
 
    end while(vif.apb_drv_cb.PREADY !== 1'b1);
 
    vif.apb_drv_cb.PSEL    <= 1'b0;
 
    vif.apb_drv_cb.PENABLE <= 1'b0;
  endtask
 
 
  endtask
  
endclass

