/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC  6/2005 MAR A
       Colombia, Bucaramanga        INICIO:  1:48 PM   DIC  6/2005 MAR

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfTrc(lShared,nModCry,PathArc,fArchvo,aStrDbf)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       PathArc                              // Path del Archivo
       fArchvo                              // Nombre del Archivo
       aStrDbf                              // Estructura del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL PathAct := ''                  // Path Actual

       LOCAL aDbfStr := {}                  // Estructura del Archivo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DE LA ESTRUCTURA
       AADD(aDbfStr,{'nIdeCodTrc','Numeric'  ,16,0}) // Ide del Registro
      *Llave Principal

       AADD(aDbfStr,{'cCodigoTrc','Character',2,0}) // C¢digo del Recibo
       AADD(aDbfStr,{'cNombreTrc','Character',16,0}) // Nombre del Tipo de Recibo
       AADD(aDbfStr,{'cCodigoBan','Character',2,0}) // C¢digo del Banco

       AADD(aDbfStr,{'cNomUsrTrc','Character',10,0}) // Nombre del Usuario
       AADD(aDbfStr,{'dFecUsrTrc','Date'     ,08,0}) // Fecha del Usuario
       AADD(aDbfStr,{'cHorUsrTrc','Character',10,0}) // Hora del Usuario
*>>>>FIN CREACION DE LA ESTRUCTURA

*>>>>RETORNO DE LA ESTRUCTURA
       IF !EMPTY(aStrDbf)
          aStrDbf := aDbfStr
          RETURN NIL
       ENDIF
*>>>>FIN RETORNO DE LA ESTRUCTURA

*>>>>CREACION DE LA ESTRUCTURA
       PathAct := cPathAct()
       DO CASE
       CASE nCd(PathArc) == 0
            DBCREATE(fArchvo,aDbfStr,'DBFNTX')

       CASE nCd(PathArc) == -3
            cError('NO EXISTE EL DIRECTORIO: '+PathArc)

       CASE nCd(PathArc) == -5
            cError('NO TIENE DERECHOS EN: '+PathArc)
       ENDCASE
       nCd(PathAct)
*>>>>FIN CREACION DE LA ESTRUCTURA

*>>>>SELECCION DE LAS AREAS DE TRABAJO
       IF !lUseDbf(.T.,PathArc+'\'+fArchvo,'ARC',NIL,lShared,nModCry)
	  WAIT 'ABRIENDO EL ARCHIVO DE CONFIGURACION DE CARTERA'
	  CloseDbf('ARC',PathArc+'\'+fArchvo,nModCry)
	  RETURN NIL
       ENDIF
*>>>>FIN SELECCION DE LAS AREAS DE TRABAJO

*>>>>GRABACION DE LOS PARAMETROS POR DEFECTO
       IF ARC->(lRegLock(lShared,.T.))

	  REPL ARC->cCodigoTrc WITH '13'
	  REPL ARC->cNombreTrc WITH 'MATRICULAS'
	  REPL ARC->cCodigoBan WITH '01'

	  REPL ARC->cNomUsrTrc WITH 'system'
	  REPL ARC->dFecUsrTrc WITH DATE()
	  REPL ARC->cHorUsrTrc WITH TIME()
	  REPL ARC->nIdeCodTrc WITH ARC->(RECNO())
	  ARC->(DBCOMMIT())
       ELSE
	  WAIT 'NO SE GRABA EL REGISTRO INICIAL DE LA CONFIGURACION'
       ENDIF

       IF lShared
	  ARC->(DBUNLOCK())
       ENDIF
       CloseDbf('ARC',PathArc+'\'+fArchvo,nModCry)
       RETURN NIL
*>>>>FIN GRABACION DE LOS PARAMETROS POR DEFECTO