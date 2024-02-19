module Mux_SrcWrite(
    input wire [4:0] in0,
    input wire  [4:0] in1,
    input wire  [4:0] in2,
    input wire  [4:0] in3,
    input wire  [4:0] in4,
    input wire  [4:0] in5,
    input wire [2:0] control,
    output wire [4:0] out
    );

    assign out = (control == 3'b000) ? in0:
                 (control == 3'b001) ? in1:
                 (control == 3'b010) ? in2:
                 (control == 3'b011) ? in3:
                 (control == 3'b100) ? in4:
                 in5;
                 
endmodule