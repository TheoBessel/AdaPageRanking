with Ada.Text_IO;               use Ada.Text_IO;
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;
with IOStream;
with Graph;

procedure TestGraph is
    file_name : constant Unbounded_String := To_Unbounded_String("/Users/theobessel/Documents/N7/Informatique/AdaPageRanking/testgraph.net");

    package IO is
        new IOStream(T_Float => Float, "<" => Standard."<");
    use IO;

    N : Natural := Lire_Nombre_Sommet(file_name);

    package MonGraph is
        new Graph(N);
    use MonGraph;

    procedure lire is new Lire_Graphe(Graphe => MonGraph);

    gra : T_Graphe;

begin
    Put_Line("Testing `Graph` Package ...");

    lire(file_name, gra);
    Put_line("Res : ");
    Afficher(gra);
    New_Line;
end TestGraph;
