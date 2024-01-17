with IOStream;

generic
    type T_Float is digits <>;
    with package P_IOStream is new IOStream(T_Float => T_Float);
package Sparse is
    type T_Pointer is private;

    type T_Cell is record 
        val : T_Float;
        i : Positive;
        j : Positive;
        row : T_Pointer; -- Suivant dans un row
        col : T_Pointer; -- Suivant dans une col
    end record;

    type T_Array is array(Positive range <>) of T_Pointer;

    type T_Matrix(height : Positive; width : Positive) is tagged record
        rows : T_Array(1..height);
        cols : T_Array(1..width);
    end record;

    -- Initialise une matrice de taille `height` x `width`
    function init(height : Positive; width : Positive) return T_Matrix;

    -- Accède à la valeur associée aux indices `i` et `j` dans une matrice
    function get(mat : in T_Matrix; i : in Positive; j : in Positive) return T_Float with
        Pre => (i in 1..mat.height) and (j in 1..mat.width);

    -- Modifie la valeur associée aux indices `i` et `j` dans une matrice
    procedure set(mat : in out T_Matrix; i : in Positive; j : in Positive; val : in T_Float) with
        Pre => (i in 1..mat.height) and (j in 1..mat.width);

    -- Multiplie deux matrices
    function "*"(left : in T_Matrix; right : in T_Matrix) return T_Matrix with
        Pre => left.width = right.height,
        Post => "*"'Result.height = left.height and "*"'Result.width = right.width;

    -- Additionne deux matrices
    function "+"(left : in T_Matrix; right : in T_Matrix) return T_Matrix with
        Pre => left.height = right.height and left.width = right.width,
        Post => "+"'Result.height = left.height and "+"'Result.width = right.width;

    -- Multiplie une matrice par un scalaire à gauche
    function "*"(left : in T_Float; right : in T_Matrix) return T_Matrix with
        Post => "*"'Result.height = right.height and "*"'Result.width = right.width;

    -- Transpose une matrice
    function T(mat : in T_Matrix) return T_Matrix with
        Post => T'Result.height = mat.width and T'Result.width = mat.height;

    -- Affiche une matrice
    generic
        with procedure print_float(f : T_Float) is <>;
    procedure print(mat : in T_Matrix);
    
private
    type T_Pointer is access T_Cell;
end Sparse;