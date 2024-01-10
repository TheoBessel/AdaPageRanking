package body Algorithm is
    function compute_H_matrix(graph : P_Graph.T_Graph) return P_Matrix.T_Matrix is
        H : P_Matrix.T_Matrix(graph.mat'Range(1),graph.mat'Range(2));
        sum : T_Float;
    begin
        for i in graph.mat'Range(1) loop
            sum := 0.0;
            for j in graph.mat'Range(2) loop
                sum := sum + P_Matrix.get(graph.mat,i,j);
            end loop;
            for j in graph.mat'Range(2) loop
                if sum = 0.0 then
                    P_Matrix.set(H,i,j,0.0);
                else
                    P_Matrix.set(H,i,j,T_Float(P_Matrix.get(graph.mat,i,j))/sum);
                end if;
            end loop;
        end loop;
        return H;
    end;

    function compute_S_matrix(H : P_Matrix.T_Matrix) return P_Matrix.T_Matrix is
        S : P_Matrix.T_Matrix(H'Range(1),H'Range(2));
        sum : T_Float;
    begin
        for i in H'Range(1) loop
            sum := 0.0;
            for j in H'Range(2) loop
                sum := sum + P_Matrix.get(H,i,j);
            end loop;
            for j in H'Range(2) loop
                if sum = 0.0 then
                    P_Matrix.set(S,i,j,1.0/T_Float(H'Length(1)));
                else
                    P_Matrix.set(S,i,j,P_Matrix.get(H,i,j));
                end if;
            end loop;
        end loop;
        return S;
    end;

    function compute_G_matrix(S : P_Matrix.T_Matrix; alpha : T_Float) return P_Matrix.T_Matrix is
        G : P_Matrix.T_Matrix(S'Range(1),S'Range(2));
        e : constant P_Matrix.T_Matrix(S'Range(1), 1..1) := P_Matrix.init(S'Length(1),1,1.0);
    begin
        G := P_Matrix."+"(P_Matrix."*"(alpha,S),P_Matrix."*"((1.0-alpha)/T_Float(S'Length(1)),P_Matrix."*"(e,P_Matrix.T(e))));
        return G;
    end;

    function compute_weight_vector(G : P_Matrix.T_Matrix; K : Natural) return P_Matrix.T_Matrix is
        pi : P_Matrix.T_Matrix(G'Range(1), 1..1) := P_Matrix.init(G'Length(1),1,1.0/T_Float(G'Length(1)));
    begin
        for i in 1..K loop
            pi := P_Matrix.T(P_Matrix."*"(P_Matrix.T(pi),G));
        end loop;
        return pi;
    end;
end Algorithm;