-- spécification du module graphe
with Matrix;
with IOStream;

generic
    with package P_Matrix is new Matrix(<>);
    with package P_IOStream is new IOStream(<>);

package Graph is
    -- description du type de Graphe
    type T_Graph(n : Natural) is tagged record
        mat : P_Matrix.T_Matrix(1..n, 1..n);
    end record;

    -- init
    -- Initialise un graphe en fonction du nombre de sommet et de la liste d'arête donné en argument
    -- Paramètre :
    --      - file      [in]    Enregistrement avec le nombre de sommet et la liste des arrêtes du graphe
    -- Pre :
    --      - Aucune
    -- Post :
    --      - Aucune
    function init(file : in P_IOStream.T_File) return T_Graph;
end Graph;