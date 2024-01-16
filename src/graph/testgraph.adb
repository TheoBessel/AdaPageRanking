with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Matrix;
with IOStream;
with Graph;

procedure TestGraph is
    package F_Matrix is 
        new Matrix(T_Float => Float);
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

    params : T_Arguments;
begin
    Put_Line("Testing `Graph` Package ..."); New_Line;

    F_IOStream.parse_args(params);
    Put("alpha : "); print_float(params.alpha); New_Line;
    Put("K : "); Put(params.k); New_Line;
    Put("epsilon : "); print_float(params.eps); New_Line;
    Put("pleine : "); Put(params.pleine'Image); New_Line;
    Put("output : "); Put(To_String(params.output)); New_Line;
    Put("input : "); Put(To_String(params.input)); New_Line;

    New_Line;

    declare
        file : constant F_IOStream.T_File := F_IOStream.parse_file(To_Unbounded_String("/Users/theobessel/Documents/N7/Informatique/AdaPageRankingNUCKED/static/testgraph.net"));
        graph : F_Graph.T_Graph(file.n);
    begin
        graph := F_Graph.init(file);
        print(graph.mat);
    end;
end;
