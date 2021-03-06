------------------------------------------------------
--
-- Código destinado a dropar todas as FK's do DB
--
------------------------------------------------------

--BEGIN TRAN

DECLARE
    @nome_fk   VARCHAR(100),
    @table_name     VARCHAR(100),
    @str_sql        VARCHAR(max)

DECLARE cr_nome CURSOR FAST_FORWARD LOCAL FOR    
    SELECT
    LTRIM(RTRIM(FK.name)) objeto,
    TBL.name tabela
    FROM sys.foreign_keys FK
    LEFT JOIN sys.objects TBL ON FK.parent_object_id = TBL.object_id
    ORDER BY objeto

OPEN cr_nome
    WHILE (1=1)
    BEGIN
        FETCH cr_nome INTO @nome_fk, @table_name
    
    IF @@FETCH_STATUS <> 0
        BREAK
        
    SELECT @str_sql = 'ALTER TABLE dbo.' + @table_name + ' DROP CONSTRAINT ' + @nome_fk
    PRINT (@str_sql)
    EXEC (@str_sql)
  
    END
CLOSE cr_nome
DEALLOCATE cr_nome


--COMMIT
--ROLLBACK