generic
    type T_Value is private;
    with function "+" (left : T_Value; right : T_Value) return T_Value is <>;
    with function "*" (left : T_Value; right : T_Value) return T_Value is <>;
package Matrix is
    type T_Matrix(V_Height : Positive; V_Width : Positive) is tagged private;
    type T_InitializerList is array(Positive range <>, Positive range <>) of T_Value;

    -- Initialise une matrice en la remplissant de `val`
    function init(height: in Positive; width : in Positive; val : in T_Value) return T_Matrix;

    -- Initialise une matrice avec un tableau
    function init(arr : in T_InitializerList) return T_Matrix;

    -- Accède à la valeur associée aux indices `i` et `j` dans une matrice
    function get(mat : in T_Matrix; i : in Positive; j : in Positive) return T_Value with
        Pre => (i in 1..mat.V_Height) and (j in 1..mat.V_Width);
    
    -- Modifie la valeur associée aux indices `i` et `j` dans une matrice
    procedure set(mat : out T_Matrix; i : in Positive; j : in Positive; val : in T_Value) with
        Pre => (i in 1..mat.V_Height) and (j in 1..mat.V_Width),
        Post => get(mat,i,j) = val;

    -- Applique un traitement à tous les éléments d'une matrice
    generic
        with procedure process(val : in T_Value);
        with procedure breakline;
    procedure forall(mat : out T_Matrix);

    -- Multiplie deux matrices
    function "*"(left : in T_Matrix; right : in T_Matrix) return T_Matrix with
        Pre => left.V_Width = right.V_Height,
        Post => "*"'Result.V_Height = left.V_Height and "*"'Result.V_Width = right.V_Width;

    -- Additionne deux matrices
    function "+"(left : in T_Matrix; right : in T_Matrix) return T_Matrix with
        Pre => left.V_Height = right.V_Height and left.V_Width = right.V_Width,
        Post => "+"'Result.V_Height = left.V_Height and "+"'Result.V_Width = right.V_Width;

    -- Multiplie une matrice par un scalaire à droite
    function "*"(left : in T_Matrix; right : in T_Value) return T_Matrix with
        Post => "*"'Result.V_Height = left.V_Height and "*"'Result.V_Width = left.V_Width;
    
    -- Multiplie une matrice par un scalaire à gauche
    function "*"(left : in T_Value; right : in T_Matrix) return T_Matrix with
        Post => "*"'Result.V_Height = right.V_Height and "*"'Result.V_Width = right.V_Width;

    -- Transpose une matrice
    function T(mat : in T_Matrix) return T_Matrix with
        Post => T'Result.V_Height = mat.V_Width and T'Result.V_Width = mat.V_Height;
private
    type T_Matrix_Content is array(Positive range <>,Positive range <>) of T_Value;

    type T_Matrix(V_Height : Positive; V_Width : Positive) is tagged record
        V_Matrix : T_Matrix_Content(1..V_Height,1..V_Width);
    end record;
end Matrix;