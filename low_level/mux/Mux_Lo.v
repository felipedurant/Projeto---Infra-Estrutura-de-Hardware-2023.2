module Mux_Lo(
    input wire [31:0] in0,
    input wire  [31:0] in1,
    input wire  control,
    output wire [31:0] out
    );

    assign out = (control == 1'b0) ? in0:
                 in1;
                 
endmodule