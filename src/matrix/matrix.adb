package body Matrix is
    procedure init(mat : out T_Matrix; val : in T_Value) is
    begin
        mat := (others => val);
    end init;

    function get(mat : in T_Matrix; i : in Positive; j : in Positive) return T_Value is
    begin
        return mat(i + j*V_Width);
    end;

    --function is_empty(mat : in T_Matrix) return Boolean is
    --    subtype T_Capacity is Integer range 1..V_Height*V_Width;
    --    empty : Boolean := True;
    --    i : T_Capacity := 1;
	--begin
	--	loop
    --        empty := mat(i) = 0;
    --        i := i + 1;
    --        exit when i = V_Height*V_Width or not empty;
    --    end loop;
    --    return empty;
    --end;
end Matrix;