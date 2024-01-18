with Ada.Command_Line; use Ada.Command_Line;

package body IOStream is
    -- Exceptions 
    Mauvais_Argument_Exception : Exception; -- Exception en cas d'erreur de la ligne de commande
    Mauvaise_Syntaxe_Exception : Exception; -- Exception en cas d'erreur de syntaxe d'un fichier
    
    procedure parse_args(args : out T_Arguments) is
        i : Positive := 1; -- indice de l'arguement traité

    begin
        -- Valeurs par défaut
        args.alpha := 0.85;
        args.K := 150;
        args.eps := 0.0;
        args.pleine := False;
        args.output := To_Unbounded_String("output");

        -- On récupère les arguments de la ligne de commande
        while (i <= Argument_Count) loop
            case Argument(i)(2) is
                when 'A' => begin
                        i := i + 1;
                        args.alpha := T_Float'Value(Argument(i));
                    exception when others =>
                        raise Mauvais_Argument_Exception ("L'argument suivant -A n'est pas un flottant compris entre 0.0 et 1.0");
                    end;
                when 'K' => begin
                        i := i + 1;
                        args.k := Natural'Value(Argument(i));
                    exception when others =>
                        raise Mauvais_Argument_Exception ("L'argument suivant -K n'est pas un entier strictement positif");
                    end;
                when 'E' => begin
                        i := i + 1;
                        args.eps := T_Float'Value(Argument(i));
                    exception when others =>
                        raise Mauvais_Argument_Exception ("L'argument qui suit -E n'est pas un Flottant");
                    end;
                when 'P' => 
                        args.pleine := True;
                when 'C' => 
                        args.pleine := False;
                when 'R' => begin
                        i := i + 1;
                        args.output := To_Unbounded_String(Argument(i));
                        if i = Argument_Count then
                            raise Mauvais_Argument_Exception ("Aucun argument spécifié");
                        elsif Argument(i)(1) = '-' then
                            raise Mauvais_Argument_Exception ("L'argument suivant est un autre paramètre");
                        end if;
                    end;
                when others => begin
                        args.input := To_Unbounded_String(Argument(i));
                    end;
            end case;
            i := i + 1;
        end loop;
    end;

    -- Parse un sommet sous la forme de deux nombres dans une String
    function parse_edge(input : String) return T_Edge is
        edge : T_Edge; -- Arête retourné
        n : constant Natural := input'Length;
        found : Boolean := False;
    begin
        for i in 1..n loop
            if input(i) = ' ' and not found then
                edge.start := Natural'Value(input(input'First..i-1));
                edge.stop := Natural'Value(input(i+1..input'Last));
                found := True;
            else
                null;
            end if;
        end loop;
        if not found then
            raise Mauvaise_Syntaxe_Exception("Une ligne du fichier ne respecte pas la syntaxe.");
        else
            null;
        end if;
        return edge;
    end;

    -- Compte le nombre d'arêtes du graphe
    function count_lines(file_name : Unbounded_String) return Natural is
        n : Natural;
        file : File_Type;
        
    begin
        n := 0;
        begin
            Open(file, name => To_String(file_name), mode => In_File, form => "shared=no");
        exception when others =>
            raise Mauvaise_Syntaxe_Exception ("Le fichier n'a pas put être ouvrir.");
        end;
        while not End_of_file(file) loop
            n := n + 1;
            Skip_Line(file);
        end loop;
        Reset(file);
        Close(file);
        return n;
    end;

    -- Parse le fichier .net en entrée
    function parse_file(file_name : Unbounded_String) return T_InFile is
        n : Natural; -- Nombre de sommet
        m : constant Natural := count_lines(file_name); -- Nombre d'arête
        output : T_InFile(m-1); -- résultat de la fonction
        file : File_Type; -- Fichier associé a nom du fichier en entré
        
    begin
        begin
            Open(file, name => To_String(file_name), mode => In_File, form => "shared=no");
        exception when others =>
            raise Mauvaise_Syntaxe_Exception ("Le fichier n'a pas put être ouvrir.");
        end;
        n := Integer'Value(Get_Line(file));
        output.n := n;
        for i in 1..m-1 loop -- m-1 arêtes pour m lignes dans le fichier
            output.edges(i) := parse_edge(Get_Line(file));
        end loop;
        Close(file);
        return output;
    end;

    -- Écrit les fichiers en sortie
    procedure write_file(file_name : Unbounded_String; file : in T_OutFile; params : in T_Arguments) is
        file_pr, file_prw : File_Type;
    begin
        Create(file_pr, name => To_String(file_name) & ".pr", mode => Out_File);
        Create(file_prw, name => To_String(file_name) & ".prw", mode => Out_File);

        printf_int(file_prw, file.n);
        Put(file_prw, " ");
        printf_float(file_prw, params.alpha);
        Put(file_prw, " ");
        printf_int(file_prw, params.K);
        Put_Line(file_prw, "");

        for i in 1..file.n loop
            printf_int(file_pr, file.pages(i).id); Put_Line(file_pr, "");
            printf_float(file_prw, file.pages(i).score); Put_Line(file_prw, "");
        end loop;

        Close(file_pr);
        Close(file_prw);
    end;
end IOStream;