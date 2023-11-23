with Text_IO; use Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;   use Ada.Float_Text_IO;

with Matrix;

package body Algorithm is
    procedure F_Algorithm is
        package Int_Matrix is
            new Matrix (T_Value => Integer, "+" => "+", "*" => "*");
        use Int_Matrix;
        package Float_Matrix is
            new Matrix (T_Value => Float, "+" => "+", "*" => "*");
        use Float_Matrix;

        procedure print_int(val : Integer) is
        begin
            Put(val,2); Put(" ");
        end;

        procedure print_float(val : Float) is
        begin
            Put(val,Exp => 0); Put(" ");
        end;

        procedure newline is
        begin
            New_Line;
        end;

        procedure print_int is new Int_Matrix.forall(process => print_int, breakline => newline);

        procedure print_float is new Float_Matrix.forall(process => print_float, breakline => newline);

        adj : Float_Matrix.T_Matrix(V_Height => 6, V_Width => 6, V_Size => 36);
        H : Float_Matrix.T_Matrix(V_Height => 6, V_Width => 6, V_Size => 36);
        S : Float_Matrix.T_Matrix(V_Height => 6, V_Width => 6, V_Size => 36);
        G : Float_Matrix.T_Matrix(V_Height => 6, V_Width => 6, V_Size => 36);

        e : Float_Matrix.T_Matrix(V_Height => 6, V_Width => 1, V_Size => 6);
        
        sum : Float;

        alpha : Float := 0.85;
    begin
        adj := Float_Matrix.init(6,6,0.0);
        H := Float_Matrix.init(6,6,0.0);

        e := Float_Matrix.init(6,1,1.0);

        Float_Matrix.set(adj,1,2,1.0);
        Float_Matrix.set(adj,1,3,1.0);
        Float_Matrix.set(adj,3,1,1.0);
        Float_Matrix.set(adj,3,2,1.0);
        Float_Matrix.set(adj,3,5,1.0);
        Float_Matrix.set(adj,4,5,1.0);
        Float_Matrix.set(adj,4,6,1.0);
        Float_Matrix.set(adj,5,4,1.0);
        Float_Matrix.set(adj,5,6,1.0);
        Float_Matrix.set(adj,6,4,1.0);

        Put("Matrice d'adjacence du graphe :"); newline;
        print_float(adj);
        newline;

        for i in 1..adj.V_Height loop
            sum := 0.0;
            for j in 1..adj.V_Width loop
                sum := sum + Float_Matrix.get(adj,i,j);
            end loop;
            for j in 1..adj.V_Width loop
                if sum = 0.0 then
                    Float_Matrix.set(H,i,j,0.0);
                else
                    Float_Matrix.set(H,i,j,Float(Float_Matrix.get(adj,i,j))/Float(sum));
                end if;
            end loop;
        end loop;

        Put("Matrice H :"); newline;
        print_float(H);
        newline;

        for i in 1..adj.V_Height loop
            sum := 0.0;
            for j in 1..adj.V_Width loop
                sum := sum + Float_Matrix.get(adj,i,j);
            end loop;
            for j in 1..adj.V_Width loop
                if sum = 0.0 then
                    Float_Matrix.set(S,i,j,1.0/Float(H.V_Width));
                else
                    Float_Matrix.set(S,i,j,Float(Float_Matrix.get(adj,i,j))/Float(sum));
                end if;
            end loop;
        end loop;

        Put("Matrice S :"); newline;
        print_float(S);
        newline;

        G := alpha*S + ((1.0-alpha)/6.0)*(e*T(e));

        Put("Matrice de Google :"); newline;
        print_float(G);

    end F_Algorithm;
end Algorithm;