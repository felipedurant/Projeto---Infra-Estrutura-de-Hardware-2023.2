module CPU (
    input wire clk,
    input wire reset
);

// Control wires
    // sent wires 
        // mux
        wire [1:0] excpControl;
        wire [1:0] iord;
        wire [1:0] excpCtrl;
        wire shiftSrc;
        wire [1:0]shiftAmt;
        wire srcRead;
        wire [2:0] srcWrite;
        wire [3:0] srcData;
        wire [1:0] aluSrcA;
        wire [1:0] aluSrcB;
        wire [2:0] pcSource;
        wire MultDiv;
        wire outAlu;
        

        // other blocks
        
        wire hiControl;
        wire loControl;
        wire control;
        wire multControl;
        wire divControl;
        wire seControl;
        wire memWrite;
        wire [1:0] ssControl;
        wire irWrite;
        wire [1:0] lsControl;
        wire [2:0] shiftControl;
        wire regWrite;
        wire [2:0] aluControl;
        wire aluOutControl;
        wire epcControl;
        wire memRegControl;
        wire aControl;
        wire bControl;
    


// Data wires
    //Data from instruction
    wire [5:0] OPCODE;
    wire [4:0] RT;
    wire [4:0] RS;
    wire [15:0] OFFSET;

    //output wires per block 
        // excpcontrol
        wire [31:0] excpControlOut;

        // pc
        wire [31:0]  pc;

        // iord
        wire [31:0] iordOut;

        //hi/lo register out
        wire [31:0] hi;
        wire [31:0] lo;

        //hi/lo mux out
        wire [31:0] hiOut;
        wire [31:0] loOut;

        // mult
        wire [31:0] multHi;
        wire [31:0] multLo;

        // div
        wire [31:0] divHi;
        wire [31:0] divLo;

        wire [31: 0] aluout;

        // signExtend16
        wire [31:0] signextend16;

        // shiftleft16
        wire [31:0] shiftleft16;

        // excpCtrl
        wire [31:0] excpCtrlOut;

        // extendshiftleft2
        wire [27:0] extendShiftLeft2;

        //SS
        wire [31:0] ss;

        //memory
        wire [31:0] memory;

        //memoryDataRegister
        wire [31:0] memoryDataRegister;

        //shiftSrc
        wire [31:0] shiftSrcOut;

        //shiftAmt
        wire [4:0] shiftAmtOut;

        //shiftReg
        wire [31:0] shiftReg;

        //LS
        wire [31:0] ls;


        //srcRead
        wire [4:0] srcReadOut;

        //srcWrite
        wire [4:0] srcWriteOut;

        //srcData
        wire [31:0] srcDataOut;

        //iShiftLeft2
        wire [31:0] iShiftLeft2;

        //Registers
        wire [31:0] registersData1;
        wire [31:0] registersData2;       

        //ShiftLeft2
        wire [31:0] shiftLeft2;

        //Concat
        wire [31:0] Concat;

        //A
        wire [31:0] a;

        //B
        wire [31:0] b;

        //aluSrcA
        wire [31:0] aluSrcAOut;

        //aluSrcB
        wire [31:0] aluSrcBOut;

        //ALU
        wire zero;
        wire LT;
        wire [31:0] result;
        wire EQ;
        wire GT;
        wire O;
        wire neg;

        //signExtend1
        wire [31:0] signExtend1;

        //ALUOut
        wire [31:0] ALUOut;

        //EPC
        wire [31:0] EPC;

        //pcSource
        wire [31:0] pcSourceOut;

        //Exception
        wire notFound;
        wire div0;
// instantiate mux
    Mux_ExcpControl mux_excp_control(
        32'b00000000000000000000000011111101, 32'b00000000000000000000000011111110, 32'b00000000000000000000000011111111, excpControl, excpControlOut
    );
    
    Mux_Iord mux_iord(
        pc, ALUOut, excpControlOut, result, iord, iordOut
    );

    Mux_ExcpCtrl mux_excp_ctrl(
        32'b00000000000000000000000000000001, 32'b00000000000000000000000000000010, 32'b00000000000000000000000000000011, excpCtrl, excpCtrlOut 
    );

    Mux_ShiftSrc mux_shift_src(
        a, b, shiftSrc, shiftSrcOut
    );

    Mux_ShiftAmt mux_shift_amt(
        b, OFFSET,memory, shiftAmt, shiftAmtOut
    );


    Mux_SrcRead mux_src_read(
        RS, 5'b11101, srcRead,srcReadOut
    );

    Mux_SrcWrite mux_src_write(
        RT, OFFSET[15:11], 5'b11101, 5'b11110, 5'b11111, RS, srcWrite, srcWriteOut 
    );

    Mux_SrcData mux_src_data(
        ALUOut, ls, hi, lo, signextend16, shiftleft16, excpCtrlOut, shiftReg, a, b,32'b00000000000000000000000011100011, srcData, srcDataOut
    );

    Mux_AluSrcA mux_alu_src_a(
        pc, a, memoryDataRegister, aluSrcA, aluSrcAOut
    );

    Mux_AluSrcB mux_alu_src_b(
        b, 32'b00000000000000000000000000000100, signextend16, shiftLeft2, aluSrcB, aluSrcBOut
    );

    Mux_PcSource mux_pc_source(
        result, ALUOut, Concat, memoryDataRegister, EPC, ls, pcSource, pcSourceOut
    );

    Mux_Hi mux_hi(
        multHi, divHi, MultDiv, hiOut
    );

    Mux_Lo mux_lo(
        multLo, divLo, MultDiv, loOut
    );

    Mux_AluOut mux_aluOut(
        result, signExtend1, outAlu, aluout
    );
//instantiate Concat
    Concat concat(
        extendShiftLeft2, pc[31:28],Concat
    );
    

// instantiate shiftleft and signextend
    ExtendShiftLeft2 extend_shift_left_2(
        RS, RT, OFFSET, extendShiftLeft2
    );

    ShiftLeft2 shift_left_2(
        signextend16, shiftLeft2
    );

    ShiftLeft16 shift_left_16(
        OFFSET, shiftleft16
    );

    SignExtend1 sign_extend_1(
        LT, signExtend1
    );

    SignExtend16 sign_extend_16(
        OFFSET, signextend16
    );

//instantiate LS and SS
    LS Ls(
        memoryDataRegister, lsControl, ls
    );

    SS Ss(
        b, memoryDataRegister, ssControl, ss
    );

// instantiate provided modules(except registradores)
    Banco_reg banco_reg(
        clk, reset, regWrite, srcReadOut, RT, srcWriteOut, srcDataOut, registersData1, registersData2 
    );

    Instr_Reg instr_reg(
        clk, reset, irWrite, memory, OPCODE, RS, RT, OFFSET
    );

    Memoria memoria(
        iordOut, clk, memWrite, ss, memory
    );

    RegDesloc reg_desloc(
        clk, reset, shiftControl, shiftAmtOut, shiftSrcOut, shiftReg    
    );

    ula32 ula_32(
        aluSrcAOut, aluSrcBOut, aluControl, result, O, neg, zero, EQ, GT, LT
    );

// instantiate registradores
    Registrador pcBloco(
        clk, reset, control, pcSourceOut, pc
    );

    Registrador mdrBloco(
        clk, reset, memRegControl, memory, memoryDataRegister 
    );

    Registrador aBloco(
        clk, reset, aControl, registersData1, a
    );

    Registrador bBloco(
        clk, reset, bControl, registersData2, b
    );

    Registrador aluoutBloco(
        clk, reset, aluOutControl, aluout, ALUOut
    );

    Registrador epcBloco(
        clk, reset, epcControl, result, EPC
    ); 
////////////-------------------------------------------------
    Registrador HI(
        clk, reset, hiControl, hiOut, hi 
    );

    Registrador LO(
        clk, reset, loControl, loOut, lo 
    );
 ///////-------------------------------------------
    Mult multiplication(
        clk, reset, multControl, a, b, multHi, multLo  
    );

    Div division(
        clk, reset, divControl, a, b, div0, divHi, divLo
    );

// instantiate ControlUnit
    Control controlUnit(
        clk, reset, O, notFound, div0, OPCODE, OFFSET[5:0], zero, LT, GT, EQ, neg, 
        excpControl, iord, excpCtrl, shiftSrc, shiftAmt, srcRead, srcWrite, srcData,
        aluSrcA, aluSrcB, pcSource, MultDiv, outAlu,hiControl,loControl,control, multControl, divControl, seControl, 
        memWrite, ssControl, irWrite, lsControl, shiftControl, regWrite, aluControl,
        aluOutControl, epcControl,
        memRegControl, aControl, bControl, reset
    );    

endmodule
