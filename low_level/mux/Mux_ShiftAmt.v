module Mux_ShiftAmt(
    input wire [31:0] in0,
    input wire  [15:0] in1,
    input wire  [31:0] in2,
    input wire [1:0] control,
    output wire [4:0] out
    );

    assign out = (control == 2'b00) ? in0[4:0]:
	             (control == 2'b01) ? in1[10:6]:
		         in2[4:0];
                 
endmodule