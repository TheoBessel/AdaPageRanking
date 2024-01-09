with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Matrix;
with IOStream;
with Graph;
with Algorithm;

procedure PageRank is
    package F_Matrix is 
        new Matrix(T_Float => Float, "+" => "+", "*" => "*");
    use F_Matrix;
    package F_IOStream is
        new IOStream(T_Float => Float);
    use F_IOStream;
    package F_Graph is
        new Graph(P_Matrix => F_Matrix, P_IOStream => F_IOStream);
    use F_Graph;

    procedure print_float(f : Float) is
    begin
        Put(f, Aft => 1, Exp => 0);
    end;
    procedure print is new F_Matrix.print(print_float => print_float);

    package F_Algorithm is
        new Algorithm(P_Matrix => F_Matrix, P_Graph => F_Graph);
    --use F_Algorithm;

    params : T_Arguments;
begin
    Put_Line("Running main program ..."); New_Line;

    F_IOStream.parse_args(params);

    declare
        file : constant F_IOStream.T_File := F_IOStream.parse_file(To_Unbounded_String("/Users/theobessel/Documents/N7/Informatique/AdaPageRankingNUCKED/static/testgraph.net"));
        graph : F_Graph.T_Graph(file.n);
    begin
        graph := F_Graph.init(file);
        print(F_Algorithm.get_H_matrix(graph));
    end;
end PageRank;