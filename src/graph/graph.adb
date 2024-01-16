-- Implémentation du module graphe
package body Graph is

    -- Initialise un graphe en fonction du nombre de sommet et de la liste d'arête donné en argument
    function init(file : in P_IOStream.T_File) return T_Graph is
        graph : T_Graph(file.n);        -- Le graphe qui sera retourné
    begin
        -- Initialisation
        graph.mat := P_Matrix.init(file.n,file.n,0.0);
        -- Remplissage
        for i in file.edges'Range loop
            P_Matrix.set(graph.mat,file.edges(i).start+1,file.edges(i).stop+1,1.0);
        end loop;
        return graph;
    end;
    
end Graph;