----------------------------------------------------------------------------
---------------------- Script de création des indexes  ---------------------
----------------------------------------------------------------------------

-- Définir le schéma à utiliser
SET SEARCH_PATH = "I_SCOLARITE";



----------------------------------------------------------------------------
------------------ Table N°1 : "I_SCOLARITE"."TB_PAYEUR" -------------------
----------------------------------------------------------------------------
--DROP INDEX IF EXISTS "IDX_NOM_PREN_PAYEUR"; 
CREATE INDEX "IDX_NOM_PREN_PAYEUR" 
ON "TB_PAYEUR" USING BTREE ("LB_NOM_PAYEUR","LB_PREN_PAYEUR");


----------------------------------------------------------------------------
----------------- Table N°2 : "I_SCOLARITE"."TB_FORMATION" -----------------
----------------------------------------------------------------------------
--DROP INDEX IF EXISTS "IDX_NOM_FORMATION" ;
CREATE INDEX "IDX_NOM_FORMATION" 
ON "TB_FORMATION" USING BTREE ("NOM_FORMATION");


----------------------------------------------------------------------------
-------------- Table N°3 : "I_SCOLARITE"."TB_INSCRIPTION" ------------------
----------------------------------------------------------------------------
--DROP INDEX IF EXISTS "IDX_LB_TYPE_PAIEMENT_SOUHAITE_INSCRIPTION"; 
CREATE INDEX "IDX_LB_TYPE_PAIEMENT_SOUHAITE" 
ON "TB_INSCRIPTION" USING BTREE ("LB_TYPE_PAIEMENT_SOUHAITE");


----------------------------------------------------------------------------
--------------- Table N°4 : "I_SCOLARITE"."TB_PAIEMENT" --------------------
----------------------------------------------------------------------------
--DROP INDEX IF EXISTS "IDX_LB_MODE_PAIEMENT"; 
CREATE INDEX "IDX_LB_MODE_PAIEMENT" 
ON "TB_PAIEMENT" USING BTREE ("LB_MODE_PAIEMENT");


----------------------------------------------------------------------------
-------------------- Table N°5 : "I_NOTE"."TB_ECHEANCE" --------------------
----------------------------------------------------------------------------
--DROP INDEX IF EXISTS "IDX_LB_MODE_PAIEMENT_ECHEANCE"; 
CREATE INDEX "IDX_LB_MODE_PAIEMENT_ECHEANCE" 
ON "TB_ECHEANCE" USING BTREE ("LB_MODE_PAIEMENT");