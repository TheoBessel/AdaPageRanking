package body Algorithm is
    function get_H_matrix(graph : P_Graph.T_Graph) return P_Matrix.T_Matrix is
    begin
        return P_Matrix."*"(0.5,graph.mat);
    end;
end Algorithm;