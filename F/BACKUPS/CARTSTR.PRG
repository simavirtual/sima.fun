/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		   BIBLIOTECAS DE FUNCIONES DE ESTRUCTURAS
			  SISTEMA DE CARTERA

OBJETIVOS:

- Define las funciones para crear las estructuras de los archivos del
  SIMA para el Sistema de Cartera Acad‚mica.

***************************************************************************
*-------------------- ESTRUCTURAS PARA SIMACART --------------------------*
**************************************************************************/

/*************************************************************************
* TITULO..: ESTUDIANTES EN CONVENIO                                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE 31/2007 MAR A
       Colombia, Bucaramanga        INICIO: 01:30 PM   ENE 31/2007 MAR

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrCarCvn(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Cvn'})
       AADD(aCamReg,{'STR->cTemCamStr','Tcv'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoEst'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Estudiante'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cvn'})
       AADD(aCamReg,{'STR->cTemCamStr','Tcv'})
       AADD(aCamReg,{'STR->Field_Name','lHayIntCvn'})
       AADD(aCamReg,{'STR->Field_Type','L'})
       AADD(aCamReg,{'STR->Field_Len' ,1})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.T.'})
       AADD(aCamReg,{'STR->cDocCamStr','Facturar con Intereses'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FACTURAR;INTERESE'})
       AADD(aCamReg,{'STR->cTxtGetStr','FACTURAR INTERESES'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE SI SE FACTURA CON INTERESES'})
       AADD(aCamReg,{'STR->cTitPrnStr','HAYINT'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cvn'})
       AADD(aCamReg,{'STR->cTemCamStr','Tcv'})
       AADD(aCamReg,{'STR->Field_Name','lPrnRecCvn'})
       AADD(aCamReg,{'STR->Field_Type','L'})
       AADD(aCamReg,{'STR->Field_Len' ,1})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.T.'})
       AADD(aCamReg,{'STR->cDocCamStr','Imprimir el Recibo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','IMPRIMIR;RECIBO'})
       AADD(aCamReg,{'STR->cTxtGetStr','IMPRIMIR RECIBO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE SI SE IMPRIME EL RECIBO'})
       AADD(aCamReg,{'STR->cTitPrnStr','PRNREC'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: CONCILIACION DE LA CARTERA                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 15/2013 MAR A
       Colombia, Bucaramanga        INICIO: 08:30 AM   OCT 15/2013 MAR

OBJETIVOS:

1- Define la estructura del archivo de la cuenta T

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrCarCtT(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','CtT'})
       AADD(aCamReg,{'STR->cTemCamStr','Tct'})
       AADD(aCamReg,{'STR->Field_Name','nNroMesCtT'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Mes'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MES'})
       AADD(aCamReg,{'STR->cTxtGetStr','MES'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MES'})
       AADD(aCamReg,{'STR->cTitPrnStr','MES'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CtT'})
       AADD(aCamReg,{'STR->cTemCamStr','Tct'})
       AADD(aCamReg,{'STR->Field_Name','nMesIniPag'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Mes Inicial'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MES;INICIAL'})
       AADD(aCamReg,{'STR->cTxtGetStr','MES INICIAL'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MES INICIAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','MESINI'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CtT'})
       AADD(aCamReg,{'STR->cTemCamStr','Tct'})
       AADD(aCamReg,{'STR->Field_Name','nMesFinPag'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Mes Final'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MES;FINAL'})
       AADD(aCamReg,{'STR->cTxtGetStr','MES FINAL'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MES FINAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','MESFIN'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CtT'})
       AADD(aCamReg,{'STR->cTemCamStr','Tct'})
       AADD(aCamReg,{'STR->Field_Name','cDescriCtT'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,40})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','Descripci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DESCRIPCION'})
       AADD(aCamReg,{'STR->cTxtGetStr','DESCRIPCION'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CtT'})
       AADD(aCamReg,{'STR->cTemCamStr','Tct'})
       AADD(aCamReg,{'STR->Field_Name','nDebitoCtT'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,10})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','DEBITOS'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DEBITOS'})
       AADD(aCamReg,{'STR->cTxtGetStr','DEBITOS'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LOS DEBITOS'})
       AADD(aCamReg,{'STR->cTitPrnStr','DEBITOS'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CtT'})
       AADD(aCamReg,{'STR->cTemCamStr','Tct'})
       AADD(aCamReg,{'STR->Field_Name','nCreditCtT'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,10})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','CREDITOS'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CREDITOS'})
       AADD(aCamReg,{'STR->cTxtGetStr','CREDITOS'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LOS CREDITOS'})
       AADD(aCamReg,{'STR->cTitPrnStr','CREDITOS'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CtT'})
       AADD(aCamReg,{'STR->cTemCamStr','Tct'})
       AADD(aCamReg,{'STR->Field_Name','nSaldosCtT'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,10})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','SALDOS'})
       AADD(aCamReg,{'STR->cTxtBrwStr','SALDOS'})
       AADD(aCamReg,{'STR->cTxtGetStr','SALDOS'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL SALDO'})
       AADD(aCamReg,{'STR->cTitPrnStr','SALDOS'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CtT'})
       AADD(aCamReg,{'STR->cTemCamStr','Tct'})
       AADD(aCamReg,{'STR->Field_Name','nCodigoCmv'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Concepto Movimiento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CONCEPTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CONCEPTO'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CONCEPTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','CONCEPTO'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: MOVIMIENTOS CONTABLES                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 30/2013 LUN A
       Colombia, Bucaramanga        INICIO: 02:00 PM   SEP 30/2013 LUN

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrCarMvt(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmv'})
       AADD(aCamReg,{'STR->Field_Name','nNroMesMvt'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Mes'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MES'})
       AADD(aCamReg,{'STR->cTxtGetStr','MES'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MES'})
       AADD(aCamReg,{'STR->cTitPrnStr','MES'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tes'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoEst'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Estudiante'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
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
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpa'})
       AADD(aCamReg,{'STR->Field_Name','nMesIniPag'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Mes Inicial'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MES;INICIAL'})
       AADD(aCamReg,{'STR->cTxtGetStr','MES INICIAL'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MES INICIAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','MESINI'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpa'})
       AADD(aCamReg,{'STR->Field_Name','nMesFinPag'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Mes Final'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MES;FINAL'})
       AADD(aCamReg,{'STR->cTxtGetStr','MES FINAL'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MES FINAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','MESFIN'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmv'})
       AADD(aCamReg,{'STR->Field_Name','nMesFinMvt'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Mes Final'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MES;FINAL'})
       AADD(aCamReg,{'STR->cTxtGetStr','MES FINAL'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MES FINAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','MESFIN'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tco'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoCon'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,02})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','Concepto'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CONCEPTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CONCEPTO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE CONCEPTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmv'})
       AADD(aCamReg,{'STR->Field_Name','cDescriMvt'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,40})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','Descripci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DESCRIPCION'})
       AADD(aCamReg,{'STR->cTxtGetStr','DESCRIPCION'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA DECRIPCION'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmv'})
       AADD(aCamReg,{'STR->Field_Name','nCreditMvt'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,14})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','CREDITOS'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CREDITOS'})
       AADD(aCamReg,{'STR->cTxtGetStr','CREDITOS'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LOS CREDITOS'})
       AADD(aCamReg,{'STR->cTitPrnStr','CREDITOS'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmv'})
       AADD(aCamReg,{'STR->Field_Name','nDebitoMvt'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,14})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','DEBITOS'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DEBITOS'})
       AADD(aCamReg,{'STR->cTxtGetStr','DEBITOS'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LOS DEBITOS'})
       AADD(aCamReg,{'STR->cTitPrnStr','DEBITOS'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmv'})
       AADD(aCamReg,{'STR->Field_Name','nSaldosMvt'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,14})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','SALDOS'})
       AADD(aCamReg,{'STR->cTxtBrwStr','SALDOS'})
       AADD(aCamReg,{'STR->cTxtGetStr','SALDOS'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LOS SALDOS'})
       AADD(aCamReg,{'STR->cTitPrnStr','SALDOS'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmv'})
       AADD(aCamReg,{'STR->Field_Name','nTotCauPag'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,14})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','CAUSACION'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CAUSACION'})
       AADD(aCamReg,{'STR->cTxtGetStr','CAUSACION'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TOTAL CAUSACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','CAUSACION'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpa'})
       AADD(aCamReg,{'STR->Field_Name','nSdoAntPag'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,14})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','SDOANT'})
       AADD(aCamReg,{'STR->cTxtBrwStr','SDOANT'})
       AADD(aCamReg,{'STR->cTxtGetStr','SDOANT'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL SALDO ANTERIOR'})
       AADD(aCamReg,{'STR->cTitPrnStr','SDOANT'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpa'})
       AADD(aCamReg,{'STR->Field_Name','nMorAntPag'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,14})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','MORANT'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MORANT'})
       AADD(aCamReg,{'STR->cTxtGetStr','MORANT'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MORA ANTERIOR'})
       AADD(aCamReg,{'STR->cTitPrnStr','MORANT'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpa'})
       AADD(aCamReg,{'STR->Field_Name','nVlrMesPag'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,14})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','VLRMES'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VLRMES'})
       AADD(aCamReg,{'STR->cTxtGetStr','VLRMES'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DEL MES'})
       AADD(aCamReg,{'STR->cTitPrnStr','MORANT'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpa'})
       AADD(aCamReg,{'STR->Field_Name','nVlrPagPag'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,14})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','VLRPAG'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VLRPAG'})
       AADD(aCamReg,{'STR->cTxtGetStr','VLRPAG'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR A PAGAR'})
       AADD(aCamReg,{'STR->cTitPrnStr','VLRPAG'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpa'})
       AADD(aCamReg,{'STR->Field_Name','nIntMesPag'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,14})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','INTMES'})
       AADD(aCamReg,{'STR->cTxtBrwStr','INTMES'})
       AADD(aCamReg,{'STR->cTxtGetStr','INTMES'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LOS INT DEL MES'})
       AADD(aCamReg,{'STR->cTitPrnStr','INTMES'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpa'})
       AADD(aCamReg,{'STR->Field_Name','cEstadoPag'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,01})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','Estado'})
       AADD(aCamReg,{'STR->cTxtBrwStr','ESTADO'})
       AADD(aCamReg,{'STR->cTxtGetStr','ESTADO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL ESTADO DEL PAGO'})
       AADD(aCamReg,{'STR->cTitPrnStr','ESTADO'})
       AADD(aRegIni,aCamReg)


       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpa'})
       AADD(aCamReg,{'STR->Field_Name','dFecPagPag'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!D'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha de Pago'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;PAGO'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA DE PAGO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DE PAGO'})
       AADD(aCamReg,{'STR->cTitPrnStr','F.PAGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','nNroFacCaA'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,11})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','NROFAC'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NROFAC'})
       AADD(aCamReg,{'STR->cTxtGetStr','NROFAC'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO FACTURA'})
       AADD(aCamReg,{'STR->cTitPrnStr','NROFAC'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpa'})
       AADD(aCamReg,{'STR->Field_Name','dFecFacPag'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!D'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha de Facturaci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;FACTURACION'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA DE FACTURACION'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DE FACTURACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','F.FACT'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tba'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoBan'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,02})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','Banco'})
       AADD(aCamReg,{'STR->cTxtBrwStr','BANCO'})
       AADD(aCamReg,{'STR->cTxtGetStr','BANCO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL BANCO'})
       AADD(aCamReg,{'STR->cTitPrnStr','BANCO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Ttr'})
       AADD(aCamReg,{'STR->Field_Name','cCodRefTra'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','Referencia'})
       AADD(aCamReg,{'STR->cTxtBrwStr','REFERENCIA'})
       AADD(aCamReg,{'STR->cTxtGetStr','REFERENCIA'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA REFERENCIA'})
       AADD(aCamReg,{'STR->cTitPrnStr','REFERENCIA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Ttr'})
       AADD(aCamReg,{'STR->Field_Name','cCodEstTra'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Estudiante'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODTRA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Ttr'})
       AADD(aCamReg,{'STR->Field_Name','nValorTra'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,14})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','VLRTRA'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VLRTRA'})
       AADD(aCamReg,{'STR->cTxtGetStr','VLRTRA'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR A CONSIGNADO'})
       AADD(aCamReg,{'STR->cTitPrnStr','VLRTRA'})
       AADD(aRegIni,aCamReg)


       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Ttr'})
       AADD(aCamReg,{'STR->Field_Name','dFechaTra'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!D'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha de Transaci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;TRANSACION'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA TRANSACION'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA TRANSACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','F.TRAN'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmv'})
       AADD(aCamReg,{'STR->Field_Name','nVlrDifMvt'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,14})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','VLRDIF'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VLRDIF'})
       AADD(aCamReg,{'STR->cTxtGetStr','VLRDIF'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DIFERENCIA'})
       AADD(aCamReg,{'STR->cTitPrnStr','VLRDIF'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmv'})
       AADD(aCamReg,{'STR->Field_Name','nCodigoCmv'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Concepto Movimiento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CONCEPTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CONCEPTO'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CONCEPTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','CONCEPTO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmv'})
       AADD(aCamReg,{'STR->Field_Name','cObservMvt'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,40})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','Observaci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','OBSERVACION'})
       AADD(aCamReg,{'STR->cTxtGetStr','OBSERVACION'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA OBSERVACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA


/*************************************************************************
* TITULO..: CONCILIACION DE LA CARTERA                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 29/2013 MAR A
       Colombia, Bucaramanga        INICIO: 02:00 PM   OCT 29/2013 MAR

OBJETIVOS:

1- Define la estructura del archivo de la conciliaci¢n

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrCarCnc(fArchvo,cTitArc,aCamGen,aRegIni)


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
       AADD(aCamReg,{'STR->cNaliasStr','Cnc'})
       AADD(aCamReg,{'STR->cTemCamStr','Tcn'})
       AADD(aCamReg,{'STR->Field_Name','nNroMesCnc'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Mes'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MES'})
       AADD(aCamReg,{'STR->cTxtGetStr','MES'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MES'})
       AADD(aCamReg,{'STR->cTitPrnStr','MES'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cnc'})
       AADD(aCamReg,{'STR->cTemCamStr','Tcn'})
       AADD(aCamReg,{'STR->Field_Name','nTotCauCnc'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','CAUSACION'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CAUSACION'})
       AADD(aCamReg,{'STR->cTxtGetStr','CAUSACION'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TOTAL CAUSACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','CAUSACION'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cnc'})
       AADD(aCamReg,{'STR->cTemCamStr','Tcn'})
       AADD(aCamReg,{'STR->Field_Name','nCauValCnc'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','CAUSACION VALIDADA'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CAUSACION;VALIDADA'})
       AADD(aCamReg,{'STR->cTxtGetStr','CAUSACION VALIDADA'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA CAUSACION VALIDADA'})
       AADD(aCamReg,{'STR->cTitPrnStr','CAUSA VAL'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cnc'})
       AADD(aCamReg,{'STR->cTemCamStr','Tcn'})
       AADD(aCamReg,{'STR->Field_Name','nTotPagCnc'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','PAGOS'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PAGOS'})
       AADD(aCamReg,{'STR->cTxtGetStr','PAGOS'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TOTAL PAGOS'})
       AADD(aCamReg,{'STR->cTitPrnStr','PAGOS'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cnc'})
       AADD(aCamReg,{'STR->cTemCamStr','Tcn'})
       AADD(aCamReg,{'STR->Field_Name','nPagValCnc'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','PAGOS VALIDADOS'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PAGOS;VALIDADOS'})
       AADD(aCamReg,{'STR->cTxtGetStr','PAGOS VALIDADOS'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LOS PAGOS VALIDADOS'})
       AADD(aCamReg,{'STR->cTitPrnStr','PAGOS VAL'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cnc'})
       AADD(aCamReg,{'STR->cTemCamStr','Tcn'})
       AADD(aCamReg,{'STR->Field_Name','lReportCnc'})
       AADD(aCamReg,{'STR->Field_Type','L'})
       AADD(aCamReg,{'STR->Field_Len' ,1})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Reporte a la Contabilidad'})
       AADD(aCamReg,{'STR->cTxtBrwStr','REPORTE;CONTABILIDAD'})
       AADD(aCamReg,{'STR->cTxtGetStr','REPORTE CONTABILIDADA'})
       AADD(aCamReg,{'STR->nLenGetStr',17})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE SI REPORTO A CONTABILIDAD'})
       AADD(aCamReg,{'STR->cTitPrnStr','REPORTE'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

