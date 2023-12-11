-- module qui lit un nom de fichier qui représentent un graphe par arrete
-- et stocke un type graphe
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Matrix;

generic
    N : Natural;   -- le Nombre de Noeud du graphe


package graph is

    type T_Graphe is limited private;

    type Int_Liste is limited private;

    type Bool_Liste is limited private;

    package maMatrix is
        new Matrix(Integer, "+", "*");
    use maMatrix;


    -- Initialiser
    -- Initialise un graphe a N noeuds
    -- Paramètres :
    --      - Graphe       [out]        Le graphe à initialiser
    -- Pre:
    --      - Aucune
    -- Post:
    --      - Aucune
    procedure Initialiser (Graphe : out T_Graphe);


    -- Lire_Graphe
    -- lire le fichier texte associé à File_Name et retourne une matrice d'adjacence
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
    function Posseder_Arete (Network: in T_Graphe; Depart : in Positive; Arrivee : in Positive) return Boolean;


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
    procedure Creer_Arete (Network : in out T_Graphe; Depart : in Positive; Arrivee : in Positive);


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
    procedure Supprimer_Arete (Network : in out T_Graphe; Depart : in Positive; Arrivee : in Positive);


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


    -- Arite_Entrante
    -- Donner le dégré maximal entrant du graphe
    -- Paramètres:
    --      - Network       [in]        Le graphe dont on va déterminer le degré maximal sortant
    -- Pre:
    --      - Aucune
    -- Post:
    --      - Aucune
    function Arite_Entrante(Network : in T_Graphe) return Natural;


    -- Arite_Sortante
    -- Donner le dégré maximal sortant du graphe
    -- Paramètres:
    --      - Network       [in]        Le graphe dont on va déterminer le degré maximal sortant
    -- Pre:
    --      - Aucune
    -- Post:
    --      - Aucune
    function Arite_Sortante(Network : in T_Graphe) return Natural;


    -- Degre_Entrant
    -- Déterminer le degré entrant du sommet donné en argument
    -- Paramètres:
    --      - Network       [in]        Le graphe sur lequel on travaille
    --      - Sommet        [in]        Le numéro du sommet duquel on va déterminer le degré entrant
    -- Pre:
    --      - Aucune
    -- Post:
    --      - Aucune
    function Degre_Entrant (Network : in T_Graphe; Sommet : in Positive) return Natural;


    -- Degre_Sortant
    -- Déterminer le degré sortant du sommet donné en argument
    -- Paramètres:
    --      - Network       [in]        Le graphe sur lequel on travaille
    --      - Sommet        [in]        Le numéro du sommet duquel on va déterminer le degré sortant
    -- Pre:
    --      - Aucune
    -- Post:
    --      - Aucune
    function Degre_Sortant (Network : in T_Graphe; Sommet : in Positive) return Natural;


    -- Nombre_Sommet
    -- Renvoie le nombre de sommets du graphe
    -- Paramètres:
    --      - Network       [in]        Le graphe dont on va renvoyer le nombre de sommet
    -- Pre:
    --      - Aucune
    -- Post:
    --      - Aucune
    function Nombre_Sommet (Network : in T_Graphe) return Natural;


    -- Obtenir_Matrice
    -- Renvoie la matrice du graphe
    -- Paramètres:
    --      - Network       [in]        Le graphe dont on va renvoyer le nombre de sommet
    -- Pre:
    --      - Aucune
    -- Post:
    --      - Aucune
    function Obtenir_Matrice (Network : in T_Graphe) return T_Matrix;


    -- Afficher
    -- Afficher la matrice d'adjacence du graphe
    -- Paramètres :
    --      - Network       [in]        Le graphe à afficher
    -- Pre :
    --      - Aucune
    -- Post :
    --      - Aucune
    procedure Afficher(Network : in T_Graphe);


    -- Obtenir_Voisins
    -- Donner les voisins d'un graphe
    -- Paramètres :
    --      - Network       [in]        Le graphe sur lequel on travaille
    --      - Sommet        [in]        Le sommet ou l'on veut connaitre les voisins
    --      - Liste         [out]       La liste des Voisins de Sommet
    -- Pre:
    --      - Aucune
    -- Post:
    --      - Aucune
    procedure Obtenir_Voisins (Network : in T_Graphe; Sommet : in Positive; Liste : out Bool_Liste);


    -- Pour_Chaque_Voisins
    -- Appliquer Traiter à chaque voisin
    -- Paramètres : 
    --      - Network       [in]        Le graphe sur lequel on travaille
    --      - Sommet        [in]        Le sommet dont on traite ses voisins
    -- Pre : 
    --      - Aucune
    -- Post :
    --      - Aucune
    generic 
        with procedure Traiter(Sommet : in Positive);
    procedure Pour_Chaque_Voisins(Network : in T_Graphe; Sommet : in Positive);



    -- Parcours
    -- Parcours le graphe en largeur
    -- Paramètres :
    --      - Network       [in]        Le graphe sur lequel on va  éffectuer un parcours en largeur
    --      - Sommet_initial[in]        Le sommet de départ du parcours
    --      - Parcours      [out]       Le parcours du graphe
    -- Pre :
    --      - Aucune
    -- Post :
    --      - Aucune
    generic
        type T_Sac is (<>);
        with procedure Ajouter(Sac : in out T_Sac; elt : in Integer);
        with procedure Retirer(Sac : in out T_Sac; Sommet : out Positive);
        with function Est_Dans(Sac : in T_Sac; elt : in Integer) return Boolean;
        with function Est_Vide(Sac : in T_Sac) return Boolean;
        with procedure Initialiser (Sac : out T_Sac);
    procedure Parcours (Network : in T_Graphe; Sommet_initial : in Positive; Parcours : out Int_Liste);


private
    type Int_Liste is array(1..N) of Integer;

    type Bool_Liste is array(1..N) of Boolean;

    type T_Graphe is record
        Nombre_Noeuds : Natural;
        Mat : T_Matrix(N, N);
    end record;

end graph;
