with Matrix;
with IOStream;

generic
    with package P_Matrix is new Matrix(<>);
    with package P_IOStream is new IOStream(<>);
package Graph is
    type T_Graph(n : Natural) is tagged record
    mat : P_Matrix.T_Matrix(1..n, 1..n);
    end record;

    function init(file : P_IOStream.T_File) return T_Graph;
end Graph;