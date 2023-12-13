with Ada.Exceptions;
with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Float_Text_IO;		use Ada.Float_Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Command_line;		use Ada.Command_line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

generic
    type T_Float is digits <>;

package IOStream is
    type T_Mode is (
        Pleine,
        Creuse
    );
    type T_Content is array (Positive range <>) of Unbounded_String;
    type T_Args(V_Count : Natural) is tagged record
        V_Args : T_Content(1..V_Count);
    end record;

    Bad_Arguments_Exception : Exception;

    alpha : T_Float := 0.85;
    k : Natural := 150;
    eps : T_Float := 0.0;
    mode : T_Mode := Pleine;
    res : Unbounded_String := To_Unbounded_String("output");

    procedure parse_args(args : T_Args);
    
    
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

private
end IOStream;