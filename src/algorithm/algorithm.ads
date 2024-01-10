with Matrix;
with IOStream;
with Graph;

generic
    type T_Float is digits <>;
    with package P_Matrix is new Matrix(T_Float => T_Float, others => <>);
    with package P_IOStream is new IOStream(T_Float => T_Float);
    with package P_Graph is new Graph(P_Matrix => P_Matrix, P_IOStream => P_IOStream);
package Algorithm is
    function compute_H_matrix(graph : P_Graph.T_Graph) return P_Matrix.T_Matrix;
    function compute_S_matrix(H : P_Matrix.T_Matrix) return P_Matrix.T_Matrix;
    function compute_G_matrix(S : P_Matrix.T_Matrix; alpha : T_Float) return P_Matrix.T_Matrix;
    function compute_weight_vector(G : P_Matrix.T_Matrix; K : Natural) return P_Matrix.T_Matrix;
end Algorithm;