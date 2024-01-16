-- Spécification du module iostream
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

generic
    type T_Float is digits <>;

package IOStream is
    -- Command line arguments
    type T_Arguments is record
        alpha  : T_Float range 0.0 .. 1.0;  -- Valeur du coefficient alpha, doit être compris entre 0 et 1
        k      : Natural;                   -- Valeur de k, le nombre d'itération du calcul du vecteur poids, doit être positif
        eps    : T_Float;                   -- Valeur de epsilon, la valeur à partir de laquelle on considère qu'une valeur absolue est nulle
        pleine : Boolean;                   -- Si le code doit être éxécuter selon l'algorithme des matrices pleines ou creuse sinon
        output : Unbounded_String;          -- Nom du fichier de sortie
        input  : Unbounded_String;          -- Nom du réseau que l'on traite
    end record;

    -- File structure
    -- type pour représenter une arête
    type T_Edge is record
        start : Natural;        -- sommet de départ, doit être positif
        stop : Natural;         -- sommet d'arrivée, doit être positif
    end record;

    -- type de liste d'arête
    type T_Edges is array (Positive range <>) of T_Edge;

    type T_File(m : Natural) is tagged record
        n : Natural;            -- Le nombre de sommet du graphe, doit être positif
        edges : T_Edges(1..m);  -- La liste des arêtes du graphe
    end record;

    -- Functions
    
    -- parse_args
    -- Initialise les constantes en fonction des arguments de la ligne de commande
    -- Paramètre :
    --      - args      [out]       Les constantes qui résultes du traitement
    -- Pre :
    --      - Aucune
    -- Post :
    --      - Aucune
    procedure parse_args(args : out T_Arguments);

    -- parse_edge
    -- Renvoie dans un enregistrement le sommet de départ et le sommet d'arrivé d'une arête
    -- Paramètre :
    --      - input     [in]        La ligne du fichier que l'on traite
    -- Pre :
    --      - Aucune
    -- Post :
    --      - Aucune
    function parse_edge(input : in String) return T_Edge;

    -- parse_file
    -- Renvoie un enregistrement avec le nombre de sommet du graphe et la liste d'arête du graphe
    -- Paramètres :
    --      - file_name [in]        Le nom du fichier que l'on traite
    -- Pre :
    --      - Aucune
    -- Post :
    --      - Aucune
    function parse_file(file_name : in Unbounded_String) return T_File;
end IOStream;