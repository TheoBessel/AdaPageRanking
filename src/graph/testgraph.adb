with Ada.Text_IO;               use Ada.Text_IO;
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;
with Graph;

procedure TestGraph is
    file_name : constant Unbounded_String := To_Unbounded_String("testgraph.net");

    N : constant Natural := 10;

    package MonGraph is
        new Graph(N);
    use MonGraph;

    gra : T_Graphe;

begin
    Put_Line("Testing `Graph` Package ...");

    Lire_Graphe(file_name, gra);
    Put_line("Res : ");
    Afficher(gra);
    New_Line;
end TestGraph;
