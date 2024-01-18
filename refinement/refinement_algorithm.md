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

R2 : Comment "Traiter les options donnés et initialisée les constantes"
    Initialiser les constantes par leur valeur par défaut       -- alpha : out Flottant, k : out entier, eps : out flottant, pleine : out Booléan, prefixe : out Unbounded_String, input : out Unbounded_String
    Pour i allant de 1 à Argument_Count Faire                   -- i : in out Entier; Argument_Count : in Entier
        Traiter l'option                                        -- alpha : out Flottant, k : out entier, eps : out flottant, pleine : out Booléan, prefixe : out Unbounded_String, input : out Unbounded_String
    Fin Pour


R3 : Comment "Initialiser les constantes par leur valeur par défaut"
    alpha: Flottant := 0.85                                 -- alpha : out Booleen
    k := 150                                                -- k : out Booleen
    Epsilon := 0                                            -- eps : out Booleen
    pleine := False                                         -- pleine : out Booleen
    output := True                                          -- output : out Booleen

R3 : Comment "Traiter l'option"
    Selon Argument(i)                                           -- i : in Entier
        Dans "-A" => Modifier la valeur de alpha                -- alpha : out Flottant
        Dans "-K" => Modifier la valeur de K                    -- K : out Entier
        Dans "-E" => Modifier la valeur de epsilon              -- epsilon : out Flottant
        Dans "-P" => Creuse := False                            -- Creuse : out Booleen
        Dans "-C" => Creuse := True                             -- Creuse : out Booleen
        Dans "-R" => Modifer le prefixe des fichiers résultats  -- prefixe : out String
        Dans "*.net" => fichier := Argument(i)                  -- fichier : out FileType
        Dans autres => Rien
    FinSelon

R4 : Comment "Modifier la valeur de alpha"
    Commencer
        alpha := Argument(i + 1)                                -- alpha : out Flottant
    Exception
        Dans Autres => Afficher usage; Quitter
    Fin

R4 : Comment "Modifier la valeur de K"
    Commencer
        K := Argument(i + 1)                                    -- K : out Entier
    Exception
        Dans Autres => Afficher usage; Quitter
    Fin

R4 : Comment "Modifier la valeur de epsilon"
    Commencer
        epsilon := Argument(i + 1)                              -- epsilon : out Flottant
    Exception
        Dans Autres => Afficher usage; Quitter
    Fin

R2 : Comment "Calculer pi_k par les matrices pleines"
    calculer la matrice G avec l'approche matrice pleine
    i := 0                                                      -- i : in out Entier
    pi_k := pi_0                                                -- pi_k : in out Matrice Flottant
    TantQue pi_k < epsilon and i <= k                           -- epsilon : in Flottant; i : in out Entier; k : in Entier
        pi_k := Multiplier G par la matrice pi_k                -- G : in Matrice; pi_0 : in Matrice
        i := i + 1;                                   
    Fin TantQue

R2 : Comment "Calculer la matrice G par l'approche des matrices pleines"
    Calculer H à partir du graphe                               -- graph : out Graphe
    Calculer S à partir de graphe H                             -- graph : in out Graphe
    Calculer G à partir de la matrice H dans le graphe          -- graph : in out Graphe


R3 : Comment "Calculer H à partir du graphe"
    Pour i allant de 1 à N faire                                -- i : in out Entier; N : in Entier
        Remplir les colonnes de H
    FinPour


R4 : Comment "Remplir les colonnes de H"
    Determiner le nombre de sommet que le sommet i pointe       -- sum : in out Entier
    Si sum /= 0 Faire
        remplacer les 1 par 1 / sum                                 -- Graph : in out Graphe; sum in Entier
    Sinon Faire
        rien
    Fin Si

R5 : Comment "Détermniner le nombre de sommet que le sommet i pointe"
    Pour J allant de 1 à N Faire
        sum := sum + get(graphe, i, J);                             -- sum : in out sum
    FinPour

R5 : Comment "remplacer les 1 par 1 / sum"
    Pour j allant de 1 à N Faire
        Si get(graph, i, j) = 1 Faire
            set(graph, i, j, 1 / sum);
        Sinon Faire
            Rien
        FinSi
    FinPour

    
R3 : Comment "Calculer S à partir de H"
    Pour i allant de 1 à N Faire                                -- i : in out Entier; N : in Entier
        Regarder si toutes les colonnes sont nuls et les remplir si oui -- graph : in Graphe
    Fin Pour

R4 : Comment "Regarder si toutes les colonnes sont nuls et les remplir si oui"
    Vide := True;                                               -- Vide : in out Booleen
    j := 1;                                                     -- j : out Entier
    TantQue Vide et alors j <= N Faire                          -- N : in Entier
        Vide := get(graph, i, j) /= 0;                          -- graph : in out Graphe
        j := j + 1;                                             -- j : in out Entier
    Fin TantQue
    Remplir si vide est Vrai

R5 : Comment "Remplir si vide est Vrai"
    Si Vide Faire                                               -- Vide : in Booleen
        Remplir pour chaque colonne par 1/N                     -- graphe : in out Graphe; N : in Entier
    Sinon Faire
        Rien
    Fin Si

R6 : Comment "Remplir pour chaque colonne par 1/N"
    Pour j allant de 1 à N Faire                                    -- j : in out Entier; N : in Entier
        set(graphe, i, j) := 1 / N;                                 -- graphe : in out : Graphe
    Fin Pour

R4 : Comment "Calculer G à partir de S"
    graph.mat := P_mat."+"(P_mat."*"(alpha,  graph.mat),  P_mat."*"(((1.0 - alpha) / N), P_Mat."*"(e,  T(e))) -- graph : in out Graphe; alpha : in Flottant; e : in Matrice;

R2 : Comment "Calculer pi_k par les matrices creuses"