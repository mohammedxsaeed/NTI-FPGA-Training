module ALU_TB();
parameter Dwidth = 32;
parameter Swidth = 4;

reg  [Dwidth-1:0] a, b;
reg  [Swidth-1:0] alu_ctrl;
wire [Dwidth-1:0] result;
wire zero;
integer i=0;

ALU DUT (.a(a),.b(b),.alu_ctrl(alu_ctrl),.result(result),.zero(zero));

initial begin
   for (i=0 ; i<100 ; i=i+1 )begin
       a=$random;
       b=$random;
       alu_ctrl=$random;
       #5;
   end 
   $stop;
end
endmodule 