with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

with Full;
with Sparse;
with IOStream;
with Graph;
with Algorithm;

procedure PageRank is
    type T_Real is digits 4;

    -- Importation des différents packages
    package F_IOStream is
        new IOStream(T_Float => T_Real);
    use F_IOStream;
    
    package F_Full is
        new Full(T_Float => T_Real, P_IOStream => F_IOStream);
    use F_Full;
    
    package F_Sparse is
        new Sparse(T_Float => T_Real, P_IOStream => F_IOStream);
    use F_Sparse;

    package F_Graph is
        new Graph(T_Float => T_Real, P_Full => F_Full, P_Sparse => F_Sparse, P_IOStream => F_IOStream);
    use F_Graph;

    package F_Algorithm is
        new Algorithm(T_Float => T_Real, P_IOStream => F_IOStream, P_Full => F_Full, P_Sparse => F_Sparse, P_Graph => F_Graph);

    -- Affichage des valeurs flottantes des matrices
    procedure printf_float(t : File_Type; f : T_Real) is
    begin
        Put(t, Float(f), Aft => 8, Exp => 0, Fore => 1);
    end;

    -- Affichage des valeurs entières des matrices
    procedure printf_integer(t : File_Type; i : Integer) is
    begin
        Put(t, i, 1);
    end;

    -- Instantitation de l'écriture de fichiers
    procedure write_file is new  F_IOStream.write_file(printf_int => printf_integer, printf_float => printf_float);

    -- Paramètres de ligne de commande
    params : T_Arguments;
begin
    Put_Line("Running main program ..."); New_Line;

    -- Récupération des paramètres de ligne de commande
    F_IOStream.parse_args(params);

    declare
        -- Fichier en entrée
        file : constant F_IOStream.T_InFile := F_IOStream.parse_file(params.input);
        -- Fichier en sortie
        output : F_IOStream.T_OutFile(file.n);
        -- Graphe du réseau
        graph : F_Graph.T_Graph(file.n, params.pleine);
    begin
        if params.pleine then
            declare
                pi, indices : F_Full.T_Matrix(1..file.n, 1..1);
            begin
                -- Initialisation du graphe
                graph := F_Graph.init(file, params.pleine);

                -- Calcul de la matrice H
                F_Algorithm.compute_H_matrix(graph);
                -- Calcul de la matrice S
                F_Algorithm.compute_S_matrix(graph);
                -- Calcul de la matrice G
                F_Algorithm.compute_G_matrix(graph, params.alpha);
                -- Calcul du vecteur de poids
                pi := F_Algorithm.compute_weight_vector_full(graph, params.K);

                -- Tri du vecteur de poids
                indices := F_Full.sort(pi);

                -- Exportation des résultats
                output := F_Full.export(indices,pi);
                write_file(params.output, output, params);
            end;
        else
            declare
                sparse_pi : F_Sparse.T_Matrix := F_Sparse.init(file.n, 1);
                pi, indices : F_Full.T_Matrix(1..file.n, 1..1);
            begin
                -- Initialisation du graphe
                graph := F_Graph.init(file, params.pleine);

                -- Calcul de la matrice H
                F_Algorithm.compute_H_matrix(graph);

                -- Calcul du vecteur de poids
                sparse_pi := F_Algorithm.compute_weight_vector_sparse(graph, params.K);

                -- Tri du vecteur de poids
                pi := F_Graph.sparse_to_full(sparse_pi);
                indices := F_Full.sort(pi);

                -- Exportation des résultats
                output := F_Full.export(indices,pi);
                write_file(params.output, output, params);
            end;
        end if;
    end;
end PageRank;