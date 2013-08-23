/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		      ARCHIVO DE CONCEPTOS DE ESTUDIANTES

/*************************************************************************
* TITULO..: GRABACION MESES PAGADOS DE LOS CONCEPTOS                     *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE 16/2005 DOM A
       Bucaramanga, Colombia	    INICIO: 04:30 PM   ENE 16/2005 DOM

OBJETIVOS:

1- Graba el estado de los meses pagados de los conceptos individuales.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cMesPagCoE(lShared,cCodEst,cConcep,nMesIni,cIniFin,cForPag)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos
       cCodEst                              // C¢digo del Estudiante
       cConcep                              // Conceptos facturados
       nMesIni                              // Mes Inicial del Pago
       cIniFin                              // Mes Inicial y Final facturados
       cForPag                              // Forma de Pago */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL     i,j := 0                   // Contadores
       LOCAL cMesIni := ''                  // Mes Inicial
       LOCAL nMesFin := 0                   // Mes Final
       LOCAL cMeses  := ''                  // Meses facturados

       LOCAL cCodigoTco := ''               // C¢digo del Concepto
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DE DECISION
       IF EMPTY(cIniFin)

	  cIniFin := ''
	  FOR i := 1 TO LEN(ALLTRIM(cConcep))/2

	      cMesIni := STR(nMesIni,2)
	      lCorrecion(@cMesIni,.T.)

	      cIniFin += cMesIni+cMesIni

	  NEXT

       ENDIF
*>>>>FIN ANALISIS DE DECISION

*>>>>GRABACION DE LA FORMA DE PAGO
       FOR i := 1 TO LEN(ALLTRIM(cConcep))/2

***********LOCALIZACION DEL CONCEPTO
	     cCodigoTco := SUBS(cConcep,i*2-1,2)
	     SELECT COE
	     COE->(DBGOTOP())
	     LOCATE FOR COE->cCodigoEst == cCodEst .AND.;
			COE->cCodigoCon == cCodigoTco

	     IF .NOT. COE->(FOUND())
		LOOP
	     ENDIF
***********FIN LOCALIZACION DEL CONCEPTO

***********MES INICIAL Y FINAL DEL CONCEPTO
	     cMeses  := SUBS(cIniFin,i*4-3,4)
	     nMesIni := VAL(SUBS(cMeses,1,2))
	     nMesFin := VAL(SUBS(cMeses,3,2))
	     IF cForPag == 'D'
		nMesFin := nMesIni
	     ENDIF
***********FIN MES INICIAL Y FINAL DEL CONCEPTO

***********GRABACION DE LA FORMA DE PAGO
	    IF COE->(lRegLock(lShared,.F.))

	       FOR j := nMesIni TO nMesFin
		   REPL COE->cMesPagCli;
			WITH STUFF(COE->cMesPagCli,j,1,cForPag)
	       NEXT
	       COE->(DBCOMMIT())

	    ELSE
	       cError('NO SE GRABA LA FORMA DE PAGO DE LOS CONCEPTOS')
	    ENDIF
	    IF lShared
	       COE->(DBUNLOCK())
	    ENDIF
***********FIN GRABACION DE LA FORMA DE PAGO

       NEXT
       RETURN NIL
*>>>>FIN GRABACION DE LA FORMA DE PAGO

/*************************************************************************
* TITULO..: VALIDAR CONCEPTOS INDIVIDUALES                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE 21/2005 VIE A
       Bucaramanga, Colombia	    INICIO: 10:30 AM   ENE 21/2005 VIE

OBJETIVOS:

1- Valida la aplicaci¢n de los conceptos individuales

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lHayConCoE(cCodEst,cConcep)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante
       cConcep			            // Conceptos Individuales */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contadores
       LOCAL lHayCoE := .F.                 // .T. Hay Conceptos

       LOCAL cCodigoTco := ''               // C¢digo del Concepto
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CONCEPTO INDIVIDUAL
       FOR i := 1 TO LEN(ALLTRIM(cConcep))/2

***********LOCALIZACION DEL CONCEPTO
	     cCodigoTco := SUBS(cConcep,i*2-1,2)
	     SELECT COE
	     COE->(DBGOTOP())
	     LOCATE FOR COE->cCodigoEst == cCodEst .AND.;
			COE->cCodigoCon == cCodigoTco

	     IF COE->(FOUND())
		lHayCoE := .T.
		EXIT
	     ENDIF
***********FIN LOCALIZACION DEL CONCEPTO

       NEXT
       RETURN lHayCoE
*>>>>FIN VALIDACION DEL CONCEPTO INDIVIDUAL

