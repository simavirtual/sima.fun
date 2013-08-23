/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		   BIBLIOTECAS DE FUNCIONES DE ESTRUCTURAS
			  SISTEMA DE PARQUEADEROS

OBJETIVOS:

- Define las funciones para crear las esctructuras de los archivos del
  generales del SIMA

***************************************************************************
*-------------------- ESTRUCTURAS PARA SIMAPAGO --------------------------*
**************************************************************************/

/*************************************************************************
* TITULO..: CATEGORIAS DE LOS VEHICULOS                                  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 27/2005 MIE A
       Colombia, Bucaramanga        INICIO: 06:30 PM   JUL 27/2005 MIE

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrPakCat(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Cat'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','cTipVehCat'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','Tipo de Veh¡culo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIPO;VEHICULO'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIPO DE VEHICULO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIPO DE VEHICULO'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cat'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','cNombreCat'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,20})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nombre del Tipo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NOMBRE;TIPO'})
       AADD(aCamReg,{'STR->cTxtGetStr','NOMBRE DEL TIPO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NOMBRE DEL TIPO'})
       AADD(aCamReg,{'STR->cTitPrnStr','NOMBRE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cat'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','nVlrFDiCat'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor de la Fracci¢n Diurna'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FRACCION;DIURNA'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR FRACCION DIURNA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DE LA FRACCION DIURNA'})
       AADD(aCamReg,{'STR->cTitPrnStr','F.DIURNA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cat'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','nVlrFNoCat'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor de la Fracci¢n Nocturna'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FRACCION;NOCTURNA'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR FRACCION NOCTURNA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DE LA FRACCION NOCTURNA'})
       AADD(aCamReg,{'STR->cTitPrnStr','F.NOCTORNA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cat'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','nVlrSegCat'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor del segundo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;SEGUNDO'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR SEGUNDO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DEL SEGUNDO'})
       AADD(aCamReg,{'STR->cTitPrnStr','V.SEGUNDO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cat'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','nVlrMDiCat'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor minuto diurno'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;MINUTO DIURNO'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR MINUTO DIURNO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DEL MINUTO DIURNO'})
       AADD(aCamReg,{'STR->cTitPrnStr','M.DIURNO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cat'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','nVlrMNoCat'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor minuto nocturno'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;MINUTO NOCTURNO'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR MINUTO NOCTURNO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DEL MINUTO NOCTURNO'})
       AADD(aCamReg,{'STR->cTitPrnStr','M.NOCTURNO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cat'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','nVlrHDiCat'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor de la Hora Diurna'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;HORA DIURNA'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR HORA DIURNA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DE LA HORA DIURNA'})
       AADD(aCamReg,{'STR->cTitPrnStr','HORA DIURNA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cat'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','nVlrHNoCat'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor de la Hora Nocturna'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;HORA NOCTURNA'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR HORA NOCTURNA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DE LA HORA NOCTURNA'})
       AADD(aCamReg,{'STR->cTitPrnStr','HORA NOCTURNA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cat'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','nVlrDiaCat'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor del D¡a'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;DEL DIA'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR DEL DIA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DEL DIA'})
       AADD(aCamReg,{'STR->cTitPrnStr','VALOR DIA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cat'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','nVlrMesCat'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor del Mes'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;DEL MES'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR DEL MES'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DEL MES'})
       AADD(aCamReg,{'STR->cTitPrnStr','VALOR MES'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cat'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','nVlrAnoCat'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor del A¤o'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;DEL A¥O'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR DEL A¥O'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DEL A¥O'})
       AADD(aCamReg,{'STR->cTitPrnStr','VALOR A¥O'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: TARIFAS                                                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 15/2005 VIE A
       Colombia, Bucaramanga        INICIO: 04:30 PM   JUL 15/2005 VIE

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrPakTar(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Tar'})
       AADD(aCamReg,{'STR->cTemCamStr','Tta'})
       AADD(aCamReg,{'STR->Field_Name','nCodigoTar'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','Cantidad a Liquidar'})
       AADD(aCamReg,{'STR->cTxtBrwStr','No.'})
       AADD(aCamReg,{'STR->cTxtGetStr','CANTIDA A LIQUIDAR'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DE LA TARIFA'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cat'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','cTipVehCat'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Tipo de Veh¡culo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIPO;VEHICULO'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIPO DE VEHICULO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIPO DE VEHICULO'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tar'})
       AADD(aCamReg,{'STR->cTemCamStr','Tta'})
       AADD(aCamReg,{'STR->Field_Name','nVlrFDiTar'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor de la Fracci¢n Diurna'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FRACCION;DIURNA'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR FRACCION DIURNA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DE LA FRACCION DIURNA'})
       AADD(aCamReg,{'STR->cTitPrnStr','F.DIURNA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tar'})
       AADD(aCamReg,{'STR->cTemCamStr','Tta'})
       AADD(aCamReg,{'STR->Field_Name','nVlrFNoTar'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor de la Fracci¢n Nocturna'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FRACCION;NOCTURNA'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR FRACCION NOCTURNA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DE LA FRACCION NOCTURNA'})
       AADD(aCamReg,{'STR->cTitPrnStr','F.NOCTURNA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tar'})
       AADD(aCamReg,{'STR->cTemCamStr','Tta'})
       AADD(aCamReg,{'STR->Field_Name','nVlrSegTar'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor del segundo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;SEGUNDO'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR SEGUNDO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DEL SEGUNDO'})
       AADD(aCamReg,{'STR->cTitPrnStr','V.SEGUNDO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tar'})
       AADD(aCamReg,{'STR->cTemCamStr','Tta'})
       AADD(aCamReg,{'STR->Field_Name','nVlrMDiTar'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor minuto diurno'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;MINUTO DIURNO'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR MINUTO DIURNO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DEL MINUTO DIURNO'})
       AADD(aCamReg,{'STR->cTitPrnStr','M.DIURNO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tar'})
       AADD(aCamReg,{'STR->cTemCamStr','Tta'})
       AADD(aCamReg,{'STR->Field_Name','nVlrMNoTar'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor minuto nocturno'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;MINUTO NOCTURNO'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR MINUTO NOCTURNO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DEL MINUTO NOCTURNO'})
       AADD(aCamReg,{'STR->cTitPrnStr','M.NOCTURNO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tar'})
       AADD(aCamReg,{'STR->cTemCamStr','Tta'})
       AADD(aCamReg,{'STR->Field_Name','nVlrHorTar'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor de la Hora'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;HORA'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR HORA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DE LA HORA'})
       AADD(aCamReg,{'STR->cTitPrnStr','HORA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tar'})
       AADD(aCamReg,{'STR->cTemCamStr','Tta'})
       AADD(aCamReg,{'STR->Field_Name','nVlrHDiTar'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor de la Hora Diurna'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;HORA DIURNA'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR HORA DIURNA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DE LA HORA DIURNA'})
       AADD(aCamReg,{'STR->cTitPrnStr','HORA DIURNA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tar'})
       AADD(aCamReg,{'STR->cTemCamStr','Tta'})
       AADD(aCamReg,{'STR->Field_Name','nVlrHNoTar'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor de la Hora Nocturna'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;HORA NOCTURNA'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR HORA NOCTURNA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DE LA HORA NOCTURNA'})
       AADD(aCamReg,{'STR->cTitPrnStr','HORA NOCTURNA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tar'})
       AADD(aCamReg,{'STR->cTemCamStr','Tta'})
       AADD(aCamReg,{'STR->Field_Name','nVlrDiaTar'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor del D¡a'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;DEL DIA'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR DEL DIA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DEL DIA'})
       AADD(aCamReg,{'STR->cTitPrnStr','VALOR DIA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tar'})
       AADD(aCamReg,{'STR->cTemCamStr','Tta'})
       AADD(aCamReg,{'STR->Field_Name','nVlrMesTar'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor del Mes'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;DEL MES'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR DEL MES'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DEL MES'})
       AADD(aCamReg,{'STR->cTitPrnStr','VALOR MES'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Tar'})
       AADD(aCamReg,{'STR->cTemCamStr','Tta'})
       AADD(aCamReg,{'STR->Field_Name','nVlrAnoTar'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor del A¤o'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;DEL A¥O'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR DEL A¥O'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DEL A¥O'})
       AADD(aCamReg,{'STR->cTitPrnStr','VALOR A¥O'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: REGISTROS DE PARQUEO                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC 03/2004 VIE A
       Colombia, Bucaramanga        INICIO: 12:15 PM   DIC 03/2004 VIE

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrDbfReg(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Reg'})
       AADD(aCamReg,{'STR->cTemCamStr','Tre'})
       AADD(aCamReg,{'STR->Field_Name','cPlacaVeh'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero de Placa'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PLACA'})
       AADD(aCamReg,{'STR->cTxtGetStr','NUMERO DE PLACA'})
       AADD(aCamReg,{'STR->nLenGetStr',18})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DE LA PLACA'})
       AADD(aCamReg,{'STR->cTitPrnStr','PLACA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Reg'})
       AADD(aCamReg,{'STR->cTemCamStr','Tre'})
       AADD(aCamReg,{'STR->Field_Name','nNroFacReg'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,9})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Numero del Recibo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','RECIBO'})
       AADD(aCamReg,{'STR->cTxtGetStr','RECIBO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DEL RECIBO'})
       AADD(aCamReg,{'STR->cTitPrnStr','RECIBO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cat'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','cTipVehCat'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','Tipo de Veh¡culo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIPO;VEHICULO'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIPO DE VEHICULO'})
       AADD(aCamReg,{'STR->nLenGetStr',18})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIPO DE VEHICULO'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIPO'})
       AADD(aRegIni,aCamReg)



       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Reg'})
       AADD(aCamReg,{'STR->cTemCamStr','Tre'})
       AADD(aCamReg,{'STR->Field_Name','dFecIngReg'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!D'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha de Ingreso'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;INGRESO'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA DE INGRESO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DE INGRESO'})
       AADD(aCamReg,{'STR->cTitPrnStr','F.INGRESO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Reg'})
       AADD(aCamReg,{'STR->cTemCamStr','Tre'})
       AADD(aCamReg,{'STR->Field_Name','dFecOutReg'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!D'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha de Salida'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;SALIDA'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA DE SALIDA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DE SALIDA'})
       AADD(aCamReg,{'STR->cTitPrnStr','F.SALIDA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Reg'})
       AADD(aCamReg,{'STR->cTemCamStr','Tre'})
       AADD(aCamReg,{'STR->Field_Name','cHorIngReg'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,08})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Hora de Ingreso'})
       AADD(aCamReg,{'STR->cTxtBrwStr','HORA;INGRESO'})
       AADD(aCamReg,{'STR->cTxtGetStr','HORA DE INGRESO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA HORA DE INGRESO'})
       AADD(aCamReg,{'STR->cTitPrnStr','H. INGRESO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Reg'})
       AADD(aCamReg,{'STR->cTemCamStr','Tre'})
       AADD(aCamReg,{'STR->Field_Name','cHorOutReg'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,08})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Hora de Salida'})
       AADD(aCamReg,{'STR->cTxtBrwStr','HORA;SALIDA'})
       AADD(aCamReg,{'STR->cTxtGetStr','HORA DE SALIDA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA HORA DE SALIDA'})
       AADD(aCamReg,{'STR->cTitPrnStr','H. SALIDA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Reg'})
       AADD(aCamReg,{'STR->cTemCamStr','Tre'})
       AADD(aCamReg,{'STR->Field_Name','cTiempoReg'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,24})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Tiempo de Duraci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIEMPO;AA:MM:DD:HD:MD:HN:MN:SS'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIEMPO DE DURACION'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIEMPO DE DURACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIEMPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Reg'})
       AADD(aCamReg,{'STR->cTemCamStr','Tre'})
       AADD(aCamReg,{'STR->Field_Name','cTieCobReg'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,20})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Tiempo Cobrado'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIEMPO COBRADO;AA:MM:DD:HD:HN:FD:FN'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIEMPO COBRADO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIEMPO COBRADO'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIEMPO COBRADO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Caj'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','nCodigoCaj'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero de la Caja'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CAJA'})
       AADD(aCamReg,{'STR->cTxtGetStr','CAJA No.'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DE LA CAJA'})
       AADD(aCamReg,{'STR->cTitPrnStr','CAJA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Reg'})
       AADD(aCamReg,{'STR->cTemCamStr','Tre'})
       AADD(aCamReg,{'STR->Field_Name','nVlrTotReg'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor del Servicio'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;SERVICIO'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR DEL SERVICIO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DEL SERVICIO'})
       AADD(aCamReg,{'STR->cTitPrnStr','VLR SERVICIO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Reg'})
       AADD(aCamReg,{'STR->cTemCamStr','Tre'})
       AADD(aCamReg,{'STR->Field_Name','nBasIvaReg'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Base del Iva'})
       AADD(aCamReg,{'STR->cTxtBrwStr','BASE;DEL IVA'})
       AADD(aCamReg,{'STR->cTxtGetStr','BASE DEL IVA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA BASE DEL IVA'})
       AADD(aCamReg,{'STR->cTitPrnStr','BASE IVA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Reg'})
       AADD(aCamReg,{'STR->cTemCamStr','Tre'})
       AADD(aCamReg,{'STR->Field_Name','nPorIvaReg'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,5})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'99.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Porcentaje del Iva'})
       AADD(aCamReg,{'STR->cTxtBrwStr','%IVA'})
       AADD(aCamReg,{'STR->cTxtGetStr','%IVA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL % DEL IVA'})
       AADD(aCamReg,{'STR->cTitPrnStr','%  IVA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Reg'})
       AADD(aCamReg,{'STR->cTemCamStr','Tre'})
       AADD(aCamReg,{'STR->Field_Name','nVlrIvaReg'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor del Iva'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;DEL IVA'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR DEL IVA'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR DEL IVA'})
       AADD(aCamReg,{'STR->cTitPrnStr','VALOR IVA'})
       AADD(aRegIni,aCamReg)



       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Reg'})
       AADD(aCamReg,{'STR->cTemCamStr','Trc'})
       AADD(aCamReg,{'STR->Field_Name','dFecRetRca'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!D'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha de Retiro de Caja'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;RETIRO'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA DE RETIRO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DEL RETIRO DE CAJA'})
       AADD(aCamReg,{'STR->cTitPrnStr','F.RETIRO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Reg'})
       AADD(aCamReg,{'STR->cTemCamStr','Trc'})
       AADD(aCamReg,{'STR->Field_Name','cHorRetRca'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,08})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Hora del Retiro de caja'})
       AADD(aCamReg,{'STR->cTxtBrwStr','HORA;RETIRO'})
       AADD(aCamReg,{'STR->cTxtGetStr','HORA DEL RETIRO'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA HORA DEL RETIRO DE CAJA'})
       AADD(aCamReg,{'STR->cTitPrnStr','H. RETIRO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Reg'})
       AADD(aCamReg,{'STR->cTemCamStr','Trc'})
       AADD(aCamReg,{'STR->Field_Name','dFecDepReg'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!D'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha de la Consignaci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;CONSIGNACION'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA DE CONSIGNACION'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DEL RETIRO DE CAJA'})
       AADD(aCamReg,{'STR->cTitPrnStr','F.RETIRO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Reg'})
       AADD(aCamReg,{'STR->cTemCamStr','Tre'})
       AADD(aCamReg,{'STR->Field_Name','cNroComReg'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@X'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Comprobante de Contabilidad'})
       AADD(aCamReg,{'STR->cTxtBrwStr','COMPROBANTE'})
       AADD(aCamReg,{'STR->cTxtGetStr','COMPROBANTE'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL COMPROBANTE DE CONTABILIDAD'})
       AADD(aCamReg,{'STR->cTitPrnStr','COMPROBANTE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Reg'})
       AADD(aCamReg,{'STR->cTemCamStr','Tre'})
       AADD(aCamReg,{'STR->Field_Name','cObservReg'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,40})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@X'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Observaci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','OBSERVACION'})
       AADD(aCamReg,{'STR->cTxtGetStr','OBSERVACION'})
       AADD(aCamReg,{'STR->nLenGetStr',21})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA OBSERVACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','OBSERVACION'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: VEHICULOS                                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 15/2005 VIE A
       Colombia, Bucaramanga        INICIO: 04:00 PM   JUL 15/2005 VIE

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrPakVeh(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Veh'})
       AADD(aCamReg,{'STR->cTemCamStr','Tve'})
       AADD(aCamReg,{'STR->Field_Name','cPlacaVeh'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero de la Placa'})
       AADD(aCamReg,{'STR->cTxtBrwStr','PLACA'})
       AADD(aCamReg,{'STR->cTxtGetStr','NUMERO DE LA PLACA'})
       AADD(aCamReg,{'STR->nLenGetStr',27})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DE LA PLACA'})
       AADD(aCamReg,{'STR->cTitPrnStr','PLACA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Cat'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','cTipVehCat'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','Tipo de Veh¡culo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIPO;VEHICULO'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIPO DE VEHICULO'})
       AADD(aCamReg,{'STR->nLenGetStr',27})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIPO DE VEHICULO'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Veh'})
       AADD(aCamReg,{'STR->cTemCamStr','Tve'})
       AADD(aCamReg,{'STR->Field_Name','dIniPakVeh'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!D'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha Inicial de Parqueo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','INICIO;PARQUEO'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA DE INICIO DEL PARQUEO'})
       AADD(aCamReg,{'STR->nLenGetStr',27})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DE INICIO DEL PARQUEO'})
       AADD(aCamReg,{'STR->cTitPrnStr','F.INICIO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Veh'})
       AADD(aCamReg,{'STR->cTemCamStr','Tve'})
       AADD(aCamReg,{'STR->Field_Name','dFinPakVeh'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!D'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha Final de Parqueo'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FIN DEL;PARQUEO'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA DE FINAL DEL PARQUEO'})
       AADD(aCamReg,{'STR->nLenGetStr',27})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DE FINAL DEL PARQUEO'})
       AADD(aCamReg,{'STR->cTitPrnStr','F.FINAL'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Veh'})
       AADD(aCamReg,{'STR->cTemCamStr','Tve'})
       AADD(aCamReg,{'STR->Field_Name','cDocDueVeh'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,16})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Documento del Due¤o '})
       AADD(aCamReg,{'STR->cTxtBrwStr','DOCUMENTO;DEL DUE¥O'})
       AADD(aCamReg,{'STR->cTxtGetStr','DOCUMENTO DEL DUE¥O'})
       AADD(aCamReg,{'STR->nLenGetStr',27})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL DOCUMENTO DEL DUE¥O'})
       AADD(aCamReg,{'STR->cTitPrnStr','DOC DUE¥O'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Veh'})
       AADD(aCamReg,{'STR->cTemCamStr','Tve'})
       AADD(aCamReg,{'STR->Field_Name','cTipNitVeh'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,1})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Tipo del Documento del Due¤o'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIPO DE;DOCUMENTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIPO DE DOCUMENTO'})
       AADD(aCamReg,{'STR->nLenGetStr',27})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIPO DE DOCUMENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Reg'})
       AADD(aCamReg,{'STR->cTemCamStr','Tre'})
       AADD(aCamReg,{'STR->Field_Name','nNroFacReg'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,9})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Numero del Recibo del Pago'})
       AADD(aCamReg,{'STR->cTxtBrwStr','RECIBO;PAGO'})
       AADD(aCamReg,{'STR->cTxtGetStr','RECIBO DE PAGO'})
       AADD(aCamReg,{'STR->nLenGetStr',27})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DEL RECIBO DEL PAGO'})
       AADD(aCamReg,{'STR->cTitPrnStr','REC.PAGO'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: CAJA                                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 28/2005 JUE A
       Colombia, Bucaramanga        INICIO: 04:45 PM   JUL 28/2005 JUE

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrPakCaj(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Caj'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','nCodigoCaj'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero de la Caja'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CAJA'})
       AADD(aCamReg,{'STR->cTxtGetStr','CAJA No.'})
       AADD(aCamReg,{'STR->nLenGetStr',16})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DE LA CAJA'})
       AADD(aCamReg,{'STR->cTitPrnStr','CAJA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Caj'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','nVlrTotCaj'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor Total en Caja'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR EN CAJA'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR EN CAJA'})
       AADD(aCamReg,{'STR->nLenGetStr',16})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR EN CAJA'})
       AADD(aCamReg,{'STR->cTitPrnStr','VLR TOTAL'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Caj'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','nVlrBasCaj'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor Base en Caja'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR BASE'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR BASE'})
       AADD(aCamReg,{'STR->nLenGetStr',16})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR BASE EN CAJA'})
       AADD(aCamReg,{'STR->cTitPrnStr','VLR BASE'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Caj'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','dFecIniCaj'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!D'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha de Inicio de Caja'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;INICIO'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA DEL INICIO'})
       AADD(aCamReg,{'STR->nLenGetStr',16})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DEL INICIO DE LA CAJA'})
       AADD(aCamReg,{'STR->cTitPrnStr','F.INICIO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Caj'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','cHorIniCaj'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,08})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Hora de Inicio de la caja'})
       AADD(aCamReg,{'STR->cTxtBrwStr','HORA;INICIO'})
       AADD(aCamReg,{'STR->cTxtGetStr','HORA DE INICIO'})
       AADD(aCamReg,{'STR->nLenGetStr',16})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA HORA DE INICIO DE LA CAJA'})
       AADD(aCamReg,{'STR->cTitPrnStr','H. INICIO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Caj'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','cCajeroCaj'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,10})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'10'})
       AADD(aCamReg,{'STR->Field_Val' ,.F.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nombre del Cajero'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CAJERO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CAJERO'})
       AADD(aCamReg,{'STR->nLenGetStr',16})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NOMBRE DEL CAJERO'})
       AADD(aCamReg,{'STR->cTitPrnStr','CAJERO'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: RETIROS DE CAJA                                              *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 29/2005 JUE A
       Colombia, Bucaramanga        INICIO: 09:45 PM   JUL 29/2005 JUE

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrPakRCa(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Rca'})
       AADD(aCamReg,{'STR->cTemCamStr','Trc'})
       AADD(aCamReg,{'STR->Field_Name','nCodigoCaj'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','N£mero de la Caja'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CAJA;NUMERO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CAJA No.'})
       AADD(aCamReg,{'STR->nLenGetStr',16})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NUMERO DE LA CAJA'})
       AADD(aCamReg,{'STR->cTitPrnStr','CAJA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Rca'})
       AADD(aCamReg,{'STR->cTemCamStr','Trc'})
       AADD(aCamReg,{'STR->Field_Name','nVlrRetRca'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,12})
       AADD(aCamReg,{'STR->Field_Dec' ,2})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999999.99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Valor del Retiro en Caja'})
       AADD(aCamReg,{'STR->cTxtBrwStr','VALOR;RETIRADO'})
       AADD(aCamReg,{'STR->cTxtGetStr','VALOR RETIRADO'})
       AADD(aCamReg,{'STR->nLenGetStr',16})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL VALOR RETIRADO'})
       AADD(aCamReg,{'STR->cTitPrnStr','VLR TOTAL'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Rca'})
       AADD(aCamReg,{'STR->cTemCamStr','Trc'})
       AADD(aCamReg,{'STR->Field_Name','dFecRetRca'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!D'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha de Retiro de Caja'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;RETIRO'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA DE RETIRO'})
       AADD(aCamReg,{'STR->nLenGetStr',16})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DEL RETIRO DE CAJA'})
       AADD(aCamReg,{'STR->cTitPrnStr','F.RETIRO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Rca'})
       AADD(aCamReg,{'STR->cTemCamStr','Trc'})
       AADD(aCamReg,{'STR->Field_Name','cHorRetRca'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,08})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Hora del Retiro de caja'})
       AADD(aCamReg,{'STR->cTxtBrwStr','HORA;RETIRO'})
       AADD(aCamReg,{'STR->cTxtGetStr','HORA DEL RETIRO'})
       AADD(aCamReg,{'STR->nLenGetStr',16})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA HORA DEL RETIRO DE CAJA'})
       AADD(aCamReg,{'STR->cTitPrnStr','H. RETIRO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Caj'})
       AADD(aCamReg,{'STR->cTemCamStr','Tca'})
       AADD(aCamReg,{'STR->Field_Name','cCajeroCaj'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,10})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'10'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nombre del Cajero'})
       AADD(aCamReg,{'STR->cTxtBrwStr','NOMBRE;CAJERO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CAJERO'})
       AADD(aCamReg,{'STR->nLenGetStr',16})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NOMBRE DEL CAJERO'})
       AADD(aCamReg,{'STR->cTitPrnStr','CAJERO'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA