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