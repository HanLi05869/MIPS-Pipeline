`timescale 1ns / 1ps

module NPC(
		input ifbeq,
        input[31:0] IsZero,
        input J,
        input[15:0] offset,
        input[31:2] instr,
        input[31:2] now_pc,
        output reg[31:2] next_pc
	);

    reg[29:0] tmp;
    reg[31:0] total;
    reg[31:0] total_now;
    always @(*)
    begin  
        if((ifbeq == 0) && (J == 0))
            next_pc = now_pc + 1;
        else if(J == 1)
            next_pc = instr;
        else if (IsZero == 0)
            begin
                tmp = $signed(offset);
                next_pc = tmp + now_pc + 1;
            end
        else
            next_pc = now_pc + 1;
        total = {next_pc ,2'b00};
        total_now = {now_pc ,2'b00};
    end
 endmodule
