-- Implémantation du package graphe
with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;

package body graph is

    procedure Initialiser (Graphe : out T_Graphe) is
    begin
        Graphe.Nombre_Noeuds := N;
        Graphe.Mat := init(N, N, 0);
    end Initialiser;


    procedure Lire_Graphe(File_Name : in Unbounded_String; Network : out T_graphe) is
        File : File_type;               -- Variable qui stocke le fichier du graphe 
        N : Natural;                    -- Nombre de noeuds du graphe
        line : Unbounded_String;        -- ligne du fichier
        Depart : Positive;              -- le numéro du node de départ
        Arrivee : Positive;              -- le numéro du node d'arrivée
        
        -- Parseur
        -- Decomposer la ligne "an...a0 bm...b0" en deux entier an...a0 et bm...b0
        -- Paramètres :
        --      - Line      [in]        La ligne qui possède les deux entier séparé par un espace
        --      - Depart    [out]       Le premier entier
        --      - Arrivee   [out]       Le dexième entier
        -- Pre:
        --      - Aucune
        -- Post :
        --      - Aucune
        procedure Parseur (Line : in Unbounded_String; Depart : out Positive; Arrivee : out Positive) is
            Caractere : Character;                              -- chaine de caractère lu par le curseur
            long : constant Natural := length(Line);            -- La longueur de la ligne
            I : Natural;                                        -- Itérateur sur la chaine de caractère
        begin
            I := 0;
            loop
                I:= I+1;
                Caractere := Element(Line, I);
                exit when Caractere = ' ' or I = long;
            end loop;
            Depart := Integer'Value(To_String(Line)(1..I));
            Arrivee := Integer'Value(To_String(Line)(I..long));

        end Parseur;

    begin
        open(File, Name => To_string(File_Name), mode => In_File);

        -- lit le nombre de noeuds dans le fichier
        N := Integer'Value(Get_line(File));
        
        Initialiser(Network);
        
        loop
            line := To_Unbounded_String(Get_Line(File));
            Parseur(line, Depart, Arrivee);
            Creer_Arete(Network, Depart, Arrivee);
            exit when End_of_file(File);
        end loop;

        close(File);
    end Lire_Graphe;


    procedure Enregistrer (Network : in T_Graphe; File_Name : in Unbounded_String) is
        
        -- Tester_Fichier
        -- Creer le fichier Filename s'il n'existe pas
        -- Paramètres:
        --      - Aucun
        -- Pre:
        --      - Aucune
        -- Post:
        --      - Aucune
        procedure Tester_Fichier is
            File : File_Type;
        begin
            Create(File, Name => To_String(File_Name));
            Close(File);
        end Tester_Fichier;
        

        File : File_type;  -- Variable qui stocke le fichier du graphe 

    begin
        Tester_Fichier;
        open(File, Name => To_string(File_Name), mode => Out_File);
        for Depart in 1..(Network.Nombre_Noeuds) loop
            for Arrivee in 1..(Network.Nombre_Noeuds) loop
                if Posseder_Arete(Network, Depart, Arrivee) then
                    Put(File, Natural'Image(Depart));Put(File, " ");Put_line(File, Natural'Image(Arrivee));
                end if;
            end loop;
        end loop;
        close(File);
    end Enregistrer;


    function Posseder_Arete (Network : in T_Graphe; Depart : in Positive; Arrivee : in Positive) return Boolean is
    begin
        return (get(mat => Network.Mat, i => Depart, j => Arrivee) = 1);
    end Posseder_Arete;


    procedure Creer_Arete (Network : in out T_Graphe; Depart : in Positive; Arrivee : in Positive) is    
    begin
        set
          (mat => Network.Mat,
           i   => Depart,
           j   => Arrivee,
           val => 1);
    end Creer_Arete;


    procedure Supprimer_Arete (Network : in out T_Graphe; Depart : in Positive; Arrivee : in Positive) is
    begin
        set
          (mat => Network.Mat,
           i   => Depart,
           j   => Arrivee,
           val => 0);
    end Supprimer_Arete;


    procedure Copier_Graphe (Network : in T_Graphe; New_Network : out T_Graphe) is
    begin
        Initialiser(New_Network);
        for Depart in 1..(Network.Nombre_Noeuds) loop
            for Arrivee in 1..(Network.Nombre_Noeuds) loop
                if Posseder_Arete(Network, Depart, Arrivee) then
                    Creer_Arete
                      (Network => New_Network,
                       Depart  => Depart,
                       Arrivee => Arrivee);
                end if;
            end loop;
        end loop;
    end Copier_Graphe;


    function Arite_Sortante (Network : in T_Graphe) return Natural is
        Max : Natural := 0;     -- Max des degrés sortant des sommets visités
        Deg : Natural;          -- Nombre d'arete sortante du sommet i
    begin
        for i in 1..(Network.Nombre_Noeuds) loop
            Deg := Degre_Entrant(Network, i);
            if Max < Deg then
                Max := Deg;
            else
                null;
            end if;
        end loop;
        return Max;
    end Arite_Sortante;
    

    function Arite_Entrante (Network : in T_Graphe) return Natural is
        Max : Natural := 0;     -- Max des degrés entrants des sommets visités
        Deg : Natural;          -- Nombre d'arete entrante du sommet i
    begin
        for i in 1..(Network.Nombre_Noeuds) loop
            Deg := Degre_Entrant(Network, i);
            if Max < Deg then
                Max := Deg;
            else
                null;
            end if;
        end loop;
        return Max;
    end Arite_Entrante;


    function Degre_Entrant (Network : in T_Graphe; Sommet : in Positive) return Natural is
        Sum : Natural := 0;
    begin
        for i in 1..(Network.Nombre_Noeuds) loop
            if Posseder_Arete(Network => Network, Depart => Sommet, Arrivee => i) then
                Sum := Sum + 1;
            else
                null;
            end if;
        end loop;
        return Sum;
    end Degre_Entrant;


    function Degre_Sortant (Network : in T_Graphe; Sommet : in Positive) return Natural is
        Sum : Natural := 0;
    begin
        for i in 1..(Network.Nombre_Noeuds) loop
            if Posseder_Arete(Network => Network, Depart => Sommet, Arrivee => i) then
                Sum := Sum + 1;
            else
                null;
            end if;
        end loop;
        return Sum;
    end Degre_Sortant;


    function Nombre_Sommet (Network : in T_Graphe) return Natural is
    begin
        return Network.Nombre_Noeuds;
    end Nombre_Sommet;


    function Obtenir_Matrice (Network : in T_Graphe) return T_Matrix is
    begin
        return Network.Mat;
    end Obtenir_Matrice;


    procedure Afficher (Network : T_Graphe) is
    begin
        for I in 1..(Network.Nombre_Noeuds) loop
            for J in 1..(Network.Nombre_Noeuds) loop
                if Posseder_Arete(Network, i, j) then
                    Put(1, 1);
                else
                    Put(".");
                end if;
                Put(" ");
            end loop;
            New_Line;
        end loop;
    end Afficher;


    procedure Obtenir_Voisins (Network : in T_Graphe; Sommet : in Positive; Liste : out Bool_Liste) is
    begin
        for I in 1..(Network.Nombre_Noeuds) loop
            Liste(I) := Posseder_Arete(Network, Sommet, I);
        end loop;
    end Obtenir_Voisins;


    procedure Pour_Chaque_Voisins (Network : in T_Graphe; Sommet : in Positive) is
        bool_V : Bool_Liste;        -- La liste des booléans des voisins de Sommets
    begin
        Obtenir_Voisins(Network, Sommet, bool_V);
        for J in 1..N loop
            if bool_V(J) then
                Traiter(J);
            else
                null;
            end if;
        end loop;
    end Pour_Chaque_Voisins;


    procedure Parcours (Network : in T_Graphe; Sommet_initial : in Positive; Parcours : out Int_Liste) is
        A_Visite : T_Sac;
        Visite : T_Sac;
        Sommet : Positive := Sommet_initial;
        I : Positive := 1;
    
        procedure Ajouter_Sans_Doublons(Sommet : in Positive) is
        begin
            if not Est_Dans(A_Visite, Sommet) then
                Ajouter(A_Visite, Sommet);
            else
                null;
            end if;
        end;
    
        procedure Pour_Chaque_Voisins_Ajouter is
            new Pour_Chaque_Voisins(Ajouter_Sans_Doublons);
    
    begin
        Initialiser(A_Visite);
        Initialiser(Visite);
    
        loop
            if not Est_Dans(Visite, Sommet) then
                Parcours(I) := Sommet;
                Ajouter(Visite, Sommet);
                Pour_Chaque_Voisins_Ajouter(Network, Sommet);
            else
                null;
            end if;
            Retirer(A_Visite, Sommet);
            I := I + 1;
            exit when Est_Vide(A_Visite);
        end loop;
    end Parcours;

    --procedure Parcours (Network : in T_Graphe; Sommet_initial : in Positive; Parcours : out Int_Liste) is
    --begin
    --    Afficher(Network);
    --    for i in 1..N loop
    --        Parcours(i) := Sommet_initial;
    --    end loop;
    --end Parcours;

end graph;
