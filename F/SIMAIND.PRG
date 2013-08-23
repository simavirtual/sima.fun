/*************************************************************************
* TITULO..: INDICADORES DE LA MATERIA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ABR 01/2008 MAR A
       Colombia, Bucaramanga        INICIO: 10:00 AM   ABR 01/2008 MAR

OBJETIVOS:

1- Lee los indicadores de la materia o area.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aIndicaMat(nNroPer,cCodNiv,cCodMat,lIndNiv,;
		    cJuicio,cNotInd,cEvaInd,cNalias)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroPer                              // N£mero del Periodo
       cCodNiv                              // C¢digo del Nivel
       cCodMat                              // C¢digo de la Materia
       lIndNiv                              // .T. Indicadores por nivel
       cJuicio                              // C¢digos de Indicadores
       cNotInd                              // Notas de los Indicadores
       cEvaInd				    // Evaluar el Indicador
       cNalias                              // Alias del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL     i,k := 0                   // Contador
       LOCAL cCodigo := ''                  // C¢digo
       LOCAL lClaEof := .T.                 // Final del Archivo
       LOCAL lEvaEof := .T.                 // Final del Archivo
       LOCAL nRegCla := 0                   // N£mero del Registro
       LOCAL nRegEva := 0                   // N£mero del Registro

       LOCAL cCodInd := ''                  // C¢digo del Indicador
       LOCAL cCodCla := ''                  // C¢digo de la Clase
       LOCAL cReeEva := ''                  // Reevaluar el c¢digo de la Clase. Ej: 01=>Reevalua la clase siempre sale en la recuperaci¢n
       LOCAL cCodEva := ''                  // C¢digo de Evaluaci¢n del Indicador
       LOCAL cEvaRec := ''                  // C¢digo de la Recuperaci¢n del Indicador
       LOCAL cNotEva := ''                  // Nota c¢digo de evaluacion incluyendo la recuperacion
       LOCAL cNomEva := ''                  // Nombre de la Evaluaci¢n
       LOCAL cNomRec := ''                  // Nombre de la Evaluaci¢n de la Recuperaci¢n
       LOCAL cCodNtI := ''                  // C¢digo Nota de los indicadores
       LOCAL cPrnBol := ''                  // Imprimir en el Boletin

       LOCAL cValInd := ''                  // Valoraci¢n del Indicador. SPACES(01)=>No Evaluado 0=>No Aprobado 1=>Aprobado

       LOCAL aJuicio := {}                  // Indicadores para el periodo
       LOCAL cNomInd := ''                  // Nombre del Indicador
       LOCAL aIndica := {}                  // Indicadores
       LOCAL aIndMat := {}                  // Indicadores de la Materia

       LOCAL cCodigoTni := ''               // Codigo del Nivel
       LOCAL cCodigoTma := ''               // C¢digo de la Materia
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DE DECISION
       lClaEof := .F.
       IF CLA->(EOF())
	  lClaEof := .T.
       ELSE
	  nRegCla := CLA->(RECNO())
       ENDIF

       lEvaEof := .F.
       IF EVA->(EOF())
	  lEvaEof := .T.
       ELSE
	  nRegEva := EVA->(RECNO())
       ENDIF
*>>>>FIN ANALISIS DE DECISION

*>>>>RECORRIDO DE LOS INDICADORES
       aJuicio := aJuicio(@cJuicio,.F.)

       FOR i := 1 TO LEN(aJuicio)

***********LECTURA DEL CODIGO DEL INDICADOR
	     cCodigoTni := cCodNiv
	     cCodigoTma := cCodMat

	     cCodigo := aJuicio[i]

	     cCodInd := SUBS(cCodigo,1,4)
	     cCodCla := SUBS(cCodInd,1,1)
	     cCodEva := SUBS(cCodigo,5,1)
	     cEvaRec := SUBS(cCodigo,6,1)

	     IF cCodNtI == NIL
		cCodNtI := SPACE(08)
	     ELSE
		cCodNtI := SUBS(cNotInd,i*8-7,8)
	     ENDIF
***********FIN LECTURA DEL CODIGO DEL INDICADOR

***********LOCALIZAR EL CODIGO DE LA CLASE
	     IF lLocCodigo('cCodigoCla','CLA',cCodCla)
		cNomInd := cTextoInd(cCodigoTni,cCodigoTma,;
				     lIndNiv,cCodInd,cNalias)
		cPrnBol := SUBS(CLA->cPrnBolCla,nNroPer,1)
	     ELSE
		cNomInd := 'CODIGO DE LA CLASE NO EXISTE '+cCodInd
		cPrnBol := '1'
	     ENDIF

	     IF .NOT. EMPTY(CLA->cCodigoMat)
		cCodigoTni := SPACE(02)
		cCodigoTma := CLA->cCodigoMat
	     ENDIF

	     cReeEva := CLA->cReeEvaCla
***********FIN LOCALIZAR EL CODIGO DE LA CLASE

***********ANALISIS DEL INDICADOR
	     cNomEva := ''
	     cNomRec := ''
	     cValInd := '-1'   // Error

	     cNotEva := cCodEva
	     IF cReeEva == '01'
		cNotEva := IF(EMPTY(cEvaRec),cCodEva,cEvaRec)
	     ELSE
	       IF cEvaInd == '0'
		  cNotEva := IF(EMPTY(cEvaRec),cCodEva,cEvaRec)
	       ENDIF
	     *ÀModificado
	     ENDIF

	     IF lLocCodigo('cCodigoEva','EVA',cNotEva)

*===============EVALUAR EL INDICADOR POR REDACION
		  cNomEva := EVA->cNombreEva
		  IF cEvaInd == '0'

		     IF CLA->lRecupeCla
			IF EVA->lSiRecuEva
			   cValInd := '1'   // Si Aprobado
			ELSE
			   cValInd := '0'   // No Aprobado
			ENDIF
		     ELSE
			cValInd := SPACE(01)  // No Evaluado
		     ENDIF

		  ENDIF
*===============FIN EVALUAR EL INDICADOR POR REDACION

*===============EVALUAR EL INDICADOR
		  IF cEvaInd == '1' .OR. cEvaInd == '2'

		     IF EVA->lRecupeEva .AND. CLA->lRecupeCla

			IF EMPTY(cEvaRec)
			   cValInd := '0'   // No Aprobado
			ELSE
			   IF lLocCodigo('cCodigoEva','EVA',cEvaRec)
			      cNomRec := EVA->cNombreEva
			      IF EVA->lSiRecuEva
				 cValInd := '1'   // Si Aprobado
			      ELSE
				 cValInd := '0'   // No Aprobado
			      ENDIF
			   ELSE
			      cNomInd += ' '+cEvaRec+' '+;
					    'EVALUACION RECUPERACION '+;
					    'NO EXISTE'
			   ENDIF
			ENDIF

		     ELSE
			cValInd := SPACE(01)  // No Evaluado
		     ENDIF

		  ENDIF
*===============FIN EVALUAR EL INDICADOR

	     ELSE
		cNomInd += ' '+cCodEva+' EVALUACION NO EXISTE'
	     ENDIF
***********FIN ANALISIS DEL INDICADOR

***********CODIGO DEL INDICADOR
	     cNomInd := cTextoInd(cCodigoTni,cCodigoTma,;
				  lIndNiv,cCodInd,cNalias)
	     aIndica := {}
	     AADD(aIndica,{'cCodInd',cCodInd}) // Codigo del Indicador
	     AADD(aIndica,{'cReeEva',cReeEva}) // Reevaluar el c¢digo de la Clase
	     AADD(aIndica,{'cCodEva',cCodEva}) // C¢digo de la Evaluaci¢n
	     AADD(aIndica,{'cEvaRec',cEvaRec}) // C¢digo de la Recuperaci¢n
	     AADD(aIndica,{'cNotEva',cNotEva}) // Nota c¢digo de evaluacion
	     AADD(aIndica,{'cNomEva',cNomEva}) // Nombre de la Evaluaci¢n
	     AADD(aIndica,{'cNomRec',cNomRec}) // Nombre de la Evaluaci¢n de la Recuperaci¢n
	     AADD(aIndica,{'cEvaRec',IF(cNotEva==cCodEva,cNomEva,cNomRec)}) // Nombre de la Evaluaci¢n con recuperaci¢n.
	     AADD(aIndica,{'cNotInd',SUBS(cCodNtI,1,4)}) // Nota del Indicador
	     AADD(aIndica,{'cNotRec',SUBS(cCodNtI,5,4)}) // Nota del recuperaci¢n del indicador
	     AADD(aIndica,{'cNomInd',cNomInd}) // Nombre del Indicador
	     AADD(aIndica,{'aNomInd',''})      // Nombre del Indicador. Para Sobrescribir
	     AADD(aIndica,{'cValInd',cValInd}) // Valoraci¢n del Indicador
	     AADD(aIndica,{'cPrnBol',cPrnBol}) // Imprimir en el boletin

	     AADD(aIndMat,aIndica)
***********FIN CODIGO DEL INDICADOR

       ENDFOR
*>>>>FIN RECORRIDO DE LOS INDICADORES

*>>>>ANALISIS DE DECISION
       IF lClaEof
	  CLA->(DBGOTO(CLA->(RECCOUNT())+1))
       ELSE
	  CLA->(DBGOTO(nRegCla))
       ENDIF

       IF lEvaEof
	  EVA->(DBGOTO(EVA->(RECCOUNT())+1))
       ELSE
	  EVA->(DBGOTO(nRegEva))
       ENDIF

       RETURN aIndMat
*>>>>FIN ANALISIS DE DECISION

/*************************************************************************
* TITULO..: LECTURA DEL TEXTO DEL INDICADOR                              *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAR 25/2008 MAR A
       Colombia, Bucaramanga        INICIO: 11:30 AM   MAR 25/2008 MAR

OBJETIVOS:

1- Lee el texto del indicador

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cTextoInd(cCodNiv,cCodMat,lIndNiv,cCodInd,cNalias)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodNiv                              // C¢digo del Nivel
       cCodMat                              // C¢digo de la Materia
       lIndNiv                              // .T. Indicadores por nivel
       cCodInd                              // C¢digo del Indicador
       cNalias                              // Alias del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL cCodigo := ''                  // C¢digo b£squeda del indicador
       LOCAL cNomInd := ''                  // Nombre del Indicador
       LOCAL nIndExt := 1                   // Indicadores Extras
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CODIGO DE BUSQUEDA
       IF lIndNiv
	  cCodigo := cCodNiv+cCodMat+cCodInd
       ELSE
	  cCodigo := cCodMat+cCodInd
       ENDIF
*>>>>FIN CODIGO DE BUSQUEDA

*>>>>BUSQUEDA DEL INDICADOR
       nIndExt := IF(nIndExt > 1,1,nIndExt)
       cNalias := IF(EMPTY(cNalias),'JUI',cNalias)

       cNomInd := 'NO EXISTE EL CODIGO '+cCodInd
       IF lSekCodigo(cCodigo,cNalias)

	  cNomInd := ALLTRIM(&cNalias->cNombreJui)+' '

**********INDICADOR EXTRA
	    FOR i := 1 TO nIndExt
		cNomInd += &(cNalias+'->cExtra'+STR(i,1)+'Jui')
	    ENDFOR
**********FIN INDICADOR EXTRA

	  cNomInd := cNomInd(ALLTRIM(cNomInd),;
			     CLA->lMinuscCla,CLA->cTipPrnCla,.T.)

       ENDIF
       RETURN cNomInd
*>>>>FIN BUSQUEDA DEL INDICADOR

/*************************************************************************
* TITULO..: ORDENAMIENTO DE LOS INDICADORES                              *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ABR 12/2002 VIE A
       Colombia, Bucaramanga        INICIO: 01:00 PM   ABR 12/2002 VIE

OBJETIVOS:

1- Ordena los c¢digos de los indicadores

2- Retorna el Vector con los c¢digos de indicadores ordenados

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aJuicio(cJuicio,lOrdJui,nLenJui)

*>>>>DESCRIPCION DE PARAMETROS
/*     cJuicio                              // Indicadores
       lOrdJui                              // Ordenar los Indicadores
       nLenJui                              // Longitud del Indicador */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL nNroInd := 0                   // N£mero de Indicadores
       LOCAL aJuicio := {}                  // Indicadores
       LOCAL cCodLog := ''                  // C¢digo del Logro
       LOCAL cIndOrd := ''                  // Indicadores Ordenados
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LECTURA DE LOS INDICADORES
       nLenJui := IF(EMPTY(nLenJui),6,nLenJui)
       cJuicio := SUBS(cJuicio,1,120)

       nNroInd := ROUND(LEN(cJuicio)/nLenJui,0)
       FOR i := 1 TO nNroInd
	   cCodLog := SUBS(cJuicio,i*nLenJui-(nLenJui-1),nLenJui)
	   IF !EMPTY(ALLTRIM(cCodLog)) .AND. VAL(cCodLog) # 0
	      AADD(aJuicio,cCodLog)
	   ENDIF
       ENDFOR
