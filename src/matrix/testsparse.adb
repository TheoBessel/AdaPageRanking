with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

with Sparse;

procedure TestSparse is
    package F_Sparse is 
        new Sparse(T_Float => Float);
    use F_Sparse;

    procedure print_float(f : Float) is
    begin
        Put(f, Aft => 1, Exp => 0);
    end;
    procedure print is new F_Sparse.print(print_float => print_float);

begin
    Put_Line("Testing `Sparse` Package ..."); New_Line;
    declare
        A : T_Matrix := F_Sparse.init(3,3);
        B : T_Matrix := F_Sparse.init(3,3);
    begin
        set(A,1,1,1.0);
        set(A,1,2,2.0);
        set(A,2,3,3.0);
        set(A,3,2,4.0);

        set(B,1,1,1.0);
        set(B,2,1,1.0);
        set(B,3,2,5.0);

        Put("A = "); New_Line;
        print(A); New_Line;
        Put("B = "); New_Line;
        print(B); New_Line;
        Put("A*B = "); New_Line;
        print(A*B);
        Put("A+B = "); New_Line;
        print(A+B);
        Put("9*A = "); New_Line;
        print(9.0*A);
    end;
end;