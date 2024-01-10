with Matrix;
with IOStream;
with Graph;

generic
    type T_Float is digits <>;
    with package P_Matrix is new Matrix(T_Float => T_Float, others => <>);
    with package P_IOStream is new IOStream(T_Float => T_Float);
    with package P_Graph is new Graph(P_Matrix => P_Matrix, P_IOStream => P_IOStream);
package Algorithm is
    procedure compute_H_matrix(graph : in out P_Graph.T_Graph);
    procedure compute_S_matrix(graph : in out P_Graph.T_Graph);
    procedure compute_G_matrix(graph : in out P_Graph.T_Graph; alpha : T_Float);
    function compute_weight_vector(graph : in P_Graph.T_Graph; K : Natural) return P_Matrix.T_Matrix;
end Algorithm;