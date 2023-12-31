package body Matrix is
    function init(height: in Positive; width : in Positive; val : in T_Value) return T_Matrix is
        mat : T_Matrix(V_Height => height, V_Width => width);
    begin
        mat.V_Matrix := (others => (others => val));
        return mat;
    end;

    function init(arr : in T_InitializerList) return T_Matrix is
        mat : T_Matrix(V_Height => arr'Last(1), V_Width => arr'Last(2));
    begin
        for i in arr'Range(1) loop
            for j in arr'Range(2) loop
                mat.V_Matrix(i,j) := arr(i,j);
            end loop;
        end loop;
        return mat;
    end;

    function get(mat : in T_Matrix; i : in Positive; j : in Positive) return T_Value is
    begin
        return mat.V_Matrix(i,j);
    end;

    procedure set(mat : out T_Matrix; i : in Positive; j : in Positive; val : in T_Value) is
    begin
        mat.V_Matrix(i,j) := val;
    end;

    procedure forall(mat : out T_Matrix) is
    begin
        for i in 1..mat.V_Height loop
            for j in 1..mat.V_Width loop
                process(mat.V_Matrix(i,j));
            end loop;
            breakline;
        end loop;
    end;

    function "*"(left : in T_Matrix; right : in T_Matrix) return T_Matrix is
        mat : T_Matrix(V_Height => left.V_Height, V_Width => right.V_Width);
        val : T_Value;
    begin
        for i in 1..mat.V_Height loop
            for j in 1..mat.V_Width loop
                val := get(left,i,1)*get(right,1,j);
                for k in 2..left.V_Width loop
                    val := val + get(left,i,k)*get(right,k,j);
                end loop;
                set(mat,i,j,val);
            end loop;
        end loop;
        return mat;
    end;

    function "+"(left : in T_Matrix; right : in T_Matrix) return T_Matrix is
        mat : T_Matrix(V_Height => left.V_Height, V_Width => right.V_Width);
    begin
        for i in 1..mat.V_Height loop
            for j in 1..mat.V_Width loop
                set(mat,i,j,get(left,i,j)+get(right,i,j));
            end loop;
        end loop;
        return mat;
    end;

    function "*"(left : in T_Matrix; right : in T_Value) return T_Matrix is
        mat : T_Matrix(V_Height => left.V_Height, V_Width => left.V_Width);
    begin
        for i in 1..mat.V_Height loop
            for j in 1..mat.V_Width loop
                set(mat,i,j,right*get(left,i,j));
            end loop;
        end loop;
        return mat;
    end;

    function "*"(left : in T_Value; right : in T_Matrix) return T_Matrix is
        mat : T_Matrix(V_Height => right.V_Height, V_Width => right.V_Width);
    begin
        for i in 1..mat.V_Height loop
            for j in 1..mat.V_Width loop
                set(mat,i,j,left*get(right,i,j));
            end loop;
        end loop;
        return mat;
    end;

    function T(mat : in T_Matrix) return T_Matrix is
        tmat : T_Matrix(V_Height => mat.V_Width, V_Width => mat.V_Height);
    begin
        for i in 1..mat.V_Height loop
            for j in 1..mat.V_Width loop
                set(tmat,j,i,get(mat,i,j));
            end loop;
        end loop;
        return tmat;
    end;
end Matrix;