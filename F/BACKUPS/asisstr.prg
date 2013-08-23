/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		   BIBLIOTECAS DE FUNCIONES DE ESTRUCTURAS
		       SISTEMA DE CONTROL DE ASISTENCIA

OBJETIVOS:

- Define las funciones para crear las estructuras de los archivos del
  SIMA para el Sistema de Control de Asistencia.

***************************************************************************
*-------------------- ESTRUCTURAS PARA SIMAASIS --------------------------*
**************************************************************************/

/*************************************************************************
* TITULO..: CONTROL DE NOVEDADES DE INGRESO DEL PERSONAL                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 20/2007 MIE A
       Colombia, Bucaramanga        INICIO: 11:30 PM   JUN 20/2007 MIE

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrAsiNov(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Nov'})
       AADD(aCamReg,{'STR->cTemCamStr','Tno'})
       AADD(aCamReg,{'STR->Field_Name','cDocPerNov'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,16})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Documento de Identidad'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DOCUMENTO DE;IDENTIDAD'})
       AADD(aCamReg,{'STR->cTxtGetStr','DOCUMENTO DE IDENTIDAD'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL DOCUMENTO DE IDENTIDAD'})
       AADD(aCamReg,{'STR->cTitPrnStr','DOCUMENTO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Nov'})
       AADD(aCamReg,{'STR->cTemCamStr','Tno'})
       AADD(aCamReg,{'STR->Field_Name','cTipNitNov'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,1})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Tipo del Documento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIPO DE;DOCUMENTO'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIPO DE DOCUMENTO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIPO DE DOCUMENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Nov'})
       AADD(aCamReg,{'STR->cTemCamStr','Tno'})
       AADD(aCamReg,{'STR->Field_Name','cCodPnlNov'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Personal'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL PERSONAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODPNL'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Nov'})
       AADD(aCamReg,{'STR->cTemCamStr','Tno'})
       AADD(aCamReg,{'STR->Field_Name','cTipPerNov'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Tipo de persona'})
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
       AADD(aCamReg,{'STR->cNaliasStr','Nov'})
       AADD(aCamReg,{'STR->cTemCamStr','Tno'})
       AADD(aCamReg,{'STR->Field_Name','nIdePerNov'})
       AADD(aCamReg,{'STR->Field_Type','N'})
       AADD(aCamReg,{'STR->Field_Len' ,6})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'9999999999999999'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Ide del Registro de Personas'})
       AADD(aCamReg,{'STR->cTxtBrwStr','IDEPER'})
       AADD(aCamReg,{'STR->cTxtGetStr','IDEPER'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL ID DE LA PERSONA'})
       AADD(aCamReg,{'STR->cTitPrnStr','IDEPER'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Nov'})
       AADD(aCamReg,{'STR->cTemCamStr','Tno'})
       AADD(aCamReg,{'STR->Field_Name','dFecIngNov'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!D'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha de Ingreso'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;INGRESO'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA DE INGRESO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DE INGRESO'})
       AADD(aCamReg,{'STR->cTitPrnStr','F.INGRESO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Nov'})
       AADD(aCamReg,{'STR->cTemCamStr','Tno'})
       AADD(aCamReg,{'STR->Field_Name','dFecOutNov'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,8})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!D'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Fecha de Salida'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA;SALIDA'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA DE SALIDA'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA FECHA DE SALIDA'})
       AADD(aCamReg,{'STR->cTitPrnStr','F.SALIDA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Nov'})
       AADD(aCamReg,{'STR->cTemCamStr','Tno'})
       AADD(aCamReg,{'STR->Field_Name','cHorIngNov'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,08})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Hora de Ingreso'})
       AADD(aCamReg,{'STR->cTxtBrwStr','HORA;INGRESO'})
       AADD(aCamReg,{'STR->cTxtGetStr','HORA DE INGRESO'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA HORA DE INGRESO'})
       AADD(aCamReg,{'STR->cTitPrnStr','H. INGRESO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Nov'})
       AADD(aCamReg,{'STR->cTemCamStr','Tno'})
       AADD(aCamReg,{'STR->Field_Name','cHorOutNov'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,08})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Hora de Salida'})
       AADD(aCamReg,{'STR->cTxtBrwStr','HORA;SALIDA'})
       AADD(aCamReg,{'STR->cTxtGetStr','HORA DE SALIDA'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA HORA DE SALIDA'})
       AADD(aCamReg,{'STR->cTitPrnStr','H. SALIDA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Nov'})
       AADD(aCamReg,{'STR->cTemCamStr','Tno'})
       AADD(aCamReg,{'STR->Field_Name','cTiempoNov'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,22})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Tiempo de Duraci¢n'})
       AADD(aCamReg,{'STR->cTxtBrwStr','TIEMPO;AA:MM:DD:HD:MD:HN:MN:SS'})
       AADD(aCamReg,{'STR->cTxtGetStr','TIEMPO DE DURACION'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIEMPO DE DURACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','TIEMPO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Nov'})
       AADD(aCamReg,{'STR->cTemCamStr','Tno'})
       AADD(aCamReg,{'STR->Field_Name','cNomOfiNov'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,30})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Nombre de la Dependencia'})
       AADD(aCamReg,{'STR->cTxtBrwStr','DEPENDENCIA;VISITADA'})
       AADD(aCamReg,{'STR->cTxtGetStr','DEPENDENCIA'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL NOMBRE DE LA DEPENDENCIA'})
       AADD(aCamReg,{'STR->cTitPrnStr','DEPENDENCIA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Nov'})
       AADD(aCamReg,{'STR->cTemCamStr','Tno'})
       AADD(aCamReg,{'STR->Field_Name','cObservNov'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,60})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Observaci¢n de la Novedad'})
       AADD(aCamReg,{'STR->cTxtBrwStr','OBSERVACION'})
       AADD(aCamReg,{'STR->cTxtGetStr','OBSERVACION'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE LA OBSERVACION'})
       AADD(aCamReg,{'STR->cTitPrnStr','OBSERVACION'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: CONTROL DE ASISTENCIA                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE 24/2008 MIE A
       Colombia, Bucaramanga        INICIO: 11:30 PM   ENE 24/2008 MIE

OBJETIVOS:

1- Define la estructura del archivo

2- Retorna la estructura de un archivo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION StrAsiCtr(fArchvo,cTitArc,aCamGen,aRegIni)

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
       AADD(aCamReg,{'STR->cNaliasStr','Ctr'})
       AADD(aCamReg,{'STR->cTemCamStr','Tct'})
       AADD(aCamReg,{'STR->Field_Name','cCodigoEst'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,06})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Documento de Identidad'})
       AADD(aCamReg,{'STR->cTxtBrwStr','CODIGO;ESTUDIANTE'})
       AADD(aCamReg,{'STR->cTxtGetStr','CODIGOESTUDIANTE'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL DOCUMENTO DE IDENTIDAD'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODIGO'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Ctr'})
       AADD(aCamReg,{'STR->cTemCamStr','Tct'})
       AADD(aCamReg,{'STR->Field_Name','dFecAsiCtr'})
       AADD(aCamReg,{'STR->Field_Type','D'})
       AADD(aCamReg,{'STR->Field_Len' ,08})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@D'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Tipo del Documento'})
       AADD(aCamReg,{'STR->cTxtBrwStr','FECHA DE LA;NOVEDAD'})
       AADD(aCamReg,{'STR->cTxtGetStr','FECHA DE LA NOVEDAD'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL TIPO DE DOCUMENTO'})
       AADD(aCamReg,{'STR->cTitPrnStr','FECHA'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Ctr'})
       AADD(aCamReg,{'STR->cTemCamStr','Tct'})
       AADD(aCamReg,{'STR->Field_Name','cCodHorHra'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'.F.'})
       AADD(aCamReg,{'STR->cDocCamStr','C¢digo del Personal'})
       AADD(aCamReg,{'STR->cTxtBrwStr','HORA'})
       AADD(aCamReg,{'STR->cTxtGetStr','HORA'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','FAVOR INGRESE EL CODIGO DEL PERSONAL'})
       AADD(aCamReg,{'STR->cTitPrnStr','CODPNL'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Ctr'})
       AADD(aCamReg,{'STR->cTemCamStr','Tct'})
       AADD(aCamReg,{'STR->Field_Name','cCodTauTau'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,2})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','Tipo de persona'})
       AADD(aCamReg,{'STR->cTxtBrwStr','cCodigoTau'})
       AADD(aCamReg,{'STR->cTxtGetStr','cCodigoTau'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','cCodigoTau'})
       AADD(aCamReg,{'STR->cTitPrnStr','cCodigoTau'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Ctr'})
       AADD(aCamReg,{'STR->cTemCamStr','Tct'})
       AADD(aCamReg,{'STR->Field_Name','cNomPadCtr'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,70})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'99'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','cNomPadCtr'})
       AADD(aCamReg,{'STR->cTxtBrwStr','cNomPadCtr'})
       AADD(aCamReg,{'STR->cTxtGetStr','cNomPadCtr'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','cNomPadCtr'})
       AADD(aCamReg,{'STR->cTitPrnStr','cNomPadCtr'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Ctr'})
       AADD(aCamReg,{'STR->cTemCamStr','Tct'})
       AADD(aCamReg,{'STR->Field_Name','cNomAutCtr'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,70})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','cNomAutCtr'})
       AADD(aCamReg,{'STR->cTxtBrwStr','cNomAutCtr'})
       AADD(aCamReg,{'STR->cTxtGetStr','cNomAutCtr'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','cNomAutCtr'})
       AADD(aCamReg,{'STR->cTitPrnStr','cNomAutCtr'})
       AADD(aRegIni,aCamReg)

       aCamReg := {}
       aCamReg := ACLONE(aCamGen)
       AADD(aCamReg,{'STR->cNomArcStr',fArchvo})
       AADD(aCamReg,{'STR->cTitArcStr',cTitArc})
       AADD(aCamReg,{'STR->cNaliasStr','Ctr'})
       AADD(aCamReg,{'STR->cTemCamStr','Tct'})
       AADD(aCamReg,{'STR->Field_Name','cObservCtr'})
       AADD(aCamReg,{'STR->Field_Type','C'})
       AADD(aCamReg,{'STR->Field_Len' ,70})
       AADD(aCamReg,{'STR->Field_Dec' ,0})
       AADD(aCamReg,{'STR->Field_Pic' ,'@!'})
       AADD(aCamReg,{'STR->Field_Val' ,.T.})
       AADD(aCamReg,{'STR->Field_Mod' ,'lModReg'})
       AADD(aCamReg,{'STR->cDocCamStr','cObservCtr'})
       AADD(aCamReg,{'STR->cTxtBrwStr','cObservCtr'})
       AADD(aCamReg,{'STR->cTxtGetStr','cObservCtr'})
       AADD(aCamReg,{'STR->nLenGetStr',22})
       AADD(aCamReg,{'STR->cHlpGetStr','cObservCtr'})
       AADD(aCamReg,{'STR->cTitPrnStr','cObservCtr'})
       AADD(aRegIni,aCamReg)

       RETURN NIL
*>>>>FIN DEFINICION DE LA ESTRUCTURA