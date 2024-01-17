with Ada.Text_IO; use Ada.Text_IO;

with IOStream;
with Sparse;

procedure TestSparse is
    package F_IOStream is
        new IOStream(T_Float => Float);
        
    package F_Sparse is
        new Sparse(T_Float => Float, P_IOStream => F_IOStream);
    use F_Sparse;

    -- Cas de test pour la fonction get et set
    procedure Test_Get_Set is
        mat : T_Matrix := init(3, 3);
    begin
        -- Vérifier que les valeurs sont correctement obtenues et modifiées
        set(mat, 2, 2, 42.0);
        pragma Assert(get(mat, 2, 2) = 42.0);
        Put_Line("Test_Get_Set passed !");
    end;

    -- Cas de test pour la multiplication de matrices
    procedure Test_Matrix_Multiplication is
        mat1 : T_Matrix := init(2, 3);
        mat2 : T_Matrix := init(3, 2);
    begin
        set(mat1,1,1,1.0); set(mat1,1,2,2.0); set(mat1,1,3,3.0);
        set(mat1,2,1,4.0); set(mat1,2,2,5.0); set(mat1,2,3,6.0);
        
        set(mat2,1,1,7.0); set(mat2,1,2,8.0);
        set(mat2,2,1,9.0); set(mat2,2,2,10.0);
        set(mat2,3,1,11.0); set(mat2,3,2,12.0);

        declare
            result : constant T_Matrix := mat1 * mat2;
        begin
            -- Vérifier les dimensions de la matrice résultante
            pragma Assert(result.height = mat1.height and result.width = mat2.width);
            -- Vérifier quelques valeurs spécifiques dans la matrice résultante
            pragma Assert(get(result, 1, 1) = 58.0);
            pragma Assert(get(result, 1, 2) = 64.0);
            pragma Assert(get(result, 2, 1) = 139.0);
            Put_Line("Test_Matrix_Multiplication passed !");
        end;
    end;

    -- Cas de test pour la transposition de la matrice
    procedure Test_Transpose is
        mat : T_Matrix := init(2, 3);
    begin
        set(mat,1,1,1.0); set(mat,1,2,2.0); set(mat,1,3,3.0);
        set(mat,2,1,4.0); set(mat,2,2,5.0); set(mat,2,3,6.0);
        declare
            transposed : constant T_Matrix := T(mat);
        begin
            -- Vérifier les dimensions de la matrice transposée
            pragma Assert(transposed.height = mat.width and transposed.width = mat.height);
            -- Vérifier quelques valeurs spécifiques dans la matrice transposée
            pragma Assert(get(transposed, 1, 1) = 1.0);
            pragma Assert(get(transposed, 2, 1) = 2.0);
            pragma Assert(get(transposed, 3, 2) = 6.0);
            Put_Line("Test_Transpose passed !");
        end;
    end;
begin
    Put_Line("Testing `Sparse` Package ..."); New_Line;
    Test_Get_Set;
    Test_Matrix_Multiplication;
    Test_Transpose;
    Put_Line("All tests passed !");
end;