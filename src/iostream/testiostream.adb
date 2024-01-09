with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with IOStream;

procedure TestIOStream is
    package F_IOStream is
        new IOStream(T_Float => Float);
    use F_IOStream;

    procedure print_float(f : Float) is
    begin
        Put(f, Aft => 1, Exp => 0);
    end;

    params : T_Arguments;
begin
    Put_Line("Testing `IOStream` Package ..."); New_Line;
    
    parse_args(params);
    Put("alpha : "); print_float(params.alpha); New_Line;
    Put("K : "); Put(params.k); New_Line;
    Put("epsilon : "); print_float(params.eps); New_Line;
    Put("pleine : "); Put(params.pleine'Image); New_Line;
    Put("output : "); Put(To_String(params.output)); New_Line;
    Put("input : "); Put(To_String(params.input)); New_Line;

    New_Line;

    declare
        file : constant F_IOStream.T_File := F_IOStream.parse_file(To_Unbounded_String("/Users/theobessel/Documents/N7/Informatique/AdaPageRankingNUCKED/static/testgraph.net"));
    begin
        for i in file.edges'Range loop
            Put(file.edges(i).start,1); Put(" -> "); Put(file.edges(i).stop,1); New_Line;
        end loop;
    end;
end;