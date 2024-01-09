package body Algorithm is
    function get_H_matrix(graph : P_Graph.T_Graph) return P_Matrix.T_Matrix is
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

    function get_S_matrix(H : P_Matrix.T_Matrix) return P_Matrix.T_Matrix is
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
end Algorithm;