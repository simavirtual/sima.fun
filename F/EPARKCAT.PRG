/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 28/2005 JUE A
       Colombia, Bucaramanga        INICIO:  9:00 AM   JUL 28/2005 JUE

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfCat(lShared,nModCry,PathArc,fArchvo,aStrDbf)

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

       LOCAL       i := 0                   // Contador
       LOCAL cTipVeh := ''                  // Tipo de Categor¡a
       LOCAL cNomCat := ''                  // Nombre de la Categor¡a
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DE LA ESTRUCTURA
       AADD(aDbfStr,{'nIdeCodCat','Numeric'  ,16,0}) // Ide del Registro
      *Llave Principal

       AADD(aDbfStr,{'cTipVehCat','Character',2,0}) // Tipo de Veh¡culo
       AADD(aDbfStr,{'cNombreCat','Character',20,0}) // Nombre del Tipo
       AADD(aDbfStr,{'nVlrFDiCat','Numeric',12,2}) // Valor de la Fracci¢n Diurna
       AADD(aDbfStr,{'nVlrFNoCat','Numeric',12,2}) // Valor de la Fracci¢n Nocturna
       AADD(aDbfStr,{'nVlrSegCat','Numeric',12,2}) // Valor del segundo
       AADD(aDbfStr,{'nVlrMDiCat','Numeric',12,2}) // Valor minuto diurno
       AADD(aDbfStr,{'nVlrMNoCat','Numeric',12,2}) // Valor minuto nocturno
       AADD(aDbfStr,{'nVlrHDiCat','Numeric',12,2}) // Valor de la Hora Diurna
       AADD(aDbfStr,{'nVlrHNoCat','Numeric',12,2}) // Valor de la Hora Nocturna
       AADD(aDbfStr,{'nVlrDiaCat','Numeric',12,2}) // Valor del D¡a
       AADD(aDbfStr,{'nVlrMesCat','Numeric',12,2}) // Valor del Mes
       AADD(aDbfStr,{'nVlrAnoCat','Numeric',12,2}) // Valor del A¤o

       AADD(aDbfStr,{'cNomUsrCat','Character',10,0}) // Nombre del Usuario
       AADD(aDbfStr,{'dFecUsrCat','Date'     ,08,0}) // Fecha del Usuario
       AADD(aDbfStr,{'cHorUsrCat','Character',10,0}) // Hora del Usuario
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
       FOR i := 1 TO 3

	 cTipVeh := STR(i,2)
	 lCorrecion(@cTipVeh)

	 DO CASE
	 CASE i == 1
	      cNomCat := 'MOTO'
	 CASE i == 2
	      cNomCat := 'VEHI'
	 CASE i == 3
	      cNomCat := 'BICI'
	 ENDCASE

	 IF ARC->(lRegLock(lShared,.T.))
	    REPL ARC->cTipVehCat WITH cTipVeh
	    REPL ARC->cNombreCat WITH cNomCat
	    REPL ARC->cNomUsrCat WITH 'system'
	    REPL ARC->dFecUsrCat WITH DATE()
	    REPL ARC->cHorUsrCat WITH TIME()
	    REPL ARC->nIdeCodCat WITH RECNO()
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
* TITULO..: SELECCION DEL CODIGO                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 15/2005 JUE A
       Colombia, Bucaramanga        INICIO:  3:36 PM   SEP 15/2005 JUE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Permite escoger el registro de acuerdo al c¢digo o descripci¢n

3- Retorna el n£mero del registro escogido

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSelCat(nNroFil,nNroCol)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // N£mero de la fila
       nNroCol                              // N£mero de la Columna */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL nFilSup := 0                   // Fila superior
       LOCAL nColSup := 0                   // Colunma superior
       LOCAL nFilInf := 0                   // Fila inferior
       LOCAL nColInf := 0                   // Columna inferior
       LOCAL nNroReg := 0                   // N£mero del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       IF CAT->(RECCOUNT()) == 0
          cError('NO EXISTEN REGISTROS GRABADOS')
          RETURN 0
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>INICIALIZACION DE LAS COORDENADAS
       SELECT CAT
       nFilSup := nNroFil+1
       nColSup := nNroCol+2
       IF nFilSup+RECCOUNT() > 22
          nFilInf := 22
       ELSE
          nFilInf := nFilSup + RECCOUNT()
       ENDIF
       nColInf := nColSup+18
*>>>>FIN INICIALIZACION DE LAS COORDENADAS

*>>>>SELECCION DEL CODIGO
       CAT->(DBGOTOP())
       cSavPan := SAVESCREEN(0,0,24,79)
       @ nFilSup-1,nColSup-1 TO nFilInf,nColInf+1 DOUBLE
       nNroReg := nBrowseDbf(nFilSup,nColSup,nFilInf-1,nColInf,;
			     {||CAT->cNombreCat})
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN nNroReg
*>>>>FIN SELECCION DEL CODIGO

/*************************************************************************
* TITULO..: LIQUIDAR POR CATEGORIA                                       *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 01/2005 LUN A
       Colombia, Bucaramanga        INICIO: 08:10 PM   AGO 01/2005 LUN

OBJETIVOS:

1- Verifica la liquidaci¢n del servicio del parqueadero por cateroria

2- Retorna .T. Por Categoria

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValorCat()

*>>>>DECLARACION DE VARIABLES
       LOCAL lSiorNo := .F.                 // Variable de decision
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LIQUIDACION POR CATEGORIA
       IF CAT->nVlrFDiCat # 0 .AND.;
	  CAT->nVlrFNoCat # 0 .AND.;
	  CAT->nVlrHDiCat # 0 .AND.;
	  CAT->nVlrHNoCat # 0 .AND.;
	  CAT->nVlrDiaCat # 0 .AND.;
	  CAT->nVlrMesCat # 0 .AND.;
	  CAT->nVlrAnoCat # 0
	  lSiorNo := .T.
       ENDIF
       RETURN lSiorNo
*>>>>FIN LIQUIDACION POR CATEGORIA

/*************************************************************************
* TITULO..: LIQUIDAR POR TARIFAS                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 01/2005 LUN A
       Colombia, Bucaramanga        INICIO: 08:30 PM   AGO 01/2005 LUN

OBJETIVOS:

1- Verifica la liquidaci¢n del servicio del parqueadero por tarifas

2- Retorna .T. Por tarifas

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValorTar()

*>>>>DECLARACION DE VARIABLES
       LOCAL lSiorNo := .F.                 // Variable de decision
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LIQUIDACION POR CATEGORIA
       IF CAT->nVlrFDiCat == 0 .AND.;
	  CAT->nVlrFNoCat == 0 .AND.;
	  CAT->nVlrHDiCat == 0 .AND.;
	  CAT->nVlrHNoCat == 0 .AND.;
	  CAT->nVlrDiaCat == 0 .AND.;
	  CAT->nVlrMesCat == 0 .AND.;
	  CAT->nVlrAnoCat == 0
	  lSiorNo := .T.
       ENDIF
       RETURN lSiorNo
*>>>>FIN LIQUIDACION POR CATEGORIA