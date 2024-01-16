package body Algorithm is

    -- calcul la matrice H
    procedure compute_H_matrix(graph : in out P_Graph.T_Graph) is
        sum : T_Float;      -- Nombre de sommet j que le sommet i pointe
    begin
        -- Traiter chaque sommet du graphe
        for i in graph.mat'Range(1) loop
            -- Calculer le nombre de sommet que le sommet pointe
            sum := 0.0;
            for j in graph.mat'Range(2) loop
                sum := sum + P_Matrix.get(graph.mat, i, j);
            end loop;

            -- Remplacer les 1 par 1/M avec M le nombre de page que le sommet pointe
            for j in graph.mat'Range(2) loop
                if sum = 0.0 then
                    P_Matrix.set(graph.mat, i, j, 0.0);
                else
                    P_Matrix.set(graph.mat, i, j, T_Float(P_Matrix.get(graph.mat, i, j)) / sum);
                end if;
            end loop;
        end loop;
    end compute_H_matrix;

    -- Calcule la matrice S à partir de la matrice H
    procedure compute_S_matrix(graph : in out P_Graph.T_Graph) is
        sum : T_Float;      -- Nombre de sommet j que le sommet i pointe
    begin
        -- Pour chaque ligne
        for i in graph.mat'Range(1) loop
            -- Savoir si la ligne est vide
            sum := 0.0;
            for j in graph.mat'Range(2) loop
                sum := sum + P_Matrix.get(graph.mat, i, j);
            end loop;

            -- Changer les lignes vides
            if sum = 0.0 then
                for j in graph.mat'Range(2) loop
                    P_Matrix.set(graph.mat,i , j, (1.0 / T_Float(graph.mat'Length(1))));
                end loop;
            else
                null;
            end if;
        end loop;
    end compute_S_matrix;

    -- Calcule la matrice G à partir de la matrice S
    procedure compute_G_matrix(graph : in out P_Graph.T_Graph; alpha : in T_Float) is
        e : constant P_Matrix.T_Matrix(graph.mat'Range(1), 1..1) := P_Matrix.init(graph.mat'Length(1), 1, 1.0);   -- Vecteur de taille Nx1 remplis de 1.0
    begin
        -- Calculer G a partir de la formule
        graph.mat := P_Matrix."+"(P_Matrix."*"(alpha,graph.mat),
                    P_Matrix."*"((1.0 - alpha) / T_Float(graph.mat'Length(1)),
                                 P_Matrix."*"(e,P_Matrix.T(e))
                                )
                    );
    end compute_G_matrix;

    -- Calcule le vecteur des poids des pages
    function compute_weight_vector(graph : in P_Graph.T_Graph; K : in Natural) return P_Matrix.T_Matrix is
        pi : P_Matrix.T_Matrix(graph.mat'Range(1), 1..1) := P_Matrix.init(graph.mat'Length(1),1,1.0/T_Float(graph.mat'Length(1)));  -- Le vecteur des poids des pages initialisé à 1/N
    begin
        -- Pour chaque itération
        for i in 1..K loop
            -- Effectuer PiT * G
            pi := P_Matrix.T(P_Matrix."*"(P_Matrix.T(pi),graph.mat));
        end loop;
        return pi;
    end compute_weight_vector;
end Algorithm;