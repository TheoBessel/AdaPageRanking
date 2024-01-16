with Text_IO; use Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package body Matrix is
    
    -- Initialise une matrice en la remplissant de `val`
    function init(height: in Positive; width : in Positive; val : in T_Float) return T_Matrix is
        mat : T_Matrix(1..height, 1..width);
    begin
        mat := (others => (others => val));
        return mat;
    end;


    -- Initialise une matrice vide
    function init(height: in Positive; width : in Positive) return T_Matrix is
        mat : T_Matrix(1..height, 1..width);
    begin
        return mat;
    end;


    -- Accède à la valeur associée aux indices `i` et `j` dans une matrice
    function get(mat : in T_Matrix; i : in Positive; j : in Positive) return T_Float is
    begin
        return mat(i,j);
    end;


    -- Modifie la valeur associée aux indices `i` et `j` dans une matrice
    procedure set(mat : out T_Matrix; i : in Positive; j : in Positive; val : in T_Float) is
    begin
        mat(i,j) := val;
    end;


    -- Multiplie deux matrices
    function "*"(left : in T_Matrix; right : in T_Matrix) return T_Matrix is
        mat : T_Matrix(left'Range(1),right'Range(2));
        val : T_Float;
    begin
        for i in mat'Range(1) loop
            for j in mat'Range(2) loop
                val := get(left,i,1)*get(right,1,j);
                for k in 2..left'Length(2) loop
                    val := val + get(left,i,k)*get(right,k,j);
                end loop;
                set(mat,i,j,val);
            end loop;
        end loop;
        return mat;
    end;


    -- Additionne deux matrices
    function "+"(left : in T_Matrix; right : in T_Matrix) return T_Matrix is
        mat : T_Matrix(left'Range(1),left'Range(2));
    begin
        for i in mat'Range(1) loop
            for j in mat'Range(2) loop
                set(mat,i,j,get(left,i,j)+get(right,i,j));
            end loop;
        end loop;
        return mat;
    end;

    -- Multiplie une matrice par un scalaire à gauche
    function "*"(left : in T_Float; right : in T_Matrix) return T_Matrix is
        mat : T_Matrix(right'Range(1),right'Range(2));
    begin
        for i in mat'Range(1) loop
            for j in mat'Range(2) loop
                set(mat,i,j,left*get(right,i,j));
            end loop;
        end loop;
        return mat;
    end;


    -- Transpose une matrice
    function T(mat : in T_Matrix) return T_Matrix is
        tmat : T_Matrix(mat'Range(2),mat'Range(1));
    begin
        for i in mat'Range(1) loop
            for j in mat'Range(2) loop
                set(tmat,j,i,get(mat,i,j));
            end loop;
        end loop;
        return tmat;
    end;

    function sort(input : in out T_Matrix) return T_Matrix is
        type T_Vector is array(Natural range <>) of T_Float;

        -- sum
        -- renvoie la somme des coéfficients
        -- Paramètre :
        --      - mat       [in]    Le vecteur que l'on traite
        -- Pre :
        --      - Aucune
        -- Post :
        --      - Aucune 
        function sum(mat : in T_Matrix) return T_Vector is
            vec : T_Vector(mat'Range(1));
            sum : T_Float;
        begin
            for i in mat'Range(1) loop
                sum := 0.0;
                for j in mat'Range(2) loop
                    sum := sum + mat(i,j);
                end loop;
                vec(i) := sum;
            end loop;
            return vec;
        end sum;

        -- aux
        --
        -- Paramètre :
        --      - vec       [in out]        Le vecteur que l'on tri
        --      - indices   [in out]        Le vecteur des indices des permutations
        -- Pre :
        --      - Aucune
        -- Post :
        --      - Aucune
        procedure aux(vec : in out T_Vector; indices : in out T_Vector) is
            procedure swap(vec : in out T_Vector; i : Natural; j : Natural) is
                tmp : T_Float;          -- Variable de stockage temporaire pour ne pas écraser une valeur lors de l'échange
            begin    
                tmp := vec(i);
                vec(i) := vec(j);
                vec(j) := tmp;
            end swap;

            i : Natural := vec'First;   -- indice dans le vecteur
            j : Natural := vec'Last;    -- indice dans le vecteur
        begin
            if vec'Length > 1 then
                while i<j loop
                    while i<j loop
                        if vec(i) <= vec(j) then
                            swap(vec,i,j);
                            swap(indices,i,j);
                            j := Positive'Pred(j);
                            exit;
                        else
                            null;
                        end if;
                        i := Positive'Succ(i);
                    end loop;

                    while i<j loop
                        if vec(i) <= vec(j) then
                            swap(vec,i,j);
                            swap(indices,i,j);
                            i := Positive'Succ(i);
                            exit;
                        else
                            null;
                        end if;
                        j := Positive'Pred(j);
                    end loop;
                end loop;

                -- appels récursifs
                aux(vec(vec'First .. Positive'Pred(j)),indices(vec'First .. Positive'Pred(j)));
                aux(vec(Positive'Succ(i) .. vec'Last),indices(Positive'Succ(i) .. vec'Last));
            else
                null;
            end if;
        end aux;

        vec : T_Vector(input'Range(1));                     -- Le vecteur des sommes des lignes
        indices : T_Vector(input'Range(1));                 -- Le vecteur des permutations
        output : T_Matrix(input'Range(1), 1..1);            -- La matrice du vecteur trié
        output_indices : T_Matrix(input'Range(1), 1..1);    -- La matrice des permutations
    begin
        -- Construire le vecteur des indices
        for i in indices'Range loop
            indices(i) := T_Float(i-1);
        end loop;
        -- Construire le vecteur des Poids (somme des lignes)
        vec := sum(input);
        -- Trier le vecteur dans l'ordre décroissant
        aux(vec,indices);

        -- Construire les sorties de la fonctions
        for i in input'Range(1) loop
            output(i,1) := vec(i);
            output_indices(i,1) := indices(i);
        end loop;
        input := output;
        return output_indices;
    end sort;


    -- Affiche une matrice
    procedure print(mat : in T_Matrix) is
    begin
        for i in mat'Range(1) loop
            Put("| ");
            for j in mat'Range(2) loop
                print_float(get(mat,i,j));
                Put(" ");
            end loop;
            Put("|"); New_Line;
        end loop;
        New_Line;
    end print;
end Matrix;