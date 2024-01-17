with IOStream;

generic
    type T_Float is digits <>;
    with package P_IOStream is new IOStream(T_Float => T_Float);
package Full is
    type T_Matrix is array(Positive range <>, Positive range <>) of T_Float;

    -- Initialise une matrice en la remplissant de `val`
    function init(height: in Positive; width : in Positive; val : in T_Float) return T_Matrix;
    
    -- Accède à la valeur associée aux indices `i` et `j` dans une matrice
    function get(mat : in T_Matrix; i : in Positive; j : in Positive) return T_Float with
        Pre => (i in 1..mat'Length(1)) and (j in 1..mat'Length(2));
    
    -- Modifie la valeur associée aux indices `i` et `j` dans une matrice
    procedure set(mat : out T_Matrix; i : in Positive; j : in Positive; val : in T_Float) with
        Pre => (i in 1..mat'Length(1)) and (j in 1..mat'Length(2));
    
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

    -- Trie une matrice
    function sort(input : in out T_Matrix) return T_Matrix;
    
    -- Affiche une matrice
    generic
        with procedure print_float(f : T_Float) is <>;
    procedure print(mat : in T_Matrix);

    -- Exporte une matrice vers un fichier de sortie
    function export(ids : in T_Matrix; scores : in T_Matrix) return P_IOStream.T_OutFile with
        Pre => ids'Length(1) = scores'Length(1);
end Full;