
generic
    type T_Value is private;
    V_Width : Positive;
    V_Height : Positive;
package Matrix is
    type T_Matrix is limited private;

    -- Initialise la matrix en la remplissant de 0.
    procedure init(mat : out T_Matrix; val : in T_Value);

    -- Accède à la valeur associée aux indices `i` et `j` dans la matrice.
    function get(mat : in T_Matrix; i : in Positive; j : in Positive) return T_Value with
        Pre => (i in 1..V_Width) and (j in 1..V_Height);

    -- Teste si la matrice passée en argument est vide
    --function is_empty(mat : in T_Matrix) return Boolean;
private
    type T_Matrix is array(1..(V_Width+1)*(V_Height+1)) of T_Value;
end Matrix;