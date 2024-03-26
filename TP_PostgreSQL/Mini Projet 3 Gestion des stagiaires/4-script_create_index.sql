----------------------------------------------------------------------------
---------------------- Script de création des indexes  ---------------------
----------------------------------------------------------------------------

-- Définir le schéma à utiliser
SET SEARCH_PATH = "I_RH";



----------------------------------------------------------------------------
-------------------- Table N°1 : "I_RH"."TB_STAGIAIRE" ---------------------
----------------------------------------------------------------------------
--DROP INDEX IF EXISTS "IDX_NOM_PREN_STAGIAIRE"; 
CREATE INDEX "IDX_NOM_PREN_STAGIAIRE" 
ON "TB_STAGIAIRE" USING BTREE ("LB_NOM_STAGIAIRE","LB_PREN_STAGIAIRE");


----------------------------------------------------------------------------
------------------- Table N°2 : "I_RH"."TB_TYPE_CONTRAT" -------------------
----------------------------------------------------------------------------
--DROP INDEX IF EXISTS "IDX_LB_TYPE_CONTRAT" ;
CREATE INDEX "IDX_LB_TYPE_CONTRAT" 
ON "TB_TYPE_CONTRAT" USING BTREE ("LB_TYPE_CONTRAT");


----------------------------------------------------------------------------
-------------------- Table N°3 : "I_RH"."TB_EQUIPE" ------------------------
----------------------------------------------------------------------------
--DROP INDEX IF EXISTS "IDX_LB_RESPONSABLE_EQUIPE"; 
CREATE INDEX "IDX_LB_RESPONSABLE_EQUIPE" 
ON "TB_EQUIPE" USING BTREE ("LB_RESPONSABLE_EQUIPE");


----------------------------------------------------------------------------
------------------- Table N°4 : "I_RH"."TB_CONTRAT" ------------------------
----------------------------------------------------------------------------
--DROP INDEX IF EXISTS "IDX_DT_DEBUT"; 
CREATE INDEX "IDX_DT_DEBUT" 
ON "TB_CONTRAT" USING BTREE ("DT_DEBUT");

--DROP INDEX IF EXISTS "IDX_DT_FIN"; 
CREATE INDEX "IDX_DT_FIN" 
ON "TB_CONTRAT" USING BTREE ("DT_FIN");

--DROP INDEX IF EXISTS "IDX_NB_SALAIRE"; 
CREATE INDEX "IDX_NB_SALAIRE" 
ON "TB_CONTRAT" USING BTREE ("NB_SALAIRE");


----------------------------------------------------------------------------
---------------- Table N°5 : "I_RH"."TB_AFFECTATION_EQUIPE" ----------------
----------------------------------------------------------------------------
--DROP INDEX IF EXISTS "IDX_DT_FIN_AFFECTATION_EQUIPE"; 
CREATE INDEX "IDX_DT_FIN_AFFECTATION_EQUIPE" 
ON "TB_AFFECTATION_EQUIPE" USING BTREE ("DT_FIN");