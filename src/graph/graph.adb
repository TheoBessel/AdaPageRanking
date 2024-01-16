package body Graph is
    function init(file : P_IOStream.T_InFile; full : Boolean) return T_Graph is
        graph : T_Graph(file.n, full);
    begin
        case graph.full is
            when True => graph.fullmat := P_Full.init(file.n,file.n,0.0);
            when False => graph.sparsemat := P_Sparse.init(file.n,file.n);
        end case;
        for i in file.edges'Range loop
            case graph.full is
                when True => P_Full.set(graph.fullmat,file.edges(i).start+1,file.edges(i).stop+1,1.0);
                when False => P_Sparse.set(graph.sparsemat,file.edges(i).start+1,file.edges(i).stop+1,1.0);
            end case;
        end loop;
        return graph;
    end;
end Graph;