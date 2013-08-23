/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		   BIBLIOTECAS DE FUNCIONES DE ESTRUCTURAS

OBJETIVOS:

- Define las funciones para crear las esctructuras de los archivos del
  generales del SIMA

***************************************************************************
*-------------------- ESTRUCTURAS PARA SIMAPAGO --------------------------*
**************************************************************************/

/*************************************************************************
* TITULO..: PLAN UNICO DE CUENTAS                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 25/2004 LUN A
       Colombia, Bucaramanga        INICIO: 05:30 PM   OCT 25/2004 LUN

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfPuc(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Puc'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoPuc'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,20})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99999999999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Puc'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO DEL PUC'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL PUC'})
       AADD(aCamReg,{'STR->nLenGetStr',19})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL PUC'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Puc'})
       AADD(aCamReg,{'STR->Field_Name','cNombrePuc'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,60})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@S56!X'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nombre de la Cuenta'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NOMBRE DE LA CUENTA'})
       AADD(aCamReg,{'STR->cTxtGetStr','NOMBRE DE LA CUENTA'})
       AADD(aCamReg,{'STR->nLenGetStr',19})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NOMBRE DE LA CUENTA'})
       AADD(aCamReg,{'STR->cTitPrnStr','NOMBRE DE LA CUENTA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Puc'})
       AADD(aCamReg,{'STR->Field_Name','lSumarPuc'})
       AADD(aCamReg,{'STR->Field_Type','L'})
       AADD(aCamReg,{'STR->Field_Len' ,01})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Naturaleza de la Cuenta'})
       AADD(aCamReg,{'STR->cTxtBrwStr','SE ACREDITA'})
       AADD(aCamReg,{'STR->cTxtGetStr','SE ACREDITA'})
       AADD(aCamReg,{'STR->nLenGetStr',19})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE SI LA CUENTA SE ACREDITA'})
       AADD(aCamReg,{'STR->cTitPrnStr','SE ACREDITA'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINCION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: CUENTAS CORRIENTES                                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 26/2004 MAR A
       Colombia, Bucaramanga        INICIO: 01:40 PM   OCT 26/2004 MAR

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfCuC(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','CuC'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoCuC'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!X'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo de la Cuenta'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;CUENTA'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DE LA CUENTA'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE LA CUENTA'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CuC'})
       AADD(aCamReg,{'STR->Field_Name','cCodBanCuC'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Banco'})
       AADD(aCamReg,{'STR->cTxtBrwStr','BANCO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL BANCO'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL BANCO'})
       AADD(aCamReg,{'STR->cTitPrnStr','BANCO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CuC'})
       AADD(aCamReg,{'STR->Field_Name','cNumeroCuC'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,20})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!X'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero de la Cuenta'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NUMERO;CUENTA'})
       AADD(aCamReg,{'STR->cTxtGetStr','NUMERO DE LA CUENTA'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DE LA CUENTA'})
       AADD(aCamReg,{'STR->cTitPrnStr','NUMERO DE CUENTA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CuC'})
       AADD(aCamReg,{'STR->Field_Name','nNroCheCuC'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,9})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero del Cheque'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NUMERO;CHEQUE'})
       AADD(aCamReg,{'STR->cTxtGetStr','NUMERO DEL CHEQUE'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DEL CHEQUE'})
       AADD(aCamReg,{'STR->cTitPrnStr','CHEQUE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CuC'})
       AADD(aCamReg,{'STR->Field_Name','cCodPucCuC'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,20})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99999999999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Puc'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO DEL PUC'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL PUC'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL PUC'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CuC'})
       AADD(aCamReg,{'STR->Field_Name','nCodRefCuC'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Posici¢n de la Referencia'})
       AADD(aCamReg,{'STR->cTxtBrwStr','POSICION;REFERENCIA'})
       AADD(aCamReg,{'STR->cTxtGetStr','POSICION DE LA REFERENCIA'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA POSICION DE LA REFERENCIA'})
       AADD(aCamReg,{'STR->cTitPrnStr','POS. REF'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CuC'})
       AADD(aCamReg,{'STR->Field_Name','nLenRefCuC'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Longitud de la Referencia'})
       AADD(aCamReg,{'STR->cTxtBrwStr','LONGITUD;REFERENCIA'})
       AADD(aCamReg,{'STR->cTxtGetStr','LONGITUD DE LA REFRENCIA'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA LONGITUD DE LA REFERENCIA'})
       AADD(aCamReg,{'STR->cTitPrnStr','LEN. REF'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CuC'})
       AADD(aCamReg,{'STR->Field_Name','nTipMovCuC'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Posici¢n Tipo de Movimiento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','POSICION TIPO;MOVIMIENTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','POSICION TIPO DE MOVIEMIENTO'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA POSICION DEL TIPO DE MOVIMIENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','POS. TIPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CuC'})
       AADD(aCamReg,{'STR->Field_Name','nLenTipCuC'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Longitud Tipo de Movimiento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','LONGITUD TIPO;MOVIMIENTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','LONGITUD TIPO DE MOVIMIENTO'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA LONGITUD DEL TIPO DE MOVIMIENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','LEN. TIPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CuC'})
       AADD(aCamReg,{'STR->Field_Name','nIntMovCuC'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','P¢sici¢n Cifra entera del Movimiento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','POSICION;CIFRA ENTERA'})
       AADD(aCamReg,{'STR->cTxtGetStr','POSICION CIFRA ENTERA'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA POSICION DE LA CIFRA ENTERA'})
       AADD(aCamReg,{'STR->cTitPrnStr','POS. INT'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CuC'})
       AADD(aCamReg,{'STR->Field_Name','nLenIntCuC'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Longitud Cifra entera del Movimiento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','LONGITUD;CIFRA ENTERA'})
       AADD(aCamReg,{'STR->cTxtGetStr','LONGITUD CIFRA ENTERA'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA LONGITUD DE LA CIFRA ENTERA'})
       AADD(aCamReg,{'STR->cTitPrnStr','LEN. ENT'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CuC'})
       AADD(aCamReg,{'STR->Field_Name','nDecMovCuC'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Posici¢n Cifra decimal del Movimiento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','POSICION;CIFRA DECIMAL'})
       AADD(aCamReg,{'STR->cTxtGetStr','POSICION CIFRA DECIMAL'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA POSICION DE LA CIFRA DECIMAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','POS. DEC'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CuC'})
       AADD(aCamReg,{'STR->Field_Name','nLenDecCuC'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Longitud Cifra decimal del Movimiento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','LONGITUD;CIFRA DECIMAL'})
       AADD(aCamReg,{'STR->cTxtGetStr','LONGITUD CIFRA DECIMAL'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA LONGITUD DE LA CIFRA DECIMAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','LEN. DEC'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CuC'})
       AADD(aCamReg,{'STR->Field_Name','nAnoMovCuC'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Posici¢n A¤o del Movimiento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','POSICION;A¥O MVTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','POSICION A¥O DEL MOVIMIENTO'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA POSICION DEL A¥O DEL MOVIMIENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','POS. A¥O'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CuC'})
       AADD(aCamReg,{'STR->Field_Name','nLenAnoCuC'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Longitud A¤o del Movimiento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','LONGITUD;A¥O MVTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','LONGITUD A¥O DEL MOVIMIENTO'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA LONGITUD DEL A¥O DEL MOVIMIENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','LEN. A¥O'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CuC'})
       AADD(aCamReg,{'STR->Field_Name','nMesMovCuC'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Posici¢n Mes del Movimiento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','POSICION;MES MVTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','POSICION MES DEL MOVIMIENTO'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA POSICION DEL MES DEL MOVIMIENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','POS. MES'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CuC'})
       AADD(aCamReg,{'STR->Field_Name','nDiaMovCuC'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Posici¢n Dia del Movimiento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','POSICION;DIA NVTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','POSICION DIA DEL MOVIMIENTO'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA POSICION DEL DIA DEL MOVIMIENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','POS. DIA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CuC'})
       AADD(aCamReg,{'STR->Field_Name','nDigVerCuC'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Digito de Chequeo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DIGITO;CHEQUEO'})
       AADD(aCamReg,{'STR->cTxtGetStr','DIGITO CHEQUEO'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL DIGITO CHEQUEO'})
       AADD(aCamReg,{'STR->cTitPrnStr','CHEQUEO'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: CHEQUES                                                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 26/2004 MAR A
       Colombia, Bucaramanga        INICIO: 01:45 PM   OCT 26/2004 MAR

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfChe(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Che'})
       AADD(aCamReg,{'STR->Field_Name','nNumeroChe'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,9})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero del Cheque'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NUMERO;CHEQUE'})
       AADD(aCamReg,{'STR->cTxtGetStr','NUMERO DEL CHEQUE'})
       AADD(aCamReg,{'STR->nLenGetStr',27})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DEL CHEQUE'})
       AADD(aCamReg,{'STR->cTitPrnStr','CHEQUE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Che'})
       AADD(aCamReg,{'STR->Field_Name','cNroCuCChe'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,20})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!X'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero de la Cuenta Corriente'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CUENTA;CORRIENTE'})
       AADD(aCamReg,{'STR->cTxtGetStr','CUENTA CORRIENTE'})
       AADD(aCamReg,{'STR->nLenGetStr',27})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DE LA CUENTA CORRIENTE'})
       AADD(aCamReg,{'STR->cTitPrnStr','CUENTA CORRIENTE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Che'})
       AADD(aCamReg,{'STR->Field_Name','nNroCpBChe'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,9})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero del Comprobante'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NUMERO;COMPROBANTE'})
       AADD(aCamReg,{'STR->cTxtGetStr','NUMERO COMPROBANTE'})
       AADD(aCamReg,{'STR->nLenGetStr',27})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DEL COMPROBANTE'})
       AADD(aCamReg,{'STR->cTitPrnStr','COMPROBANTE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Che'})
       AADD(aCamReg,{'STR->Field_Name','dFecCheChe'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!D'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha del Cheque'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;CHEQUE'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA DEL CHEQUE'})
       AADD(aCamReg,{'STR->nLenGetStr',27})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DEL CHEQUE'})
       AADD(aCamReg,{'STR->cTitPrnStr','FECHA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Che'})
       AADD(aCamReg,{'STR->Field_Name','nVlrCheChe'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor del Cheque'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;CHEQUE'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR DEL CHEQUE'})
       AADD(aCamReg,{'STR->nLenGetStr',27})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DEL CHEQUE'})
       AADD(aCamReg,{'STR->cTitPrnStr','VLR CHEQUE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Che'})
       AADD(aCamReg,{'STR->Field_Name','cDocNitChe'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,16})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Documento del Beneficiario'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DOCUMENTO;BENEICIARIO'})
       AADD(aCamReg,{'STR->cTxtGetStr','DOCUMENTO BENEFICIARIO'})
       AADD(aCamReg,{'STR->nLenGetStr',27})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL DOCUMENTO DEL BENEFICIARIO'})
       AADD(aCamReg,{'STR->cTitPrnStr','DOCUMENTO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Che'})
       AADD(aCamReg,{'STR->Field_Name','cTipNitChe'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,1})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Tipo del Documento del Beneficiario'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIPO DOCUMENTO;BENEICIARIO'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIPO DOCUMENTO BENEFICIARIO'})
       AADD(aCamReg,{'STR->nLenGetStr',27})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIPO DEL DOCUMENTO DEL BENEFICIARIO'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Che'})
       AADD(aCamReg,{'STR->Field_Name','nEstadoChe'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,1})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Estado del Cheque. 0=>Original 1=>Duplicado 2=>Anulado 3=>No Impreso'})
       AADD(aCamReg,{'STR->cTxtBrwStr','ESTADO'})
       AADD(aCamReg,{'STR->cTxtGetStr','ESTADO DEL CHEQUE'})
       AADD(aCamReg,{'STR->nLenGetStr',27})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL ESTADO DEL CHEQUE'})
       AADD(aCamReg,{'STR->cTitPrnStr','ESTADO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Che'})
       AADD(aCamReg,{'STR->Field_Name','cCodTraChe'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo de la Transacci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;TRANSACCION'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO TRANSACION'})
       AADD(aCamReg,{'STR->nLenGetStr',27})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE LA TRANSACCION'})
       AADD(aCamReg,{'STR->cTitPrnStr','TRANS'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Che'})
       AADD(aCamReg,{'STR->Field_Name','dFecTraChe'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha de la Transacci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;TRANSACCION'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA TRANSACION'})
       AADD(aCamReg,{'STR->nLenGetStr',27})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DE LA TRANSACCION'})
       AADD(aCamReg,{'STR->cTitPrnStr','F. TRANS'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Che'})
       AADD(aCamReg,{'STR->Field_Name','nVlrTraChe'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor de la Transacci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;TRANSACCION'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR TRANSACCION'})
       AADD(aCamReg,{'STR->nLenGetStr',27})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DE LA TRANSACCION'})
       AADD(aCamReg,{'STR->cTitPrnStr','VLR TRANS'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: PROVEEDORES                                                  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 26/2004 MAR A
       Colombia, Bucaramanga        INICIO: 01:50 PM   OCT 26/2004 MAR

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfPrv(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Prv'})
       AADD(aCamReg,{'STR->Field_Name','cDocNitPrv'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,16})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','Nit de la Empresa'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DOCUMENTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','DOCUMENTO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL DOCUMENTO DEL PROVEEDOR'})
       AADD(aCamReg,{'STR->cTitPrnStr','DOCUMENTO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Prv'})
       AADD(aCamReg,{'STR->Field_Name','cTipNitPrv'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,1})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','Tipo de Documento. 2=>Nits Empresariales, 3=>Nits de Extranjeria'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIPO'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIPO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIPO DE DOCUMENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Prv'})
       AADD(aCamReg,{'STR->Field_Name','nBasRtfPrv'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Base de la Retenci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','BASE DE;LA RETENCION'})
       AADD(aCamReg,{'STR->cTxtGetStr','BASE DE LA RETENCION'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA BASE DE LA RETENCION'})
       AADD(aCamReg,{'STR->cTitPrnStr','BASE RETENCION'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Prv'})
       AADD(aCamReg,{'STR->Field_Name','nVlrIvaPrv'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor del Iva'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR DEL IVA'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR DEL IVA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DEL IVA'})
       AADD(aCamReg,{'STR->cTitPrnStr','VALOR IVA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Prv'})
       AADD(aCamReg,{'STR->Field_Name','nVlrRtfPrv'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor de la Retenci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR RETENCION'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR DE LA RETENCION'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DE LA RETENCION'})
       AADD(aCamReg,{'STR->cTitPrnStr','VLR RETENCION'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: PRESUPUESTO                                                  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 26/2004 MAR A
       Colombia, Bucaramanga        INICIO: 05:40 PM   OCT 26/2004 MAR

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfPrS(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','cCodPucPrS'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,20})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99999999999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Puc'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO DEL PUC'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL PUC'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL PUC'})
       AADD(aCamReg,{'STR->cTitPrnStr','CUENTA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nPrsEnePrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Presupuesto'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PRESUPUESTO;ENERO'})
       AADD(aCamReg,{'STR->cTxtGetStr','PRESUPUESTO ENERO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR PRESUPUESTADO DE ENERO'})
       AADD(aCamReg,{'STR->cTitPrnStr','P ENERO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nPrsFebPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Presupuesto'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PRESUPUESTO;FEBRERO'})
       AADD(aCamReg,{'STR->cTxtGetStr','PRESUPUESTO FEBRERO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR PRESUPUESTADO DE FEBRERO'})
       AADD(aCamReg,{'STR->cTitPrnStr','P FEBRERO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nPrsMarPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Presupuesto'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PRESUPUESTO;MARZO'})
       AADD(aCamReg,{'STR->cTxtGetStr','PRESUPUESTO MARZO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR PRESUPUESTADO DE MARZO'})
       AADD(aCamReg,{'STR->cTitPrnStr','P MARZO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nPrsAbrPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Presupuesto'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PRESUPUESTO;ABRIL'})
       AADD(aCamReg,{'STR->cTxtGetStr','PRESUPUESTO ABRIL'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR PRESUPUESTADO DE ABRIL'})
       AADD(aCamReg,{'STR->cTitPrnStr','P ABRIL'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nPrsMayPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Presupuesto'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PRESUPUESTO;MAYO'})
       AADD(aCamReg,{'STR->cTxtGetStr','PRESUPUESTO MAYO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR PRESUPUESTADO DE MAYO'})
       AADD(aCamReg,{'STR->cTitPrnStr','P MAYO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nPrsJunPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Presupuesto'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PRESUPUESTO;JUNIO'})
       AADD(aCamReg,{'STR->cTxtGetStr','PRESUPUESTO JUNIO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR PRESUPUESTADO DE JUNIO'})
       AADD(aCamReg,{'STR->cTitPrnStr','P JUNIO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nPrsJulPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Presupuesto'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PRESUPUESTO;JULIO'})
       AADD(aCamReg,{'STR->cTxtGetStr','PRESUPUESTO JULIO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR PRESUPUESTADO DE JULIO'})
       AADD(aCamReg,{'STR->cTitPrnStr','P JULIO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nPrsAgoPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Presupuesto'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PRESUPUESTO;AGOSTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','PRESUPUESTO AGOSTO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR PRESUPUESTADO DE AGOSTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','P AGOSTO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nPrsSepPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Presupuesto'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PRESUPUESTO;SEPTIEMBRE'})
       AADD(aCamReg,{'STR->cTxtGetStr','PRESUPUESTO SEPTIEMBRE'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR PRESUPUESTADO DE SEPTIEMBRE'})
       AADD(aCamReg,{'STR->cTitPrnStr','P SEPTIEMBRE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nPrsOctPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Presupuesto'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PRESUPUESTO;OCTUBRE'})
       AADD(aCamReg,{'STR->cTxtGetStr','PRESUPUESTO OCTUBRE'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR PRESUPUESTADO DE OCTUBRE'})
       AADD(aCamReg,{'STR->cTitPrnStr','P OCTUBRE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nPrsNovPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Presupuesto'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PRESUPUESTO;NOVIEMBRE'})
       AADD(aCamReg,{'STR->cTxtGetStr','PRESUPUESTO NOVIEMBRE'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR PRESUPUESTADO DE NOVIEMBRE'})
       AADD(aCamReg,{'STR->cTitPrnStr','P NOVIEMBRE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nPrsDicPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Presupuesto'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PRESUPUESTO;DICIEMBRE'})
       AADD(aCamReg,{'STR->cTxtGetStr','PRESUPUESTO DICIEMBRE'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR PRESUPUESTADO DE DICIEMBRE'})
       AADD(aCamReg,{'STR->cTitPrnStr','P DICIEMBRE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nTotPrSPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Presupuesto'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TOTAL;PRESUPUESTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','TOTAL PRESUPUESTO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR TOTAL DEL PRESUPUESTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','PRESUPUESTO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nEjeEnePrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Ejecutado'})
       AADD(aCamReg,{'STR->cTxtBrwStr','EJECUTADO;ENERO'})
       AADD(aCamReg,{'STR->cTxtGetStr','EJECUTADO ENERO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR EJECUTADO DE ENERO'})
       AADD(aCamReg,{'STR->cTitPrnStr','E ENERO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nEjeFebPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Ejecutado'})
       AADD(aCamReg,{'STR->cTxtBrwStr','EJECUTADO;FEBRERO'})
       AADD(aCamReg,{'STR->cTxtGetStr','EJECUTADO FEBRERO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR EJECUTADO DE FEBRERO'})
       AADD(aCamReg,{'STR->cTitPrnStr','E FEBRERO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nEjeMarPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Ejecutado'})
       AADD(aCamReg,{'STR->cTxtBrwStr','EJECUTADO;MARZO'})
       AADD(aCamReg,{'STR->cTxtGetStr','EJECUTADO MARZO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR EJECUTADO DE MARZO'})
       AADD(aCamReg,{'STR->cTitPrnStr','E MARZO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nEjeAbrPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Ejecutado'})
       AADD(aCamReg,{'STR->cTxtBrwStr','EJECUTADO;ABRIL'})
       AADD(aCamReg,{'STR->cTxtGetStr','EJECUTADO ABRIL'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR EJECUTADO DE ABRIL'})
       AADD(aCamReg,{'STR->cTitPrnStr','E ABRIL'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nEjeMayPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Ejecutado'})
       AADD(aCamReg,{'STR->cTxtBrwStr','EJECUTADO;MAYO'})
       AADD(aCamReg,{'STR->cTxtGetStr','EJECUTADO MAYO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR EJECUTADO DE MAYO'})
       AADD(aCamReg,{'STR->cTitPrnStr','E MAYO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nEjeJunPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Ejecutado'})
       AADD(aCamReg,{'STR->cTxtBrwStr','EJECUTADO;JUNIO'})
       AADD(aCamReg,{'STR->cTxtGetStr','EJECUTADO JUNIO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR EJECUTADO DE JUNIO'})
       AADD(aCamReg,{'STR->cTitPrnStr','E JUNIO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nEjeJulPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Ejecutado'})
       AADD(aCamReg,{'STR->cTxtBrwStr','EJECUTADO;JULIO'})
       AADD(aCamReg,{'STR->cTxtGetStr','EJECUTADO JULIO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR EJECUTADO DE JULIO'})
       AADD(aCamReg,{'STR->cTitPrnStr','E JULIO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nEjeAgoPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Ejecutado'})
       AADD(aCamReg,{'STR->cTxtBrwStr','EJECUTADO;AGOSTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','EJECUTADO AGOSTO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR EJECUTADO DE AGOSTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','E AGOSTO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nEjeSepPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Ejecutado'})
       AADD(aCamReg,{'STR->cTxtBrwStr','EJECUTADO;SEPTIEMBRE'})
       AADD(aCamReg,{'STR->cTxtGetStr','EJECUTADO SEPTIEMBRE'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR EJECUTADO DE SEPTIEMBRE'})
       AADD(aCamReg,{'STR->cTitPrnStr','E SEPTIEMBRE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nEjeOctPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Ejecutado'})
       AADD(aCamReg,{'STR->cTxtBrwStr','EJECUTADO;OCTUBRE'})
       AADD(aCamReg,{'STR->cTxtGetStr','EJECUTADO OCTUBRE'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR EJECUTADO DE OCTUBRE'})
       AADD(aCamReg,{'STR->cTitPrnStr','E OCTUBRE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nEjeNovPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Ejecutado'})
       AADD(aCamReg,{'STR->cTxtBrwStr','EJECUTADO;NOVIEMBRE'})
       AADD(aCamReg,{'STR->cTxtGetStr','EJECUTADO NOVIEMBRE'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR EJECUTADO DE NOVIEMBRE'})
       AADD(aCamReg,{'STR->cTitPrnStr','E NOVIEMBRE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nEjeDicPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Ejecutado'})
       AADD(aCamReg,{'STR->cTxtBrwStr','EJECUTADO;DICIEMBRE'})
       AADD(aCamReg,{'STR->cTxtGetStr','EJECUTADO DICIEMBRE'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR EJECUTADO DE DICIEMBRE'})
       AADD(aCamReg,{'STR->cTitPrnStr','E DICIEMBRE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nTotEjePrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Ejecutado'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TOTAL;EJECUTADO'})
       AADD(aCamReg,{'STR->cTxtGetStr','TOTAL EJECUTADO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR TOTAL EJECUTADO'})
       AADD(aCamReg,{'STR->cTitPrnStr','EJECUTADO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nTotSdoPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Saldo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TOTAL;SALDO'})
       AADD(aCamReg,{'STR->cTxtGetStr','TOTAL SALDO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR TOTAL DEL SALDO'})
       AADD(aCamReg,{'STR->cTitPrnStr','TOTAL SALDO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nPorEjePrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Porcentaje Ejecutado'})
       AADD(aCamReg,{'STR->cTxtBrwStr','POR %'})
       AADD(aCamReg,{'STR->cTxtGetStr','POR %'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL PORCENTAJE EJECUTADO'})
       AADD(aCamReg,{'STR->cTitPrnStr','POR %'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PrS'})
       AADD(aCamReg,{'STR->Field_Name','nPorIngPrS'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Porcentaje respecto ingreso'})
       AADD(aCamReg,{'STR->cTxtBrwStr','ING %'})
       AADD(aCamReg,{'STR->cTxtGetStr','ING %'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL PORCENTAJE RESPECTO EL INGRESO'})
       AADD(aCamReg,{'STR->cTitPrnStr','ING %'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: TABLA DE RETENCION                                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 27/2004 MAR A
       Colombia, Bucaramanga        INICIO: 03:15 PM   OCT 27/2004 MAR

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfRtf(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Rtf'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoRtf'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!X'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo de Retenci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;RETENCION'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO RETENCION'})
       AADD(aCamReg,{'STR->nLenGetStr',20})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE LA RETENCION'})
       AADD(aCamReg,{'STR->cTitPrnStr','RETENCION'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Rtf'})
       AADD(aCamReg,{'STR->Field_Name','cNombreRtf'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,60})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!S55'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Descripci¢n de la Retenci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DESCRIPCION DE LA RETENCION'})
       AADD(aCamReg,{'STR->cTxtGetStr','DESCRIPCION'})
       AADD(aCamReg,{'STR->nLenGetStr',20})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA DESCRIPCION DE LA RETENCION'})
       AADD(aCamReg,{'STR->cTitPrnStr','DESCRIPCION'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Rtf'})
       AADD(aCamReg,{'STR->Field_Name','nVlrBasRtf'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor Base de la Retenci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','BASE DE LA;RETENCION'})
       AADD(aCamReg,{'STR->cTxtGetStr','BASE DE RETENCION'})
       AADD(aCamReg,{'STR->nLenGetStr',20})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA BASE DE LA RETENCION'})
       AADD(aCamReg,{'STR->cTitPrnStr','VLR BASE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Rtf'})
       AADD(aCamReg,{'STR->Field_Name','nPorcenRtf'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Porcentaje de la Retenci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PORCENTAJE;RETENCION'})
       AADD(aCamReg,{'STR->cTxtGetStr','PORCENTAJE RETENCION'})
       AADD(aCamReg,{'STR->nLenGetStr',20})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL PORCENTAJE DE LA RETENCION'})
       AADD(aCamReg,{'STR->cTitPrnStr','PORCENTAJE'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: FACTURAS                                                     *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 27/2004 MIE A
       Colombia, Bucaramanga        INICIO: 04:50 PM   OCT 27/2004 MIE

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfFac(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoFac'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,10})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo de la Factura'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;FACTURA'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO FACTURA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE LA FACTURA'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','cCodFacFac'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,10})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo de la Factura cuando es una couta'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;FACTURA'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO FACTURA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE LA FACTURA'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODFAC'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','cNumeroFac'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,10})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!X'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero de la Factura'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NUMERO;FACTURA'})
       AADD(aCamReg,{'STR->cTxtGetStr','NUMERO FACTURA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DE LA FACTURA'})
       AADD(aCamReg,{'STR->cTitPrnStr','NUMERO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','cDocNitFac'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,16})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nit de la Empresa'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DOCUMENTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','DOCUMENTO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL DOCUMENTO DEL PROVEEDOR'})
       AADD(aCamReg,{'STR->cTitPrnStr','DOCUMENTO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','cTipNitFac'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,1})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Tipo de Documento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIPO'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIPO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIPO DE DOCUMENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','dFecFacFac'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@D'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha de la Factura'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;FACTURA'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA FACTURA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DE LA FACTURA'})
       AADD(aCamReg,{'STR->cTitPrnStr','F. FACTURA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','dFecOpoFac'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@D'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha Pago Oportuno'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;OPORTUNA'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA PAGO OPORTUNO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA PARA PAGO OPORTUNO'})
       AADD(aCamReg,{'STR->cTitPrnStr','F. OPORTUNO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','dFecVtoFac'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@D'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha de Vencimiento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;VENCIMIENTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA VENCIMIENTO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DE VENCIMIENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','F. VENCIMIENTO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','cDescriFac'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,40})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@S!40'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Descripci¢n de la Factura'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DESCRIPCION'})
       AADD(aCamReg,{'STR->cTxtGetStr','DESCRIPCION'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA DESCRIPCION'})
       AADD(aCamReg,{'STR->cTitPrnStr','DESCRIPCION'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','nBasRtfFac'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor Base de Retenci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR BASE;RETENCION'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR BASE RETENCION'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR BASE DE LA RETENCION'})
       AADD(aCamReg,{'STR->cTitPrnStr','BASE RETENCION'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','nVlrIvaFac'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor del Iva'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR IVA'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR IVA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DEL IVA'})
       AADD(aCamReg,{'STR->cTitPrnStr','VLR IVA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','cCodRtfFac'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!X'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo de la Retenci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;RETENCION'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO RETENCION'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE RETENCION'})
       AADD(aCamReg,{'STR->cTitPrnStr','COD RTF'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','nPorRtfFac'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Porcentaje de la Retenci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PORCENTAJE;RETENCION'})
       AADD(aCamReg,{'STR->cTxtGetStr','PORCENTAJE RETENCION'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL PORCENTAJE DE LA RETENCION'})
       AADD(aCamReg,{'STR->cTitPrnStr','POR% RTF'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','nVlrRtfFac'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor de la Retenci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR RETENCION'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR DE LA RETENCION'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DE LA RETENCION'})
       AADD(aCamReg,{'STR->cTitPrnStr','VLR RETENCION'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','nVlrPagFac'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor a Pagar'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR A PAGAR'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR A PAGAR'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR A PAGAR'})
       AADD(aCamReg,{'STR->cTitPrnStr','VLR A PAGAR'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','nVlrCanFac'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor Pagado'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR PAGADO'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR PAGADO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR PAGADO'})
       AADD(aCamReg,{'STR->cTitPrnStr','VLR PAGADO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','lPagCouFac'})
       AADD(aCamReg,{'STR->Field_Type','L'})
       AADD(aCamReg,{'STR->Field_Len' ,01})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Pago por Coutas'})
       AADD(aCamReg,{'STR->cTxtBrwStr','POR CUOTAS'})
       AADD(aCamReg,{'STR->cTxtGetStr','POR COUTAS'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE SI LA FACTURA SE PAGA POR CUOTAS'})
       AADD(aCamReg,{'STR->cTitPrnStr','POR CUOTAS'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpu'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoPuc'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,20})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99999999999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Puc'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO DEL PUC'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL PUC'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL PUC'})
       AADD(aCamReg,{'STR->cTitPrnStr','CTA PUC'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','nMesReqFac'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Mes de la Requesici¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MES REQUISICION'})
       AADD(aCamReg,{'STR->cTxtGetStr','MES REQUISICION'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MES DE LA REQUISICION'})
       AADD(aCamReg,{'STR->cTitPrnStr','MES REQ'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fac'})
       AADD(aCamReg,{'STR->cTemCamStr','Tcp'})
       AADD(aCamReg,{'STR->Field_Name','nNumeroCpB'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,9})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero del Comprobante'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NUMERO;COMPROBANTE'})
       AADD(aCamReg,{'STR->cTxtGetStr','NUMERO COMPROBANTE'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DEL COMPROBANTE'})
       AADD(aCamReg,{'STR->cTitPrnStr','COMPROBANTE'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: COUTAS DE LAS FACTURAS                                       *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ABR 11/2005 LUN A
       Colombia, Bucaramanga        INICIO: 10:00 PM   ABR 11/2005 LUN

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfCoF(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','CoF'})
       AADD(aCamReg,{'STR->cTemCamStr','Tcf'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoCoF'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,10})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo Couta de la Factura'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO CUOTA;FACTURA'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO COUTA FACTURA'})
       AADD(aCamReg,{'STR->nLenGetStr',20})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO COUTA DE LA FACTURA'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CoF'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoFac'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,10})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo de la Factura'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;FACTURA'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO FACTURA'})
       AADD(aCamReg,{'STR->nLenGetStr',20})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE LA FACTURA'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CoF'})
       AADD(aCamReg,{'STR->cTemCamStr','Tcf'})
       AADD(aCamReg,{'STR->Field_Name','dFecCoFCoF'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@D'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha de la Cuenta de la Couta'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;CUENTA'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA CUENTA'})
       AADD(aCamReg,{'STR->nLenGetStr',20})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DE LA CUENTA'})
       AADD(aCamReg,{'STR->cTitPrnStr','F. CUENTA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CoF'})
       AADD(aCamReg,{'STR->cTemCamStr','Tcf'})
       AADD(aCamReg,{'STR->Field_Name','dFecOpoCoF'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@D'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha Pago Oportuno'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;OPORTUNA'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA PAGO OPORTUNO'})
       AADD(aCamReg,{'STR->nLenGetStr',20})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA PARA PAGO OPORTUNO'})
       AADD(aCamReg,{'STR->cTitPrnStr','F. OPORTUNO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CoF'})
       AADD(aCamReg,{'STR->cTemCamStr','Tcf'})
       AADD(aCamReg,{'STR->Field_Name','dFecVtoCoF'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@D'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha de Vencimiento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;VENCIMIENTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA VENCIMIENTO'})
       AADD(aCamReg,{'STR->nLenGetStr',20})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DE VENCIMIENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','F. VENCIMIENTO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CoF'})
       AADD(aCamReg,{'STR->cTemCamStr','Tcf'})
       AADD(aCamReg,{'STR->Field_Name','cDescriCoF'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,40})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@S!40'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Descripci¢n de la Cuenta'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DESCRIPCION'})
       AADD(aCamReg,{'STR->cTxtGetStr','DESCRIPCION'})
       AADD(aCamReg,{'STR->nLenGetStr',20})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA DESCRIPCION'})
       AADD(aCamReg,{'STR->cTitPrnStr','DESCRIPCION'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CoF'})
       AADD(aCamReg,{'STR->cTemCamStr','Tcf'})
       AADD(aCamReg,{'STR->Field_Name','nVlrPagCoF'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor a Pagar'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR A PAGAR'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR A PAGAR'})
       AADD(aCamReg,{'STR->nLenGetStr',20})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR A PAGAR'})
       AADD(aCamReg,{'STR->cTitPrnStr','VLR A PAGAR'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CoF'})
       AADD(aCamReg,{'STR->cTemCamStr','Tcf'})
       AADD(aCamReg,{'STR->Field_Name','nMesReqCoF'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Mes de la Requesici¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MES REQUISICION'})
       AADD(aCamReg,{'STR->cTxtGetStr','MES REQUISICION'})
       AADD(aCamReg,{'STR->nLenGetStr',20})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MES DE LA REQUISICION'})
       AADD(aCamReg,{'STR->cTitPrnStr','MES REQ'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: COMPROBANTES                                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 27/2004 MIE A
       Colombia, Bucaramanga        INICIO: 07:00 PM   OCT 27/2004 MIE

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfCpB(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','CpB'})
       AADD(aCamReg,{'STR->Field_Name','nNumeroCpB'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,9})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero del Comprobante'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NUMERO;COMPROBANTE'})
       AADD(aCamReg,{'STR->cTxtGetStr','NUMERO COMPROBANTE'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DEL COMPROBANTE'})
       AADD(aCamReg,{'STR->cTitPrnStr','COMPROBANTE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CpB'})
       AADD(aCamReg,{'STR->Field_Name','cDescriCpB'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,40})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@S!40'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Descripci¢n del Comprobante'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DESCRIPCION'})
       AADD(aCamReg,{'STR->cTxtGetStr','DESCRIPCION'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA DESCRIPCION'})
       AADD(aCamReg,{'STR->cTitPrnStr','DESCRIPCION'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CpB'})
       AADD(aCamReg,{'STR->Field_Name','nNroCheCpB'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,9})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero del Cheque'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NUMERO;CHEQUE'})
       AADD(aCamReg,{'STR->cTxtGetStr','NUMERO DEL CHEQUE'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DEL CHEQUE'})
       AADD(aCamReg,{'STR->cTitPrnStr','CHEQUE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CpB'})
       AADD(aCamReg,{'STR->Field_Name','dFecCheCpB'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!D'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha del Cheque'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;CHEQUE'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA DEL CHEQUE'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DEL CHEQUE'})
       AADD(aCamReg,{'STR->cTitPrnStr','FECHA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CpB'})
       AADD(aCamReg,{'STR->Field_Name','cPucCreCpb'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,20})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99999999999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Puc'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO DEL PUC'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL PUC'})
       AADD(aCamReg,{'STR->nLenGetStr',20})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL PUC DE LA CUENTA CORRIENTE'})
       AADD(aCamReg,{'STR->cTitPrnStr','CUENTA'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: ITEM DE LOS COMPROBANTES                                     *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 28/2004 JUE A
       Colombia, Bucaramanga        INICIO: 10:00 PM   OCT 28/2004 JUE

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfCpI(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','CpI'})
       AADD(aCamReg,{'STR->Field_Name','nNroCpBCpI'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,9})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero del Comprobante'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NUMERO;COMPROBANTE'})
       AADD(aCamReg,{'STR->cTxtGetStr','NUMERO COMPROBANTE'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DEL COMPROBANTE'})
       AADD(aCamReg,{'STR->cTitPrnStr','COMPROBANTE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CpB'})
       AADD(aCamReg,{'STR->Field_Name','cCodFacCpI'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,10})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo de la Factura'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;FACTURA'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO FACTURA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE LA FACTURA'})
       AADD(aCamReg,{'STR->cTitPrnStr','FACTURA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CpB'})
       AADD(aCamReg,{'STR->Field_Name','cPucDebCpI'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,20})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99999999999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Puc'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CUENTA DEBITO;COMPROBANTE'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL PUC'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL PUC DE LA CUENTA DEBITO'})
       AADD(aCamReg,{'STR->cTitPrnStr','CUENTA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CpB'})
       AADD(aCamReg,{'STR->Field_Name','cModPucCpI'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,20})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99999999999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Puc Modificado'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO PUC;MODIFICADO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO PUC MODIFICADO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUEVO CODIGO DEL PUC'})
       AADD(aCamReg,{'STR->cTitPrnStr','NUEVO PUC'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

***************************************************************************
*-------------------- ESTRUCTURAS PARA SIMACART --------------------------*
**************************************************************************/

