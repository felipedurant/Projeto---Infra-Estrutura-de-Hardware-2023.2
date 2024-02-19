module ExtendShiftLeft2(
    input wire [4:0] in1,
    input wire [4:0] in2,
    input wire [15:0] in3,
    output wire [27:0] out
);
    wire [27:0] aux; 
    assign aux[27:0] = {{2'b00},in1,in2 ,in3};
    assign out = aux << 2; 

endmodule