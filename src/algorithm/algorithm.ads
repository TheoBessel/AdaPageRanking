with IOStream;
with Full;
with Sparse;
with Graph;

generic
    type T_Float is digits <>;
    with package P_IOStream is new IOStream(T_Float => T_Float);
    with package P_Full is new Full(P_IOStream => P_IOStream, T_Float => T_Float);
    with package P_Sparse is new Sparse(P_IOStream => P_IOStream, T_Float => T_Float);
    with package P_Graph is new Graph(T_Float => T_Float, P_Full => P_Full, P_Sparse => P_Sparse, P_IOStream => P_IOStream);
package Algorithm is
    -- Calcule la matrice H
    procedure compute_H_matrix(graph : in out P_Graph.T_Graph);

    -- Calcule la matrice S à partir de la matrice H
    procedure compute_S_matrix(graph : in out P_Graph.T_Graph);
    
    -- Calcule la matrice G à partir de la matrice S
    procedure compute_G_matrix(graph : in out P_Graph.T_Graph; alpha : T_Float);

    -- Calcule le vecteur des poids pour les matrices pleines
    function compute_weight_vector_full(graph : in P_Graph.T_Graph; K : Natural) return P_Full.T_Matrix;
    
    -- Calcule le vecteur des poids pour les matrices creuses
    function compute_weight_vector_sparse(graph : in P_Graph.T_Graph; K : Natural) return P_Sparse.T_Matrix;
end Algorithm;