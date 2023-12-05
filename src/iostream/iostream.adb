package body IOStream is
    procedure parse_args(args : T_Args) is
        function parse_composed_arg(prefix : String) return String is
            found : Boolean := False;
            output : Unbounded_String;
        begin
            for i in 1..args.V_Count loop
                if (args.V_Args(i) = To_Unbounded_String(prefix)) then
                    if found then
                        raise Bad_Arguments_Exception with "The argument " & To_String(args.V_Args(i)) & " has already been specified";
                    elsif i < args.V_Count then
                        output := args.V_Args(i + 1);
                        found := True;
                    else
                        raise Bad_Arguments_Exception with "An argument is missing after : " & To_String(args.V_Args(i));
                    end if;
                end if;
            end loop;
            return To_String(output);
        end;
        function parse_optionnal_arg(true_option : String; false_option : String) return Boolean is
            found : Boolean := False;
            output : Boolean := True;
        begin
            for i in 1..args.V_Count loop
                if (args.V_Args(i) = To_Unbounded_String(true_option)) then
                    if found then
                        raise Bad_Arguments_Exception with "The argument " & To_String(args.V_Args(i)) & " has already been specified";
                    else
                        output := True;
                        found := True;
                    end if;
                elsif (args.V_Args(i) = To_Unbounded_String(false_option)) then
                    if found then
                        raise Bad_Arguments_Exception with "The argument " & To_String(args.V_Args(i)) & " has already been specified";
                    else
                        output := False;
                        found := True;
                    end if;
                end if;
            end loop;
            return output;
        end;
    begin
        if args.V_Count < 1 then
            raise Bad_Arguments_Exception with "The program need at list one argument";
        else
            alpha := T_Float'Value(parse_composed_arg("-A"));
            k := Integer'Value(parse_composed_arg("-K"));
            eps := T_Float'Value(parse_composed_arg("-E"));
            if not parse_optionnal_arg("-P","-C") then
                mode := Creuse;
            end if;
            res := To_Unbounded_String(parse_composed_arg("-R"));
        end if;
    end;
end IOStream;