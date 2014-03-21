/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 31/2013 JUE A
       Colombia, Bucaramanga        INICIO:  9:49 AM   OCT 31/2013 JUE

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfCnc(lShared,nModCry,PathArc,fArchvo,aStrDbf)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       PathArc                              // Path del Archivo
       fArchvo                              // Nombre del Archivo
       aStrDbf                              // Estructura del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL PathAct := ''                  // Path Actual

       LOCAL       i := 0                   // Contador
       LOCAL aDbfStr := {}                  // Estructura del Archivo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DE LA ESTRUCTURA
       AADD(aDbfStr,{'nIdeCodCnc','Numeric'  ,16,0}) // Ide del Registro
      *Llave Principal

       AADD(aDbfStr,{'nNroMesCnc','Numeric',2,0}) // Mes
       AADD(aDbfStr,{'nTotCauCnc','Numeric',14,2}) // CAUSACION
       AADD(aDbfStr,{'nCauValCnc','Numeric',14,2}) // CAUSACION VALIDADA
       AADD(aDbfStr,{'nTotPagCnc','Numeric',14,2}) // PAGOS
       AADD(aDbfStr,{'nPagValCnc','Numeric',14,2}) // PAGOS VALIDADOS
       AADD(aDbfStr,{'lReportCnc','Logical',1,0}) // Reporte a la Contabilidad

       AADD(aDbfStr,{'cNomUsrCnc','Character',10,0}) // Nombre del Usuario
       AADD(aDbfStr,{'dFecUsrCnc','Date'     ,08,0}) // Fecha del Usuario
       AADD(aDbfStr,{'cHorUsrCnc','Character',10,0}) // Hora del Usuario
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
       FOR i := 1 TO 12

	 IF ARC->(lRegLock(lShared,.T.))
	    REPL ARC->nNroMesCnc WITH i

	    REPL ARC->cNomUsrCnc WITH 'system'
	    REPL ARC->dFecUsrCnc WITH DATE()
	    REPL ARC->cHorUsrCnc WITH TIME()
	    REPL ARC->nIdeCodCnc WITH RECNO()
	    ARC->(DBCOMMIT())
	 ELSE
	    WAIT 'NO SE GRABA EL REGISTRO INICIAL DE LA CONFIGURACION'
	 ENDIF

       ENDFOR
       IF lShared
	  ARC->(DBUNLOCK())
       ENDIF
       CloseDbf('ARC',PathArc+'\'+fArchvo,nModCry)
       RETURN NIL
*>>>>FIN GRABACION DE LOS PARAMETROS POR DEFECTO

/*************************************************************************
* TITULO..: GRABACION DE lA CAUSACION                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 30/2013 LUN A
       Colombia, Bucaramanga        INICIO: 11:50 AM   OCT 30/2013 LUN

OBJETIVOS:

1- Graba el total de la causaci¢n.

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lSavTotCau(nNroMes,nTotCua,lShared,lInsReg,cNomUsr)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroMes                              // N£mero del Mes
       nTotCua                              // Total Causaci¢n
       lShared                              // .T. Sistema Compartido
       lInsReg                              // .T. Insertar Registro
       cNomUsr                              // Nombre del Usuario */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>GRABACION DEL REGISTRO
       lInsReg := IF(lInsReg == NIL,.F.,lInsReg)

       IF lLocCodigo('nNroMesCnc','CNC',nNroMes)

	  IF CNC->(lRegLock(lShared,lInsReg))

	     IF !CNC->lReportCnc

		REPL CNC->nTotCauCnc WITH nTotCua

		CNC->(DBCOMMIT())

	     ENDIF

	  ENDIF

	  IF lShared
	     CNC->(DBUNLOCK())
	  ENDIF

       ENDIF
       RETURN NIL
*>>>>FIN GRABACION DEL REGISTRO

/*************************************************************************
* TITULO..: GRABACION DE lA CAUSACION VALIDADA                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 31/2013 LUN A
       Colombia, Bucaramanga        INICIO: 02:50 AM   OCT 31/2013 LUN

OBJETIVOS:

1- Graba el total de la validada.

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lSavCauVal(nNroMes,nCauVal,lShared,lInsReg,cNomUsr)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroMes                              // N£mero del Mes
       nCauVal			      // Total Causaci¢n
       lShared                              // .T. Sistema Compartido
       lInsReg                              // .T. Insertar Registro
       cNomUsr                              // Nombre del Usuario */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>GRABACION DEL REGISTRO
       lInsReg := IF(lInsReg == NIL,.F.,lInsReg)

       IF lLocCodigo('nNroMesCnc','CNC',nNroMes)

	  IF CNC->(lRegLock(lShared,lInsReg))

	     IF !CNC->lReportCnc

		REPL CNC->nCauValCnc WITH nCauVal

		CNC->(DBCOMMIT())

	     ENDIF

	  ENDIF

	  IF lShared
	     CNC->(DBUNLOCK())
	  ENDIF

       ENDIF
       RETURN NIL
*>>>>FIN GRABACION DEL REGISTRO


/*************************************************************************
* TITULO..: GRABACION DE LOS PAGOS DEL MES                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 18/2014 LUN A
       Colombia, Bucaramanga        INICIO: 19:45 AM   NOV 18/2014 LUN

OBJETIVOS:

1- Graba el total de los pagos del mes.

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lSavTotPag(nNroMes,nTotPag,lShared,lInsReg,cNomUsr)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroMes                              // N£mero del Mes
       nTotPag                              // Total Pagos
       lShared                              // .T. Sistema Compartido
       lInsReg                              // .T. Insertar Registro
       cNomUsr                              // Nombre del Usuario */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>GRABACION DEL REGISTRO
       lInsReg := IF(lInsReg == NIL,.F.,lInsReg)

       IF lLocCodigo('nNroMesCnc','CNC',nNroMes)

	  IF CNC->(lRegLock(lShared,lInsReg))

	     IF !CNC->lReportCnc

		REPL CNC->nTotPagCnc WITH nTotPag

		CNC->(DBCOMMIT())

	     ENDIF

	  ENDIF

	  IF lShared
	     CNC->(DBUNLOCK())
	  ENDIF

       ENDIF
       RETURN NIL
*>>>>FIN GRABACION DEL REGISTRO

/*************************************************************************
* TITULO..: GRABACION DE LOS PAGOS DEL MES VALIDADOS                     *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 18/2014 LUN A
       Colombia, Bucaramanga        INICIO: 11:00 AM   NOV 18/2014 LUN

OBJETIVOS:

1- Graba el total de los pagos del mes validados.

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/


FUNCTION lSavPagVal(nNroMes,nPagVal,lShared,lInsReg,cNomUsr)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroMes                              // N£mero del Mes
       nPagVal                              // Total Pagos validados
       lShared                              // .T. Sistema Compartido
       lInsReg                              // .T. Insertar Registro
       cNomUsr                              // Nombre del Usuario */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>GRABACION DEL REGISTRO
       lInsReg := IF(lInsReg == NIL,.F.,lInsReg)

       IF lLocCodigo('nNroMesCnc','CNC',nNroMes)

	  IF CNC->(lRegLock(lShared,lInsReg))

	     IF !CNC->lReportCnc

		REPL CNC->nPagValCnc WITH nPagVal

		CNC->(DBCOMMIT())

	     ENDIF

	  ENDIF

	  IF lShared
	     CNC->(DBUNLOCK())
	  ENDIF

       ENDIF
       RETURN NIL
*>>>>FIN GRABACION DEL REGISTRO