module mips(input  logic        clk, reset,
            output logic [31:0] pcF,
            input  logic [31:0] instrF,
<<<<<<< HEAD
            output logic [1:0]  memwriteM,
            output logic halfM,bM,bunsignedM,
=======
            output logic [1:0] ls_ctrlM,
            output logic        memwriteM,
>>>>>>> 0bde0b2add8ea3748d1a29d6545d2bc7ed3b6a35
            output logic [31:0] aluoutM, writedataM,
            input  logic [31:0] readdataM);
			
 logic [5:0]  opD, functD;
 logic        regdstE, alusrcE, 
             pcsrcD,
             memtoregE, memtoregM, memtoregW, 
             regwriteE, regwriteM, regwriteW;
 logic [2:0]  alucontrolE;
 logic        flushE, equalD, nequalD;
 
 controller c(clk, reset, opD, functD, flushE, 
              equalD, nequalD, memtoregE, memtoregM, 
<<<<<<< HEAD
              memtoregW, memwriteM, halfM,bM,bunsignedM,pcsrcD, 
=======
              memtoregW, ls_ctrlM, memwriteM , pcsrcD, 
>>>>>>> 0bde0b2add8ea3748d1a29d6545d2bc7ed3b6a35
              branchD, bneD, alusrcE, regdstE, regwriteE,
              regwriteM, regwriteW, jumpD, extendD,
              alucontrolE);
			  
 datapath dp(clk, reset, memtoregE, memtoregM, 
             memtoregW, pcsrcD, branchD, bneD,
             alusrcE, regdstE, regwriteE, 
             regwriteM, regwriteW, jumpD, extendD,
             alucontrolE,
             equalD, nequalD, pcF, instrF,
             aluoutM, writedataM, readdataM,
             opD, functD, flushE,halfM ,bM,bunsignedM);
endmodule
