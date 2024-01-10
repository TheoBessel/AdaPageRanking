with Text_IO; use Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

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

    function sort(input : in out T_Matrix) return T_Matrix is
        type T_Vector is array(Natural range <>) of T_Float;

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
        end;

        procedure aux(vec : in out T_Vector; indices : in out T_Vector) is
            procedure swap(vec : in out T_Vector; i : Natural; j : Natural) is
                tmp : T_Float;
            begin    
                tmp := vec(i);
                vec(i) := vec(j);
                vec(j) := tmp;
            end;

            i : Natural := vec'First;
            j : Natural := vec'Last;
        begin
            if vec'Length > 1 then
                while i<j loop
                    while i<j loop
                        if vec(i) <= vec(j) then
                            swap(vec,i,j);
                            swap(indices,i,j);
                            j := Positive'Pred(j);
                            exit;
                        end if;
                        i := Positive'Succ(i);
                    end loop;
                    while i<j loop
                        if vec(i) <= vec(j) then
                        swap(vec,i,j);
                        swap(indices,i,j);
                        i := Positive'Succ(i);
                        exit;
                        end if;
                        j := Positive'Pred(j);
                    end loop;
                end loop;
                aux(vec(vec'First .. Positive'Pred(j)),indices(vec'First .. Positive'Pred(j)));
                aux(vec(Positive'Succ(i) .. vec'Last),indices(Positive'Succ(i) .. vec'Last));
            end if;    
        end;

        vec : T_Vector(input'Range(1));
        indices : T_Vector(input'Range(1));
        output : T_Matrix(input'Range(1), 1..1);
        output_indices : T_Matrix(input'Range(1), 1..1);
    begin
        for i in indices'Range loop
            indices(i) := T_Float(i-1);
        end loop;
        vec := sum(input);
        aux(vec,indices);
        for i in input'Range(1) loop
            output(i,1) := vec(i);
            output_indices(i,1) := indices(i);
        end loop;
        input := output;
        return output_indices;
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