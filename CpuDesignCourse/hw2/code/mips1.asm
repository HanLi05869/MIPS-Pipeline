LUI $t1, 0
ORI $t1, 1    # $t1 赋值为 1, 表示循环变量     i
LUI $t2, 0
ORI $t2, 11   # $t2 赋值为 11, 表示循环的上限  n + 1
LUI $t3, 0
ORI $t3, 0    # $t3 赋值为 0，用来储存结果     ans
LUI $t4, 0
ORI $t4, 1    # $t4 赋值为 1, 表示循环的增量   delta
loop_begin:
BEQ $t1, $t2, loop_end       # if i >= n + 1 goto loop_end
ADDU $t3, $t3, $t1           # ans = ans + i
ADDU $t1, $t4, $t1           # i = i + delta
BEQ $zero, $zero, loop_begin # goto loop_begin
loop_end:
SW $t3, 8($zero)             # Mem[8] = ans