/*************************************************************************
* TITULO..: GRABAR CONCEPTOS INDIVIDUALES                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 03/2005 JUE A
       Bucaramanga, Colombia	    INICIO: 10:00 AM   FEB 03/2005 JUE

OBJETIVOS:

1- Graba todos los conceptos que no que no figuren en el control individual
   de conceptos

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION SaveConCoE(lShared,cNomUsr,cCodEst,nMesIni,nMesFin,cConcep,cMesPag)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos
       cNomUsr                              // Nombre del Usuario
       cCodEst                              // C¢digo del Estudiante
       nMesIni                              // Mes Inicial
       nMesFin                              // Mes Final
       cConcep			            // Conceptos a facturar
       cMesPag                              // Control de meses pagados */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contadores

       LOCAL cCodigoTco := ''               // C¢digo del Concepto
       LOCAL nMesIniTco := 0                // Mes Inicial del Concepto
       LOCAL nMesFinTco := 0                // Mes Final del Concepto
*>>>>FIN DECLARACION DE VARIABLES

*>>>>GRABACION DE LOS CONCEPTOS
       FOR i := 1 TO LEN(ALLTRIM(cConcep))/2

***********LOCALIZACION DEL CONCEPTO
	     cCodigoTco := SUBS(cConcep,i*2-1,2)
	     SELECT COE
	     COE->(DBGOTOP())
	     LOCATE FOR COE->cCodigoEst == cCodEst .AND.;
			COE->cCodigoCon == cCodigoTco

	     IF COE->(FOUND())
		LOOP
	     ENDIF
***********FIN LOCALIZACION DEL CONCEPTO

***********LOCALIZACION DEL CONCEPTO
	     IF lLocCodigo('cCodigoCon','CON',cCodigoTco)
		IF CON->nMesIniCon == 0 .AND. CON->nMesFinCon == 0
		   nMesIniTco := nMesIni
		   nMesFinTco := nMesFin
		ELSE
		   nMesIniTco := CON->nMesIniCon
		   nMesFinTco := CON->nMesFinCon
		ENDIF

	     ELSE
		nMesIniTco := nMesIni
		nMesFinTco := nMesFin
	     ENDIF

	     IF nMesFinTco < nMesIni
		nMesFinTco := nMesIni
	     ENDIF
	    *ÀValidacion del mes final
***********FIN LOCALIZACION DEL CONCEPTO

***********GRABACION DEL CONCEPTO
	     cMesPag := IF(EMPTY(cMesPag),'',cMesPag)
	     IF COE->(lRegLock(lShared,.T.))

		REPL COE->nIdeCodCoE WITH COE->(RECNO())
		REPL COE->cCodigoEst WITH cCodEst
		REPL COE->cCodigoCon WITH cCodigoTco
		REPL COE->nMesIniPag WITH nMesIni
		REPL COE->nMesFinPag WITH nMesFinTco
		REPL COE->cMesPagCli WITH cMesPag

		REPL COE->cNomUsrCoE WITH cNomUsr
		REPL COE->dFecUsrCoE WITH DATE()
		REPL COE->cHorUsrCoE WITH TIME()

		COE->(DBCOMMIT())

	     ELSE
		cError('NO SE GRABA LA FORMA DE PAGO DE LOS CONCEPTOS')
	     ENDIF
	     IF lShared
		COE->(DBUNLOCK())
	     ENDIF
***********FIN GRABACION DEL CONCEPTO

       NEXT
       RETURN NIL
*>>>>FIN GRABACION DE LOS CONCEPTOS

/*************************************************************************
* TITULO..: ORDENAR EL ARCHIVO POR ESTUDIANTE                            *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 14/2005 LUN A
       Colombia, Bucaramanga        INICIO: 05:30 PM   FEB 14/2005 LUN

OBJETIVOS:

1- Ordena el archivo por c¢digo del estudiante.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OrdenaCoE(lShared,FileCoE,oBrowse)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Sistema Compartido
       FileCoE                              // Archivo de Conceptos Individuales
       oBrowse			            // Browse del Archivo */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>VALIDACION DEL CONTENIDO
       IF !EMPTY(oBrowse)
	  IF COE->(RECCOUNT()) == 0
	     RETURN NIL
	  ENDIF
       ENDIF
       CloseDbf('COE')
*>>>>FIN VALIDACION DEL CONTENIDO

*>>>>ORDENACION DEL ARCHIVO
       IF !lOrdFile(lShared,FileCoE,'cCodigoEst')
*	  cError('NO SE ORDENO EL ARCHIVO')
       ENDIF
*>>>>FIN ORDENACION DEL ARCHIVO

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbf(.T.,FileCoE,'COE',NIL,lShared)
	  cError('ABRIENDO EL ARCHIVO CONCEPTOS INDIVIDUALES')
	  RETURN NIL
       ENDIF
       SELECT COE
       IF !EMPTY(oBrowse)
	  oBrowse:GOTOP()
	  oBrowse:FORCESTABLE()
       ENDIF
       RETURN NIL
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO