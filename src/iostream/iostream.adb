-- Implémantation du module IOStream

package body IOStream is

    procedure Parse_Args (args : in T_Args; Constantes : out T_Constantes) is
        alpha_non_initialisee : Boolean := True;
        k_non_initialisee : Boolean := True;
        eps_non_initialisee : Boolean := True;
        mode_non_initialisee : Boolean := True;
        res_non_initialisee : Boolean := True;
        prefix_non_initialisee : Boolean := True;
    begin
        for J in 1..args.V_Count loop
            case args.V_Args(J) is

                when "-A" =>
                    
                    if not alpha_non_initialisee then
                        raise Bad_Arguments_Exception with "Double définition de alpha en argument";
                    else
                        null;
                    end if;

                    alpha_non_initialisee := False;
                    if J+1 > args.V_Count then 
                        raise Bad_Arguments_Exception with "Aucune valeur de Alpha donné en argument";
                    else
                        null;
                    end if;

                    begin
                        Constantes.alpha := Float'Value(args.V_Args(J + 1));
                        if alpha < 0 or alpha > 1 then
                            raise Bad_Arguments_Exception with "L'argument qui suit -A n'est pas  compris entre 0 et 1";
                        else
                            null;
                        end if;
                    exception
                        when others =>
                            raise Bad_Arguments_Exception with "L'argument qui suit -A n'est pas un float";
                    end;

                when "-K" =>
                    -- vérification que K n'a pas déjà était définie
                    if not k_non_initialisee then
                        raise Bad_Arguments_Exception  with "Double définition de k en argument";
                    else
                        null;
                    end if;

                    k_non_initialisee := False;
                    if J+1 > args.V_Count then 
                        raise Bad_Arguments_Exception with "Aucune valeur de k donné en argument";
                    else
                        null;
                    end if;
                    begin
                        Constantes.k : constant Natural := Natural'Value(args.V_Args(J + 1));
                    exception
                        when others =>
                            raise Bad_Arguments_Exception with "L'argument qui suit -K n'est pas un entier Naturel";
                    end;
            
                when "-E" =>
                    -- vérification que eps n'a pas déjà était définie
                    if not eps_non_initialisee then
                        raise Bad_Arguments_Exception with "Double définition de eps en argument";
                    else
                        null;
                    end if;

                    eps_non_initialisee := False;

                    if J+1 > args.V_Count then 
                        raise Bad_Arguments_Exception with "Aucune valeur de eps donné en argument";
                    else
                        null;
                    end if;

                    begin
                        Constantes.eps := Float'Value(args.V_Args(J + 1));
                        if Constantes.eps < 0 then
                            raise Bad_Arguments_Exception with "L'arguement qui suit -E doit être un Float positif";
                    exception
                        when others =>
                            raise Bad_Arguments_Exception with "L'argument qui suit -E n'est pas un Float";
                    end;

                when "-P" =>
                    if not mode_non_initialisee then
                        raise Bad_Arguments_Exception with "Le mode a été choisi 2 fois";
                    else
                        null;
                    end if;

                    mode_non_initialisee := False;
                    
                    Constantes.mode := Pleine;


                when "-C" =>
                    if not mode_non_initialisee then
                        raise Bad_Arguments_Exception with "Le mode a été choisi 2 fois";
                    else
                        null;
                    end if;

                    mode_non_initialisee := False;

                    Constantes.mode := Creuse;

                when "-R" =>
                    if not prefix_non_initialisee then
                        raise Bad_Arguments_Exception with "Le préfixe de sortie a déjà été initialisé";
                    else
                        null;
                    end if;
                    
                    if J+1 > args.V_Count then 
                        raise Bad_Arguments_Exception with "Aucune valeur de prefixe donné en argument";
                    else
                        null;
                    end if;

                    Constantes.res := To_Unbounded_String(args.V_Args(J + 1));

                when others =>
                    raise Bad_Arguments_Exception with "L'argument " & To_String(args.V_Args(J)) & " n'est pas reconnu par le programme";
            end case;
        end loop;

        -- Initialisation des constantes non initialisée
        if alpha_non_initialisee then
            Constantes.alpha := 0.85;
        else
            null;
        end if;
        
        if k_non_initialisee then
            Constantes.k := 150;
        else
            null;
        end if;
        
        if prefix_non_initialisee then
            Constantes.res := To_Unbounded_String("output");
        else
            null;
        end if;

        if eps_non_initialisee then
            Constantes.eps := 0.0;
        else
            null;
        end if;
        
        
        if mode_non_initialisee then
            Constantes.mode := Creuse;
        else
            null;
        end if;         

    end Parse_Args;



    procedure Lire_Graphe(File_Name : in Unbounded_String; Network : out T_graphe) is
        File : File_type;                       -- Variable qui stocke le fichier du graphe 
        N : Natural;                            -- Nombre de noeuds du graphe
        line : Unbounded_String;                -- ligne du fichier
        Depart : Positive;                      -- le numéro du node de départ
        Arrivee : Positive;                     -- le numéro du node d'arrivée
        Implementation_Impossible : exception;  -- Exception levé quand le graph n'est pas implémentable à cause de la mauvaise valeur de généricité de Graphe


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
        -- Vérifie que le graphe est Implémentable avec la Valeur du type
        if N > Network.Nombre_Noeuds then
            raise Implementation_Impossible;
        else
            null;
        end if;
        
        Initialiser(Network);
        
        loop
            line := To_Unbounded_String(Get_Line(File));
            Parseur(line, Depart, Arrivee);
            Creer_Arete(Network, Depart, Arrivee);
            exit when End_of_file(File);
        end loop;

        close(File);
    end Lire_Graphe;


end IOStream;