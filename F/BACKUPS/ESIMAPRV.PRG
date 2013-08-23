/*************************************************************************
* TITULO..: LOCALIZACION DEL DOCUMENTO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 30/2004 VIE A
       Colombia, Bucaramanga        INICIO: 03:40 PM   OCT 30/2004 VIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Localiza el documento de identidad junto con el tipo de documento

3- Deja el archivo en el registro localizado

4- Retorna .F. el resultado de la busqueda

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lLocDocPrv(cDocNit,cTipDoc)

*>>>>DESCRIPCION DE PARAMETROS
/*     cDocNit                              // Documento de Identidad
       cTipDoc                              // Tipo de Documento */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lExiste := .T.                 // .T. Existe el c¢digo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DEL CODIGO
       SELECT PRV
       PRV->(DBGOTOP())
       LOCATE FOR PRV->cDocNitPrv == cDocNit .AND.;
		  PRV->cTipNitPrv == cTipDoc

       IF .NOT. FOUND()
	  lExiste := .F.
       ENDIF
       RETURN lExiste
*>>>>FIN LOCALIZACION DEL CODIGO