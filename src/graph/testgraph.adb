with Ada.Text_IO;               use Ada.Text_IO;
with Ada.Integer_text_IO;       use Ada.Integer_text_IO;
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;
with Matrix;
with Graph;


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

    package mongraph is 
        new graph(T_matrix, init, set);
    gra : T_Matrix;
begin
    Put_Line("Testing `Graph` Package ...");

    gra := lire_graphe(File_type);
    Put_line("Res : ");
    print_int(gra);
    New_Line;
end TestGraph;
