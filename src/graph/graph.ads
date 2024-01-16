with IOStream;
with Full;
with Sparse;

generic
    type T_Float is digits <>;
    with package P_IOStream is new IOStream(T_Float => T_Float);
    with package P_Full is new Full(P_IOStream => P_IOStream, T_Float => T_Float);
    with package P_Sparse is new Sparse(P_IOStream => P_IOStream, T_Float => T_Float);
package Graph is
    type T_Graph(n : Natural; full : Boolean) is tagged record
        case full is
            when True => fullmat : P_Full.T_Matrix(1..n, 1..n);
            when False => sparsemat : P_Sparse.T_Matrix(n,n);
        end case;
    end record;

    function init(file : P_IOStream.T_InFile; full : Boolean) return T_Graph;
end Graph;