module CU_TB();
    reg clk, go, gt;
    wire cnt_ld, cnt_en, reg_ld, mux, done;
    
    CU DUT(gt, go, clk, done, mux, reg_ld, cnt_en, cnt_ld);
    
    initial begin
            go = 0;
            gt = 0;
            
            clk = 0;
            #10
            clk = 1;
            
            go = 1;
            
            //Transition to state 1
            #10
            clk = 0;
            
            #10
            clk = 1;
            #10
            clk = 0;   
            
            gt = 1;
            
            #10
            clk = 1;
            #10
            clk = 0;
            #10
            clk = 1;
            #10
            clk = 0;
            #10
            clk = 1;
            #10
            clk = 0;
    end
    
endmodule