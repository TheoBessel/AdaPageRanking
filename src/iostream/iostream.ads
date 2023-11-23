with Ada.Exceptions;
with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Float_Text_IO;		use Ada.Float_Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Command_line;		use Ada.Command_line;

generic
    type T_Float is digits <>;

package IOStream is
    type T_Mode is private;
    type T_Args is private;

    Bad_Arguments_Exception : Exception;

    alpha : T_Float := 0.85;
    k : Natural := 150;
    eps : T_Float := 0.0;
    mode : T_Mode := Pleine;
    res : String := "output";

    procedure parse_args(args : T_Args; count : Natural);
    procedure parse_file(name : String);
private
    type T_Mode is (
        Pleine,
        Creuse
    );
    type T_Args is array (Positive range <>) of String;
end IOStream;