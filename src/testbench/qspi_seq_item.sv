class seq_item extends uvm_sequence_item;

  `uvm_object_utils(seq_item)

  function new(string name="qspi_seq_item");
    super.new(seq_item)
  endfunction
  //////////////////////////////////////APB//////////////////////////
  rand bit PSEL;
  rand bit PENABLE;
  rand bit PWRITE;
  rand bit [`APB_STRB-1:0]PSTRB;
  rand bit [`APB_ADD-1:0]PADDR:
  rand bit [`APB_DATA-1:0]PWDATA;

  bit [`APB_DATA1-1:0]PRDATA;
  bit PREADY;
  bit PSLVERR;

  ///////////////////////////////AHB/////////////////////////////////
  rand bit HSEL;
  rand bit [`AHB_ADD-1:0]HADDR;
  rand bit [1:0]HTRANS;
  rand bit HWRITE;
  rand bit [`AHB_TRANFER_SIZE-1:0]HSIZE;
  rand bit [2:0]HBURST;
  rand bit [`AHB_DATA-1:0]HWDATA;
  rand bit HREADY;

  bit [`AHB_DATA-1:0]HRDATA;
  bit HREADYOUT;
  bit [1:0]HRESP;

  ///////////////////////////OTHER/////////////////////////
  rand bit xip_en;
  
  bit spi_cs_n;
  bit spi_sclk;
  
  rand bit [`IO_WIDTH-1:0]Io; 
  
endclass
