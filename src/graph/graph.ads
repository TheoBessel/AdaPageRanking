-- module qui lit un nom de fichier qui représentent un graphe par arrete
-- et stocke un type graphe
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Matrix;

package graph is

    type T_Graphe is limited private;

    package Matrix is
        new Matrix(Integer, "+", "*");
    use Matrix;
    
    -- Lire_Graphe
    -- lire le fichier texte associé à File_Name et retourne une matrice d'adjacence
    -- Paramètres :
    --      - File_Name     [in]        Le nom du fichier dont le graphe doit être extrait 
    -- pre :
    --      - Aucune
    -- post :
    --      - Aucune
    -- Exemple :
    --      File_Name := "Test.net"
    --      Graphe := Lire_graphe(File_Name);
    --      Graphe = ⌈ 0 1 1 1 0 ⌉
    --               | 1 0 1 0 0 |
    --               | 1 1 0 0 0 |
    --               | 1 0 0 0 1 |
    --               ⌊ 0 0 0 1 0 ⌋
    function Lire_Graphe(File_Name : in Unbounded_String) return T_Graphe;

    -- Enregistrer
    -- Enregistrer un graphe dans un fichier File_Name à partir d'un graphe
    -- Paramêtres:
    --      - Network       [in]        Le graphe que l'on va enregistrer dans le fichier
    --      - File_Name     [in]        Le nom du fichier dans lequel on doit exporter le graphe
    -- pre :
    --      - Aucune
    -- post :
    --      - Aucune
    procedure Enregistrer(Network : in T_Graphe; File_Name : in Unbounded_String);

    -- Posseder_Arete
    -- Renvoie s'il existe une arete entre le sommet de Depart et le sommet d'Arrivee
    -- Paramètres:
    --      - Network       [in]        Le graphe dans lequel on va déterminer l'existence de l'arete
    --      - Depart        [in]        Le numéro du sommet de Départ de l'arete
    --      - Arrivee       [in]        Le numéro du sommet d'Arrivée de l'arete
    -- pre :
    --      - Aucune
    -- post : 
    --      - Aucune
    function Posseder_Arete (Network: in T_Graphe; Depart : in Natural; Arrivee : in Natural) return Boolean;

    -- Creer_Arete
    -- Creer une arete du sommet Depart au sommet Arrivee dans le graphe Network
    -- Paramètres:
    --      - Network       [in out]    Le graphe dans lequel on va créer l'arete
    --      - Depart        [in]        Le sommet de Depart de l'arete
    --      - Arrivee       [in]        Le sommet d'Arrivee de l'arete
    -- Pre:
    --      - Aucune
    -- Post:
    --      - Aucune
    procedure Creer_Arete (Network : in out T_Graphe; Depart : in Natural; Arrivee : in Natural);

    -- Supprimer_Arete
    -- Supprime une arete du graphe du sommet Depart au sommet Arrivee
    -- Paramètres:
    --      - Network       [in out]    Le graphe dans lequel on va supprimer l'arete
    --      - Depart        [in]        Le sommet de Depart de l'arete
    --      - Arrivee       [in]        Le sommet d'Arrivee de l'arete
    -- Pre:
    --      - Aucune
    -- Post:
    --      - Aucune
    procedure Supprimer_Arete (Network : in out T_Graphe; Depart : in Natural; Arrivee : in Natural);

    -- Copier_Graphe
    -- Copie le graphe Network dans le graphe New_Network
    -- Paramètres:
    --      - Network       [in]        Le graphe copié
    --      - New_Network   [out]       Le graphe qui contient la copie
    -- Pre:
    --      - Aucune
    -- Post:
    --      - Aucune
    procedure Copier_Graphe (Network : in T_Graphe; New_Network : out T_Graphe);

    -- Arite_Sortante
    -- Donner le dégré maximal sortant du graphe
    -- Paramètres:
    --      - Network       [in]        Le graphe dont on va déterminer le degré maximal sortant
    -- Pre:
    --      - Aucune
    -- Post:
    --      - Aucune
    function Arite_Sortante(Network : in T_Graphe) return Natural;

    -- Arite_Entrante
    -- Donner le dégré maximal entrant du graphe
    -- Paramètres:
    --      - Network       [in]        Le graphe dont on va déterminer le degré maximal entrant
    -- Pre:
    --      - Aucune
    -- Post:
    --      - Aucune
    function Arite_Entrante(Network : in T_Graphe) return Natural;

    -- Degre_Entrant
    -- Déterminer le degré entrant du sommet donné en argument
    -- Paramètres:
    --      - Network       [in]        Le graphe sur lequel on travaille
    --      - Sommet        [in]        Le numéro du sommet duquel on va déterminer le degré entrant
    -- Pre:
    --      - Aucune
    -- Post:
    --      - Aucune
    function Degre_Entrant (Network : in T_Graphe; Sommet : Positive) return Natural;


    -- Degre_Sortant
    -- Déterminer le degré sortant du sommet donné en argument
    -- Paramètres:
    --      - Network       [in]        Le graphe sur lequel on travaille
    --      - Sommet        [in]        Le numéro du sommet duquel on va déterminer le degré sortant
    -- Pre:
    --      - Aucune
    -- Post:
    --      - Aucune
    function Degre_Entrant (Network : in T_Graphe; Sommet : Positive) return Natural;

    -- Nombre_Sommet
    -- Renvoie le nombre de sommets du graphe
    -- Paramètres:
    --      - Network       [in]        Le graphe dont on va renvoyer le nombre de sommet
    -- Pre:
    --      - Aucune
    -- Post:
    --      - Aucune
    function Nombre_Sommet (Network : T_Graphe) return Natural;

private
    type T_Graphe is record
        Nombre_Noeuds : Natural;
        Mat : T_Matrix(Nombre_Noeuds, Nombre_Noeuds);
    end record;

end graph;
