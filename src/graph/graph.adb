-- Implémantation du package graphe

package body graph is

    procedure lire_graphe is
        File : constant File_type;  -- Variable qui stocke le fichier du graphe 
        N : constant Integer;       -- Nombre de noeuds du graphe
        res : T_Matrix;             -- Matrice résultat du graphe
        line : Unbounded_String;    -- ligne du fichier
        depart : Integer;           -- le numéro du node de départ
        arrive : Integer;           -- le numéro du node d'arrivée
    begin
        open(File, Name => To_string(File_Name), mode => In_File);
        N := Integer'Value(Get_line(File));
        res := Initialiser(N, N, 0);
        loop
            line := Get_Line(File);
            depart := Get(line);
            arrive := Get(line);
            Mettre(res, depart, arrive, 1);
            exit when End_of_file(File);
        end loop;
        close(File);
        return res; 
    end lire_graphe;
end graph;