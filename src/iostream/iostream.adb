package body IOStream is
    procedure parse_args(args : T_Args) is
        function parse_composed_arg(prefix : String) return String is
            found : Boolean := False;
            output : Unbounded_String;
        begin
            for i in 1..args.V_Count loop
                if (args.V_Args(i) = To_Unbounded_String(prefix)) then
                    if found then
                        raise Bad_Arguments_Exception with "The argument " & To_String(args.V_Args(i)) & " has already been specified";
                    elsif i < args.V_Count then
                        output := args.V_Args(i + 1);
                        found := True;
                    else
                        raise Bad_Arguments_Exception with "An argument is missing after : " & To_String(args.V_Args(i));
                    end if;
                end if;
            end loop;
            return To_String(output);
        end;
        function parse_optionnal_arg(true_option : String; false_option : String) return Boolean is
            found : Boolean := False;
            output : Boolean := True;
        begin
            for i in 1..args.V_Count loop
                if (args.V_Args(i) = To_Unbounded_String(true_option)) then
                    if found then
                        raise Bad_Arguments_Exception with "The argument " & To_String(args.V_Args(i)) & " has already been specified";
                    else
                        output := True;
                        found := True;
                    end if;
                elsif (args.V_Args(i) = To_Unbounded_String(false_option)) then
                    if found then
                        raise Bad_Arguments_Exception with "The argument " & To_String(args.V_Args(i)) & " has already been specified";
                    else
                        output := False;
                        found := True;
                    end if;
                end if;
            end loop;
            return output;
        end;
    begin
        if args.V_Count < 1 then
            raise Bad_Arguments_Exception with "The program need at list one argument";
        else
            alpha := T_Float'Value(parse_composed_arg("-A"));
            k := Integer'Value(parse_composed_arg("-K"));
            eps := T_Float'Value(parse_composed_arg("-E"));
            if not parse_optionnal_arg("-P","-C") then
                mode := Creuse;
            end if;
            res := To_Unbounded_String(parse_composed_arg("-R"));
        end if;
    end;



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