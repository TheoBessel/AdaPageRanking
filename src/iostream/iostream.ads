with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;

generic
    type T_Float is digits <>;
package IOStream is
    -- Arguments de ligne de commande
    type T_Arguments is record
        alpha  : T_Float range 0.0 .. 1.0;
        k      : Natural;
        eps    : T_Float;
        pleine : Boolean;
        output : Unbounded_String;
        input  : Unbounded_String;
    end record;

    -- Structure représentant le fichier en entrée
    type T_Edge is record
        start : Natural;
        stop : Natural;
    end record;
    type T_Edges is array (Positive range <>) of T_Edge;
    type T_InFile(m : Natural) is tagged record
        n : Natural;
        edges : T_Edges(1..m);
    end record;

    -- Structure représentant les fichiers en sortie
    type T_Page is record
        id : Natural;
        score : T_Float;
    end record;
    type T_Pages is array (Positive range <>) of T_Page;
    type T_OutFile(n : Natural) is tagged record
        pages : T_Pages(1..n);
    end record;

    -- Parse les arguments de la ligne de commande
    procedure parse_args(args : out T_Arguments);

    -- Parse un sommet sous la forme de deux nombres dans une String
    function parse_edge(input : String) return T_Edge;

    -- Parse le fichier .net en entrée
    function parse_file(file_name : Unbounded_String) return T_InFile;

    -- Écrit les fichiers en sortie
    generic
        with procedure printf_int(t : File_Type; i : Integer) is <>;
        with procedure printf_float(t : File_Type; f : T_Float) is <>;
    procedure write_file(file_name : Unbounded_String; file : in T_OutFile; params : in T_Arguments);
end IOStream;