package body Algorithm is
    procedure compute_H_matrix(graph : in out P_Graph.T_Graph) is
        sum : T_Float;
    begin
        case graph.full is
            when True => 
            for i in graph.fullmat'Range(1) loop
                sum := 0.0;
                for j in graph.fullmat'Range(2) loop
                    sum := sum + P_Full.get(graph.fullmat,i,j);
                end loop;
                for j in graph.fullmat'Range(2) loop
                    if sum = 0.0 then
                        P_Full.set(graph.fullmat,i,j,0.0);
                    else
                        P_Full.set(graph.fullmat,i,j,T_Float(P_Full.get(graph.fullmat,i,j))/sum);
                    end if;
                end loop;
            end loop;
            when False =>
            for i in 1..graph.sparsemat.height loop
                sum := 0.0;
                for j in 1..graph.sparsemat.width loop
                    sum := sum + P_Sparse.get(graph.sparsemat,i,j);
                end loop;
                for j in 1..graph.sparsemat.width loop
                    if sum = 0.0 then
                        P_Sparse.set(graph.sparsemat,i,j,0.0);
                    else
                        P_Sparse.set(graph.sparsemat,i,j,T_Float(P_Sparse.get(graph.sparsemat,i,j))/sum);
                    end if;
                end loop;
            end loop;
        end case;
    end;

    procedure compute_S_matrix(graph : in out P_Graph.T_Graph) is
        sum : T_Float;
    begin
        for i in graph.fullmat'Range(1) loop
            sum := 0.0;
            for j in graph.fullmat'Range(2) loop
                sum := sum + P_Full.get(graph.fullmat,i,j);
            end loop;
            for j in graph.fullmat'Range(2) loop
                if sum = 0.0 then
                    P_Full.set(graph.fullmat,i,j,1.0/T_Float(graph.fullmat'Length(1)));
                else
                    Null;
                end if;
            end loop;
        end loop;
    end;

    procedure compute_G_matrix(graph : in out P_Graph.T_Graph; alpha : T_Float) is
        e : constant P_Full.T_Matrix(graph.fullmat'Range(1), 1..1) := P_Full.init(graph.fullmat'Length(1),1,1.0);
    begin
        graph.fullmat := P_Full."+"(P_Full."*"(alpha,graph.fullmat),P_Full."*"((1.0-alpha)/T_Float(graph.fullmat'Length(1)),P_Full."*"(e,P_Full.T(e))));
    end;

    function compute_weight_vector_full(graph : in P_Graph.T_Graph; K : Natural) return P_Full.T_Matrix is
        pi : P_Full.T_Matrix(graph.fullmat'Range(1), 1..1) := P_Full.init(graph.fullmat'Length(1),1,1.0/T_Float(graph.fullmat'Length(1)));
    begin
        for i in 1..K loop
            pi := P_Full.T(P_Full."*"(P_Full.T(pi),graph.fullmat));
        end loop;
        return pi;
    end;

    function compute_weight_vector_sparse(graph : in P_Graph.T_Graph; K : Natural) return P_Sparse.T_Matrix is
        pi : P_Sparse.T_Matrix(graph.sparsemat.height, 1) := P_Sparse.init(graph.sparsemat.height,1);
    begin
        for i in 1..graph.sparsemat.height loop
            P_Sparse.set(pi,i,1,1.0/T_Float(graph.sparsemat.height));
        end loop;
        for i in 1..K loop
            pi := P_Sparse.T(P_Sparse."*"(P_Sparse.T(pi),graph.sparsemat));
        end loop;
        return pi;
    end;
end Algorithm;