generic
    type T_Float is digits <>;
    with function "+" (left : T_Float; right : T_Float) return T_Float is <>;
    with function "*" (left : T_Float; right : T_Float) return T_Float is <>;
package Matrix is
    type T_Matrix is array(Positive range <>, Positive range <>) of T_Float;

    -- Initialise une matrice en la remplissant de `val`
    function init(height: in Positive; width : in Positive; val : in T_Float) return T_Matrix;
    
    -- Initialise une matrice vide
    function init(height: in Positive; width : in Positive) return T_Matrix;
    
    -- Accède à la valeur associée aux indices `i` et `j` dans une matrice
    function get(mat : in T_Matrix; i : in Positive; j : in Positive) return T_Float with
        Pre => (i in 1..mat'Length(1)) and (j in 1..mat'Length(2));
    
    -- Modifie la valeur associée aux indices `i` et `j` dans une matrice
    procedure set(mat : out T_Matrix; i : in Positive; j : in Positive; val : in T_Float) with
        Pre => (i in 1..mat'Length(1)) and (j in 1..mat'Length(2)),
        Post => get(mat,i,j) = val;
    
    -- Multiplie deux matrices
    function "*"(left : in T_Matrix; right : in T_Matrix) return T_Matrix with
        Pre => left'Length(2) = right'Length(1),
        Post => "*"'Result'Length(1) = left'Length(1) and "*"'Result'Length(2) = right'Length(2);
    
    -- Additionne deux matrices
    function "+"(left : in T_Matrix; right : in T_Matrix) return T_Matrix with
        Pre => left'Length(1) = right'Length(1) and left'Length(2) = right'Length(2),
        Post => "+"'Result'Length(1) = left'Length(1) and "+"'Result'Length(2) = right'Length(2);
    
    -- Multiplie une matrice par un scalaire à gauche
    function "*"(left : in T_Float; right : in T_Matrix) return T_Matrix with
        Post => "*"'Result'Length(1) = right'Length(1) and "*"'Result'Length(2) = right'Length(2);
    
    -- Transpose une matrice
    function T(mat : in T_Matrix) return T_Matrix with
        Post => T'Result'Length(1) = mat'Length(2) and T'Result'Length(2) = mat'Length(1);

    function sort(input : in out T_Matrix) return T_Matrix;
    
    -- Affiche une matrice
    generic
        with procedure print_float(f : T_Float) is <>;
    procedure print(mat : in T_Matrix);
end Matrix;