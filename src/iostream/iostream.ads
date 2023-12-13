with Ada.Exceptions;
with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Float_Text_IO;		use Ada.Float_Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Command_line;		use Ada.Command_line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with graph;

generic
    type T_Float is digits <>;

package IOStream is
    
    type T_Constantes;

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


    -- Parse_Args
    -- Traiter les paramètres et définir les constantes
    -- Paramètres : 
    --      - args          [in]        Le tableau des arguments données
    --      - Constantes    [out]       Record qui contient toutes les constantes
    -- pre :
    --      - Auncune
    -- post :
    --      - Aucune
    procedure Parse_Args(args : in T_Args; Constantes : out T_Constantes);
    
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
    procedure Lire_Graphe(File_Name : in Unbounded_String; Network : out T_Graphe);

    type T_Constantes is record
        
        alpha : T_Float;
        k : Natural;
        eps : T_Float;
        mode : T_Mode;
        prefixe : Unbounded_String;
    end record;

private


end IOStream;