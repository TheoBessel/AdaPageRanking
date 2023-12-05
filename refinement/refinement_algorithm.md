R0 : calculer pi_k

R1 : comment "calculer pi_k"
 -  traiter les arguments de la ligne de commande et initialiser les constantes
 -  Si creuse Faire                                             -- creuse : in booleen
        - calculer pi_k par les matrices creuse
    Sinon Faire
        - calculer pi_k par les matrices pleines
    Fin Si
    écrire le résultat dans prefixe.pr et prefixe.prw


R2 : Comment "traiter les arguments de la ligne de commande et initialiser les constantes"
    Si Argument_Count = 0 Faire                                 -- Argument_Count : in Entier
        - Afficher usage
    Sinon
        - traiter chaque les options donnés et initialisée les constantes
    Fin Si

R3 : Comment "Afficher usage"
 -  Afficher ("Usage : " & command_Name & " [option] reseau")   -- command_Name : in String
 -  Afficher une nouvelle ligne
 -  Afficher ("    reseau : Le réseau de page étudié")
 -  Afficher ("options : ")
 -  Afficher les options

R4 : Comment "Afficher les options"
 -  Afficher ("     -A <valeur> : Définir une valeur de alpha. La valeur doit être un nombre réel compris entre 0 et 1 inclus. La Valeur par défaut est 0.85")
 -  Afficher ("     -K <valeur> : Définir l'indice k du vecteur poids à calculer, pi_k, grâce à l'algorithme PageRank. La valeur doit être un entier positif. Sa valeur par défaut est 150")
 -  Afficher ("     -E <valeur> : Définir une précision (un epsilon) qui permettra d'interrompre le calcul PageRank si le vecteur poids est à une distance de vecteurs poids précédent strictement inférieure à epsilon. La valeur par défaut est 0.0 (désactiver)")
 -  Afficher ("     -P          : Choisir l'algorithme avec des matrices pleines")
 -  Afficher ("     -C          : Choisir l'algorithme avec des matrices creuses. C'est l'algorithme choisie par défaut")
 -  Afficher ("     -R <prefixe>: Choisir le préfixe des fichiers résultats, output")

R3 : Comment "traiter les options donnés et initialisée les constantes"
 -  Initialiser les obligation d'initialisation
    Pour i allant de 1 à Argument_Count Faire                   -- i : in out Entier; Argument_Count : in Entier
        - traiter l'option
    Fin Pour
 -  Initialiser les constantes non initialisée

R4 : Comment "Initialiser les obligation d'initialisation"
 -  Alpha_Non_Initialise := True                                -- Alpha_Non_Initialise : out Booleen
 -  K_Non_Initialise := True                                    -- K_Non_Initialise : out Booleen
 -  Epsilon_Non_Initialise := True                              -- Epsilon_Non_Initialise : out Booleen
 -  Creuse_Non_Initialise := True                               -- Creuse_Non_Initialise : out Booleen
 -  Prefixe_Non_Initialise := True                              -- Prefixe_Non_Initialise : out Booleen

R4 : Comment "Traiter l'option"
    Selon Argument(i)                                           -- i : in Entier
        dans "-A" => modifier la valeur de alpha                -- alpha : out Flottant
        dans "-K" => modifier la valeur de K                    -- K : out Entier
        dans "-E" => modifier la valeur de epsilon              -- epsilon : out Flottant
        dans "-P" => Creuse := False                            -- Creuse : out Booleen
        dans "-C" => Creuse := True                             -- Creuse : out Booleen
        dans "-R" => modiifer le prefixe des fichiers résultats -- prefixe : out String
        dans "*.net" => fichier := Argument(i)                  -- fichier : out FileType
        dans autres => rien
    FinSelon

R5 : Comment "modifier la valeur de alpha"
    Commencer
        Alpha := argument(i + 1)                                -- alpha : out Flottant
    Exception
        dans autres => Afficher usage; Quitter
    Fin


R5 : Comment "modifier la valeur de K"
    Commencer
        K := argument(i + 1)                                    -- K : out Entier
    Exception
        dans autres => Afficher usage; Quitter
    Fin

R5 : Comment "modifier la valeur de epsilon"
    Commencer
        epsilon := argument(i + 1)                              -- epsilon : out Flottant
    Exception
        dans autres => Afficher usage; Quitter
    Fin

R4 : Comment "initialiser les constantes non initialisée"
 -  initialiser alpha                                           -- alpha : out Flottant
 -  initialiser K                                               -- K : out Entier
 -  initialiser epsilon                                         -- epsilon : out Flottant
 -  initialiser prefixe                                         -- prefixe : out String
 -  initialiser N                                               -- N : out Entier
 -  initialiser les constantes indépendantes des paramètres

R5 : Comment "initialiser alpha"
    Si Alpha_Non_Initialise Faire                               -- Alpha_Non_Initialise : in Booleen
        alpha := 0.85;                                          -- alpha : out Flottant
    Sinon
        rien;
    FinSi

