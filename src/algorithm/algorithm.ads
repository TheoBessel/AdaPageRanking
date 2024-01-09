with Matrix;
with Graph;

generic
    with package P_Matrix is new Matrix(<>);
    with package P_Graph is new Graph(P_Matrix => P_Matrix, others => <>);
package Algorithm is
    function get_H_matrix(graph : P_Graph.T_Graph) return P_Matrix.T_Matrix;
end Algorithm;