*>>>>FIN LECTURA DE LOS INDICADORES

*>>>>ORDENAMIENTO DE LOS INDICADORES EN EL VECTOR
       lOrdJui := IF(EMPTY(lOrdJui),.F.,lOrdJui)
       IF lOrdJui
	  aJuicio := ASORT(aJuicio)
       ENDIF
*>>>>FIN ORDENAMIENTO DE LOS INDICADORES EN EL VECTOR

*>>>>ORDENAMIENTO DE LOS INDICADORES EN STRING
       cIndOrd := ''
       IF lOrdJui
	  FOR i := 1 TO LEN(aJuicio)
	      cIndOrd += aJuicio[i]
	  ENDFOR
	  cJuicio := cIndOrd
       ENDIF
       RETURN aJuicio
*>>>>FIN ORDENAMIENTO DE LOS INDICADORES EN STRING

/*************************************************************************
* TITULO..: NOMBRE DEL INDICADOR                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ABR 13/2002 SAB A
       Bucaramanga,Colombia         INICIO: 12:00 AM   ABR 13/2002 SAB

OBJETIVOS:

1- Convierte el nombre del Indicador en May£sculas o Min£sculas

2- Retorna el nombre del Indicador

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cNomInd(cNomInd,lIndMin,cTipPrn,lMayUno)

*>>>>DESCRIPCION DE PARAMETROS
/*     cNomInd                              // Nombre del Indicador
       lIndMin                              // Indicador en Min£scula
       cTipPrn                              // Tipo de Impresi¢n 0=>Normal 1=>Min£cula 2=>May£scula
       lMayUno                              // .T. Primera Letra en May£scula */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>NOMBRE DEL INDICADOR
       DO CASE
       CASE !lIndMin .AND. cTipPrn == '1'
	    IF lMayUno
	       cNomInd := SUBS(cNomInd,1,1)+LOWER(SUBS(cNomInd,2,106))
	    ELSE
	       cNomInd := LOWER(cNomInd)
	    ENDIF

       CASE lIndMin .AND. cTipPrn == '2'
	    cNomInd := UPPER(cNomInd)
       ENDCASE

       RETURN cNomInd
*>>>>FIN NOMBRE DEL INDICADOR

/*************************************************************************
* TITULO..: NOMBRE DEL INDICADOR.VERTOR                                  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ABR 09/2008 MIE A
       Bucaramanga,Colombia         INICIO: 08:00 PM   ABR 09/2008 MIE

OBJETIVOS:

1- Crear un vector con el nombre Indicador de acuerdo a la longitud de
   lineas especificadas

2- Retorna el vector con el nombre del Indicador

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aNombreInd(cNomInd,nLenLin)

*>>>>DESCRIPCION DE PARAMETROS
/*     cNomInd                              // Nombre del Indicador
       nLenLin                              // Longitud de la l¡nea */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL aNroLin := 0                   // N£mero de l¡neas
       LOCAL aNomInd := {}                  // Nombre del Indicador
*>>>>FIN DECLARACION DE VARIABLES

*>>>>NOMBRE DEL INDICADOR
       aNroLin := aDivLin(ALLTRIM(cNomInd),nLenLin)

       aNomInd := {}
       FOR i := 1 TO LEN(aNroLin)
	   IF i == 1
	      AADD(aNomInd,aNroLin[i])
	   ELSE
	      AADD(aNomInd,SPACE(02)+aNroLin[i])
	   ENDIF
       ENDFOR
       RETURN aNomInd
