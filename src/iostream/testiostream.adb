with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Float_Text_IO;		use Ada.Float_Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Command_line;		use Ada.Command_line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with IOStream;

procedure TestIOStream is
    package IO is
        new IOStream(T_Float => Float);
    use IO;

    args : IO.T_Args(Argument_Count);
begin
    for i in 1..args.V_Count loop
        args.V_Args(i) := To_Unbounded_String(Argument(i));
    end loop;
    Put_Line("Testing `IOStream` Package ...");
    parse_args(args);
    Put("alpha = "); Put(alpha,Exp => 0); New_Line;
    Put("K = "); Put(k,1); New_Line;
    Put("eps = "); Put(eps,Exp => 0); New_Line;
    Put("mode = "); if IO.mode = Pleine then Put("pleine"); else Put("creuse"); end if; New_Line;
    Put("filename = "); Put(To_String(res)); New_Line;
end TestIOStream;