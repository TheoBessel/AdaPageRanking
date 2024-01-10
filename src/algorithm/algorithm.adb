package body Algorithm is
    procedure compute_H_matrix(graph : in out P_Graph.T_Graph) is
        sum : T_Float;
    begin
        for i in graph.mat'Range(1) loop
            sum := 0.0;
            for j in graph.mat'Range(2) loop
                sum := sum + P_Matrix.get(graph.mat,i,j);
            end loop;
            for j in graph.mat'Range(2) loop
                if sum = 0.0 then
                    P_Matrix.set(graph.mat,i,j,0.0);
                else
                    P_Matrix.set(graph.mat,i,j,T_Float(P_Matrix.get(graph.mat,i,j))/sum);
                end if;
            end loop;
        end loop;
    end;

    procedure compute_S_matrix(graph : in out P_Graph.T_Graph) is
        sum : T_Float;
    begin
        for i in graph.mat'Range(1) loop
            sum := 0.0;
            for j in graph.mat'Range(2) loop
                sum := sum + P_Matrix.get(graph.mat,i,j);
            end loop;
            for j in graph.mat'Range(2) loop
                if sum = 0.0 then
                    P_Matrix.set(graph.mat,i,j,1.0/T_Float(graph.mat'Length(1)));
                else
                    P_Matrix.set(graph.mat,i,j,P_Matrix.get(graph.mat,i,j));
                end if;
            end loop;
        end loop;
    end;

    procedure compute_G_matrix(graph : in out P_Graph.T_Graph; alpha : T_Float) is
        e : constant P_Matrix.T_Matrix(graph.mat'Range(1), 1..1) := P_Matrix.init(graph.mat'Length(1),1,1.0);
    begin
        graph.mat := P_Matrix."+"(P_Matrix."*"(alpha,graph.mat),P_Matrix."*"((1.0-alpha)/T_Float(graph.mat'Length(1)),P_Matrix."*"(e,P_Matrix.T(e))));
    end;

    function compute_weight_vector(graph : in P_Graph.T_Graph; K : Natural) return P_Matrix.T_Matrix is
        pi : P_Matrix.T_Matrix(graph.mat'Range(1), 1..1) := P_Matrix.init(graph.mat'Length(1),1,1.0/T_Float(graph.mat'Length(1)));
    begin
        for i in 1..K loop
            pi := P_Matrix.T(P_Matrix."*"(P_Matrix.T(pi),graph.mat));
        end loop;
        return pi;
    end;
end Algorithm;