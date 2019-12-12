//  `include "building_blocks/mem.sv"

module top(input  logic        clk, reset, 
           output logic [31:0] writedata, dataadr, 
           output logic [1:0]  memwrite,
           output logic half,b,bunsigned);

  logic [31:0] pc, instr, readdata;
  
  // instantiate processor and memories
  mips mips(clk, reset, pc, instr, memwrite,half,b,bunsigned, dataadr, 
            writedata, readdata);
  imem imem(pc[7:2], instr);
  dmem dmem(clk, memwrite,hlaf,b,bunsigned, dataadr, writedata, readdata);
endmodule

