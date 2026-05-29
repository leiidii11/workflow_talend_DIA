INSERT ALL
    WHEN (
        SELECT NOT EXISTS (
            SELECT *
            FROM DIA.F_VALORISATION_SUPPORT_CONTRAT_
            WHERE SK_F_VALORISATION_SUPPORT_CONTRAT_ = 0
        )
    )
    THEN INTO DIA.F_VALORISATION_SUPPORT_CONTRAT_ (
        SK_F_VALORISATION_SUPPORT_CONTRAT_,
        ID_SUPPORT_COMPOSANT,
        DT_VALORISATION,
        DT_SITUATION_CONTRAT,
        DT_FIN_VALORISATION,
        PLUS_OU_MOINS_VALUE,
        MT_SUPPORT,
        NB_PART,
        ID_SUPPORT_RETRAITE,
        FK_D_SUPPORT_RETRAITE,
        EST_DERNIERE_SITUATION,
        ID_CONTRAT,
        FK_D_CONTRAT_RETRAITE,
        FK_D_CONTRAT_RETRAITE_DERNIERE_VERSION,
        ID_PROFIL_GESTION,
        FK_D_PROFIL_GESTION_RETRAITE,
        DT_CREA,
        DT_MODIF,
        DT_ALIM
    )
    VALUES (
        0,
        -2,
        NULL,
        NULL,
        NULL,
        NULL,
        '',
        NULL,
        -2,
        0,
        NULL,
        -2,
        0,
        0,
        -2,
        0,
        GETDATE(),
        GETDATE(),
        GETDATE()
    )
    WHEN (
        SELECT NOT EXISTS (
            SELECT *
            FROM DIA.F_VALORISATION_SUPPORT_CONTRAT_
            WHERE SK_F_VALORISATION_SUPPORT_CONTRAT_ = -1
        )
    )
    THEN INTO DIA.F_VALORISATION_SUPPORT_CONTRAT_ (
        SK_F_VALORISATION_SUPPORT_CONTRAT_,
        ID_SUPPORT_COMPOSANT,
        DT_VALORISATION,
        DT_SITUATION_CONTRAT,
        DT_FIN_VALORISATION,
        PLUS_OU_MOINS_VALUE,
        MT_SUPPORT,
        NB_PART,
        ID_SUPPORT_RETRAITE,
        FK_D_SUPPORT_RETRAITE,
        EST_DERNIERE_SITUATION,
        ID_CONTRAT,
        FK_D_CONTRAT_RETRAITE,
        FK_D_CONTRAT_RETRAITE_DERNIERE_VERSION,
        ID_PROFIL_GESTION,
        FK_D_PROFIL_GESTION_RETRAITE,
        DT_CREA,
        DT_MODIF,
        DT_ALIM
    )
    VALUES (
        -1,
        -1,
        NULL,
        NULL,
        NULL,
        NULL,
        '',
        NULL,
        -1,
        -1,
        NULL,
        -1,
        -1,
        -1,
        -1,
        -1,
        GETDATE(),
        GETDATE(),
        GETDATE()
    )
SELECT 1;
