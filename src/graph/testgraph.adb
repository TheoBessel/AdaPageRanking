with Text_IO; use Text_IO;

procedure TestGraph is
    file_name : String := "testgraph.net";
    package Int_Matrix is
        new Matrix (T_Value => Integer, "+" => "+", "*" => "*");
    use Int_Matrix;
    
    procedure print_int is new Int_Matrix.forall(process => print_int, breakline => newline);

    package mongraph is 
        new graph(T_Matrix, init, set);
    gra : T_Matrix;
begin
    Put_Line("Testing `Graph` Package ...");

    gra := lire_graphe(File_type);
    Put_line("Res : ");
    print_int(gra);
    New_Line;
end TestGraph;