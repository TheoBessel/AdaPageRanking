-- Implémantation du module IOStream
with Ada.Text_IO;			use Ada.Text_IO;



package body IOStream is

    function Parse_Args (args : in T_Args) return T_Constantes is
        constantes : T_Constantes;                  -- record qui stocke les constantes
        alpha_non_initialisee : Boolean := True;    -- si alpha     n'est pas initialisée
        k_non_initialisee : Boolean := True;        -- si K         n'est pas initialisée
        eps_non_initialisee : Boolean := True;      -- si epsilon   n'est pas initialisée
        mode_non_initialisee : Boolean := True;     -- si mode      n'est pas initialisée
        prefix_non_initialisee : Boolean := True;   -- si prefixe   n'est pas initialisée
        passer_parametre : Boolean := False;        -- si le paramètre n'es pas à analyser
    begin
        for J in 1..args.V_Count loop
            if passer_parametre then
                passer_parametre := False;

            elsif Length(args.V_Args) < 2 then
                raise Bad_Arguments_Exception with "L'argument n'est pas bien renseigner";
            
            else
                case To_String(args.V_Args(J))(2) is

                    when 'A' =>
                        
                        if not alpha_non_initialisee then
                            raise Bad_Arguments_Exception with "Double définition de alpha en argument";
                        else
                            null;
                        end if;

                        alpha_non_initialisee := False;
                        passer_parametre := True;

                        if J+1 > args.V_Count then 
                            raise Bad_Arguments_Exception with "Aucune valeur de Alpha donné en argument";
                        else
                            null;
                        end if;

                        begin
                            Constantes.alpha := T_Float'Value(To_String(args.V_Args(J + 1)));
                            if Constantes.alpha < 0.0 or 1.0 < Constantes.alpha then
                                raise Bad_Arguments_Exception with "L'argument qui suit -A n'est pas  compris entre 0 et 1";
                            else
                                null;
                            end if;
                        exception
                            when others =>
                                raise Bad_Arguments_Exception with "L'argument qui suit -A n'est pas un float";
                        end;

                    when 'K' =>
                        -- vérification que K n'a pas déjà était définie
                        if not k_non_initialisee then
                            raise Bad_Arguments_Exception  with "Double définition de k en argument";
                        else
                            null;
                        end if;

                        k_non_initialisee := False;
                        passer_parametre := True;
                        
                        if J+1 > args.V_Count then 
                            raise Bad_Arguments_Exception with "Aucune valeur de k donné en argument";
                        else
                            null;
                        end if;
                        begin
                            Constantes.k := Natural'Value(To_String(args.V_Args(J + 1)));
                        exception
                            when others =>
                                raise Bad_Arguments_Exception with "L'argument qui suit -K n'est pas un entier Naturel";
                        end;
                
                    when 'E' =>
                        -- vérification que eps n'a pas déjà était définie
                        if not eps_non_initialisee then
                            raise Bad_Arguments_Exception with "Double définition de eps en argument";
                        else
                            null;
                        end if;

                        eps_non_initialisee := False;
                        passer_parametre := True;

                        if J+1 > args.V_Count then 
                            raise Bad_Arguments_Exception with "Aucune valeur de eps donné en argument";
                        else
                            null;
                        end if;

                        begin
                            Constantes.eps := T_Float'Value(To_String(args.V_Args(J + 1)));
                            if Constantes.eps < 0.0 then
                                raise Bad_Arguments_Exception with "L'arguement qui suit -E doit être un Float positif";
                            else
                                null;
                            end if;
                        exception
                            when others =>
                                raise Bad_Arguments_Exception with "L'argument qui suit -E n'est pas un Float";
                        end;

                    when 'P' =>
                        if not mode_non_initialisee then
                            raise Bad_Arguments_Exception with "Le mode a été choisi 2 fois";
                        else
                            null;
                        end if;

                        mode_non_initialisee := False;
                        
                        Constantes.mode := Pleine;


                    when 'C' =>
                        if not mode_non_initialisee then
                            raise Bad_Arguments_Exception with "Le mode a été choisi 2 fois";
                        else
                            null;
                        end if;

                        mode_non_initialisee := False;

                        Constantes.mode := Creuse;

                    when 'R' =>
                        if not prefix_non_initialisee then
                            raise Bad_Arguments_Exception with "Le préfixe de sortie a déjà été initialisé";
                        else
                            null;
                        end if;

                        prefix_non_initialisee := False;
                        passer_parametre := True;

                        if J+1 > args.V_Count then 
                            raise Bad_Arguments_Exception with "Aucune valeur de prefixe donné en argument";
                        else
                            null;
                        end if;

                        Constantes.prefixe := args.V_Args(J + 1);

                    when others =>
                        if J = args.V_Count then
                            if '.' in args.V_Args(J) then
                                raise Bad_Arguments_Exception with "L'argument du nom du réseau ne possède pas d'extension"
                            constantes.Nom_Reseau := args.V_Args(J);
                        else
                            raise Bad_Arguments_Exception with "L'argument " & To_String(args.V_Args(J)) & " n'est pas reconnu par le programme";
                        end if;
                end case;
            end if;
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
            Constantes.prefixe := To_Unbounded_String("output");
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

        return Constantes;
    end Parse_Args;


    function Lire_Nombre_Sommet(File_Name : in Unbounded_String) return Natural is
        N : Natural;                            -- Le Nombre de Noeuds
        File : File_type;                       -- Variable qui stocke le fichier du graphe 
    begin
        open(File, Name => To_string(File_Name), mode => In_File);

        begin
            -- lit le nombre de noeuds dans le fichier
            N := Integer'Value(Get_line(File));
        exception
            when others => raise Bad_Arguments_Exception with "Le fichier ne respecte pas la structure demander";
        end;
        close(File);
        return N;
    end Lire_Nombre_Sommet;


    procedure Parseur_Ligne (Line : in Unbounded_String; Depart : out Natural; Arrivee : out Natural) is
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

    end Parseur_Ligne;


    procedure Lire_Graphe (File_Name : in Unbounded_String; Network : out Graphe.T_Graphe) is
        File : File_type;                       -- Variable qui stocke le fichier du graphe 
        line : Unbounded_String;                -- ligne du fichier
        Depart : Natural;                       -- le numéro du node de départ
        Arrivee : Natural;                      -- le numéro du node d'arrivée

        N : constant Natural := Lire_Nombre_Sommet(File_Name);

    begin
        open(File, Name => To_string(File_Name), mode => In_File);
        Skip_Line(File); -- on passe la ligne ou est affiché le nombre de sommet

        Graphe.Initialiser(Network);
        
        loop
            line := To_Unbounded_String(Get_Line(File));
            Parseur_Ligne(line, Depart, Arrivee);
            -- vérification de la cohérence des sommets données dans le fichier
            if Depart >= N or Arrivee >= N then
                raise Bad_Arguments_Exception;
            else
                null;
            end if;
            Graphe.Creer_Arete(Network, Depart+1, Arrivee+1);
            exit when End_of_file(File);
        end loop;

        close(File);
    end Lire_Graphe;

end IOStream;