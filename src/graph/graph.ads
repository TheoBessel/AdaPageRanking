-- module qui lit un nom de fichier qui représentent un graphe par arrete
-- et stocke un type graphe
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;

generic
    type T_Matrix is private;
    with function Initialiser(height: in Positive; width : in Positive; val : in Integer) return T_Matrix;
    with procedure Mettre (mat : out T_Matrix; i : in Positive; j : in Positive; val : in Integer);
    
package graph is
    -- lire_graphe
    -- lire le fichier texte associé à file_name et retourne une matrice d'adjacence
    -- Paramètres :
    --      - File_Name     [in]        Le nom du fichier dont le graphe doit être extrait 
    -- pre :
    --      - Aucune
    -- post :
    --      - Aucune
    -- Exemple :
    --      File_Name := "../Examples/Test.net"
    --      Graphe := Lire_graphe(File_Name);
    --      Graphe = ⌈ 0 1 1 1 0 ⌉
    --               | 1 0 1 0 0 |
    --               | 1 1 0 0 0 |
    --               | 1 0 0 0 1 |
    --               ⌊ 0 0 0 1 0 ⌋
        
    function Lire_Graphe(File_Name : Unbounded_String) return T_Matrix; 
private
end graph;
