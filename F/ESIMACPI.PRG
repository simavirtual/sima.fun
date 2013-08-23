/*************************************************************************
* TITULO..: LOCALIZACION DEL ITEM DEL COMPROBANTE                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 03/2004 MIE A
       Colombia, Bucaramanga        INICIO: 02:30 PM   NOV 03/2004 MIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Localiza el numero del comprobante junto con el numero de la factura

3- Deja el archivo en el registro localizado

4- Retorna .F. el resultado de la busqueda

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lLocateCpI(nNroCpB,cCodFac)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroCpB			      // N£mero del Comprobante
       cCodFac			      // C¢digo de la Factura */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lExiste := .T.                 // .T. Existe el c¢digo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DEL CODIGO
       SELECT CPI
       CPI->(DBGOTOP())
       LOCATE FOR CPI->nNroCpBCpI == nNroCpB .AND.;
		  CPI->cCodFacCpI == cCodFac

       IF .NOT. FOUND()
	  lExiste := .F.
       ENDIF
       RETURN lExiste
*>>>>FIN LOCALIZACION DEL CODIGO