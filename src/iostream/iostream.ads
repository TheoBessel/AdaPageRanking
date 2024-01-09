with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

generic
    type T_Float is digits <>;
package IOStream is
    -- Command line arguments
    type T_Arguments is record
        alpha  : T_Float range 0.0 .. 1.0;
        k      : Natural;
        eps    : T_Float;
        pleine : Boolean;
        output : Unbounded_String;
        input  : Unbounded_String;
    end record;

    -- File structure
    type T_Edge is record
        start : Natural;
        stop : Natural;
    end record;
    type T_Edges is array (Positive range <>) of T_Edge;
    type T_File(m : Natural) is tagged record
        n : Natural;
        edges : T_Edges(1..m);
    end record;

    -- Fuctions
    procedure parse_args(args : out T_Arguments);

    function parse_edge(input : String) return T_Edge;

    function parse_file(file_name : Unbounded_String) return T_File;
end IOStream;