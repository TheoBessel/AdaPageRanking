with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Matrix;
with IOStream;
with Graph;
with Algorithm;

procedure PageRank is
    -- Création du type de flottant utilisé
    type myfloat is digits 2 range 0.0 .. 10000.0;

    -- Instanciation des packages générique
    package F_Matrix is 
        new Matrix(T_Float => Float, "+" => "+", "*" => "*");
    use F_Matrix;

    package F_IOStream is
        new IOStream(T_Float => Float);
    use F_IOStream;

    package F_Graph is
        new Graph(P_Matrix => F_Matrix, P_IOStream => F_IOStream);
    use F_Graph;

    -- Construction de la procédure d'affichage d'une matrice de Flottant
    procedure print_float(f : Float) is
    begin
        Put(f, Aft => 4, Exp => 0);
    end;
    procedure print is new F_Matrix.print(print_float => print_float);

    package F_Algorithm is
        new Algorithm(T_Float => Float, P_Matrix => F_Matrix, P_IOStream => F_IOStream, P_Graph => F_Graph);

    params : T_Arguments;       -- Les valeurs des constantes

begin
    Put_Line("Running main program ..."); New_Line;

    F_IOStream.parse_args(params);

    declare
        file : constant F_IOStream.T_File := F_IOStream.parse_file(To_Unbounded_String("/Users/theobessel/Documents/N7/Informatique/AdaPageRankingNUCKED/static/linux26.net"));
        --graph : F_Graph.T_Graph(file.n);
        --pi : T_Matrix(1..file.n, 1..1);
    begin
        --graph := F_Graph.init(file);
        --F_Algorithm.compute_H_matrix(graph);
        --F_Algorithm.compute_S_matrix(graph);
        --F_Algorithm.compute_G_matrix(graph, params.alpha);
        --pi := F_Algorithm.compute_weight_vector(graph, params.K);
        --print(H);
        --print(S);
        --print(G);
        --print(pi);
        --print(sort(pi));
        --print(pi);
        for i in  1..file.m loop
            Put(file.edges(i).start); Put("  "); Put(file.edges(i).stop); New_Line;
        end loop;
        Put_Line(Float'Size'Image);
        Put_Line(Natural'Size'Image);
        Put(file.m);
    end;
end PageRank;