//  `include "building_blocks/flopers.sv"
//  `include "decoders/*"
// //  `include "decoders/maindec.sv"

module controller(input   logic        clk, reset,
                  input   logic  [5:0] opD, functD,
                  input   logic        flushE, equalD, nequalD,
                  output  logic        memtoregE, memtoregM, 
                  output  logic        memtoregW,
                  output  logic  [1:0] ls_ctrlM,
                  output  logic        memwriteM,
                  output  logic        pcsrcD, branchD, bneD, alusrcE,
                  output  logic       regdstE, regwriteE, 
                  output  logic       regwriteM, regwriteW,
                  output  logic       jumpD, extendD,
                  output  logic [2:0] alucontrolE);
				  
 logic       memtoregD, ls_ctrlD ,memwriteD, alusrcD,
            regdstD, regwriteD;
 logic [2:0] alucontrolD;
 logic       memwriteE;
 logic [1:0] aluopD, ls_ctrlE;

 maindec md(opD, memtoregD, ls_ctrlD ,memwriteD, branchD, bneD,
            alusrcD, regdstD, regwriteD, jumpD, extendD,
            aluopD);
 aludec  ad(functD, aluopD, alucontrolD);
 assign pcsrcD = (branchD & equalD) | (bneD & nequalD);
 
 // pipeline registers
 floprc #(10) regE(clk, reset, flushE,
                 {memtoregD, ls_ctrlD, memwriteD, alusrcD, 
                  regdstD, regwriteD, alucontrolD}, 
                 {memtoregE, ls_ctrlE, memwriteE, alusrcE, 
                  regdstE, regwriteE,  alucontrolE});
 flopr #(3) regM(clk, reset, 
                 {memtoregE, ls_ctrlE,memwriteE, regwriteE},
                 {memtoregM, ls_ctrlM,memwriteM, regwriteM});
 flopr #(2) regW(clk, reset, 
                 {memtoregM, regwriteM},
                 {memtoregW, regwriteW});
endmodule

