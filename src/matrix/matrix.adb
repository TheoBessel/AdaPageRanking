with Text_IO; use Text_IO;

package body Matrix is
    function init(height: in Positive; width : in Positive; val : in T_Float) return T_Matrix is
        mat : T_Matrix(1..height, 1..width);
    begin
        mat := (others => (others => val));
        return mat;
    end;

    function init(height: in Positive; width : in Positive) return T_Matrix is
        mat : T_Matrix(1..height, 1..width);
    begin
        return mat;
    end;

    function get(mat : in T_Matrix; i : in Positive; j : in Positive) return T_Float is
    begin
        return mat(i,j);
    end;

    procedure set(mat : out T_Matrix; i : in Positive; j : in Positive; val : in T_Float) is
    begin
        mat(i,j) := val;
    end;

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
    end;
end Matrix;