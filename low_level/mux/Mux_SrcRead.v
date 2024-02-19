module Mux_SrcRead(
    input wire [4:0] in0,
    input wire  [4:0] in1,
    input wire control,
    output wire [4:0] out
    );

    assign out = (control == 1'b0) ? in0:
                 in1;
                 
endmodule