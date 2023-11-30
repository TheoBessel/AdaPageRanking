R0: calculer la matrice G avec l'approche matrice pleine

R1 : Comment "calculer la matrice G avec l'approche matrice pleine"
 -  traiter les arguments de la ligne de commande et initialiser les constantes
 -  Obtenir la matrice G

R2 : Comment "traiter les arguments de la ligne de commande et initialiser les constantes"
    Si Argument_CountSi = 0 Faire
        - Afficher usage
    Sinon
        - traiter chaque les options donnés et initialisée les constantes
    Fin Si

R3 : Comment "Afficher usage"
 -  Afficher ("Usage : " & command_Name & " [option] reseau")
 -  Afficher une nouvelle ligne
 -  Afficher ("    reseau : Le réseau de page étudié")
 -  Afficher ("options : ")
 -  Afficher les options

R4 : Comment "Afficher les options"
 -  Afficher (" -A <valeur> : Définir une valeur de alpha. La valeur doit être un nombre réel compris entre 0 et 1 inclus. La Valeur par défaut est 0.85")
 -  Afficher (" -K <valeur> : Définir l'indice k du vecteur poids à calculer, pi_k, grâce à l'algorithme PageRank. La valeur doit être un entier positif. Sa valeur par défaut est 150")
 -  Afficher (" -E <valeur> : Définir une précision (un epsilon) qui permettra d'interrompre le calcul PageRank si le vecteur poids est à une distance de vecteurs poids précédent strictement inférieure à epsilon. La valeur par défaut est 0.0 (désactiver)")
 -  Afficher (" -P          : Choisir l'algorithme avec des matrices pleines")
 -  Afficher (" -C          : Choisir l'algorithme avec des matrices creuses. C'est l'algorithme choisie par défaut")
 -  Afficher (" -R <prefixe>: Choisir le préfixe des fichiers résultats, output")

R3 : Comment "traiter les options donnés et initialisée les constantes"
 -  Initialiser les obligation d'initialisation
    Pour i allant de 1 à Argument_Count Faire
        - traiter l'option
    Fin Pour
 -  Initialiser les constantes non initialisée

R4 : Comment "Initialiser les obligation d'initialisation"
 -  Alpha_Non_Initialise := True
 -  K_Non_Initialise := True
 -  Epsilon_Non_Initialise := True
 -  Creuse_Non_Initialise := True
 -  prefixe_Non_Initialise := True

R4 : Comment "Traiter l'option"
    Selon Argument(i)
        dans "-A" => modifier la valeur de alpha
        dans "-K" => modifier la valeur de K
        dans "-E" => modifier la valeur de epsilon
        dans "-P" => Creuse := False
        dans "-C" => Creuse := True
        dans "-R" => modiifer le prefixe des fichiers résultats
        dans autres => rien
    FinSelon

R5 : Comment "modifier la valeur de alpha"
    Commencer
        Alpha := argument(i + 1)
    Exception
        dans autres => Afficher usage; Quitter
    Fin


R5 : Comment "modifier la valeur de K"
    Commencer
        K := argument(i + 1)
    Exception
        dans autres => Afficher usage; Quitter
    Fin

R5 : Comment "modifier la valeur de epsilon"
    Commencer
        epsilon := argument(i + 1)
    Exception
        dans autres => Afficher usage; Quitter
    Fin

R4 : Comment "initialiser les constantes non initialisée"
 -  initialiser alpha
 -  initialiser k
 -  initialiser epsilon
 -  initialiser prefixe

R5 : Comment "initialiser alpha"
    Si Alpha_Non_Initialise Faire
        Alpha := 0.85;
    Sinon
        rien;
    FinSi

R5 : Comment "initialiser k"
    Si K_Non_Initialise Faire
        K := 150;
    Sinon
        rien;
    FinSi

R5 : Comment "initialiser epsilon"
    Si Epsilon_Non_Initialise Faire
        Epsilon := 0.0;
    Sinon
        rien;
    FinSi

R5 : Comment "initialiser prefixe"
    Si Alpha_Non_Initialise Faire
        prefixe := "output";
    Sinon
        rien;
    FinSi

R2 : Comment "Obtenir la matrice G"
 -  transformer la matrice S en la matrice G

R3 : Comment "transformer la matrice S en la matrice G"
 -  Obtenir la matrice S
 -  appliquer la deuxième transformation de Brin et Page

R4 : Comment "Obtenir la matrice S"
 -  Obtenir la matrice H
 -  transformer la matrice H en la matrice S

R5 : Comment "Obtenir la matrice H"
 -  Initialiser H
 -  remplir H
 
R6 : Comment remplir H
 -  remplir les lignes de H

R7 : Comment "remplir les lignes de H"
    Pour i allant de 1 à N faire
        - remplir les colonnes
    FinPour


R8 : Comment "remplir les colonnes de H"
    Si existe au moins un lien sortant de la page Pi vers la page Pj Faire
        H(i*N + j) := 1 / |Pi|
    sinon Faire
        H(i*N + j) := 0
    Fin Si

R5 : Comment "transformer la matrice H en la matrice S"
 -  remplacer toutes les lignes vides pour que la somme vaut 1

R6 : Comment "remplacer toutes les lignes vides pour que la somme vaut 1"
 - identifier les lignes qui sont vide et les remplir par 1/N

R7 : Comment "identifier les lignes qui sont vide et les remplir par 1/N"
    Pour i allant de 1 à N Faire
        - regarder si toutes les colonnes sont nuls et les remplir si oui
    Fin Pour

R8 : Comment "regarder si toutes les colonnes sont nuls et les remplir si oui"
    Vide := True;
    j := 1;
    TantQue Vide and then j <= N Faire
        Vide := H(i * N + j) /= 0;
        j := j + 1;
    Fin TantQue
    - remplir si vide est Vrai

R9 : Comment "remplir si vide est Vrai"
    Si Vide Faire
        - remplir pour chaque colonne par 1/N
    Sinon Faire
        rien 
    Fin Si

R10 : Comment "remplir pour chaque colonne par 1/N"
    Pour j allant de 1 à N Faire
        H(i * N + j) := 1 / N;
    Fin Pour

R4 : appliquer la deuxième transformation de Brin et Page
 -  multiplier la matrice S par le scalaire alpha
 -  multiplier la matrice e par la matrice eT (eT = e transpose)
 -  multiplier la matrice e x eT par le scalaire (1 - alpha) / N 
 -  sommer la matrice alpha.S et la matrice (1 - alpha) / N x eeT
