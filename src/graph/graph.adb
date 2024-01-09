package body Graph is
    function init(file : P_IOStream.T_File) return T_Graph is
        graph : T_Graph(file.n);
    begin
        graph.mat := P_Matrix.init(file.n,file.n,0.0);
        for i in file.edges'Range loop
            P_Matrix.set(graph.mat,file.edges(i).start+1,file.edges(i).stop+1,1.0);
        end loop;
        return graph;
    end;
end Graph;