with Matrix;
with IOStream;
with Graph;

generic
    type T_Float is digits <>;
    with package P_Matrix is new Matrix(T_Float => T_Float, others => <>);
    with package P_IOStream is new IOStream(T_Float => T_Float);
    with package P_Graph is new Graph(P_Matrix => P_Matrix, P_IOStream => P_IOStream);

package Algorithm is
    
    -- compute_H_matrix
    -- calcul la matrice H
    -- Paramètre :
    --      - graph     [in out]    Le graphe du réseau que l'on traite et transforme en un graphe orienté pondéré
    -- Pre :
    --      - Aucune
    -- Post :
    --      - Aucune
    procedure compute_H_matrix(graph : in out P_Graph.T_Graph);
    
    -- compute_S_matrix
    -- Calcule la matrice S à partir de la matrice H
    -- Paramètre :
    --      - graph     [in out]    La matrice H qui devient la matrice S
    -- Pre :
    --      - Aucune
    -- Post :
    --      - Aucune
    procedure compute_S_matrix(graph : in out P_Graph.T_Graph);
    
    -- compute_G_matrix
    -- Calcule la matrice G à partir de la matrice S
    -- Paramètre :
    --      - graph     [in out]    La matrice S qui devient la matrice G
    --      - alpha     [in]        Le coefficient dans le calcul de G peut changer selon la ligne de commande
    -- Pre :
    --      - Aucune
    -- Post :
    --      - Aucune
    procedure compute_G_matrix(graph : in out P_Graph.T_Graph; alpha : in T_Float);

    -- compute_weight_vector
    -- Calcule le vecteur des poids des pages
    -- Paramètre :
    --      - graph     [in out]    La matrice G
    --      - K         [in]        Le nombre d'itérations du calcule du vecteur poids
    -- pre :
    --      - Aucune
    -- Post :
    --      - Aucune
    function compute_weight_vector(graph : in P_Graph.T_Graph; K : in Natural) return P_Matrix.T_Matrix;
end Algorithm;