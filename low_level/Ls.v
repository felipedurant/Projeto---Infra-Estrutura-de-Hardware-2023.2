module LS(
    input wire [31:0] in0,
    input wire [1:0] control,
    output wire [31:0] out
    );

    assign out = (control == 2'b01) ? in0:
                 (control == 2'b10) ? {{16{1'b0}},in0[15:0]}:
                 (control == 2'b11) ? {{24{1'b0}},in0[7:0]}:
                 32'b00000000000000000000000000000000;
                 
endmodule