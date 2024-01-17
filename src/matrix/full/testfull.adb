with Ada.Text_IO; use Ada.Text_IO;

with IOStream;
with Full;

procedure TestFull is
    package F_IOStream is
        new IOStream(T_Float => Float);
        
    package F_Full is
        new Full(T_Float => Float, P_IOStream => F_IOStream);
    use F_Full;

    -- Cas de test pour la fonction init
    procedure Test_Init is
        mat : constant T_Matrix := init(3, 3, 1.0);
    begin
        -- Vérifier que toutes les valeurs sont initialisées correctement
        for i in 1..mat'Length(1) loop
            for j in 1..mat'Length(2) loop
                pragma Assert(mat(i, j) = 1.0);
            end loop;
        end loop;
        Put_Line("Test_Init passed !");
    end;

    -- Cas de test pour la fonction get et set
    procedure Test_Get_Set is
        mat : T_Matrix := init(3, 3, 0.0);
    begin
        -- Vérifier que les valeurs sont correctement obtenues et modifiées
        set(mat, 2, 2, 42.0);
        pragma Assert(get(mat, 2, 2) = 42.0);
        Put_Line("Test_Get_Set passed !");
    end;

    -- Cas de test pour la multiplication de matrices
    procedure Test_Matrix_Multiplication is
        mat1 : constant T_Matrix := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0));
        mat2 : constant T_Matrix := ((7.0, 8.0), (9.0, 10.0), (11.0, 12.0));
        result : constant T_Matrix := mat1 * mat2;
    begin
        -- Vérifier les dimensions de la matrice résultante
        pragma Assert(result'Length(1) = mat1'Length(1) and result'Length(2) = mat2'Length(2));
        -- Vérifier quelques valeurs spécifiques dans la matrice résultante
        pragma Assert(result(1, 1) = 58.0);
        pragma Assert(result(1, 2) = 64.0);
        pragma Assert(result(2, 1) = 139.0);
        Put_Line("Test_Matrix_Multiplication passed !");
    end;

    -- Cas de test pour la transposition de la matrice
    procedure Test_Transpose is
        mat : constant T_Matrix := ((1.0, 2.0, 3.0), (4.0, 5.0, 6.0));
        transposed : constant T_Matrix := T(mat);
    begin
        -- Vérifier les dimensions de la matrice transposée
        pragma Assert(transposed'Length(1) = mat'Length(2) and transposed'Length(2) = mat'Length(1));
        
        -- Vérifier quelques valeurs spécifiques dans la matrice transposée
        pragma Assert(transposed(1, 1) = 1.0);
        pragma Assert(transposed(2, 1) = 2.0);
        pragma Assert(transposed(3, 2) = 6.0);
        Put_Line("Test_Transpose passed !");
    end;
begin
    Put_Line("Testing `Full` Package ..."); New_Line;
    Test_Init;
    Test_Get_Set;
    Test_Matrix_Multiplication;
    Test_Transpose;
    Put_Line("All tests passed !");
end;