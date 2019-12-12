//  `include "building_blocks/flopers.sv"
//  `include "decoders/*"
// //  `include "decoders/maindec.sv"

module controller(input   logic         clk, reset,
                  input   logic  [5:0]  opD, functD,
                  input   logic         flushE, equalD, nequalD,
                  output  logic         memtoregE, memtoregM, 
                  output  logic         memtoregW, 
                  output  logic  [1:0]  memwriteM,
                  output logic          halfM , bM,bunsignedM,
                  output  logic         pcsrcD, branchD, bneD, alusrcE,
                  output  logic         regdstE, regwriteE, 
                  output  logic         regwriteM, regwriteW,
                  output  logic         jumpD, extendD,
                  output  logic  [2:0]  alucontrolE);
				  
logic [1:0] aluopD;
logic       memtoregD, alusrcD,
            regdstD, regwriteD;
logic [1:0] memwriteD;
logic halfD, bD,bunsignedD; 
logic [2:0] alucontrolD;

logic [1:0] memwriteE;
logic halfE , bE,bunsignedE;
maindec md(opD, memtoregD, memwriteD,halfD,bD,bunsignedD, branchD, bneD,
            alusrcD, regdstD, regwriteD, jumpD, extendD,
            aluopD);
 aludec  ad(functD, aluopD, alucontrolD);
 assign pcsrcD = (branchD & equalD) | (bneD & nequalD);
 
 // pipeline registers
 floprc #(12) regE(clk, reset, flushE,
                 {memtoregD, memwriteD, halfD,bD,bunsignedD,alusrcD, 
                  regdstD, regwriteD, alucontrolD}, 
                 {memtoregE, memwriteE, hlafE,bE,bunsignedE, alusrcE, 
                  regdstE, regwriteE,  alucontrolE});
 flopr #(7) regM(clk, reset, 
                 {memtoregE, memwriteE,hlafE,bE,bunsignedE, regwriteE},
                 {memtoregM, memwriteM,halfM,bM, bunsignedM, regwriteM});
 flopr #(2) regW(clk, reset, 
                 {memtoregM, regwriteM},
                 {memtoregW, regwriteW});
endmodule

