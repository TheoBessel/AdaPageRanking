with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;

package body IOStream is
    procedure parse_args(args : out T_Arguments) is
        i : Positive := 1;
    begin
        -- Default parameter values
        args.alpha := 0.85;
        args.K := 150;
        args.eps := 0.0;
        args.pleine := False;
        args.output := To_Unbounded_String("output");
        while (i <= Argument_Count) loop
            case Argument(i)(2) is
                when 'A' => begin
                        i := i + 1;
                        args.alpha := T_Float'Value(Argument(i));
                    end;
                when 'K' => begin
                        i := i + 1;
                        args.k := Natural'Value(Argument(i));
                    end;
                when 'E' => begin
                        i := i + 1;
                        args.eps := T_Float'Value(Argument(i));
                    end;
                when 'P' => begin
                        args.pleine := True;
                    end;
                when 'C' => begin
                        args.pleine := False;
                    end;
                when 'R' => begin
                        i := i + 1;
                        args.output := To_Unbounded_String(Argument(i));
                    end;
                when others => begin -- TODO : Check if i == Argument_Count, else raise exception.
                        args.input := To_Unbounded_String(Argument(i));
                    end;
            end case;
            i := i + 1;
        end loop;
    end;

    function parse_edge(input : String) return T_Edge is
        edge : T_Edge;
        n : constant Natural := input'Length;
    begin
        for i in 1..n loop
            if input(i) = ' ' then
                edge.start := Natural'Value(input(input'First..i-1));
                edge.stop := Natural'Value(input(i+1..input'Last));
            end if;
        end loop;
        return edge;
    end;

    function count_lines(file_name : Unbounded_String) return Natural is
        n : Natural;
        file : File_Type;
    begin
        n := 0;
        Open(file, name => To_String(file_name), mode => In_File, form => "shared=no");
        while not End_of_file(file) loop
            n := n + 1;
            Skip_Line(file);
        end loop;
        Reset(file);
        Close(file);
        return n;
    end;

    function parse_file(file_name : Unbounded_String) return T_File is
        n : Natural;
        m : constant Natural := count_lines(file_name);
        output : T_File(m-1);
        file : File_Type;
    begin
        Open(file, name => To_String(file_name), mode => In_File, form => "shared=no");
        n := Integer'Value(Get_Line(file));
        output.n := n;
        for i in 1..m-1 loop -- m-1 edges because m lines with number of nodes
            output.edges(i) := parse_edge(Get_Line(file));
        end loop;
        Close(file);
        return output;
    end;
end IOStream;