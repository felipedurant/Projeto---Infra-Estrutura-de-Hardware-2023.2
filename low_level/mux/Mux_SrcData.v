module Mux_SrcData(
    input wire [31:0] in0,
    input wire  [31:0] in1,
    input wire  [31:0] in2,
    input wire  [31:0] in3,
    input wire  [31:0] in4,
    input wire  [31:0] in5,
    input wire  [31:0] in6,
    input wire  [31:0] in7,
    input wire  [31:0] in8,
    input wire  [31:0] in9,
    input wire  [31:0] in10,
    input wire [3:0] control,
    output wire [31:0] out
    );

    assign out = (control == 4'b0000) ? in0:
                 (control == 4'b0001) ? in1:
                 (control == 4'b0010) ? in2:
                 (control == 4'b0011) ? in3:
                 (control == 4'b0100) ? in4:
                 (control == 4'b0101) ? in5:
                 (control == 4'b0110) ? in6:
                 (control == 4'b0111) ? in7:
                 (control == 4'b1000) ? in8:
                 (control == 4'b1001) ? in9:
                 in10;
                 
endmodule