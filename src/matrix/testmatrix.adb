with Text_IO; use Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;

with Matrix;

procedure TestMatrix is
    package Int_Matrix is
		new Matrix (T_Value => Integer, V_Width => 4, V_Height => 3);
	use Int_Matrix;

    mat : T_Matrix;
begin
    Put_Line("Testing `Matrix` Package ...");
    init(mat,0);
    Put(get(mat,4,3),1);
end TestMatrix;