module ShiftLeft16(
    input wire [15:0] in,
    output wire [31:0] out
);

    wire [31:0] aux;

    assign aux = {{16'b0000000000000000}, in};
    assign out = aux << 16; 

endmodule