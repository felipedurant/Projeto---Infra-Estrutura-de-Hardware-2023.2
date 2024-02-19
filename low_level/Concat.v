module Concat(
    input wire [27:0] in0,
    input wire [3:0] in1,
    output wire [31:0] out
    );

    assign out = {in1,in0};
                 
endmodule