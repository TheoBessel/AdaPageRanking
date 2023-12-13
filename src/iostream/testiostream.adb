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
    
    -- récupération des Constants
    args : T_Args(Argument_Count);
    
    constantes : T_Constantes;
    alpha : Float := constantes.alpha;
    k : Natural := constantes.k;
    eps : Float := constantes.eps;
    mode : T_Mode := constantes.mode;
    prefixe : Unbounded_String := constantes.prefixe;
begin
    for i in 1..args.V_Count loop
        args.V_Args(i) := To_Unbounded_String(Argument(i));
    end loop;
    Put_Line("Testing `IOStream` Package ...");
    Parse_Args(args, constantes);
    alpha := constantes.alpha;
    k := constantes.k;
    eps := constantes.eps;
    mode := constantes.mode;
    prefixe := constantes.prefixe;
    Put("alpha = "); Put(alpha,Exp => 0); New_Line;
    Put("K = "); Put(k,1); New_Line;
    Put("eps = "); Put(eps,Exp => 0); New_Line;
    Put("mode = "); if IO.mode = Pleine then Put("pleine"); else Put("creuse"); end if; New_Line;
    Put("filename = "); Put(To_String(prefixe)); New_Line;
end TestIOStream;