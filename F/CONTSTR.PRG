/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		   BIBLIOTECAS DE FUNCIONES DE ESTRUCTURAS
			  SISTEMA DE CONTABILIDAD

OBJETIVOS:

- Define las funciones para crear las estructuras de los archivos del
  SIMA para el Sistema de Contabilidad Acad‚mica

***************************************************************************
*-------------------- ESTRUCTURAS PARA SIMACONT --------------------------*
**************************************************************************/

/*************************************************************************
* TITULO..: ESTADISTICA DE LAS MATERIAS                                  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 11/2005 MAR A
       Colombia, Bucaramanga        INICIO: 01:30 PM   OCT 11/2005 MAR

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrSCoStd(fArchvo,cTitArc,aCamGen,aRegIni)

*>>>>DESCRIPCION DE PARAMETROS
/*     fArchvo                              // Nombre del Archivo
       cTitArc                              // T¡tulo del Archivo
       aCamGen                              // Campos Generales
       aRegIni                              // @Registro Inicial */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL aCamReg := {}                  // Campos del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DEFINICION DE LA ESTRUCTURA
       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Std'})
       AADD(aCamReg,{'STR->cTemCamStr','Tgr'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoGru'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Grupo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;DEL GRUPO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL GRUPO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL GRUPO'})
       AADD(aCamReg,{'STR->cTitPrnStr','GRUPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Std'})
       AADD(aCamReg,{'STR->cTemCamStr','Tma'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoMat'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo de la Materia'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;MATERIA'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DE LA MATERIA'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE LA MATERIA'})
       AADD(aCamReg,{'STR->cTitPrnStr','MATERIA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Std'})
       AADD(aCamReg,{'STR->cTemCamStr','Tst'})
       AADD(aCamReg,{'STR->Field_Name','nNroPerStd'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero del Periodo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NUMERO;PERIODO'})
       AADD(aCamReg,{'STR->cTxtGetStr','PERIODO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DEL PERIODO'})
       AADD(aCamReg,{'STR->cTitPrnStr','PERIODO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Std'})
       AADD(aCamReg,{'STR->cTemCamStr','Tst'})
       AADD(aCamReg,{'STR->Field_Name','cNotDefStd'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XXXX'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nota Definitiva'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NOTA;DEFINITIVA'})
       AADD(aCamReg,{'STR->cTxtGetStr','NOTA DEFINITIVA'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NOTA DEFINITIVA'})
       AADD(aCamReg,{'STR->cTitPrnStr','NOTA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Std'})
       AADD(aCamReg,{'STR->cTemCamStr','Tst'})
       AADD(aCamReg,{'STR->Field_Name','nTotNotStd'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Total de Notas'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TOTAL;NOTAS'})
       AADD(aCamReg,{'STR->cTxtGetStr','TOTAL NOTAS'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TOTAL DE NOTAS'})
       AADD(aCamReg,{'STR->cTitPrnStr','TOTAL'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Std'})
       AADD(aCamReg,{'STR->cTemCamStr','Tst'})
       AADD(aCamReg,{'STR->Field_Name','nTotIndStd'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Indicadores Aprobados'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TOTAL;INDICADORES'})
       AADD(aCamReg,{'STR->cTxtGetStr','INDICADORES'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TOTAL DE INDICADORES'})
       AADD(aCamReg,{'STR->cTitPrnStr','INDICADORES'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Std'})
       AADD(aCamReg,{'STR->cTemCamStr','Tst'})
       AADD(aCamReg,{'STR->Field_Name','nIndiSiStd'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Indicadores Aprobados'})
       AADD(aCamReg,{'STR->cTxtBrwStr','INDICADORES;APROBADOS'})
       AADD(aCamReg,{'STR->cTxtGetStr','INDICADORES APROBADOS'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL INDICADORES APROBADOS'})
       AADD(aCamReg,{'STR->cTitPrnStr','IND SI'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Std'})
       AADD(aCamReg,{'STR->cTemCamStr','Tst'})
       AADD(aCamReg,{'STR->Field_Name','nIndiNoStd'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Indicadores Reprobados'})
       AADD(aCamReg,{'STR->cTxtBrwStr','INDICADORES;REPROBADOS'})
       AADD(aCamReg,{'STR->cTxtGetStr','INDICADORES REPROBADOS'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL INDICADORES REPROBADOS'})
       AADD(aCamReg,{'STR->cTitPrnStr','IND NO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Std'})
       AADD(aCamReg,{'STR->cTemCamStr','Tst'})
       AADD(aCamReg,{'STR->Field_Name','nTotEstStd'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Total de Estudiantes'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TOTAL;ESTUDIANTES'})
       AADD(aCamReg,{'STR->cTxtGetStr','TOTAL ESTUDIANTES'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TOTAL DE ESTUDIANTES'})
       AADD(aCamReg,{'STR->cTitPrnStr','TOT EST'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Std'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpr'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoPro'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Profesor'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;PROFESOR'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL PROFESOR'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL PROFESOR'})
       AADD(aCamReg,{'STR->cTitPrnStr','PROFESOR'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA



/*************************************************************************
* TITULO..: INTERVALO DE JUICIOS VALORATIVOS                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 14/2005 VIE A
       Colombia, Bucaramanga        INICIO: 10:35 PM   OCT 14/2005 VIE

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfJvf(fArchvo,cTitArc,aCamGen,aRegIni)

*>>>>DESCRIPCION DE PARAMETROS
/*     fArchvo                              // Nombre del Archivo
       cTitArc                              // T¡tulo del Archivo
       aCamGen                              // Campos Generales
       aRegIni                              // @Registro Inicial */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL aCamReg := {}                  // Campos del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DEFINICION DE LA ESTRUCTURA
       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Jvf'})
       AADD(aCamReg,{'STR->cTemCamStr','Tjv'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoJvf'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,1})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'X'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','Juicio Valorativo Final'})
       AADD(aCamReg,{'STR->cTxtBrwStr','JUICIO;VALORATIVO'})
       AADD(aCamReg,{'STR->cTxtGetStr','JUICIO VALORATIVO'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL JUICIO VALORATIVO'})
       AADD(aCamReg,{'STR->cTitPrnStr','JUICIO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Jvf'})
       AADD(aCamReg,{'STR->cTemCamStr','Tjv'})
       AADD(aCamReg,{'STR->Field_Name','cNombreJvf'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,14})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!A'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nombre del Juicio Valorativo Final'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DESCRIPCION'})
       AADD(aCamReg,{'STR->cTxtGetStr','DESCRIPCION'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA DESCRIPCION DEL JUICIO VALORATIVO'})
       AADD(aCamReg,{'STR->cTitPrnStr','DESCRIPCION'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Jvf'})
       AADD(aCamReg,{'STR->cTemCamStr','Tjv'})
       AADD(aCamReg,{'STR->Field_Name','nNotIniJvf'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nota Inicial'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NOTA;INICIAL'})
       AADD(aCamReg,{'STR->cTxtGetStr','NOTA INICIAL'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA NOTA INICIAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','NOTINI'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Jvf'})
       AADD(aCamReg,{'STR->cTemCamStr','Tjv'})
       AADD(aCamReg,{'STR->Field_Name','nNotFinJvf'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nota Final'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NOTA;FINAL'})
       AADD(aCamReg,{'STR->cTxtGetStr','NOTA FINAL'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA NOTA FINAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','NOTFIN'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Jvf'})
       AADD(aCamReg,{'STR->cTemCamStr','Tjv'})
       AADD(aCamReg,{'STR->Field_Name','lAproboJvf'})
       AADD(aCamReg,{'STR->Field_Type','L'})
       AADD(aCamReg,{'STR->Field_Len' ,1})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Aprobaci¢n del Juicio'})
       AADD(aCamReg,{'STR->cTxtBrwStr','APRUEBA;LA NOTA'})
       AADD(aCamReg,{'STR->cTxtGetStr','NOTA APROBADA'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA APROBACION DE LA NOTA'})
       AADD(aCamReg,{'STR->cTitPrnStr','APRUEBA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Jvf'})
       AADD(aCamReg,{'STR->cTemCamStr','Tjv'})
       AADD(aCamReg,{'STR->Field_Name','nFactorJvf'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'9.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Factor del Juicio valorativo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FACTOR;PARA JVF'})
       AADD(aCamReg,{'STR->cTxtGetStr','FACTOR PARA JVF'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL FACTOR DEL JVF'})
       AADD(aCamReg,{'STR->cTitPrnStr','FACTOR'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Jvf'})
       AADD(aCamReg,{'STR->cTemCamStr','Tjv'})
       AADD(aCamReg,{'STR->Field_Name','cNotNumJvf'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,05})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nota Numerica del Juicio Valorativo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NOTA;NUMERICA'})
       AADD(aCamReg,{'STR->cTxtGetStr','NOTA NUMERICA'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA NOTA NUMERICA'})
       AADD(aCamReg,{'STR->cTitPrnStr','NOTA NUMERICA'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: HORARIO DE CLASE                                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 14/2007 LUN A
       Colombia, Bucaramanga        INICIO: 09:00 AM   MAY 14/2007 LUN

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfHor(fArchvo,cTitArc,aCamGen,aRegIni)

*>>>>DESCRIPCION DE PARAMETROS
/*     fArchvo                              // Nombre del Archivo
       cTitArc                              // T¡tulo del Archivo
       aCamGen                              // Campos Generales
       aRegIni                              // @Registro Inicial */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL aCamReg := {}                  // Campos del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DEFINICION DE LA ESTRUCTURA
       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Hor'})
       AADD(aCamReg,{'STR->cTemCamStr','Tho'})
       AADD(aCamReg,{'STR->Field_Name','nDiaSemHor'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,1})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','D¡a de la Semama'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DIA DE LA;SEMANA'})
       AADD(aCamReg,{'STR->cTxtGetStr','DIA DE LA SEMANA'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL DIA DE LA SEMANA'})
       AADD(aCamReg,{'STR->cTitPrnStr','DIA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Hor'})
       AADD(aCamReg,{'STR->cTemCamStr','Tho'})
       AADD(aCamReg,{'STR->Field_Name','cCodHraHor'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,02})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XX'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo de la hora'})
       AADD(aCamReg,{'STR->cTxtBrwStr','HORA'})
       AADD(aCamReg,{'STR->cTxtGetStr','HORA'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA HORA DEL HORARIO'})
       AADD(aCamReg,{'STR->cTitPrnStr','HORA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Hor'})
       AADD(aCamReg,{'STR->cTemCamStr','Tho'})
       AADD(aCamReg,{'STR->Field_Name','cCodGruHor'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,04})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Grupo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','GRUPO'})
       AADD(aCamReg,{'STR->cTxtGetStr','GRUPO'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL GRUPO'})
       AADD(aCamReg,{'STR->cTitPrnStr','GRUPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Hor'})
       AADD(aCamReg,{'STR->cTemCamStr','Tho'})
       AADD(aCamReg,{'STR->Field_Name','cCodMatHor'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,04})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo de la Materia'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MATERIA'})
       AADD(aCamReg,{'STR->cTxtGetStr','MATERIA'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE LA MATERIA'})
       AADD(aCamReg,{'STR->cTitPrnStr','MATERIA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Hor'})
       AADD(aCamReg,{'STR->cTemCamStr','Tho'})
       AADD(aCamReg,{'STR->Field_Name','cCodAulHor'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,04})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Aula o Salon'})
       AADD(aCamReg,{'STR->cTxtBrwStr','AULA'})
       AADD(aCamReg,{'STR->cTxtGetStr','AULA'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL AULA'})
       AADD(aCamReg,{'STR->cTitPrnStr','MATERIA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Hor'})
       AADD(aCamReg,{'STR->cTemCamStr','Tho'})
       AADD(aCamReg,{'STR->Field_Name','cCodProHor'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,06})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Profesor'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PROFESOR'})
       AADD(aCamReg,{'STR->cTxtGetStr','PROFESOR'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL PROFESOR'})
       AADD(aCamReg,{'STR->cTitPrnStr','PROFESOR'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: PERSONAL DE LA EMPRESA                                       *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 08/2007 LUN A
       Colombia, Bucaramanga        INICIO: 06:00 PM   JUN 08/2007 LUN

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfPnl(fArchvo,cTitArc,aCamGen,aRegIni)

*>>>>DESCRIPCION DE PARAMETROS
/*     fArchvo                              // Nombre del Archivo
       cTitArc                              // T¡tulo del Archivo
       aCamGen                              // Campos Generales
       aRegIni                              // @Registro Inicial */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL aCamReg := {}                  // Campos del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DEFINICION DE LA ESTRUCTURA
       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Pnl'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpn'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoPnl'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Personal'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO'})
       AADD(aCamReg,{'STR->nLenGetStr',12})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Pnl'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpn'})
       AADD(aCamReg,{'STR->Field_Name','cTipPerPnl'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Tipo de persona'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIPO'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIPO'})
       AADD(aCamReg,{'STR->nLenGetStr',12})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIPO DE PERSONA'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Pnl'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpn'})
       AADD(aCamReg,{'STR->Field_Name','cPasWorPnl'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,10})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XXXXXXXXXX'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Clave de la Personal'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CLAVE'})
       AADD(aCamReg,{'STR->cTxtGetStr','CLAVE'})
       AADD(aCamReg,{'STR->nLenGetStr',12})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA CLAVE DEL PERSONAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','CLAVE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Pnl'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpn'})
       AADD(aCamReg,{'STR->Field_Name','lRetiroPnl'})
       AADD(aCamReg,{'STR->Field_Type','L'})
       AADD(aCamReg,{'STR->Field_Len' ,1})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Retiro del Personal'})
       AADD(aCamReg,{'STR->cTxtBrwStr','RETIRO'})
       AADD(aCamReg,{'STR->cTxtGetStr','RETIRO'})
       AADD(aCamReg,{'STR->nLenGetStr',12})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE SI SE RETIRO EL PERSONAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','RETIRO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Pnl'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpn'})
       AADD(aCamReg,{'STR->Field_Name','dFecRetPnl'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!D'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha de retiro'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;RETIRO'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA RETIRO'})
       AADD(aCamReg,{'STR->nLenGetStr',12})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DE RETIRO'})
       AADD(aCamReg,{'STR->cTitPrnStr','RETIRO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Pnl'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpn'})
       AADD(aCamReg,{'STR->Field_Name','nIdePerPnl'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Ide del Registro de Personas'})
       AADD(aCamReg,{'STR->cTxtBrwStr','IDEPER'})
       AADD(aCamReg,{'STR->cTxtGetStr','IDEPER'})
       AADD(aCamReg,{'STR->nLenGetStr',12})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL ID DE LA PERSONA'})
       AADD(aCamReg,{'STR->cTitPrnStr','IDEPER'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: TIPO DE PERSONAL                                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 15/2007 LUN A
       Colombia, Bucaramanga        INICIO: 02:00 PM   JUN 15/2007 LUN

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfTpe(fArchvo,cTitArc,aCamGen,aRegIni)

*>>>>DESCRIPCION DE PARAMETROS
/*     fArchvo                              // Nombre del Archivo
       cTitArc                              // T¡tulo del Archivo
       aCamGen                              // Campos Generales
       aRegIni                              // @Registro Inicial */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL aCamReg := {}                  // Campos del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DEFINICION DE LA ESTRUCTURA
       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tpe'})
       AADD(aCamReg,{'STR->cTemCamStr','Ttp'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoTpe'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','Tipo de Personal'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tpe'})
       AADD(aCamReg,{'STR->cTemCamStr','Ttp'})
       AADD(aCamReg,{'STR->Field_Name','cNombreTpe'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,40})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nombre del tipo de persona'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIPO'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIPO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIPO DE PERSONA'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tpe'})
       AADD(aCamReg,{'STR->cTemCamStr','Ttp'})
       AADD(aCamReg,{'STR->Field_Name','lCtrIngTpe'})
       AADD(aCamReg,{'STR->Field_Type','L'})
       AADD(aCamReg,{'STR->Field_Len' ,1})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Control de Ingreso'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CONTROL;INGRESO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CONTROL DE INGRESO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CONTROL DE INGRESO'})
       AADD(aCamReg,{'STR->cTitPrnStr','CONTROL'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tpe'})
       AADD(aCamReg,{'STR->cTemCamStr','Ttp'})
       AADD(aCamReg,{'STR->Field_Name','nCodigoTpe'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Posici¢n del C¢digo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','POSICION;CODIGO'})
       AADD(aCamReg,{'STR->cTxtGetStr','POSICION CODIGO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA POSICION DEL CODIGO'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tpe'})
       AADD(aCamReg,{'STR->cTemCamStr','Ttp'})
       AADD(aCamReg,{'STR->Field_Name','nLenCodTpe'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Longitud del C¢digo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','ANCHO;CODIGO'})
       AADD(aCamReg,{'STR->cTxtGetStr','ANCHO CODIGO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL ANCHO DEL CODIGO'})
       AADD(aCamReg,{'STR->cTitPrnStr','ANCHO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tpe'})
       AADD(aCamReg,{'STR->cTemCamStr','Ttp'})
       AADD(aCamReg,{'STR->Field_Name','nCodTipTpe'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Posici¢n del Tipo de Personal'})
       AADD(aCamReg,{'STR->cTxtBrwStr','POSICION;TIPO PERSONAL'})
       AADD(aCamReg,{'STR->cTxtGetStr','POSICION TIPO PERSONAL'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA POSICION DEL TIPO DE PERSONAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tpe'})
       AADD(aCamReg,{'STR->cTemCamStr','Ttp'})
       AADD(aCamReg,{'STR->Field_Name','nLenTipTpe'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Longitud del Tipo de Personal'})
       AADD(aCamReg,{'STR->cTxtBrwStr','ANCHO;TIPO PERSONAL'})
       AADD(aCamReg,{'STR->cTxtGetStr','ANCHO TIPO PERSONAL'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL ANCHO DEL TIPO DE PERSONAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','A.TIPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tpe'})
       AADD(aCamReg,{'STR->cTemCamStr','Ttp'})
       AADD(aCamReg,{'STR->Field_Name','nNitPerTpe'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Posici¢n de la Cedula de la persona'})
       AADD(aCamReg,{'STR->cTxtBrwStr','POSICION;DOCUMENTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','POSICION DOCUMENTO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA POSICION DEL DOCUMENTO DEL PERSONAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','P.DOCU'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tpe'})
       AADD(aCamReg,{'STR->cTemCamStr','Ttp'})
       AADD(aCamReg,{'STR->Field_Name','nLenNitSco'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Longitud de la Cedula de la persona'})
       AADD(aCamReg,{'STR->cTxtBrwStr','ANCHO;DOCUMENTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','ANCHO DOCUMENTO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL ANCHO DEL DOCUMENTO DEL PERSONAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','A.DOCU'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tpe'})
       AADD(aCamReg,{'STR->cTemCamStr','Ttp'})
       AADD(aCamReg,{'STR->Field_Name','nTipNitTpe'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Posici¢n Tipo de documento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','POSICION TIPO;DOCUMENTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','POSICION TIPO DOCUMENTO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA POSICION DEL TIPO DEL DOCUMENTO DEL PERSONAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','P.TDOC'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tpe'})
       AADD(aCamReg,{'STR->cTemCamStr','Ttp'})
       AADD(aCamReg,{'STR->Field_Name','nLenTniTpe'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Longitud Tipo de documento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','ANCHO TIPO;DOCUMENTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','ANCHO TIPO DOCUMENTO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL ANCHO DEL TIPO DEL DOCUMENTO DEL PERSONAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','A.TDOC'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tpe'})
       AADD(aCamReg,{'STR->cTemCamStr','Ttp'})
       AADD(aCamReg,{'STR->Field_Name','cTipCodTpe'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XX'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Tipo de Codigo. Espacios por defecto. 01=>De acuerdo a las posiciones'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIPO DE;CODIGO'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIPO DE CODIGO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIPO DE CODIGO'})
       AADD(aCamReg,{'STR->cTitPrnStr','T.COD'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: ESTADISTICA DE LOS INDICADORES                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 15/2007 MIE A
       Colombia, Bucaramanga        INICIO: 05:30 PM   AGO 15/2007 MIE

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrStdInd(fArchvo,cTitArc,aCamGen,aRegIni)

*>>>>DESCRIPCION DE PARAMETROS
/*     fArchvo                              // Nombre del Archivo
       cTitArc                              // T¡tulo del Archivo
       aCamGen                              // Campos Generales
       aRegIni                              // @Registro Inicial */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL aCamReg := {}                  // Campos del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DEFINICION DE LA ESTRUCTURA
       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','StI'})
       AADD(aCamReg,{'STR->cTemCamStr','Tgr'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoGru'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Grupo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;DEL GRUPO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL GRUPO'})
       AADD(aCamReg,{'STR->nLenGetStr',26})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL GRUPO'})
       AADD(aCamReg,{'STR->cTitPrnStr','GRUPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','StI'})
       AADD(aCamReg,{'STR->cTemCamStr','Tma'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoMat'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo de la Materia'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;MATERIA'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DE LA MATERIA'})
       AADD(aCamReg,{'STR->nLenGetStr',26})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE LA MATERIA'})
       AADD(aCamReg,{'STR->cTitPrnStr','MATERIA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','StI'})
       AADD(aCamReg,{'STR->cTemCamStr','Tst'})
       AADD(aCamReg,{'STR->Field_Name','nNroPerStI'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero del Periodo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NUMERO;PERIODO'})
       AADD(aCamReg,{'STR->cTxtGetStr','PERIODO'})
       AADD(aCamReg,{'STR->nLenGetStr',26})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DEL PERIODO'})
       AADD(aCamReg,{'STR->cTitPrnStr','PERIODO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','StI'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpr'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoPro'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Profesor'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;PROFESOR'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL PROFESOR'})
       AADD(aCamReg,{'STR->nLenGetStr',26})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL PROFESOR'})
       AADD(aCamReg,{'STR->cTitPrnStr','PROFESOR'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','StI'})
       AADD(aCamReg,{'STR->cTemCamStr','Tst'})
       AADD(aCamReg,{'STR->Field_Name','cNotDefStI'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XXXX'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nota Definitiva'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NOTA;DEFINITIVA'})
       AADD(aCamReg,{'STR->cTxtGetStr','NOTA DEFINITIVA'})
       AADD(aCamReg,{'STR->nLenGetStr',26})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NOTA DEFINITIVA'})
       AADD(aCamReg,{'STR->cTitPrnStr','NOTA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','StI'})
       AADD(aCamReg,{'STR->cTemCamStr','Tst'})
       AADD(aCamReg,{'STR->Field_Name','cJvfDefStI'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XXXX'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','JUICIO VALORATIVO'})
       AADD(aCamReg,{'STR->cTxtBrwStr','JVF;DEFINITIVA'})
       AADD(aCamReg,{'STR->cTxtGetStr','JVF DEFINITIVA'})
       AADD(aCamReg,{'STR->nLenGetStr',26})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NOTA DEFINITIVA'})
       AADD(aCamReg,{'STR->cTitPrnStr','NOTA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','StI'})
       AADD(aCamReg,{'STR->cTemCamStr','Tst'})
       AADD(aCamReg,{'STR->Field_Name','cCodIndStI'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Indicador'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;INDICADOR'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO INDICADOR'})
       AADD(aCamReg,{'STR->nLenGetStr',26})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO INDICADOR'})
       AADD(aCamReg,{'STR->cTitPrnStr','INDICADOR'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','StI'})
       AADD(aCamReg,{'STR->cTemCamStr','Tst'})
       AADD(aCamReg,{'STR->Field_Name','nEstuSiStI'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Estudiantes que aprobaron'})
       AADD(aCamReg,{'STR->cTxtBrwStr','ESTUDIANTES;APROBADOS'})
       AADD(aCamReg,{'STR->cTxtGetStr','ESTUDIANTES APROBADOS'})
       AADD(aCamReg,{'STR->nLenGetStr',26})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LOS ESTUDIANTES APROBADOS'})
       AADD(aCamReg,{'STR->cTitPrnStr','APROBADOS'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','StI'})
       AADD(aCamReg,{'STR->cTemCamStr','Tst'})
       AADD(aCamReg,{'STR->Field_Name','nEstuNoStI'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Estudiantes que no aprobaron'})
       AADD(aCamReg,{'STR->cTxtBrwStr','ESTUDIANTES;NO APROBADOS'})
       AADD(aCamReg,{'STR->cTxtGetStr','ESTUDIANTES NO APROBADOS'})
       AADD(aCamReg,{'STR->nLenGetStr',26})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LOS ESTUDIANTES NO APROBADOS'})
       AADD(aCamReg,{'STR->cTitPrnStr','NO APROBADOS'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','StI'})
       AADD(aCamReg,{'STR->cTemCamStr','Tst'})
       AADD(aCamReg,{'STR->Field_Name','nEstNoRStI'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Estudiantes recuperados'})
       AADD(aCamReg,{'STR->cTxtBrwStr','ESTUDIANTES;RECUPERACIONES'})
       AADD(aCamReg,{'STR->cTxtGetStr','ESTUDIANTES RECUPERACIONES'})
       AADD(aCamReg,{'STR->nLenGetStr',26})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LOS ESTUDIANTES CON RECUPERACIONES'})
       AADD(aCamReg,{'STR->cTitPrnStr','RECUPERACIONES'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','StI'})
       AADD(aCamReg,{'STR->cTemCamStr','Tst'})
       AADD(aCamReg,{'STR->Field_Name','nTotEstStI'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Total de Estudiantes'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TOTAL;ESTUDIANTES'})
       AADD(aCamReg,{'STR->cTxtGetStr','TOTAL ESTUDIANTES'})
       AADD(aCamReg,{'STR->nLenGetStr',26})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TOTAL DE ESTUDIANTES'})
       AADD(aCamReg,{'STR->cTitPrnStr','TOT EST'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA