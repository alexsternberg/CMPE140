module DP_TB();
    reg clk, cnt_ld, cnt_en, reg_ld, mux, done;
    wire gt;
    reg [31:0] in;
    wire [31:0] out;
    
    DP         DUT(done, in, mux, reg_ld, cnt_en, cnt_ld, gt, out, clk);
    
    integer i;
    
    initial begin
    clk = 0;
    for (i = 0; i < 11; i = i + 1) begin
        in = i;
        cnt_ld = 1;
        reg_ld = 1;
        mux = 0;
        done = 0;
        
        #10
        clk = 1;
        #10
        clk = 0;
        
        while(gt == 1'b1) begin
            cnt_ld = 0;
            cnt_en = 1;
            mux = 1;
            
            #10
            clk = 1;
            #10
            clk = 0;
        end
        
        done = 1;
        cnt_en = 0;
        
        #10
        clk = 1;
        #10
        clk = 0;
        
        case(i)
        0:  if(out != 1) begin
                $display("Error at 0");
                $finish; end
        1:  if(out != 1) begin
                $display("Error at 1");
                $finish; end
        2:  if(out != 2) begin
                $display("Error at 2");
                $finish; end
        3:  if(out != 6) begin
                $display("Error at 3");
                $finish; end
        4:  if(out != 24) begin
                $display("Error at 4");
                $finish; end
        5:  if(out != 120) begin
                $display("Error at 5");
                $finish; end
        6:  if(out != 720) begin
                $display("Error at 6");
                $finish; end
        7:  if(out != 5040) begin
                $display("Error at 7");
                $finish; end
        8:  if(out != 40320) begin
                $display("Error at 8");
                $finish; end
        9:  if(out != 362880) begin
                $display("Error at 9");
                $finish; end
        10:  if(out != 3628800) begin
                $display("Error at 10");
                $finish; end
        endcase
        
    end
    
    $display("Test Successful");
    $finish;

    
    end
endmodule
    