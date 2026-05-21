INSERT ALL
    WHEN (
        SELECT NOT EXISTS (
            SELECT *
            FROM DIA.D_ASSURE_RETRAITE
            WHERE SK_D_ASSURE_RETRAITE = 0
        )
    ) THEN
    INTO DIA.D_ASSURE_RETRAITE (
        SK_D_ASSURE_RETRAITE,
        ID_ASSURE,
        ID_PERSONNE_ASSURE,
        FK_D_PERSONNE_RETRAITE_ASSURE,
        ID_CONTRAT_RETRAITE,
        FK_D_CONTRAT_RETRAITE,
        DT_CREA,
        DT_MODIF,
        DT_ALIM
    ) VALUES (
        0, '0', 0, 0, 0, 0, GETDATE(), GETDATE(), GETDATE()
    )
    WHEN (
        SELECT NOT EXISTS (
            SELECT *
            FROM DIA.D_ASSURE_RETRAITE
            WHERE SK_D_ASSURE_RETRAITE = -1
        )
    ) THEN
    INTO DIA.D_ASSURE_RETRAITE (
        SK_D_ASSURE_RETRAITE,
        ID_ASSURE,
        ID_PERSONNE_ASSURE,
        FK_D_PERSONNE_RETRAITE_ASSURE,
        ID_CONTRAT_RETRAITE,
        FK_D_CONTRAT_RETRAITE,
        DT_CREA,
        DT_MODIF,
        DT_ALIM
    ) VALUES (
        -1, '-1', -1, -1, -1, -1, GETDATE(), GETDATE(), GETDATE()
    )
SELECT * FROM DUAL;
