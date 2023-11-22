with Text_IO; use Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;

with Matrix;

procedure TestMatrix is
    package Int_Matrix is
		new Matrix (T_Value => Integer, "+" => Standard."+", "*" => Standard."*");
	use Int_Matrix;

    n : constant Positive := 3;
    m : constant Positive := 4;

    mat : T_Matrix(V_Height => n, V_Width => m, V_Size => n*m);

    procedure print(val : Integer) is
    begin
        Put(val,2); Put(" ");
    end;

    procedure newline is
    begin
        New_Line;
    end;

    procedure print is new forall(process => print, breakline => newline);

    A : T_Matrix(V_Height => 3, V_Width => 2, V_Size => 6);
    B : T_Matrix(V_Height => 2, V_Width => 4, V_Size => 8);
    C : T_Matrix(V_Height => 3, V_Width => 4, V_Size => 12);
    D : T_Matrix(V_Height => 4, V_Width => 3, V_Size => 12);
begin
    Put_Line("Testing `Matrix` Package ...");

    mat := init((
        (1,2,3,0),
        (4,5,6,0),
        (7,8,9,0)
    ));

    print(mat);
    New_Line;

    mat := init(n,m,0);

    set(mat,2,3,1);
    set(mat,1,2,3);
    set(mat,3,2,9);
    set(mat,3,3,6);

    print(mat);
    New_Line;

    A := init((
        (3,1),
        (-4,2),
        (1,8)
    ));

    B := init((
        (3,9,1,3),
        (4,2,0,-2)
    ));

    print(A);
    New_Line;

    print(B);
    New_Line;
    
    C := A*B;

    print(C);
    New_Line;

    C := C+mat;

    print(C);
    New_Line;

    pragma Assert(2*C = C+C);

    C := 2*C;

    print(C);
    New_Line;

    D := T(C);

    print(D);
    New_Line;

end TestMatrix;