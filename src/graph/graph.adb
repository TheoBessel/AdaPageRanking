package body Graph is
    -- Initialise un graphe à partir d'un fichier
    function init(file : P_IOStream.T_InFile; full : Boolean) return T_Graph is
        graph : T_Graph(file.n, full);
    begin
        case graph.full is
            when True => graph.fullmat := P_Full.init(file.n,file.n,0.0);
            when False => graph.sparsemat := P_Sparse.init(file.n,file.n);
        end case;
        -- Remplis le graphe avec les sommets lus dans le fichier
        for i in file.edges'Range loop
            case graph.full is
                when True => P_Full.set(graph.fullmat,file.edges(i).start+1,file.edges(i).stop+1,1.0);
                when False => P_Sparse.set(graph.sparsemat,file.edges(i).start+1,file.edges(i).stop+1,1.0);
            end case;
        end loop;
        return graph;
    end;

    -- Convertis une matrice creuse en matrice pleine
    function sparse_to_full(mat : P_Sparse.T_Matrix) return P_Full.T_Matrix is
        output : P_Full.T_Matrix := P_Full.init(mat.height,mat.width,0.0);
    begin
        for i in 1..mat.height loop
            for j in 1..mat.width loop
                P_Full.set(output,i,j,P_Sparse.get(mat,i,j));
            end loop;
        end loop;
        return output;
    end;
end Graph;