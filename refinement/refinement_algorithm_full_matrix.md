R0: calculer la matrice G avec l'approche matrice pleine

R1 : Comment "calculer la matrice G avec l'approche matrice pleine"
 - N est la taille de la matrice
 - Obtenir la matrice G

R2 : Comment "Obtenir la matrice G"
 - transformer la matrice S en la matrice G

R3 : Comment "transformer la matrice S en la matrice G"
 - Obtenir la matrice S
 - appliquer la deuxième transformation de Brin et Page

R4 : Comment "Obtenir la matrice S"
 - Obtenir la matrice H
 - transformer la matrice H en la matrice S

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
        H(i*N + j) = 1 / |Pi|
    sinon Faire
        H(i*N + j) = 0
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
        H(i * N + j) = 1 / N;
    Fin Pour

R4 : appliquer la deuxième transformation de Brin et Page
 -  multiplier la matrice S par le scalaire alpha
 -  multiplier la matrice e par la matrice eT (eT = e transpose)
 -  multiplier la matrice e x eT par le scalaire (1 - alpha) / N 
 -  sommer la matrice alpha.S et la matrice (1 - alpha) / N x eeT
