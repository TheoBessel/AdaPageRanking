package body IOStream is
    procedure parse_args(args : T_Args; count : Natural) is
    begin
        if Argument_Count < 1 then
            raise Bad_Arguments_Exception with "The program need at list one argument";
        else
            
        end if;
    end;
end IOStream;