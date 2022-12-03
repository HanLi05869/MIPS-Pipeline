module testbench_;

    reg clock, reset;

    mips mips_i(clock, reset);

    initial
    begin
        clock = 0 ;
        reset = 1 ;
        #30 reset = 0 ; 
    end

    initial
    begin
        $dumpfile("testbench.vcd");
        $dumpvars(0, testbench_);
        #10000000 $finish;
    end

    always
    begin
        #20 clock = ~clock ;
    end
endmodule