/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		    DEFINICION DE ESTRUCTURAS DEL SISTEMA
			  SISTEMA DE MATRICULAS

OBJETIVOS:

- Define las funciones para crear las esctructuras de los archivos del
  sistema de Matr¡culas

***************************************************************************
*-------------------- DEFINICION DE ESTRUCTURAS --------------------------*
**************************************************************************/

/*************************************************************************
* TITULO..: TIPOS DE RECIBOS                                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC 06/2005 MAR A
       Colombia, Bucaramanga        INICIO: 12:30 AM   DIC 06/2005 MAR

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrMtrTrc(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Trc'})
       AADD(aCamReg,{'STR->cTemCamStr','Ttr'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoTrc'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Recibo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;RECIBO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO RECIBO'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL RECIBO'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Trc'})
       AADD(aCamReg,{'STR->cTemCamStr','Ttr'})
       AADD(aCamReg,{'STR->Field_Name','cNombreTrc'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,16})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nombre del Tipo de Recibo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NOMBRE;RECIBO'})
       AADD(aCamReg,{'STR->cTxtGetStr','NOMBRE DEL RECIBO'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NOMBRE DEL RECIBO'})
       AADD(aCamReg,{'STR->cTitPrnStr','NOMBRE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Ban'})
       AADD(aCamReg,{'STR->cTemCamStr','Tba'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoBan'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,02})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Banco'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;BANCO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL BANCO'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL BANCO'})
       AADD(aCamReg,{'STR->cTitPrnStr','BANCO'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: ARCHIVO DEL SISBEN                                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 26/2007 LUN A
       Colombia, Bucaramanga        INICIO: 03:30 AM   SEP 26/2007 LUN

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfSib(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Sib'})
       AADD(aCamReg,{'STR->cTemCamStr','Tsi'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoEst'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,06})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Estudiante'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO ESTUDIANTE'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Sib'})
       AADD(aCamReg,{'STR->cTemCamStr','Tsi'})
       AADD(aCamReg,{'STR->Field_Name','cNroFicSib'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,06})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XXXXXX'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Ficha del Sisben'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FICHA'})
       AADD(aCamReg,{'STR->cTxtGetStr','NUMERO DE FICHA'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DE LA FICHA'})
       AADD(aCamReg,{'STR->cTitPrnStr','FICHA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Sib'})
       AADD(aCamReg,{'STR->cTemCamStr','Tsi'})
       AADD(aCamReg,{'STR->Field_Name','cNroNivSib'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,02})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XX'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nivel del Sisben'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NIVEL'})
       AADD(aCamReg,{'STR->cTxtGetStr','NIVEL'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NIVEL DEL SISBEN'})
       AADD(aCamReg,{'STR->cTitPrnStr','NIVEL'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Sib'})
       AADD(aCamReg,{'STR->cTemCamStr','Tsi'})
       AADD(aCamReg,{'STR->Field_Name','cPuntajSib'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,08})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XXXXXXXXX'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Puntaje del Sisben'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PUNTAJE'})
       AADD(aCamReg,{'STR->cTxtGetStr','PUNTAJE'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL PUNTAJE DEL SISBEN'})
       AADD(aCamReg,{'STR->cTitPrnStr','PUNTAJE'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: CONFIGURACION DE RECIBOS                                     *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 11/2011 MAR A
       Colombia, Bucaramanga        INICIO: 03:00 PM   NOV 11/2011 MAR

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfMzp(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Mzp'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmz'})
       AADD(aCamReg,{'STR->Field_Name','nRecNroMzp'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero del Recibo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NUMERO;RECIBO'})
       AADD(aCamReg,{'STR->cTxtGetStr','RECIBO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DEL RECIBO'})
       AADD(aCamReg,{'STR->cTitPrnStr','RECIBO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mzp'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmz'})
       AADD(aCamReg,{'STR->Field_Name','cCamposMzp'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,06})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XXXXXX'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','Campo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CAMPO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CAMPO'})
       AADD(aCamReg,{'STR->nLenGetStr',6})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CAMPO'})
       AADD(aCamReg,{'STR->cTitPrnStr','CAMPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mzp'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmz'})
       AADD(aCamReg,{'STR->Field_Name','cParte1Mzp'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,60})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XXXXXX'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Parte1'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PARTE1'})
       AADD(aCamReg,{'STR->cTxtGetStr','PARTE1'})
       AADD(aCamReg,{'STR->nLenGetStr',6})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL PARTE1'})
       AADD(aCamReg,{'STR->cTitPrnStr','PARTE1'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mzp'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmz'})
       AADD(aCamReg,{'STR->Field_Name','cParte2Mzp'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,60})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XXXXXX'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Parte2'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PARTE2'})
       AADD(aCamReg,{'STR->cTxtGetStr','PARTE2'})
       AADD(aCamReg,{'STR->nLenGetStr',6})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL PARTE2'})
       AADD(aCamReg,{'STR->cTitPrnStr','PARTE2'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mzp'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmz'})
       AADD(aCamReg,{'STR->Field_Name','cParte3Mzp'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,60})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XXXXXX'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Parte3'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PARTE3'})
       AADD(aCamReg,{'STR->cTxtGetStr','PARTE3'})
       AADD(aCamReg,{'STR->nLenGetStr',6})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL PARTE3'})
       AADD(aCamReg,{'STR->cTitPrnStr','PARTE3'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mzp'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmz'})
       AADD(aCamReg,{'STR->Field_Name','cParte4Mzp'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,60})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XXXXXX'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Parte4'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PARTE4'})
       AADD(aCamReg,{'STR->cTxtGetStr','PARTE4'})
       AADD(aCamReg,{'STR->nLenGetStr',6})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL PARTE4'})
       AADD(aCamReg,{'STR->cTitPrnStr','PARTE4'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mzp'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmz'})
       AADD(aCamReg,{'STR->Field_Name','cParte5Mzp'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,60})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XXXXXX'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Parte5'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PARTE5'})
       AADD(aCamReg,{'STR->cTxtGetStr','PARTE5'})
       AADD(aCamReg,{'STR->nLenGetStr',6})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL PARTE5'})
       AADD(aCamReg,{'STR->cTitPrnStr','PARTE5'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mzp'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmz'})
       AADD(aCamReg,{'STR->Field_Name','cParte6Mzp'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,60})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XXXXXX'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Parte6'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PARTE6'})
       AADD(aCamReg,{'STR->cTxtGetStr','PARTE6'})
       AADD(aCamReg,{'STR->nLenGetStr',6})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL PARTE6'})
       AADD(aCamReg,{'STR->cTitPrnStr','PARTE6'})
       AADD(aRegIni,aCamReg)


       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA