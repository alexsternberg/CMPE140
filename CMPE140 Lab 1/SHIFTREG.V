odule SHIFTREG #(parameter WIDTH=4)(
        input inl, inr,
        input [WIDTH-1:0] d,
        input ld, sr, sl, rst, clk,
        output [WIDTH-1:0] q
    );
    reg [WIDTH-1:0] _q;
    always @ (posedge clk)
        casex ({rst,  sr, sl, ld})
            4'b1xxx: _q <= 0;
            4'b0xx1: _q <= d;
            4'b0x10: _q <= {_q[WIDTH-1:0], inr} ;
            4'b0100: _q <= {inl, _q[WIDTH-1:1]};
            4'b0000: _q <= _q;
        endcase
    assign q = _q;
endmodule/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////SR



















