with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with graph;

generic
    type T_Float is digits <>;
    with function "<" (left : in T_Float; right : in T_Float) return Boolean;

package IOStream is
    
    -- type discret qui permet de faire 
    type T_Argument is (
        Alpha, Creuse, Pleine, K, Epsilon, Prefixe, Autre
    );

    type T_Constantes;

    -- Type énumération qui définie le mode de calcul
    type T_Mode is (
        Pleine,
        Creuse
    );

    -- le tableau vide des arguments
    type T_Content is array (Positive range <>) of Unbounded_String;
    
    -- les arguments
    type T_Args(V_Count : Natural) is tagged record
        V_Args : T_Content(1..V_Count);
    end record;

    -- Exception levé quand les argument ne fonctionne pas
    Bad_Arguments_Exception : Exception;

    -- To_Argument
    -- retourne l'argument de la chaine de caractère donnée en argument
    -- Paramètres :
    --      - Chaine        [in]        La chaine de caratère
    -- Pre :
    --      - Aucune
    -- Post :
    --      - Aucune
    function To_Argument (Chaine : in Unbounded_String) return T_Argument;


    -- Parse_Args
    -- Traiter les paramètres et définir les constantes
    -- Paramètres : 
    --      - args          [in]        Le tableau des arguments données
    --      - Constantes    [out]       Record qui contient toutes les constantes
    -- pre :
    --      - Auncune
    -- post :
    --      - Aucune
    function Parse_Args(args : in T_Args) return T_Constantes;

    -- Lire_Nombre_Sommet
    -- retourne le nombre de sommet du graphe
    -- Paramètres :
    --      - Aucun
    -- Pre :
    --      - Aucune
    -- Post :
    --      - Aucune
    function Lire_Nombre_Sommet(File_Name : in Unbounded_String) return Natural;

    -- Parseur_Ligne
    -- Decomposer la ligne "an...a0 bm...b0" en deux entier an...a0 et bm...b0
    -- Paramètres :
    --      - Line      [in]        La ligne qui possède les deux entier séparé par un espace
    --      - Depart    [out]       Le premier entier
    --      - Arrivee   [out]       Le dexième entier
    -- Pre:
    --      - Aucune
    -- Post :
    --      - Aucune
    procedure Parseur_Ligne (Line : in Unbounded_String; Depart : out Positive; Arrivee : out Positive);

    --procedure parse_file(name : Unbounded_String);

    -- Lire_Graphe
    -- lire le fichier texte associé à File_Name et retourne une matrice d'adjacence de taille N erreur si le nombre de noeud dans le fichier est supérieur à la valeur de généricité
    -- Paramètres :
    --      - File_Name     [in]        Le nom du fichier dont le graphe doit être extrait
    --      - Network       [out]       La variable qui stocke le graphe
    -- pre :
    --      - Aucune
    -- post :
    --      - Aucune
    -- Exemple :
    --      Graphe : T_Graphe;
    --      File_Name : Unbounded_String := To_Unbounded_String("Test.net");
    --      Lire_graphe(File_Name, Graphe);
    --      Graphe = ⌈ 0 1 1 1 0 ⌉
    --               | 1 0 1 0 0 |
    --               | 1 1 0 0 0 |
    --               | 1 0 0 0 1 |
    --               ⌊ 0 0 0 1 0 ⌋
    generic
        with package Graphe is new graph (<>);
    procedure Lire_Graphe(File_Name : in Unbounded_String; Network : out Graphe.T_Graphe);

    type T_Constantes is record
        
        alpha : T_Float;
        k : Natural;
        eps : T_Float;
        mode : T_Mode;
        prefixe : Unbounded_String;
    end record;

private


end IOStream;