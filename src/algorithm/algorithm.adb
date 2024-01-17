package body Algorithm is
    -- Calcule la matrice H
    procedure compute_H_matrix(graph : in out P_Graph.T_Graph) is
        sum : T_Float; -- Nombre de sommet j que le sommet i pointe
    begin
        -- Traiter chaque sommet du graphe
        case graph.full is
            when True => 
                for i in graph.fullmat'Range(1) loop
                    -- Calculer le nombre de sommet que le sommet pointe
                    sum := 0.0;
                    for j in graph.fullmat'Range(2) loop
                        sum := sum + P_Full.get(graph.fullmat, i, j);
                    end loop;
                    -- Remplacer les 1 par 1/M avec M le nombre de page que le sommet pointe
                    for j in graph.fullmat'Range(2) loop
                        if sum = 0.0 then
                            P_Full.set(graph.fullmat, i, j, 0.0);
                        else
                            P_Full.set(graph.fullmat, i, j, T_Float(P_Full.get(graph.fullmat, i, j)) / sum);
                        end if;
                    end loop;
                end loop;
            when False =>
                for i in 1 .. graph.sparsemat.height loop
                    -- Calculer le nombre de sommet que le sommet pointe
                    sum := 0.0;
                    for j in 1 .. graph.sparsemat.width loop
                        sum := sum + P_Sparse.get(graph.sparsemat, i, j);
                    end loop;
                    -- Remplacer les 1 par 1/M avec M le nombre de page que le sommet pointe
                    for j in 1 .. graph.sparsemat.width loop
                        if sum = 0.0 then
                            Null;
                        else
                            P_Sparse.set(graph.sparsemat, i, j, T_Float(P_Sparse.get(graph.sparsemat, i, j)) / sum);
                        end if;
                    end loop;
                end loop;
        end case;
    end;

    -- Calcule la matrice S à partir de la matrice H
    procedure compute_S_matrix(graph : in out P_Graph.T_Graph) is
        sum : T_Float; -- Nombre de sommet j que le sommet i pointe
    begin
        for i in graph.fullmat'Range(1) loop
            -- On teste si la ligne n'est composée que de zéros
            sum := 0.0;
            for j in graph.fullmat'Range(2) loop
                sum := sum + P_Full.get(graph.fullmat, i, j);
            end loop;
            for j in graph.fullmat'Range(2) loop
                if sum = 0.0 then
                    -- On remplace la valeur des sommets concernés par 1/N
                    P_Full.set(graph.fullmat, i, j, 1.0 / T_Float(graph.fullmat'Length(1)));
                else
                    Null;
                end if;
            end loop;
        end loop;
    end;

    -- Calcule la matrice G à partir de la matrice S
    procedure compute_G_matrix(graph : in out P_Graph.T_Graph; alpha : T_Float) is
        e : constant P_Full.T_Matrix(graph.fullmat'Range(1),  1 .. 1) := P_Full.init(graph.fullmat'Length(1), 1, 1.0);
    begin
        -- On applique la formule G = alpha*S + (1-alpha)/N*e*e^T
        graph.fullmat := P_Full."+"(
                            P_Full."*"(alpha, graph.fullmat),
                            P_Full."*"(
                                (1.0-alpha) / T_Float(graph.fullmat'Length(1)), P_Full."*"(e, P_Full.T(e))
                            )
                        );
    end;

    -- Calcule le vecteur des poids pour les matrices pleines
    function compute_weight_vector_full(graph : in P_Graph.T_Graph; K : Natural) return P_Full.T_Matrix is
        pi : P_Full.T_Matrix(graph.fullmat'Range(1),  1 .. 1) := P_Full.init(graph.fullmat'Length(1), 1, 1.0 / T_Float(graph.fullmat'Length(1)));
    begin
        -- On itère l'algorithme K fois : pi^(k+1) = G*pi^(k)
        for i in 1 .. K loop
            pi := P_Full.T(P_Full."*"(P_Full.T(pi), graph.fullmat));
        end loop;
        return pi;
    end;

    -- Calcule le vecteur des poids pour les matrices creuses
    function compute_weight_vector_sparse(graph : in P_Graph.T_Graph; K : Natural) return P_Sparse.T_Matrix is
        pi : P_Sparse.T_Matrix := P_Sparse.init(graph.sparsemat.height, 1);
    begin
        -- On initialise pi^(0) à (1/N,...,1/N)
        for i in 1 .. graph.sparsemat.height loop
            P_Sparse.set(pi, i, 1, 1.0 / T_Float(graph.sparsemat.height));
        end loop;
        -- On itère l'algorithme K fois : pi^(k+1) = H*pi^(k)
        for i in 1 .. K loop
            pi := P_Sparse.T(P_Sparse."*"(P_Sparse.T(pi), graph.sparsemat));
        end loop;
        return pi;
    end;
end Algorithm;