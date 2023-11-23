with Text_IO; use Text_IO;

with IOStream;

procedure TestIOStream is
    package IO is
        new IOStream(T_Float => Float);
    use IO;

    args : IO.T_Args(1..Argument_Count);
begin
    for i in args'Range loop
        args(i) := Argument(i);
    end loop;
    Put_Line("Testing `IOStream` Package ...");
end TestIOStream;