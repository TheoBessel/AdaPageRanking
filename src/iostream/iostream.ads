with Ada.Exceptions;
with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Float_Text_IO;		use Ada.Float_Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Command_line;		use Ada.Command_line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

generic
    type T_Float is digits <>;

package IOStream is
    type T_Mode is (
        Pleine,
        Creuse
    );
    type T_Content is array (Positive range <>) of Unbounded_String;
    type T_Args(V_Count : Natural) is tagged record
        V_Args : T_Content(1..V_Count);
    end record;

    Bad_Arguments_Exception : Exception;

    alpha : T_Float := 0.85;
    k : Natural := 150;
    eps : T_Float := 0.0;
    mode : T_Mode := Pleine;
    res : Unbounded_String := To_Unbounded_String("output");

    procedure parse_args(args : T_Args);
    --procedure parse_file(name : Unbounded_String);
private
end IOStream;