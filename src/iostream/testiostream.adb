with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Float_Text_IO;		use Ada.Float_Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Command_line;		use Ada.Command_line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with IOStream;

procedure TestIOStream is
    package IO is
        new IOStream(T_Float => Float, "<" => "<");
    use IO;
    
    function Obtenir_argument return T_Content is
        res : T_Content(1..Argument_Count);
    begin
        for J in 1..Argument_Count loop
            res(J) := To_Unbounded_String(Argument(J));
        end loop;
        return res;
    end Obtenir_argument;

    -- récupération des Constants
    args : constant T_Args(Argument_Count) := (V_Count => Argument_Count, V_Args => Obtenir_argument);
    constantes : constant T_Constantes := Parse_Args(Args);
    alpha : constant Float := constantes.alpha;
    k : constant Natural := constantes.k;
    eps : constant Float := constantes.eps;
    mode : constant T_Mode := constantes.mode;
    prefixe : constant Unbounded_String := constantes.prefixe;
begin
    Put_Line("Testing `IOStream` Package ...");
    Put("Alpha = "); Put(alpha,Exp => 0); New_Line;
    Put("K = "); Put(k,1); New_Line;
    Put("Eps = "); Put(eps,Exp => 0); New_Line;
    Put("Mode = "); if mode = Pleine then Put("pleine"); else Put("creuse"); end if; New_Line;
    Put("Filename = "); Put(To_String(prefixe)); New_Line;
end TestIOStream;