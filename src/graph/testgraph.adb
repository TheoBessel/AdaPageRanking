with Ada.Text_IO;               use Ada.Text_IO;
with Ada.Integer_text_IO;       use Ada.Integer_text_IO;
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;
with Graph;                     use Graph;
with Matrix;


procedure TestGraph is
    file_name : Unbounded_String := To_Unbounded_String("testgraph.net");
    package Int_Matrix is
        new Matrix (T_Value => Integer, "+" => "+", "*" => "*");
    use Int_Matrix;
   
    procedure print_int(val : Integer) is
    begin
        Put(val,2); Put(" ");
    end;
    
    procedure newline is
    begin
        New_Line;
    end;

    procedure print_int is new Int_Matrix.forall(process => print_int, breakline => newline);

    gra : T_Graphe;
begin
    Put_Line("Testing `Graph` Package ...");

    Lire_Graphe(file_name, gra);
    Put_line("Res : ");
    print_int(Obtenir_Matrice(gra));
    New_Line;
end TestGraph;
