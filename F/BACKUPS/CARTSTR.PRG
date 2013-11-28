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
       AADD(aCamReg,{'STR->cTemCamStr','Tmv'})
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
       AADD(aCamReg,{'STR->cTemCamStr','Tmv'})
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
       AADD(aCamReg,{'STR->cTemCamStr','Tmv'})
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
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmv'})
       AADD(aCamReg,{'STR->Field_Name','nDebitoMvt'})
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
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmv'})
       AADD(aCamReg,{'STR->Field_Name','nCreditMvt'})
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
       AADD(aCamReg,{'STR->cNaliasStr','Mvt'})
       AADD(aCamReg,{'STR->cTemCamStr','Tmv'})
       AADD(aCamReg,{'STR->Field_Name','nSaldosMvt'})
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

