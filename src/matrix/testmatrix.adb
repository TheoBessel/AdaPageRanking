with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

with Matrix;

procedure TestMatrix is
    package F_Matrix is 
        new Matrix(T_Float => Float, "+" => "+", "*" => "*");
    use F_Matrix;

    procedure print_float(f : Float) is
    begin
        Put(f, Aft => 1, Exp => 0);
    end;
    procedure print is new F_Matrix.print(print_float => print_float);
begin
    Put_Line("Testing `Matrix` Package ..."); New_Line;
    declare
        mat : constant T_Matrix := (
            (1.1, 2.0, 3.0),
            (4.0, 5.4, 6.9),
            (4.2, 4.2, 0.3),
            (3.8, 3.2, 0.3)
        );
    begin
        print(mat);
        print(mat*T(mat));
        print(T(mat)*mat);
    end;
end;