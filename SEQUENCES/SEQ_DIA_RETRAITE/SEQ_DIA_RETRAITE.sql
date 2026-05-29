CREATE OR REPLACE STAGE marcela COMMENT = 'Stage interne pour les fichiers SQL de la séquence';

PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/ddl_D_EVENEMENT_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/dml_D_EVENEMENT_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
EXECUTE IMMEDIATE FROM '@marcela/ddl_D_EVENEMENT_RETRAITE.sql';
EXECUTE IMMEDIATE FROM '@marcela/dml_D_EVENEMENT_RETRAITE.sql';

PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/ddl_D_PERSONNE_PHYSIQUE_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/dml_D_PERSONNE_PHYSIQUE_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
EXECUTE IMMEDIATE FROM '@marcela/ddl_D_PERSONNE_PHYSIQUE_RETRAITE.sql';
EXECUTE IMMEDIATE FROM '@marcela/dml_D_PERSONNE_PHYSIQUE_RETRAITE.sql';

PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/ddl_D_CATEGORIE_SUPPORT_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/dml_D_CATEGORIE_SUPPORT_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
EXECUTE IMMEDIATE FROM '@marcela/ddl_D_CATEGORIE_SUPPORT_RETRAITE.sql';
EXECUTE IMMEDIATE FROM '@marcela/dml_D_CATEGORIE_SUPPORT_RETRAITE.sql';

PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/ddl_D_PROFIL_GESTION_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/dml_D_PROFIL_GESTION_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
EXECUTE IMMEDIATE FROM '@marcela/ddl_D_PROFIL_GESTION_RETRAITE.sql';
EXECUTE IMMEDIATE FROM '@marcela/dml_D_PROFIL_GESTION_RETRAITE.sql';

PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/ddl_D_PERSONNE_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/dml_D_PERSONNE_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
EXECUTE IMMEDIATE FROM '@marcela/ddl_D_PERSONNE_RETRAITE.sql';
EXECUTE IMMEDIATE FROM '@marcela/dml_D_PERSONNE_RETRAITE.sql';

PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/ddl_D_SUPPORT_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/dml_D_SUPPORT_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
EXECUTE IMMEDIATE FROM '@marcela/ddl_D_SUPPORT_RETRAITE.sql';
EXECUTE IMMEDIATE FROM '@marcela/dml_D_SUPPORT_RETRAITE.sql';

PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/ddl_D_CONTRAT_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/dml_D_CONTRAT_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
EXECUTE IMMEDIATE FROM '@marcela/ddl_D_CONTRAT_RETRAITE.sql';
EXECUTE IMMEDIATE FROM '@marcela/dml_D_CONTRAT_RETRAITE.sql';

PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/ddl_D_ASSURE_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/dml_D_ASSURE_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
EXECUTE IMMEDIATE FROM '@marcela/ddl_D_ASSURE_RETRAITE.sql';
EXECUTE IMMEDIATE FROM '@marcela/dml_D_ASSURE_RETRAITE.sql';

PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/ddl_F_EVENEMENT_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/dml_F_EVENEMENT_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
EXECUTE IMMEDIATE FROM '@marcela/ddl_F_EVENEMENT_RETRAITE.sql';
EXECUTE IMMEDIATE FROM '@marcela/dml_F_EVENEMENT_RETRAITE.sql';

PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/ddl_F_VALORISATION_SUPPORT_CONTRAT_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/dml_F_VALORISATION_SUPPORT_CONTRAT_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
EXECUTE IMMEDIATE FROM '@marcela/ddl_F_VALORISATION_SUPPORT_CONTRAT_RETRAITE.sql';
EXECUTE IMMEDIATE FROM '@marcela/dml_F_VALORISATION_SUPPORT_CONTRAT_RETRAITE.sql';

PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/ddl_F_EVENEMENT_DETAIL_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
PUT file://C:/Users/marcelaa/ALPTIS/GithubBI/snowflake_aps/Databases/Schémas/DIA/dml_F_EVENEMENT_DETAIL_RETRAITE.sql @marcela AUTO_COMPRESS = FALSE OVERWRITE = TRUE;
EXECUTE IMMEDIATE FROM '@marcela/ddl_F_EVENEMENT_DETAIL_RETRAITE.sql';
EXECUTE IMMEDIATE FROM '@marcela/dml_F_EVENEMENT_DETAIL_RETRAITE.sql';

DROP STAGE IF EXISTS marcela;
