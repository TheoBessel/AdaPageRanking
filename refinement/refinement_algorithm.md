R0 : Calculer pi_k

R1 : Comment "Calculer pi_k"
    Traiter les arguments de la ligne de commande et initialiser les constantes -- alpha : out Flottant, k : out entier, eps : out flottant, pleine : out Booléan, prefixe : out Unbounded_String, input : out Unbounded_String
    Si pleine Faire                                              -- PLeine : in booleen
        Calculer pi_k par les matrices pleines
    Sinon Faire
        Calculer pi_k par les matrices creuse
    Fin Si
    Ecrire le résultat dans prefixe.pr et prefixe.prw


R2 : Comment "Traiter les arguments de la ligne de commande et initialiser les constantes"
    Si Argument_Count = 0 Faire                                 -- Argument_Count : in Entier
        Afficher usage
    Sinon
        Traiter chaque les options donnés et initialisée les constantes -- alpha : out Flottant, k : out entier, eps : out flottant, pleine : out Booléan, prefixe : out Unbounded_String, input : out Unbounded_String
    Fin Si

R3 : Comment "Afficher usage"
    Afficher ("Usage : " & Command_Name & " [option] reseau")   -- Command_Name : in String
    Afficher une nouvelle ligne
    Afficher ("    reseau : Le réseau de page étudiée")
    Afficher ("Options : ")
    Afficher les options

R4 : Comment "Afficher les options"
    Afficher ("     -A <valeur> : Définir une valeur de alpha. La valeur doit être un nombre réel compris entre 0 et 1 inclus. La Valeur par défaut est 0.85")
    Afficher ("     -K <valeur> : Définir l'indice k du vecteur poids à calculer, pi_k, grâce à l'algorithme PageRank. La valeur doit être un entier positif. Sa valeur par défaut est 150")
    Afficher ("     -E <valeur> : Définir une précision (un epsilon) qui permettra d'interrompre le calcul PageRank si le vecteur poids est à une distance de vecteurs poids précédent strictement inférieure à epsilon. La valeur par défaut est 0.0 (désactiver)")
    Afficher ("     -P          : Choisir l'algorithme avec des matrices pleines")
    Afficher ("     -C          : Choisir l'algorithme avec des matrices creuses. C'est l'algorithme choisie par défaut")
    Afficher ("     -R <prefixe>: Choisir le préfixe des fichiers résultats, output")

R3 : Comment "Traiter les options donnés et initialisée les constantes"
    Initialiser les constantes par leur valeur par défaut
    Pour i allant de 1 à Argument_Count Faire                   -- i : in out Entier; Argument_Count : in Entier
        Traiter l'option                                        -- alpha : out Flottant, k : out entier, eps : out flottant, pleine : out Booléan, prefixe : out Unbounded_String, input : out Unbounded_String
    Fin Pour
    Initialiser les constantes non initialisée

R4 : Comment "Initialiser les constantes par leur valeur par défaut"
    alpha: Flottant := 0.85                                     -- alpha    : out Booleen
    k := 150                                                    -- k        : out Booleen
    Epsilon := 0                                                -- eps      : out Booleen
    pleine := False                                             -- pleine   : out Booleen
    output := True                                              -- output   : out Booleen

R4 : Comment "Traiter l'option"
    Selon Argument(i)                                           -- i        : in Entier
        Dans "-A" => Modifier la valeur de alpha                -- alpha    : out Flottant
        Dans "-K" => Modifier la valeur de K                    -- K        : out Entier
        Dans "-E" => Modifier la valeur de epsilon              -- epsilon  : out Flottant
        Dans "-P" => Pleine := True                             -- Pleine   : out Booleen
        Dans "-C" => Pleine := False                            -- Pleine   : out Booleen
        Dans "-R" => Modifer le prefixe des fichiers résultats  -- prefixe  : out String
        Dans "*.net" => fichier := Argument(i)                  -- fichier  : out FileType
        Dans autres => Rien
    FinSelon

R5 : Comment "Modifier la valeur de alpha"
    Commencer
        alpha := Argument(i + 1)                                -- alpha    : out Flottant
    Exception
        Dans Autres => Afficher usage; Quitter
    Fin