R5 : Comment "initialiser k"
    Si K_Non_Initialise Faire                                   -- K_Non_Initialise : in Booleen
        K := 150;                                               -- K : out Entier
    Sinon
        rien;
    FinSi

R5 : Comment "initialiser epsilon"
    Si Epsilon_Non_Initialise Faire                             -- Epsilon_Non_Initialise : in Booleen
        epsilon := 0.0;                                         -- epsilon : out Flottant
    Sinon
        rien;
    FinSi

R5 : Comment "initialiser prefixe"
    Si Prefixe_Non_Initialise Faire                             -- Prefixe_Non_Initialise : in Booleen
        prefixe := "output";                                    -- prefixe : out String
    Sinon
        rien;
    FinSi

R5 : Comment "initialiser N"
    N := ligne 1 de fichier mis en entier                       -- N : out Entier

R5 : Comment "initialiser les constantes indépendantes des paramètres"
 -  Initialiser e comme un vecteur de N colonnes rempli avec 1
 -  Initialiser pi_0 comme un vecteur de N colonnes rempli avec 1/N



R2 : Comment "calculer pi_k par les matrices pleines"
        - calculer la matrice G avec l'approche matrice pleine
        - i := 0                                                -- i : in out Entier
        TantQue pi_k < epsilon and i <= k                       -- pi_k : in out Matrice Flottant; epsilon : in Flottant; i : in out Entier; k : in Entier
                - pi_k := multiplier G par la matrice pi_0      -- G : in Matrice; pi_0 : in Matrice
                - i := i + 1;                                   
        Fin TantQue

R2 : Comment "calculer la matrice G par l'approche des matrices pleines"
 -  transformer la matrice S en la matrice G

R3 : Comment "transformer la matrice S en la matrice G"
 -  Obtenir la matrice S                                        -- S : in Matrice
 -  appliquer la deuxième transformation de Brin et Page

R4 : Comment "Obtenir la matrice S"
 -  Obtenir la matrice H                                        -- H : in Matrice
 -  transformer la matrice H en la matrice S

R5 : Comment "Obtenir la matrice H"
 -  Initialiser H                                               -- H : out Matrice
 -  remplir H
 
R6 : Comment "remplir H"
 -  remplir les lignes de H                                     -- H : out Matrice

R7 : Comment "remplir les lignes de H"
    Pour i allant de 1 à N faire                                -- i : in out Entier; N : in Entier
        - remplir les colonnes
    FinPour


R8 : Comment "remplir les colonnes de H"
    - determiner s'il existe au moins un lien sortant de la page Pi vers la page Pj
    Si existe au moins un lien sortant de la page Pi vers la page Pj Faire
        H(i*N + j) := 1 / |Pi|                                  -- H : out Matrice; P : in Graphe
    sinon Faire
        H(i*N + j) := 0
    Fin Si

R9 : Comment "détermniner s'il existe au moins un lien sortant de la page Pi vers la page Pj"
 -  S'il existe une arete entre Pi et Pj dans la le graphe


R5 : Comment "transformer la matrice H en la matrice S"
 -  remplacer toutes les lignes vides pour que la somme soit égale à 1

R6 : Comment "remplacer toutes les lignes vides pour que la somme soit égale à 1"
 - identifier les lignes qui sont vide et les remplir par 1/N   -- N : in Entier

R7 : Comment "identifier les lignes qui sont vide et les remplir par 1/N"
    Pour i allant de 1 à N Faire                                -- i : in out Entier; N : in Entier
        - regarder si toutes les colonnes sont nuls et les remplir si oui
    Fin Pour

R8 : Comment "regarder si toutes les colonnes sont nuls et les remplir si oui"
    Vide := True;                                               -- Vide : in out Booleen
    j := 1;                                                     -- j : in out Entier
    TantQue Vide and then j <= N Faire                          -- N : in Entier
        Vide := H(i * N + j) /= 0;                              -- H : in out Matrice
        j := j + 1;
    Fin TantQue
    - remplir si vide est Vrai

R9 : Comment "remplir si vide est Vrai"
    Si Vide Faire                                               -- Vide : in Booleen
        - remplir pour chaque colonne par 1/N                   -- N : in Entier
    Sinon Faire
        rien 
    Fin Si

R10 : Comment "remplir pour chaque colonne par 1/N"
    Pour j allant de 1 à N Faire                                -- j : in out Entier; N : in Entier
        H(i * N + j) := 1 / N;                                  -- H : out : Matrice
    Fin Pour

R4 : Comment "appliquer la deuxième transformation de Brin et Page"
 -  multiplier la matrice S par le scalaire alpha                       -- S : in out Matrice; alpha : in Flottant
 -  multiplier la matrice e par la matrice eT (eT = e transpose)        -- e : in out Matrice
 -  multiplier la matrice e x eT par le scalaire (1 - alpha) / N        -- e : in out Matrice; alpha : in Flottant; N : in Entier
 -  sommer la matrice alpha.S et la matrice (1 - alpha) / N x eeT       -- e, S : in out Matrice; alpha : in Flottant; N : in Entier

R2 : Comment "calculer pi_k par les matrices creuses"