*>>>>FIN NOMBRE DEL INDICADOR

/*************************************************************************
* TITULO..: INDICADORES RECUPERADOS O POR RECUPERAR                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ABR 02/2008 MIE A
       Colombia, Bucaramanga        INICIO: 05:00 PM   ABR 02/2008 MIE

OBJETIVOS:

1- Calcula los indicadores Recuperados o por Recuperar

2- Retorna los Indicadores Recuperados o por Recuperar

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION IndicaSiNo(aIndMat,aSiRecu,aNoRecu)

*>>>>DESCRIPCION DE PARAMETROS
/*     aIndMat                              // Indicadores de la Materia
       aSiRecu                              // Indicadores Si Recuperados
       aNoRecu                              // Indicadores NO Recuperados */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL i := 1                         // Contador
       LOCAL aIndica := {}                  // Indicadores
       LOCAL cValInd := ''                  // Valoraci¢n del Indicador. SPACES(01)=>No Evaluado 0=>No Aprobado 1=>Aprobado
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DE INDICADORES
       aSiRecu := {}
       aNoRecu := {}
       FOR i := 1 TO LEN(aIndMat)

	   aIndica := aIndMat[i]
	   cValInd := xPrm(aIndica,'cValInd')

	   DO CASE
	   CASE cValInd == '1'  // Si Aprobado

		AADD(aSiRecu,aIndMat[i])

	   CASE cValInd == '0'  // No Aprobado

		AADD(aNoRecu,aIndMat[i])

	   ENDCASE

       ENDFOR
       RETURN NIL
*>>>>FIN ANALISIS DE INDICADORES

/*************************************************************************
* TITULO..: ESTRUCTURA DE LOGROS E INDICADORES                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 12/2009 JUE A
       Colombia, Bucaramanga        INICIO: 10:30 AM   NOV 12/2009 JUE

OBJETIVOS:

1- Lee la estructura de logros e indicadores de la materia o area.

2- Retorna la estructura de logros e indicadores.


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aLogIndMat(cCodNiv,cCodMat,lIndNiv)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodNiv                              // C¢digo del Nivel
       cCodMat                              // C¢digo de la Materia
       lIndNiv                              // .T. Indicadores por nivel */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL     i,k := 0                   // Contador
       LOCAL aFilter := {}                  // Detalles para filtrar

       LOCAL cIdeCod := ''                  // C¢digo de Identificaci¢n del Indicador
       LOCAL cCodInd := ''                  // C¢digo del Indicador
       LOCAL cCodPad := ''                  // C¢digo del Indicador padre
       LOCAL aLogInd := {}                  // Logros e indicadores
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CLASE DE INDICADORES A FILTRAR
       aFilter := {}
       SELECT CLA
       CLA->(DBGOTOP())
       DO WHILE .NOT. CLA->(EOF())

	  IF LEN(aFilTer) == 0

	     IF EMPTY(CLA->cCodigoMat)
		AADD(aFilTer,{cCodMat,cCodNiv})
	     ELSE
		AADD(aFilTer,{CLA->cCodigoMat,SPACE(02)})
	     ENDIF

	  ELSE

	     IF EMPTY(CLA->cCodigoMat)
		k := ASCAN(aFilTer,{|aFil|aFil[1] == cCodMat .AND.;
					  aFil[2] == cCodNiv})
		IF k == 0
		   AADD(aFilTer,{cCodMat,cCodNiv})
		ENDIF
	     ELSE
		k := ASCAN(aFilTer,{|aFil|aFil[1] == cCodMat .AND.;
					  aFil[2] == SPACE(02)})
		IF k == 0
		   AADD(aFilTer,{CLA->cCodigoMat,SPACE(02)})
		ENDIF
	     ENDIF

	  ENDIF
	  CLA->(DBSKIP())
       ENDDO
       IF EMPTY(aFilter)
	  cError('NO EXISTEN INDICADORES PARA FILTRAR'+' '+;
		 'MAT:'+cCodMat+' NIVEL:'+cCodNiv,;
		 'FAVOR INFORMAR')
	  RETURN NIL
       ENDIF
*>>>>FIN CLASE DE INDICADORES A FILTRAR

*>>>>INDICADORES DE LA MATERIA O AREA
       aLogInd := {}
       SELECT IND
       FOR i := 1 TO LEN(aFilter)

	   cCodMat := aFilter[i,1]
	   cCodNiv := aFilter[i,2]

***********FILTRACION DE LOS INDICADORES
	     SELECT IND
	     IF lIndNiv
		SET FILTER TO SUBS(IND->cCodigoJui,1,4) == cCodMat .AND.;
			      IND->cCodigoNiv == cCodNiv
	     ELSE
		SET FILTER TO SUBS(IND->cCodigoJui,1,4) == cCodMat
	     ENDIF
***********FIN FILTRACION DE LOS INDICADORES

***********ANALISIS DE DECISION
	     IND->(DBGOTOP())
	     IF IND->(EOF())
		cError('NO HAY INDICADORES '+;
		       IF(lIndNiv,'DE NIVEL','DE MATERIA')+' '+;
		       'PARCIALES PARA LA MATERIA CON CODIGO:'+cCodMat,;
		       'FAVOR INFORMAR')
		RETURN NIL
	     ENDIF
***********FIN ANALISIS DE DECISION

***********RECORRIDO DE LOS INDICADORES
	     SELECT IND
	     IND->(DBGOTOP())
	     DO WHILE .NOT. IND->(EOF())

*===============LOCALIZACION CLASE DE INDICADOR
		  cIdeCod := ALLTRIM(IND->cIdeCodJui)
		  cCodInd := SUBS(IND->cCodigoJui,5,4)
		  cCodPad := SUBS(IND->cCodLogJui,5,4)

		  IF !lLocCodigo('cCodigoCla','CLA',SUBS(cCodInd,1,1))
		     cError('NO EXISTE LA CLASE '+;
			    SUBS(cCodInd,1,1)+' DEL INDICADOR '+cCodInd)
		     aLogInd := {}
		     EXIT
		  ENDIF
*===============FIN LOCALIZACION CLASE DE INDICADOR

*===============CLASIFICACION DE LOS INDICADORES
		  k := ASCAN(aLogInd,{|aArray|aArray[1] == cCodInd})
		  IF k == 0

		     AADD(aLogInd,{cCodInd,;
				   cCodPad,;
				   cIdeCod,;
				   CLA->nNivClaCla,;
				   IND->cNombreJui,;
				   IND->cExtra1Jui,;
				   '',;
				   .F.,;
				   .F.,;
				   '',;
				   CLA->cReeEvaCla})
		    /*Posiciones:
		      01. Logro o Indicador
		      02. C¢digo del Indicador padre
		      03. C¢digo de Identificaci¢n del Indicador
		      04. N£mero del SubNivel del Indicador
		      05. Texto del Indicador
		      06. Texto del Indicador Extra
		      07. Sub Indicadores
		      08. .T. Impreso
		      09. .T. C¢digo aplicado
		      10. C¢digo de evaluaci¢n. Aprobaci¢n del indicador
		      11. Reevaluar el c¢digo de la Clase */
		  ENDIF

		  k := ASCAN(aLogInd,{|aArray|aArray[1] == cCodPad})
		  IF k # 0
		     aLogInd[k,7] += cCodInd   // SubIndicadores
		  ENDIF
*===============FIN CLASIFICACION DE LOS INDICADORES

		IND->(DBSKIP())

	     ENDDO
***********RECORRIDO DE LOS INDICADORES

       ENDFOR
       aLogInd := ASORT(aLogInd,,,{|x,y| x[3] < y[3]})
     *ÀOrden por cIdeCod

       SELECT IND
       SET FILTER TO

       RETURN aLogInd
*>>>>FIN INDICADORES DE LA MATERIA O AREA

/*************************************************************************
* TITULO..: RELACION DE LOS LOGROS                                       *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 12/2009 JUE A
       Colombia, Bucaramanga        INICIO: 03:00 PM   NOV 12/2009 JUE

OBJETIVOS:

1- Busca los logros dentro de la estructura de logros e indicadores.

2- Retorna un vector con los logros.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aLogros(aLogInd,cCodCla,nNivCla)

*>>>>DESCRIPCION DE PARAMETROS
/*     aLogInd                              // Logros e indicadores
       cCodCla                              // C¢digo clase de indicadores
       nNivCla	                            // N£mero del SubNivel de la Clase de Indicador */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador

       LOCAL cCodLog := ''                  // C¢digo del logro
       LOCAL aLogros := {}                  // Logros

       LOCAL cCodigoTcl := ''               // C¢digo clase de indicador
       LOCAL nNivClaTcl := 0                // N£mero del SubNivel de la Clase de indicador
*>>>>FIN DECLARACION DE VARIABLES

*>>>>RECORRDO DE LOS LOGROS E INDICADORES
       FOR i := 1 TO LEN(aLogInd)

	      cCodLog := aLogInd[i,1]
	   nNivClaTcl := aLogInd[i,4]
	   cCodigoTcl := SUBS(cCodLog,1,1)

	   IF cCodigoTcl == cCodCla .AND. nNivClaTcl == nNivCla
	      AADD(aLogros,aLogInd[i])
	   ENDIF

       ENDFOR
       RETURN aLogros
*>>>>FIN RECORRDO DE LOS LOGROS E INDICADORES

/*************************************************************************
* TITULO..: RELACION DE INDICADORES DE UN LOGRO                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 12/2009 JUE A
       Colombia, Bucaramanga        INICIO: 03:15 PM   NOV 12/2009 JUE

OBJETIVOS:

1- Busca los indicadores pertenecientes a un logro.

2- Retorna un vector con los indicadores del logros.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aIndLogros(aLogInd,cCodLog)

*>>>>DESCRIPCION DE PARAMETROS
/*     aLogInd                              // Logros e indicadores
       cCodLog                              // C¢digo del logro */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador

       LOCAL cCodPad := ''                  // C¢digo del padre
       LOCAL aIndLog := {}                  // Indicadores del logro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>RECORRDO DE LOS LOGROS E INDICADORES
       FOR i := 1 TO LEN(aLogInd)

	   cCodPad := aLogInd[i,2]
	   IF cCodPad == cCodLog
	      AADD(aIndLog,aLogInd[i])
	   ENDIF

       ENDFOR
       RETURN aIndLog
*>>>>FIN RECORRDO DE LOS LOGROS E INDICADORES