R5 : Comment "Modifier la valeur de K"
    Commencer
        K := Argument(i + 1)                                    -- K        : out Entier
    Exception
        Dans Autres => Afficher usage; Quitter
    Fin

R5 : Comment "Modifier la valeur de epsilon"
    Commencer
        epsilon := Argument(i + 1)                              -- epsilon  : out Flottant
    Exception
        Dans Autres => Afficher usage; Quitter
    Fin

R2 : Comment "Calculer pi_k par les matrices pleines"
    calculer la matrice G avec l'approche matrice pleine
    i := 0                                                      -- i        : in out Entier
    pi_k := pi_0                                                -- pi_k     : in out Matrice Flottant
    TantQue pi_k < epsilon and i <= k                           -- epsilon : in Flottant; i : in out Entier; k : in Entier
        pi_k := Multiplier G par la matrice pi_k                -- G : in Matrice; pi_0 : in Matrice
        i := i + 1;
    Fin TantQue

R2 : Comment "Calculer la matrice G par l'approche des matrices pleines"
    Initialiser le graphe                                       -- graph : out Graphe
    Calculer le graphe de la matrice H à partir du graphe       -- graph : in out Graphe
    Calculer le graphe S à partir du graphe H                   -- graph : in out Graphe
    Calculer le graphe G à partir du graphe S                   -- graph : in out Graphe


R3 : Comment "Calculer le graphe de la matrice H à partir du graphe"
    Pour i allant de 1 à N faire                                -- i : in out Entier; N : in Entier
        Remplir les colonnes
    FinPour

R8 : Comment "Remplir les colonnes de H"
    Determiner s'il existe au moins un lien sortant de la page Pi vers la page Pj
    Si existe au moins un lien sortant de la page Pi vers la page Pj Faire
        H(i*N + j) := 1 / |Pi|                                  -- H : out Matrice;
    Sinon Faire
        H(i*N + j) := 0
    Fin Si

R9 : Comment "Détermniner s'il existe au moins un lien sortant de la page Pi vers la page Pj"
    S'il existe une arete entre Pi et Pj dans la le graphe


R5 : Comment "Transformer la matrice H en la matrice S"
    Remplacer toutes les lignes vides pour que la somme soit égale à 1

R6 : Comment "Remplacer toutes les lignes vides pour que la somme soit égale à 1"
    Identifier les lignes qui sont vide et les remplir par 1/N   -- N : in Entier

R7 : Comment "Identifier les lignes qui sont vide et les remplir par 1/N"
    Pour i allant de 1 à N Faire                                -- i : in out Entier; N : in Entier
        Regarder si toutes les colonnes sont nuls et les remplir si oui
    Fin Pour

R8 : Comment "Regarder si toutes les colonnes sont nuls et les remplir si oui"
    Vide := True;                                               -- Vide : in out Booleen
    j := 1;                                                     -- j : in out Entier
    TantQue Vide and then j <= N Faire                          -- N : in Entier
        Vide := H(i * N + j) /= 0;                              -- H : in out Matrice
        j := j + 1;
    Fin TantQue
    Remplir si vide est Vrai

R9 : Comment "Remplir si vide est Vrai"
    Si Vide Faire                                               -- Vide : in Booleen
        Remplir pour chaque colonne par 1/N                   -- N : in Entier
    Sinon Faire
        Rien 
    Fin Si

R10 : Comment "Remplir pour chaque colonne par 1/N"
    Pour j allant de 1 à N Faire                                -- j : in out Entier; N : in Entier
        H(i * N + j) := 1 / N;                                  -- H : out : Matrice
    Fin Pour

R4 : Comment "Appliquer la deuxième transformation de Brin et Page"
    Multiplier la matrice S par le scalaire alpha                       -- S : in out Matrice; alpha : in Flottant
    Multiplier la matrice e par la matrice eT (eT = e transpose)        -- e : in out Matrice
    Multiplier la matrice e x eT par le scalaire (1 - alpha) / N        -- e : in out Matrice; alpha : in Flottant; N : in Entier
    Sommer la matrice alpha.S et la matrice (1 - alpha) / N x eeT       -- e, S : in out Matrice; alpha : in Flottant; N : in Entier

R2 : Comment "Calculer pi_k par les matrices creuses"