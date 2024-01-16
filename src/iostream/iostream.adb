-- implémentation du module IOstream
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;

package body IOStream is

    -- Initialise les constantes en fonction des arguments de la ligne de commande
    procedure parse_args(args : out T_Arguments) is
        i : Positive := 1;          -- L'indice de l'argument traité
    begin
        -- Default parameter values
        args.alpha := 0.85;
        args.K := 150;
        args.eps := 0.0;
        args.pleine := False;
        args.output := To_Unbounded_String("output");

        -- traiter les arguments de la commande
        while (i <= Argument_Count) loop            
            case Argument(i)(2) is
                when 'A' => begin
                        i := i + 1;
                        args.alpha := T_Float'Value(Argument(i));
                    end;
                when 'K' => begin
                        i := i + 1;
                        args.k := Natural'Value(Argument(i));
                    end;
                when 'E' => begin
                        i := i + 1;
                        args.eps := T_Float'Value(Argument(i));
                    end;
                when 'P' => begin
                        args.pleine := True;
                    end;
                when 'C' => begin
                        args.pleine := False;
                    end;
                when 'R' => begin
                        i := i + 1;
                        args.output := To_Unbounded_String(Argument(i));
                    end;
                when others => begin -- TODO : Check if i == Argument_Count, else raise exception.
                        args.input := To_Unbounded_String(Argument(i));
                    end;
            end case;
            i := i + 1;
        end loop;
    end;

    -- Renvoie dans un enregistrement le sommet de départ et le sommet d'arrivé d'une arête
    function parse_edge(input : in String) return T_Edge is
        edge : T_Edge;                          -- Enregistrement qui stockent le sommet de départ et le sommet d'arrivée d'une arète
        n : constant Natural := input'Length;   -- La longueur de la chaine de caractère lu en entrée
        found : Boolean := False;               -- Si un espace est rencontré
    begin
        -- Traiter la ligne du fichier en fonction du caractère
        for i in 1..n loop
            -- Traiter la rencontre avec un espace
            if input(i) = ' ' and not found then
                edge.start := Natural'Value(input(input'First..i-1));
                edge.stop := Natural'Value(input(i+1..input'Last));
                found := True;
            else
                null;
            end if;
        end loop;
        return edge;
    end;


    -- count_lines
    -- Compte le nombre de ligne d'un fichier dont le nom est donné en argument
    -- Paramètre :
    --      - file_name         [in]        Le nom du fichier que l'on traite
    -- Pre :
    --      - Aucune
    -- Post :
    --      - Aucune
    function count_lines(file_name : in Unbounded_String) return Natural is
    n : Natural := 0;               -- Le nombre de ligne du fichier
        file : File_Type;           -- Le fichier que l'on traite
    begin
        -- Ouvrir le fichier
        Open(file, name => To_String(file_name), mode => In_File, form => "shared=no");
        
        -- Compter les lignes du fichier
        while not End_of_file(file) loop
            n := n + 1;
            Skip_Line(file);
        end loop;
        
        -- Fermer le fichier
        Reset(file);
        Close(file);
        return n;
    end;


    -- Renvoie un enregistrement avec le nombre de sommet du graphe et la liste d'arête du graphe
    function parse_file(file_name : in Unbounded_String) return T_File is
        n : Natural;
        m : constant Natural := count_lines(file_name);
        output : T_File(m-1);
        file : File_Type;
    begin
        Open(file, name => To_String(file_name), mode => In_File, form => "shared=no");
        
        -- Lire le nombre de sommet du graphe
        n := Integer'Value(Get_Line(file));
        output.n := n;

        -- Traiter les lignes du fichiers comportant les arètes
        for i in 1..(m-1) loop -- m-1 edges because m lines with number of nodes
            output.edges(i) := parse_edge(Get_Line(file));
        end loop;

        Close(file);

        return output;
    end;
end IOStream;