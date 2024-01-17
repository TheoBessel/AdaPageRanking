with Text_IO; use Text_IO;

package body Sparse is
    -- Initialise une matrice de taille `height` x `width`
    function init(height : Positive; width : Positive) return T_Matrix is
        mat : T_Matrix(height, width);
    begin
        return mat;
    end;
    
    -- Accède à la valeur associée aux indices `i` et `j` dans une matrice
    function get(mat : in T_Matrix; i : in Positive; j : in Positive) return T_Float is
        ptr : T_Pointer := new T_Cell;
        val : T_Float := 0.0;
    begin
        ptr := mat.rows(i);
        if (ptr /= Null) then
            while (ptr /= Null and then ptr.j < j) loop
                ptr := ptr.row;
            end loop;
            if (ptr /= Null and then ptr.j = j) then
                val := ptr.val;
            else
                val := 0.0;
            end if;
        else
            val := 0.0;
        end if;
        return val;
    end;

    -- Modifie la valeur associée aux indices `i` et `j` dans une matrice
    procedure set(mat : in out T_Matrix; i : in Positive; j : in Positive; val : in T_Float) is
        elem : constant T_Pointer := new T_Cell;
        row_ptr, col_ptr : T_Pointer;
    begin
        if (val /= 0.0) then
            elem.val := val;
            elem.i := i;
            elem.j := j;
            elem.row := Null;
            elem.col := Null;

            col_ptr := mat.rows(i);
            while (col_ptr /= Null and then col_ptr.j < j) loop
                row_ptr := col_ptr;
                col_ptr := col_ptr.row;
            end loop;
            elem.row := col_ptr;
            if (col_ptr = mat.rows(i)) then
                mat.rows(i) := elem;
            else
                row_ptr.row := elem;
            end if;

            col_ptr := mat.cols(j);
            while (col_ptr /= Null and then col_ptr.i < i) loop
                row_ptr := col_ptr;
                col_ptr := col_ptr.col;
            end loop;
            elem.col := col_ptr;
            if (col_ptr = mat.cols(j)) then
                mat.cols(j) := elem;
            else
                row_ptr.col := elem;
            end if;
        else
            Null;
        end if;
    end;

    -- Multiplie deux matrices
    function "*"(left : in T_Matrix; right : in T_Matrix) return T_Matrix is
        mat : T_Matrix := init(left.height, right.width);
        val : T_Float := 0.0;
        left_ptr, right_ptr : T_Pointer;
    begin
        for i in 1..mat.height loop
            for j in 1..mat.width loop
                val := 0.0;
                right_ptr := right.cols(j);
                left_ptr := left.rows(i);
                while (left_ptr /= Null) loop
                    while (right_ptr /= Null and then right_ptr.i < left_ptr.j) loop
                        right_ptr := right_ptr.col;
                    end loop;
                    if (right_ptr /= Null and then right_ptr.i = left_ptr.j) then
                        val := val + right_ptr.val * left_ptr.val;
                    else
                        Null;
                    end if;
                    left_ptr := left_ptr.row;
                end loop;
                if (val /= 0.0) then
                    set(mat,i,j,val);
                else
                    Null;
                end if;
            end loop;
        end loop;
        return mat;
    end;

    -- Additionne deux matrices
    function "+"(left : in T_Matrix; right : in T_Matrix) return T_Matrix is
        mat : T_Matrix := init(left.height, right.width);
        val : T_Float := 0.0;
        left_ptr, right_ptr : T_Pointer;
    begin
        for i in 1..mat.height loop
            for j in 1..mat.width loop
                val := 0.0;
                left_ptr := left.rows(i);
                right_ptr := right.rows(i);
                if (left_ptr /= Null or right_ptr /= Null) then
                    while (left_ptr /= Null and then left_ptr.j < j) loop
                        left_ptr := left_ptr.row;
                    end loop;
                    while (right_ptr /= Null and then right_ptr.j < j) loop
                        right_ptr := right_ptr.row;
                    end loop;

                    if ((left_ptr /= Null and right_ptr /= Null) and then (left_ptr.j = j and right_ptr.j = j)) then
                        val := left_ptr.val + right_ptr.val;
                    elsif (left_ptr /= Null and then left_ptr.j = j) then
                        val := left_ptr.val;
                    elsif (right_ptr /= Null and then right_ptr.j = j) then
                        val := right_ptr.val;
                    else
                        val := 0.0;
                    end if;
                else
                    val := 0.0;
                end if;
                if (val /= 0.0) then
                    set(mat,i,j,val);
                else
                    Null;
                end if;
            end loop;
        end loop;
        return mat;
    end;

    -- Multiplie une matrice par un scalaire à gauche
    function "*"(left : in T_Float; right : in T_Matrix) return T_Matrix is
        mat : T_Matrix := init(right.height, right.width);
        val : T_Float := 0.0;
        ptr : T_Pointer;
    begin
        for i in 1..mat.height loop
            for j in 1..mat.width loop
                val := 0.0;
                ptr := right.rows(i);
                if (ptr /= Null) then
                    while (ptr /= Null and then ptr.j < j) loop
                        ptr := ptr.row;
                    end loop;
                    if (ptr /= Null and then ptr.j = j) then
                        val := left*ptr.val;
                    else
                        val := 0.0;
                    end if;
                else
                    val := 0.0;
                end if;
                if (val /= 0.0) then
                    set(mat,i,j,val);
                else
                    Null;
                end if;
            end loop;
        end loop;
        return mat;
    end;

    -- Transpose une matrice
    function T(mat : in T_Matrix) return T_Matrix is
        tmat : T_Matrix := init(mat.width, mat.height);
        val : T_Float := 0.0;
    begin
        for i in 1..mat.height loop
            for j in 1..mat.width loop
                val := get(mat,i,j);
                if val /= 0.0 then
                    set(tmat,j,i,val);
                else
                    Null;
                end if;
            end loop;
        end loop;
        return tmat;
    end;

    -- Affiche une matrice
    procedure print(mat : in T_Matrix) is
        ptr : T_Pointer;
    begin
        for i in 1..mat.height loop
            Put("| ");
            for j in 1..mat.width loop
                ptr := mat.rows(i);
                if (ptr /= Null) then
                    while (ptr /= Null and then ptr.j < j) loop
                        ptr := ptr.row;
                    end loop;
                    if (ptr /= Null and then ptr.j = j) then
                        print_float(ptr.val);
                    else
                        Put("  * ");
                    end if;
                else
                    Put("  * ");
                end if;
                Put(" ");
            end loop;
            Put("|"); New_Line;
        end loop;
        New_Line;
    end;
end Sparse;