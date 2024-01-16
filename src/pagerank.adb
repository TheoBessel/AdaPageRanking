with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

with Full;
with Sparse;
with IOStream;
with Graph;
with Algorithm;

procedure PageRank is
    package F_IOStream is
        new IOStream(T_Float => Float);
    use F_IOStream;
    package F_Full is
        new Full(T_Float => Float, P_IOStream => F_IOStream);
    use F_Full;
    package F_Sparse is
        new Sparse(T_Float => Float, P_IOStream => F_IOStream);
    use F_Sparse;
    package F_Graph is
        new Graph(T_Float => Float, P_Full => F_Full, P_Sparse => F_Sparse, P_IOStream => F_IOStream);
    use F_Graph;

    procedure print_float(f : Float) is
    begin
        Put(f, Aft => 4, Exp => 0);
    end;

    procedure print_integer(f : Float) is
    begin
        Put(Integer(f), 3);
    end;

    procedure printf_float(t : File_Type; f : Float) is
    begin
        Put(t, f, Aft => 8, Exp => 0, Fore => 1);
    end;

    procedure printf_integer(t : File_Type; i : Integer) is
    begin
        Put(t, i, 1);
    end;

    procedure full_print is new F_Full.print(print_float => print_float);
    procedure full_print_int is new F_Full.print(print_float => print_integer);

    procedure sparse_print is new F_Sparse.print(print_float => print_float);
    procedure sparse_print_int is new F_Sparse.print(print_float => print_integer);

    procedure write_file is new  F_IOStream.write_file(printf_int => printf_integer, printf_float => printf_float);

    package F_Algorithm is
        new Algorithm(T_Float => Float, P_IOStream => F_IOStream, P_Full => F_Full, P_Sparse => F_Sparse, P_Graph => F_Graph);

    params : T_Arguments;
begin
    Put_Line("Running main program ..."); New_Line;

    F_IOStream.parse_args(params);

    declare
        file : constant F_IOStream.T_InFile := F_IOStream.parse_file(params.input);
        output : F_IOStream.T_OutFile(file.n);
        graph : F_Graph.T_Graph(file.n, params.pleine);
    begin
        if params.pleine then
            declare
                pi, indices : F_Full.T_Matrix(1..file.n, 1..1);
            begin
                graph := F_Graph.init(file, params.pleine);
                F_Algorithm.compute_H_matrix(graph);
                F_Algorithm.compute_S_matrix(graph);
                F_Algorithm.compute_G_matrix(graph, params.alpha);
                pi := F_Algorithm.compute_weight_vector_full(graph, params.K);
                full_print(pi);
                indices := F_Full.sort(pi);
                output := F_Full.export(indices,pi);
                full_print_int(indices);
                full_print(pi);
                write_file(params.output, output, params);
            end;
        else
            declare
                pi, indices : F_Sparse.T_Matrix(file.n, 1);
            begin
                graph := F_Graph.init(file, params.pleine);
                F_Algorithm.compute_H_matrix(graph);
                pi := F_Algorithm.compute_weight_vector_sparse(graph, params.K);
                --indices := F_Sparse.sort(pi);
                --output := F_Sparse.export(indices,pi);
                --print_int(indices);
                sparse_print(pi);
                --write_file(params.output, output, params);
            end;
        end if;
    end;
end PageRank;