generic
    type T_Value is private;
    with function "+" (left : T_Value; right : T_Value) return T_Value is <>;
    with function "*" (left : T_Value; right : T_Value) return T_Value is <>;

type T_Matrix_Content is array(Positive range <>) of T_Value;

type T_Matrix(V_Width : Positive; V_Height : Positive; V_Size : Positive) is tagged record
    V_Matrix : T_Matrix_Content(1..V_Size);
end record;

-- nom : init
-- sémantique : Initialise une matrice en la remplissant de `val`
-- paramètres : 
    height : (In) Positive
    width : (In) Positive
    val : (In) T_Value
-- type retour : T_Matrix
-- précondition : Aucune
-- postcondition : Aucune
-- exemple : init(2,2,0) renvoie ((0,0),(0,0))

R0 : Initialiser une matrice avec `val`


-- nom : get
-- sémantique : Accède à la valeur associée aux indices `i` et `j` dans une matrice
-- paramètres : 
    mat : (In) T_Matrix
    i : (In) Positive
    j : (In) Positive
-- type retour : T_Value
-- précondition : (i in 1..mat.V_Height) and (j in 1..mat.V_Width)
-- postcondition : Aucune
-- exemple : 

R0 : Récupérer la valeur à la position `i`, `j` de mat


-- nom : set
-- sémantique : Modifie la valeur associée aux indices `i` et `j` dans une matrice
-- paramètres : 
    mat : (In) T_Matrix
    i : (In) Positive
    j : (In) Positive
    val : (In) T_Value
-- type retour : Aucun
-- précondition : (i in 1..mat.V_Height) and (j in 1..mat.V_Width)
-- postcondition : get(mat,i,j) = val
-- exemple : 

R0 : Modifier la valeur à la position `i`, `j` de mat


-- nom : "*"
-- sémantique : Multiplie deux matrices
-- paramètres : 
    left : (In) T_Matrix
    right : (In) T_Matrix
-- type retour : T_Matrix
-- précondition : left.V_Width = right.V_Height
-- postcondition : "*"'Result.V_Height = left.V_Height and "*"'Result.V_Width = right.V_Width
-- exemple : 

R0 : Multiplier les matrices `left` et `right`


-- nom : "+"
-- sémantique : Additionne deux matrices
-- paramètres : 
    left : (In) T_Matrix
    right : (In) T_Matrix
-- type retour : T_Matrix
-- précondition : left.V_Height = right.V_Height and left.V_Width = right.V_Width
-- postcondition : "+"'Result.V_Height = left.V_Height and "+"'Result.V_Width = right.V_Width
-- exemple : 

R0 : Additionner les matrices `left` et `right`


-- nom : "+"
-- sémantique : Multiplie une matrice par un scalaire à gauche
-- paramètres : 
    left : (In) T_Value
    right : (In) T_Matrix
-- type retour : T_Matrix
-- précondition : Aucune
-- postcondition : "*"'Result.V_Height = right.V_Height and "*"'Result.V_Width = right.V_Width
-- exemple : 

R0 : Multiplier la matrice `right` par le scalaire `left`