/*************************************************************************
* TITULO..: CONCEPTOS DE LOS ESTUDIANTES                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 26/2004 VIE A
       Colombia, Bucaramanga        INICIO: 10:00 AM   NOV 26/2004 VIE

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfCoE(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','CoE'})
       AADD(aCamReg,{'STR->cTemCamStr','Tes'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoEst'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Estudiante'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CoE'})
       AADD(aCamReg,{'STR->cTemCamStr','Tco'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoCon'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del C¢ncepto'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;CONCEPTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL CONCEPTO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL CONCEPTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','CONCEPTO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CoE'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpa'})
       AADD(aCamReg,{'STR->Field_Name','nMesIniPag'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Mes inicial del Servicio'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MES INICIAL'})
       AADD(aCamReg,{'STR->cTxtGetStr','MES INICIAL'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MES INICIAL DEL SERVICIO'})
       AADD(aCamReg,{'STR->cTitPrnStr','INICIO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CoE'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpa'})
       AADD(aCamReg,{'STR->Field_Name','nMesFinPag'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Mes final del Servicio'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MES FINAL'})
       AADD(aCamReg,{'STR->cTxtGetStr','MES FINAL'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MES FINAL DEL SERVICIO'})
       AADD(aCamReg,{'STR->cTitPrnStr','FINAL'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','CoE'})
       AADD(aCamReg,{'STR->cTemCamStr','Tcl'})
       AADD(aCamReg,{'STR->Field_Name','cMesPagCli'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Control de meses pagados'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MESES PAGOS'})
       AADD(aCamReg,{'STR->cTxtGetStr','MESES PAGOS'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CONTROL DE LOS MESES PAGADOS'})
       AADD(aCamReg,{'STR->cTitPrnStr','PAGOS'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: PAGO DE CONCEPTOS                                            *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 26/2004 VIE A
       Colombia, Bucaramanga        INICIO: 03:30 PM   NOV 26/2004 VIE

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfPaC(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','PaC'})
       AADD(aCamReg,{'STR->cTemCamStr','Tes'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoEst'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Estudiante'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PaC'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpa'})
       AADD(aCamReg,{'STR->Field_Name','nMesIniPag'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Mes inicial de Pago'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MES INICIAL;DEL PAGO'})
       AADD(aCamReg,{'STR->cTxtGetStr','MES INICIAL DEL PAGO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MES INICIAL DEL PAGO'})
       AADD(aCamReg,{'STR->cTitPrnStr','MES'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PaC'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpc'})
       AADD(aCamReg,{'STR->Field_Name','nMesIniPaC'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Mes inicial del Pago del Concepto'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MES INICIAL;CONCEPTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','MES INICIAL DEL CONCEPTO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MES INICIAL DEL CONCEPTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','MES INI'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PaC'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpc'})
       AADD(aCamReg,{'STR->Field_Name','nMesFinPaC'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Mes Final del Pago del Concepto'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MES FINAL;CONCEPTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','MES FINAL DEL CONCEPTO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MES FINAL DEL CONCEPTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','MES FIN'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','PaC'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpc'})
       AADD(aCamReg,{'STR->Field_Name','nVlrConPaC'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor del Concepto'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;CONCEPTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR DEL CONCEPTO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DEL CONCEPTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','VALOR'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA


/*************************************************************************
* TITULO..: RUTAS                                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC 03/2004 VIE A
       Colombia, Bucaramanga        INICIO: 12:15 PM   DIC 03/2004 VIE

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfRut(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Rut'})
       AADD(aCamReg,{'STR->cTemCamStr','Tru'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoRut'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo de la Ruta'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;RUTA'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DE LA RUTA'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE LA RUTA'})
       AADD(aCamReg,{'STR->cTitPrnStr','RUTA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Rut'})
       AADD(aCamReg,{'STR->cTemCamStr','Tru'})
       AADD(aCamReg,{'STR->Field_Name','cNombreRut'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,40})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@X'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nombre de la Ruta'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NOMBRE DE;LA RUTA'})
       AADD(aCamReg,{'STR->cTxtGetStr','NOMBRE DE LA RUTA'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NOMBRE DE LA RUTA'})
       AADD(aCamReg,{'STR->cTitPrnStr','DESCRIPCION'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Rut'})
       AADD(aCamReg,{'STR->cTemCamStr','Tru'})
       AADD(aCamReg,{'STR->Field_Name','cConcepRut'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,40})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@X'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Conceptos de la Ruta'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CONCEPTOS;DE LA RUTA'})
       AADD(aCamReg,{'STR->cTxtGetStr','CONCEPTOS DE LA RUTA'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','POR FAVOR INGRESE LOS CONCEPTOS DE LA RUTA'})
       AADD(aCamReg,{'STR->cTitPrnStr','CONCEPTOS'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Rut'})
       AADD(aCamReg,{'STR->cTemCamStr','Tru'})
       AADD(aCamReg,{'STR->Field_Name','cNitChfRut'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,16})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Documento del Conductor'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DOCUMENTO;CONDUCTOR'})
       AADD(aCamReg,{'STR->cTxtGetStr','DOCUMENTO DEL CONDUCTOR'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL DOCUMENTO DEL CONDUCTOR'})
       AADD(aCamReg,{'STR->cTitPrnStr','CONDUCTOR'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Rut'})
       AADD(aCamReg,{'STR->cTemCamStr','Tru'})
       AADD(aCamReg,{'STR->Field_Name','cTipChfRut'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,1})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Tipo del Documento del Conductor'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIPO DOCUMENTO;CONDUCTOR'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIPO DOCUMENTO CONDUCTOR'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIPO DEL DOCUMENTO DEL CONDUCTOR'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Rut'})
       AADD(aCamReg,{'STR->cTemCamStr','Tru'})
       AADD(aCamReg,{'STR->Field_Name','cNitAuxRut'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,16})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Documento del Conductor'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DOCUMENTO;AUXILIAR'})
       AADD(aCamReg,{'STR->cTxtGetStr','DOCUMENTO DEL AUXILIAR'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL DOCUMENTO DEL AUXILIAR'})
       AADD(aCamReg,{'STR->cTitPrnStr','AUXILIAR'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Rut'})
       AADD(aCamReg,{'STR->cTemCamStr','Tru'})
       AADD(aCamReg,{'STR->Field_Name','cTipAuxRut'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,1})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Tipo del Documento del Auxiliar'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIPO DOCUMENTO;AUXILIAR'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIPO DOCUMENTO AUXILIAR'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIPO DEL DOCUMENTO DEL AUXILIAR'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIPO'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: USUARIOS DE RUTAS                                            *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC 10/2004 VIE A
       Colombia, Bucaramanga        INICIO: 05:00 PM   DIC 10/2004 VIE

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfUru(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','URu'})
       AADD(aCamReg,{'STR->cTemCamStr','Tru'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoRut'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo de la Ruta'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;RUTA'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DE LA RUTA'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE LA RUTA'})
       AADD(aCamReg,{'STR->cTitPrnStr','RUTA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','URu'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpe'})
       AADD(aCamReg,{'STR->Field_Name','cDocNitPer'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,16})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Documento de la Persona'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DOCUMENTO;DE LA PERSONA'})
       AADD(aCamReg,{'STR->cTxtGetStr','DOCUMENTO DE LA PERSONA'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL DOCUMENTO DE LA PERSONA'})
       AADD(aCamReg,{'STR->cTitPrnStr','DOCUMENTO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','URu'})
       AADD(aCamReg,{'STR->cTemCamStr','Tpe'})
       AADD(aCamReg,{'STR->Field_Name','cTipNitPer'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,1})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Tipo del Documento de la Persona'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIPO DOCUMENTO;DE LA PERSONA'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIPO DOCUMENTO DE LA PERSONA'})
       AADD(aCamReg,{'STR->nLenGetStr',28})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIPO DEL DOCUMENTO DEL USUARIO'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIPO'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: FAMILIAS                                                     *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 08/2005 LUN A
       Colombia, Bucaramanga        INICIO: 05:15 PM   AGO 08/2005 LUN

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfFam(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Fam'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','cNombreFam'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,30})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','Nombre de la Familia'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FAMILIA'})
       AADD(aCamReg,{'STR->cTxtGetStr','NOMBRE DE LA FAMILIA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NOMBRE DE LA FAMILIA'})
       AADD(aCamReg,{'STR->cTitPrnStr','FAMILIA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fam'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','cCodEstFam'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,60})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digos de Estudiante de la familia'})
       AADD(aCamReg,{'STR->cTxtBrwStr','HIJOS'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGOS ESTUDIANTES'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE LOS HIJOS'})
       AADD(aCamReg,{'STR->cTitPrnStr','FAMILIA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fam'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','cPadNitEst'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,16})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Documento del Padre'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DOCUMENTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','DOCUMENTO DEL PADRE'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL DOCUMENTO DEL PADRE'})
       AADD(aCamReg,{'STR->cTitPrnStr','DOCUMENTO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fam'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','cApePadEst'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,30})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Apellido del Padre'})
       AADD(aCamReg,{'STR->cTxtBrwStr','APELLIDO;PADRE'})
       AADD(aCamReg,{'STR->cTxtGetStr','APELLIDO DEL PADRE'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL APELLIDO DEL PADRE'})
       AADD(aCamReg,{'STR->cTitPrnStr','APELLIDO PADRE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fam'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','cNomPadEst'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,40})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nombre del Padre'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NOMBRE;PADRE'})
       AADD(aCamReg,{'STR->cTxtGetStr','NOMBRE DEL PADRE'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NOMBRE DEL PADRE'})
       AADD(aCamReg,{'STR->cTitPrnStr','NOMBRE PADRE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fam'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','cMadNitEst'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,16})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Documento de la Madre'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DOCUMENTO;MADRE'})
       AADD(aCamReg,{'STR->cTxtGetStr','DOCUMENTO DE LA MADRE'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL DOCUMENTO DE LA MADRE'})
       AADD(aCamReg,{'STR->cTitPrnStr','DOCUMENTO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fam'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','cApeMadEst'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,30})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Apellido de la Madre'})
       AADD(aCamReg,{'STR->cTxtBrwStr','APELLIDO;MADRE'})
       AADD(aCamReg,{'STR->cTxtGetStr','APELLIDO DE LA MADRE'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL APELLIDO DE LA MADRE'})
       AADD(aCamReg,{'STR->cTitPrnStr','APELLIDO MADRE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Fam'})
       AADD(aCamReg,{'STR->cTemCamStr','Tfa'})
       AADD(aCamReg,{'STR->Field_Name','cNomMadEst'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,40})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nombre de la Madre'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NOMBRE;MADRE'})
       AADD(aCamReg,{'STR->cTxtGetStr','NOMBRE DE LA MADRE'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NOMBRE DE LA MADRE'})
       AADD(aCamReg,{'STR->cTitPrnStr','NOMBRE MADRE'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: INFORMES DEL SISTEMA                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 10/2007 LUN A
       Colombia, Bucaramanga        INICIO: 10:45 AM   SEP 10/2007 LUN

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfInf(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Inf'})
       AADD(aCamReg,{'STR->cTemCamStr','Tin'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoInf'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,08})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XXXXXXXX'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Informe'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;INFORME'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO INFORME'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL INFORME'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Inf'})
       AADD(aCamReg,{'STR->cTemCamStr','Tin'})
       AADD(aCamReg,{'STR->Field_Name','cTituloInf'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,60})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!S42'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','T¡tulo por defecto del Informe'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TITULO;POR DEFECTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','TITULO POR DEFECTO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TITULO POR DEFECTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','TITULO POR DEFECTO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Inf'})
       AADD(aCamReg,{'STR->cTemCamStr','Tin'})
       AADD(aCamReg,{'STR->Field_Name','cObservInf'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,80})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!S42'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','Observaci¢n del informe'})
       AADD(aCamReg,{'STR->cTxtBrwStr','OBSERVACION'})
       AADD(aCamReg,{'STR->cTxtGetStr','OBSERVACION'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA OBSERVACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','OBSERVACION'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Inf'})
       AADD(aCamReg,{'STR->cTemCamStr','Tin'})
       AADD(aCamReg,{'STR->Field_Name','nNroOrdInf'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero de orden'})
       AADD(aCamReg,{'STR->cTxtBrwStr','ORDEN'})
       AADD(aCamReg,{'STR->cTxtGetStr','NUMERO DE ORDEN'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DE ORDEN'})
       AADD(aCamReg,{'STR->cTitPrnStr','ORDEN'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Inf'})
       AADD(aCamReg,{'STR->cTemCamStr','Tin'})
       AADD(aCamReg,{'STR->Field_Name','nNumeroInf'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero del Informe'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NUMERO'})
       AADD(aCamReg,{'STR->cTxtGetStr','NUMERO DEL INFORME'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DEL INFORME'})
       AADD(aCamReg,{'STR->cTitPrnStr','NUMERO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Inf'})
       AADD(aCamReg,{'STR->cTemCamStr','Tin'})
       AADD(aCamReg,{'STR->Field_Name','lInfVarInf'})
       AADD(aCamReg,{'STR->Field_Type','L'})
       AADD(aCamReg,{'STR->Field_Len' ,01})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Informe variable'})
       AADD(aCamReg,{'STR->cTxtBrwStr','INFORME;VARIABLE'})
       AADD(aCamReg,{'STR->cTxtGetStr','INFORME VARIABLE'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE SI EL INFORME ES VARIABLE'})
       AADD(aCamReg,{'STR->cTitPrnStr','VARIABLE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Inf'})
       AADD(aCamReg,{'STR->cTemCamStr','Tin'})
       AADD(aCamReg,{'STR->Field_Name','cCodSuiInf'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,04})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Sistema'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;SISTEMA'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO SISTEMA'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO SISTEMA'})
       AADD(aCamReg,{'STR->cTitPrnStr','SISTEMA'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: TIPO DE DOCUMENTOS PARA IMPRIMIR                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 10/2006 LUN A
       Colombia, Bucaramanga        INICIO: 03:20 PM   JUL 10/2006 LUN

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfIso(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','nNumeroIso'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero Iso del Documento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NUMERO'})
       AADD(aCamReg,{'STR->cTxtGetStr','NUMERO DEL DOCUMENTO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DEL DOCUMENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','NUMERO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','cCodSuiIso'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,04})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Sistema'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;SISTEMA'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO SISTEMA'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO SISTEMA'})
       AADD(aCamReg,{'STR->cTitPrnStr','SISTEMA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','nNroOrdIso'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero de orden'})
       AADD(aCamReg,{'STR->cTxtBrwStr','ORDEN'})
       AADD(aCamReg,{'STR->cTxtGetStr','NUMERO DE ORDEN'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DE ORDEN'})
       AADD(aCamReg,{'STR->cTitPrnStr','ORDEN'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','cCodInfIso'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,08})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XXXXXXXX'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Informe'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;INFORME'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO INFORME'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL INFORME'})
       AADD(aCamReg,{'STR->cTitPrnStr','INFORME'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','nCodPrnIso'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo de la Impresora'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;IMPRESORA'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO IMPRESORA'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE LA IMPRESORA'})
       AADD(aCamReg,{'STR->cTitPrnStr','IMPRESORA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','dFecAprIso'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!D'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha de Aprobaci¢n del Iso'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;APROBACION'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA APROBACION'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DE APROBACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','FECHA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','cFecAprIso'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XXXXXXXXXXXX'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha de Aprobaci¢n del Iso'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;APROBACION'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA APROBACION'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DE APROBACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','FECHA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','cNroVerIso'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,08})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'XXXXXXXX'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Versi¢n del Documento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VERSION'})
       AADD(aCamReg,{'STR->cTxtGetStr','VERSION'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA VERSION DEL INFORME'})
       AADD(aCamReg,{'STR->cTitPrnStr','VERSION'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','nMargSIIso'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Margen Superior Izquierdo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MARGEN SUPERIOR;IZQUIERDO'})
       AADD(aCamReg,{'STR->cTxtGetStr','MARGEN SUPERIOR IZQUIERDO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MARGEN SUPERIOR IZQUIERDO'})
       AADD(aCamReg,{'STR->cTitPrnStr','MARGENSI'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','nMargSDIso'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Margen Superior Derecho'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MARGEN SUPERIOR;DERECHO'})
       AADD(aCamReg,{'STR->cTxtGetStr','MARGEN SUPERIOR DERECHO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MARGEN SUPERIOR DERECHO'})
       AADD(aCamReg,{'STR->cTitPrnStr','MARGENSD'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','nMargIIIso'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Margen Inferior Izquierdo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MARGEN INFERIOR;IZQUIERDO'})
       AADD(aCamReg,{'STR->cTxtGetStr','MARGEN INFERIOR IZQUIERDO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MARGEN INFERIOR IZQUIERDO'})
       AADD(aCamReg,{'STR->cTitPrnStr','MARGENII'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','nMargIDIso'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Margen Inferior Derecho'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MARGEN INFERIOR;DERECHO'})
       AADD(aCamReg,{'STR->cTxtGetStr','MARGEN INFERIOR DERECHO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MARGEN INFERIOR DERECHO'})
       AADD(aCamReg,{'STR->cTitPrnStr','MARGENID'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','nMarg1IIso'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Margen Uno Izquierdo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MARGEN UNO;IZQUIERDO'})
       AADD(aCamReg,{'STR->cTxtGetStr','MARGEN UNO IZQUIERDO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MARGEN UNO IZQUIERDO'})
       AADD(aCamReg,{'STR->cTitPrnStr','MARGEN1I'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','nMarg1DIso'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Margen Uno Derecho'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MARGEN UNO;DERECHO'})
       AADD(aCamReg,{'STR->cTxtGetStr','MARGEN UNO DERECHO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MARGEN UNO DERECHO'})
       AADD(aCamReg,{'STR->cTitPrnStr','MARGEN1D'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','nMarg2IIso'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Margen Dos Izquierdo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MARGEN DOS;IZQUIERDO'})
       AADD(aCamReg,{'STR->cTxtGetStr','MARGEN DOS IZQUIERDO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MARGEN DOS IZQUIERDO'})
       AADD(aCamReg,{'STR->cTitPrnStr','MARGEN2I'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','nMarg2DIso'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,3})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Margen Dos Derecho'})
       AADD(aCamReg,{'STR->cTxtBrwStr','MARGEN DOS;DERECHO'})
       AADD(aCamReg,{'STR->cTxtGetStr','MARGEN DOS DERECHO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL MARGEN DOS DERECHO'})
       AADD(aCamReg,{'STR->cTitPrnStr','MARGEN2D'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','nNroDocIso'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero del Documento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NUMERO;DOCUMENTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','NUMERO DOCUMENTO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DEL DOCUMENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','DOCUMENTO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','cTituloIso'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,60})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!S42'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','T¡tulo por defecto del Documento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TITULO;POR DEFECTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','TITULO POR DEFECTO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TITULO POR DEFECTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','TITULO POR DEFECTO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','cOpcSysIso'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,60})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!S42'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Opci¢n del Sistema del Informe'})
       AADD(aCamReg,{'STR->cTxtBrwStr','OPCION DEL SISTEMA'})
       AADD(aCamReg,{'STR->cTxtGetStr','OPCION DEL SISTEMA'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA OPCION DEL INFORME'})
       AADD(aCamReg,{'STR->cTitPrnStr','OPCION DEL SISTEMA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoIso'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,60})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!S42'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo Iso del Documento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;DE LA ISO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO ISO DEL DOCUMENTO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO ISO DEL DOCUMENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODISO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','cTitUnoIso'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,60})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!S42'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','T¡tulo Uno Iso del Documento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TITULO UNO'})
       AADD(aCamReg,{'STR->cTxtGetStr','TITULO UNO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TITULO UNO DEL DOCUMENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','TITULO UNO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','cTitDosIso'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,60})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!S42'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','T¡tulo Dos Iso del Documento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TITULO DOS'})
       AADD(aCamReg,{'STR->cTxtGetStr','TITULO DOS'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TITULO DOS DEL DOCUMENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','TITULO DOS'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','cTitTreIso'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,60})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!S42'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','T¡tulo Tres Iso del Documento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TITULO TRES'})
       AADD(aCamReg,{'STR->cTxtGetStr','TITULO TRES'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TITULO TRES ISO DEL DOCUMENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','TITULO TRES'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','cPieUnoIso'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,256})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!S42'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Pie de P gina Uno del Documento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PIE DE PAGINA UNO'})
       AADD(aCamReg,{'STR->cTxtGetStr','PIE DE PAGINA UNO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL PIE DE PAGINA UNO DEL DOCUMENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','PIE UNO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','cPieDosIso'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,256})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!S42'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Pie de P gina Dos del Documento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PIE DE PAGINA DOS'})
       AADD(aCamReg,{'STR->cTxtGetStr','PIE DE PAGINA DOS'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL PIE DE PAGINA DOS DEL DOCUMENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','PIE DOS'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','cPieTreIso'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,256})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!S42'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Pie de P gina Tres del Documento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PIE DE PAGINA TRES'})
       AADD(aCamReg,{'STR->cTxtGetStr','PIE DE PAGINA TRES'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL PIE DE PAGINA UNO DEL DOCUMENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','PIE TRES'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','cObsUnoIso'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,256})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!S42'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Observaci¢n Uno'})
       AADD(aCamReg,{'STR->cTxtBrwStr','OBSERVACION UNO'})
       AADD(aCamReg,{'STR->cTxtGetStr','OBSERVACION UNO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA OBSERVACION UNO'})
       AADD(aCamReg,{'STR->cTitPrnStr','OBSERVACION UNO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','cObsDosIso'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,256})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!S42'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Observaci¢n Dos'})
       AADD(aCamReg,{'STR->cTxtBrwStr','OBSERVACION DOS'})
       AADD(aCamReg,{'STR->cTxtGetStr','OBSERVACION DOS'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA OBSERVACION DOS'})
       AADD(aCamReg,{'STR->cTitPrnStr','OBSERVACION DOS'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Iso'})
       AADD(aCamReg,{'STR->cTemCamStr','Tis'})
       AADD(aCamReg,{'STR->Field_Name','cObsTreIso'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,256})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!S42'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Observaci¢n Tres'})
       AADD(aCamReg,{'STR->cTxtBrwStr','OBSERVACION TRES'})
       AADD(aCamReg,{'STR->cTxtGetStr','OBSERVACION TRES'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA OBSERVACION TRES'})
       AADD(aCamReg,{'STR->cTitPrnStr','OBSERVACION TRES'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: TABLA DE OBSERVACIONES                                       *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 08/2006 MAR A
       Colombia, Bucaramanga        INICIO: 10:30 AM   AGO 08/2006 MAR

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfTob(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Tob'})
       AADD(aCamReg,{'STR->cTemCamStr','Tto'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoTob'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo de la Observaci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DE LA OBSERVACION'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE LA OBSERVACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tob'})
       AADD(aCamReg,{'STR->cTemCamStr','Tto'})
       AADD(aCamReg,{'STR->Field_Name','cNombreTob'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,40})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nombre de la Observacion'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NOMBRE;DE LA OBSERVACION'})
       AADD(aCamReg,{'STR->cTxtGetStr','NOMBRE DE LA OBSERVACION'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NOMBRE DE LA OBSERVACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','TITULO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tob'})
       AADD(aCamReg,{'STR->cTemCamStr','Tto'})
       AADD(aCamReg,{'STR->Field_Name','cUsrAutTob'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,10})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nombre de la Usuario'})
       AADD(aCamReg,{'STR->cTxtBrwStr','USUARIO;AUTORIZADO'})
       AADD(aCamReg,{'STR->cTxtGetStr','USUARIO AUTORIZADO'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL USUARIO AUTORIZADO'})
       AADD(aCamReg,{'STR->cTitPrnStr','USUARIO'})
       AADD(aRegIni,aCamReg)


       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: OBSERVACIONES DE LOS ESTUDIANTES                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 08/2006 MAR A
       Colombia, Bucaramanga        INICIO: 10:35 AM   AGO 08/2006 MAR

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfObs(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Obs'})
       AADD(aCamReg,{'STR->cTemCamStr','Tob'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoTob'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,4})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@9999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo de la Observaci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DE LA OBSERVACION'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE LA OBSERVACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Obs'})
       AADD(aCamReg,{'STR->cTemCamStr','Tob'})
       AADD(aCamReg,{'STR->Field_Name','cCodEstObs'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Estudiante'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Obs'})
       AADD(aCamReg,{'STR->cTemCamStr','Tob'})
       AADD(aCamReg,{'STR->Field_Name','mObservObs'})
       AADD(aCamReg,{'STR->Field_Type','M'})
       AADD(aCamReg,{'STR->Field_Len' ,10})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Observaci¢n del Estudiante'})
       AADD(aCamReg,{'STR->cTxtBrwStr','OBSERVACION;ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTxtGetStr','OBSERVACION DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA OBSERVACION DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Obs'})
       AADD(aCamReg,{'STR->cTemCamStr','Tob'})
       AADD(aCamReg,{'STR->Field_Name','cNotaObs'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,04})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nota de la Observaci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NOTA DE LA;OBSERVACION'})
       AADD(aCamReg,{'STR->cTxtGetStr','NOTA DE LA OBSERVACION'})
       AADD(aCamReg,{'STR->nLenGetStr',24})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA APROBACION DE LA OBSERVACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','NOTA'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: OBSERVACIONES GENERALES                                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 28/2006 MAR A
       Colombia, Bucaramanga        INICIO: 03:30 PM   NOV 28/2006 MAR

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfObG(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','ObG'})
       AADD(aCamReg,{'STR->cTemCamStr','Tto'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoEst'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Estudiante'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','ObG'})
       AADD(aCamReg,{'STR->cTemCamStr','Tto'})
       AADD(aCamReg,{'STR->Field_Name','cObsGenPer'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,256})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!S70'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Observaci¢n General de la Persona'})
       AADD(aCamReg,{'STR->cTxtBrwStr','OBSERVACION GENERAL'})
       AADD(aCamReg,{'STR->cTxtGetStr','OBSERVACION GENERAL'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA OBSERVACION GENERAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','OBSERVACION GENERAL'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','ObG'})
       AADD(aCamReg,{'STR->cTemCamStr','Tto'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoTog'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del tipo de Observaci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIPO;OBSERVACION'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIPO OBSERVACION'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIPO DE OBSERVACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: TIPO OBSERVACIONES GENERALES                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 28/2006 MAR A
       Colombia, Bucaramanga        INICIO: 12:45 PM   NOV 28/2006 MAR

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfToG(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','ToG'})
       AADD(aCamReg,{'STR->cTemCamStr','Tto'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoTog'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del tipo de Observaci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;TIPO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO TIPO'})
       AADD(aCamReg,{'STR->nLenGetStr',23})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL TIPO'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','ToG'})
       AADD(aCamReg,{'STR->cTemCamStr','Tso'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoSoG'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo de Clasificaci¢n de la Observaci¢n General'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;CLASIFICACION'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO DE CLASIFICACION'})
       AADD(aCamReg,{'STR->nLenGetStr',23})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE CLASIFICACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','ToG'})
       AADD(aCamReg,{'STR->cTemCamStr','Tto'})
       AADD(aCamReg,{'STR->Field_Name','cNombreTog'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,40})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nombre del Tipo de Observaci¢n General'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIPO OBSERVACION'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIPO OBSERVACION'})
       AADD(aCamReg,{'STR->nLenGetStr',23})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIPO DE OBSERVACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIPO OBSERVACION GENERAL'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','ToG'})
       AADD(aCamReg,{'STR->cTemCamStr','Tto'})
       AADD(aCamReg,{'STR->Field_Name','cGetHlpTog'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,80})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@XS70'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Mensaje de Ayuda para la lectura'})
       AADD(aCamReg,{'STR->cTxtBrwStr','GET AYUDA'})
       AADD(aCamReg,{'STR->cTxtGetStr','GET AYUDA'})
       AADD(aCamReg,{'STR->nLenGetStr',23})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA AYUDA PARA EL GET'})
       AADD(aCamReg,{'STR->cTitPrnStr','AYUDA PARA EL GET'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','ToG'})
       AADD(aCamReg,{'STR->cTemCamStr','Tm1'})
       AADD(aCamReg,{'STR->Field_Name','Field_Type'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,01})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Tipo del Campo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIPO DEL CAMPO'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIPO DEL CAMPO'})
       AADD(aCamReg,{'STR->nLenGetStr',23})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIPO DEL CAMPO'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','ToG'})
       AADD(aCamReg,{'STR->cTemCamStr','Tm2'})
       AADD(aCamReg,{'STR->Field_Name','Field_Len'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,03})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Longitud del Campo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','LONGITUD DEL CAMPO'})
       AADD(aCamReg,{'STR->cTxtGetStr','LONGITUD DEL CAMPO'})
       AADD(aCamReg,{'STR->nLenGetStr',23})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA LONGITUD DEL CAMPO'})
       AADD(aCamReg,{'STR->cTitPrnStr','LEN'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','ToG'})
       AADD(aCamReg,{'STR->cTemCamStr','Tm3'})
       AADD(aCamReg,{'STR->Field_Name','Field_Dec'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,01})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero de decimales'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NUMERO DE DECIMALES'})
       AADD(aCamReg,{'STR->cTxtGetStr','NUMERO DE DECIMALES'})
       AADD(aCamReg,{'STR->nLenGetStr',23})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DE DECIMALES'})
       AADD(aCamReg,{'STR->cTitPrnStr','DEC'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','ToG'})
       AADD(aCamReg,{'STR->cTemCamStr','Tm4'})
       AADD(aCamReg,{'STR->Field_Name','Field_Pic'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,20})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Picture del Campo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PICTURE DEL CAMPO'})
       AADD(aCamReg,{'STR->cTxtGetStr','PICTURE DEL CAMPO'})
       AADD(aCamReg,{'STR->nLenGetStr',23})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL PICTURE DEL CAMPO'})
       AADD(aCamReg,{'STR->cTitPrnStr','PICTURE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','ToG'})
       AADD(aCamReg,{'STR->cTemCamStr','Tm5'})
       AADD(aCamReg,{'STR->Field_Name','Field_Dup'})
       AADD(aCamReg,{'STR->Field_Type','L'})
       AADD(aCamReg,{'STR->Field_Len' ,01})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Campo Duplicado'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CAMPO DUPLICADO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CAMPO DUPLICADO'})
       AADD(aCamReg,{'STR->nLenGetStr',23})
       AADD(aCamReg,{'STR->cHlpGetStr','EL CAMPO PUEDE SER DUPLICADO'})
       AADD(aCamReg,{'STR->cTitPrnStr','DUPLICADO'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: SUBDIVISION DE LAS OBSERVACIONES GENERALES                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 28/2006 MAR A
       Colombia, Bucaramanga        INICIO: 12:45 PM   NOV 28/2006 MAR

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfSoG(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','SoG'})
       AADD(aCamReg,{'STR->cTemCamStr','Tso'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoSoG'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo de Clasificaci¢n de la Observaci¢n General'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;CLASIFICACION'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO CLASIFICACION'})
       AADD(aCamReg,{'STR->nLenGetStr',20})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE CLASIFICACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','SoG'})
       AADD(aCamReg,{'STR->cTemCamStr','Tso'})
       AADD(aCamReg,{'STR->Field_Name','cNombreSoG'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,40})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Clasificaci¢n de la Observaci¢n General'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CLASIFICACION'})
       AADD(aCamReg,{'STR->cTxtGetStr','CLASIFICACION'})
       AADD(aCamReg,{'STR->nLenGetStr',20})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE CLASIFICACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','CLASIFICACION'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA