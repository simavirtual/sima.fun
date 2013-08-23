/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		BIBLIOTECAS DE FUNCIONES GENERALES DE CONCEPTOS

OBJETIVOS:

- Definici¢n de funciones generales para el SIMA

***************************************************************************
*-------------------- DECLARACION DE LAS FUNCIONES -----------------------*
**************************************************************************/

/*************************************************************************
* TITULO..: CONSULTA LOS CONCEPTO A COBRAR                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 13/1994 SAB A
       Colombia,Bucaramanga         INICIO: 02:00 PM   AGO 13/1994 SAB

OBJETIVOS:

1- Debe estar en uso el archivo de conceptos

2- Visualiza los conceptos por cobrar


SINSTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION ConsultCon(nFilPal,nColPal,cConcep)

*>>>>PARAMETROS DE LA FUNCION
/*     nFilPal                              // Fila Superior
       nColPal                              // Columna Superior
       cConcep                              // Conceptos por cobrar */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroFil := 0                   // N£mero de la Fila
       LOCAL nNroCol := 0                   // N£mero de la Columna
       LOCAL cMsgTxt := ''                  // Texto variable
       LOCAL       i := 0                   // Contador
       LOCAL lHayErr := .T.                 // .T. Hay Error

       LOCAL cSayDat := ''                  // Color para los datos
       MEMVA xClrSys			    // Color del Sistema

       LOCAL cCodigoTco := ''               // C¢digo del concepto
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DEL COLOR
       Colores(xColores(IF(!EMPTY(xClrSys),xClrSys[1],'')),,,,,@cSayDat)
*>>>>IF ANALISIS DEL COLOR

*>>>>CONSULTA DE LOS CONCEPTOS POR COBRAR
       nNroFil := nFilPal
       nNroCol := nColPal
       SELECT CON
       i := 1
       DO WHILE i <= LEN(RTRIM(cConcep))/2

	  cCodigoTco := SUBS(cConcep,i*2-1,2)
	  LOCATE FOR CON->cCodigoCon == cCodigoTco

	  IF FOUND()
	     SET COLOR TO I
	     cSetColor(cSayDat)
	     @ nNroFil,nNroCol  SAY RTRIM(CON->cNombreCon)
	     nNroCol := nNroCol+LEN(RTRIM(CON->cNombreCon))+1

	     IF nNroCol > 62
		SET COLOR TO
		nNroCol := nColPal
		cPausa()
		@ nNroFil,00 CLEAR TO nNroFil,79
	       *Limpia la linea de impresion de los conceptos a cobrar
		SET COLOR TO I
		cSetColor(cSayDat)
	     ENDIF
	  ELSE
	     cError('EL CODIGO DEL CONCEPTO '+cCodigoTco+' NO SE ENCUENTRA')
	     SET COLOR TO
	     lHayErr := .F.
	  ENDIF

	  i := i + 1

       ENDDO
       SET COLOR TO
       RETURN lHayErr
*>>>>FIN CONSULTA DE LOS CONCEPTOS POR COBRAR

/*************************************************************************
* TITULO..: DISCRIMINACION CONCEPTOS DEL SALDO                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 10/2003 VIE A
       Bucaramanga, Colombia        INICIO: 07:00 PM   OCT 10/2003 VIE

OBJETIVOS:

1- Permite descriminar el Saldo

2- El registro del pago debe estar ubicado en el £ltimo recibo

2- Retorna Nil

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lVlrConSdo(nVlrDeu,nVlrMor,aVlrCon,nDiaMor,nMesSdo)

*>>>>DESCRIPCION DE PARAMETROS
/*     nVlrDeu                            // @Valor de la Deuda
       nVlrMor                            // Valor de la Mora
       aVlrCon                            // Valor de los Conceptos
       nDiaMor                            // @Dias en Mora
       nMesSdo                            // @Mes del saldo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
       LOCAL       i := 0                   // Contador
       LOCAL nSdoAnt := 0                   // Saldo Anterior
       LOCAL nMorAnt := 0                   // Mora Anterior
       LOCAL nVlrMes := 0                   // Valor del Mes
       LOCAL nIntMes := 0                   // Valor Intereses del Mes
       LOCAL nVlrInt := 0                   // Valor de los Intereses
       LOCAL nRegAct := 0                   // Registro Actual
       LOCAL aRegPag := {}                  // Registro de Pagos
       LOCAL nVlrRec := 0                   // Valor Recargos
       LOCAL nMesRec := 0                   // Mes del Recargo
       LOCAL nRegDes := 0                   // Registro del Descuento
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DESCRIMINACION DE LOS INTERESES DEL MES
       IF (PAG->cEstadoPag == 'D' .OR. PAG->cEstadoPag == 'A') .AND.;
	  nVlrMor # 0

	  nIntMes := nVlrIntPag(CAA->lIntPenCaA,;
				PAG->nMesIniPag,;
				CAA->nMesAmnCaA)

	  IF nVlrMor > nIntMes
	     nVlrInt := nIntMes
	     nVlrMor -= nIntMes
	  ELSE
	     nVlrInt := nVlrMor
	     nVlrMor := 0
	  ENDIF

	  IF nVlrInt # 0
	     VlrCon('MES',;
		    SUBS('INT DEL MES'+SPACE(16),1,16),;
		    nVlrInt,;
		    aVlrCon)
	  ENDIF
       ENDIF
*>>>>FIN DESCRIMINACION DE LOS INTERESES

*>>>>DESCRIMINACION DE LOS INTESESES ANTERIORES
       nMorAnt := nVlrMor
       IF nMorAnt # 0
	  VlrCon('ANT',;
		 SUBS('INT ANTERIOR'+SPACE(16),1,16),;
		 nMorAnt,;
		 aVlrCon)
	  nVlrMor := 0
       ENDIF
*>>>>FIN DESCRIMINACION DE LOS INTESESES ANTERIORES

*>>>>DESCRIMINACION DEL SALDO ANTERIOR
       nSdoAnt := nVlrDeu
       nRegAct := PAG->(RECNO())
       IF nSdoAnt # 0

*=========LECTURA DE LOS REGISTROS DE PAGOS
	    aRegPag := aRegPagos(PAG->cCodigoEst)
	    IF EMPTY(aRegPag)
	       RETURN lHayErr
	    ENDIF
	    PAG->(DBGOTO(nRegAct))
*=========FIN LECTURA DE LOS REGISTROS DE PAGOS

*=========DESCRIMINACION DEL SALDO
	    i := ASCAN(aRegPag,{|aArray| aArray == nRegAct})
	    DO WHILE nSdoAnt > 0

	       nDiaMor += 30

*--------------ANALISIS DEL DEUDOR
		 IF PAG->cEstadoPag == '*'
		    i--
		 ENDIF
		 lHayErr := !lDbGoTo('PAG',aRegPag,i--)
*--------------FIN ANALISIS DEL DEUDOR

*--------------MES DEL SALDO
		 IF nMesSdo < PAG->nMesIniPag
		    nMesSdo := PAG->nMesIniPag
		 ENDIF
*--------------FIN MES DEL SALDO

*--------------ANALISIS DEL RECARGO
		 nMesRec := PAG->nMesIniPag
		 nVlrRec := PAG->nVlrRecPag
		 nSdoAnt -= nVlrRec
*--------------FIN ANALISIS DEL RECARGO

*--------------DESCRIMINACION DEL SALDO
		 VlrConPag(@nSdoAnt,aVlrCon)
*--------------FIN DESCRIMINACION DEL SALDO

*--------------DESCRIMINACION DEL RECARGO
		 IF nVlrRec # 0

		    nRegDes := DES->(RECNO())
		    IF (lSekCodDes(PAG->cCodigoEst,nMesRec,.F.) .AND.;
				    DES->nTipDesDes == 2) .AND.;
				    DES->nValorDes == nVlrRec     // Recargo
		       VlrConDes(nVlrRec,aVlrCon)
		    ELSE
		       VlrCon('REC',;
			      SUBS('ERROR EN RECARGO'+SPACE(16),1,16),;
			      nVlrRec,;
			      aVlrCon)
		    ENDIF
		    DES->(DBGOTO(nRegDes))

		 ENDIF
*--------------FIN DESCRIMINACION DEL RECARGO

	    ENDDO
	    nVlrDeu := nSdoAnt
*=========FIN DESCRIMINACION DEL SALDO

       ENDIF
       PAG->(DBGOTO(nRegAct))
       RETURN !lHayErr
*>>>>FIN DESCRIMINACION DEL SALDO ANTERIOR

/*************************************************************************
* TITULO..: ACUMULACION DE CONCEPTOS                                     *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 03/2003 MIE A
       Bucaramanga, Colombia        INICIO: 11:30 PM   SEP 03/2003 MIE

OBJETIVOS:

1- Permite acumular los valores de los conceptos

2- Retorna Nil


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION VlrCon(cCodCon,cNomCon,nVlrCon,aVlrCon,lSumar)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodCon                              // C¢digo del Concepto
       cNomCon                              // Nombre del Concepto
       nVlrCon                              // Valor del Concepto
       aVlrCon                              // @Valor de los Conceptos
       lSumar                               // .T. lSumar  */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL i := 0                         // Contador
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ACUMUACION DE LOS CONCEPTOS
       lSumar := IF(lSumar == NIL,.T.,lSumar)
       IF EMPTY(aVlrCon)
	  IF lSumar
	     AADD(aVlrCon,{cCodCon,cNomCon,nVlrCon,0})
	  ELSE
	     AADD(aVlrCon,{cCodCon,cNomCon,0,nVlrCon})
	  ENDIF
       ELSE
	  i := ASCAN(aVlrCon,{|aArr|aArr[1] == cCodCon})
	  IF i == 0
	     IF lSumar
		AADD(aVlrCon,{cCodCon,cNomCon,nVlrCon,0})
	     ELSE
		AADD(aVlrCon,{cCodCon,cNomCon,0,nVlrCon})
	     ENDIF
	  ELSE
	     IF lSumar
		aVlrCon[i,3] += nVlrCon
	     ELSE
		aVlrCon[i,4] += nVlrCon
	     ENDIF
	  ENDIF
       ENDIF
       RETURN NIL
*>>>>FIN ACUMUACION DE LOS CONCEPTOS

/*************************************************************************
* TITULO..: DISCRIMINACION CONCEPTOS DEL DEL MES                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 05/2003 VIE A
       Bucaramanga, Colombia        INICIO: 01:06 PM   SEP 05/2003 VIE

OBJETIVOS:

1- Descrimina el valor de los conceptos facturados del mes de acuerdo
   al valor especificado.

2- Retorna Nil

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION VlrConPag(nVlrDiv,aVlrCon,lSiCert)

*>>>>DESCRIPCION DE PARAMETROS
/*     nVlrDiv                              // @Valor a Discriminar
       aVlrCon                              // @Valor de los Conceptos
       lSiCert                              // .T. Si Certificado */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL i := 0                         // Contador
       LOCAL nMesIni := 0                   // Mes Inicial
       LOCAL nMesFin := 0                   // Mes Final
       LOCAL nVlrCon := 0                   // Valor del Concepto
       LOCAL cCodigoTco := ''               // C¢digo del Concepto
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DESCRIMINACION DEL VALOR
       lSiCert := IF(lSiCert==NIL,.F.,lSiCert)
       FOR i := 1 TO LEN(ALLTRIM(PAG->cConcepPag))/2

***********LOCALIZACION DEL CONCEPTO
	     cCodigoTco := SUBS(PAG->cConcepPag,i*2-1,2)
	     lLocCodigo('cCodigoCon','CON',cCodigoTco)

	     nVlrCon := nVlrConPag(cCodigoTco,'PAG')
	    *Valor del Concepto
***********FIN LOCALIZACION DEL CONCEPTO

***********ANALISIS DEL PAGO ANTICIPADO
	     IF PAG->nMesIniPag # PAG->nMesFinPag
		nVlrCon += nVlrCon * (PAG->nMesFinPag-PAG->nMesIniPag)
	     ELSE
		IF lHayAntici(PAG->nMesIniPag,PAG->cIniFinPag)
		   nMesIni := 0
		   nMesFin := 0
		   cIniFinPag(i,PAG->cIniFinPag,@nMesIni,@nMesFin)
		   nVlrCon += nVlrCon * (nMesFin-nMesIni)
		ENDIF
	     ENDIF
***********FIN ANALISIS DEL PAGO ANTICIPADO

***********DESCUENTO DE LA BECA
	     IF PAG->nVlrBecPag # 0 .AND. 'PENSION' $ CON->cNombreCon
		nVlrCon -= PAG->nVlrBecPag
	     ENDIF
***********FIN DESCUENTO DE LA BECA

***********SUMA DEL CONCEPTO DESCRIMINADO
	     IF nVlrCon # 0

*---------------RESTA DEL VALOR DESCRIMINADO
		  IF nVlrCon <= nVlrDiv
		     nVlrDiv -= nVlrCon
		  ELSE
		     nVlrCon := nVlrDiv
		     nVlrDiv := 0
		  ENDIF
*---------------FIN RESTA DEL VALOR DESCRIMINADO

*---------------SUMA DEL CONCEPTO DESCRIMINADO
		  IF lSiCert
		     IF CON->lSiCertCon
			VlrCon(IF(EMPTY(CON->cCodCerCon),;
				  cCodigoTco,CON->cCodCerCon),;
			       IF(EMPTY(CON->cNomCerCon),;
				  CON->cNombreCon,CON->cNomCerCon),;
			       nVlrCon,aVlrCon)
		     ENDIF
		  ELSE
		     VlrCon(cCodigoTco,CON->cNombreCon,nVlrCon,aVlrCon)
		  ENDIF
*---------------FIN SUMA DEL CONCEPTO DESCRIMINADO

	     ENDIF
***********FIN SUMA DEL CONCEPTO DESCRIMINADO

***********ANALISIS DE DECISION
	     IF nVlrDiv == 0
		EXIT
	     ENDIF
***********FIN ANALISIS DE DECISION

       ENDFOR
       RETURN NIL
*>>>>FIN DESCRIMINACION DEL VALOR

/*************************************************************************
* TITULO..: VALOR DEL CONCEPTO EN PAGOS                                  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 05/2003 VIE A
       Bucaramanga, Colombia        INICIO: 12:20 PM   SEP 05/2003 VIE

OBJETIVOS:

1- Calcula el Valor del Concepto facturado en el recibo

2- Retorna el Valor del Concepto

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nVlrConPag(cCodCon,cNalias)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodCon                              // C¢digo del Concepto
       cNalias                              // cNalias del Archivo*/
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nVlrCon := 0                   // Valor del Concepto
       LOCAL nNroPos := 0                   // N£mero de la posici¢n
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CALCULA EL VALOR DEL CONCEPTO
       cNalias := IF(EMPTY(cNalias),'PAG',cNalias)
       SELECT &cNalias
       IF cCodCon $ &cNalias->cConcepPag
	  nNroPos := (AT(cCodCon,;
			 &cNalias->cConcepPag)+1)/2
	  nVlrCon := &('nVlrCo'+;
		       STR(nNroPos,1)+'Pag')
       ENDIF
       RETURN nVlrCon
*>>>>FIN CALCULA EL VALOR DEL CONCEPTO

/*************************************************************************
* TITULO..: DISCRIMINACION CONCEPTOS EN DESCUENTOS                       *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 22/2003 LUN A
       Bucaramanga, Colombia        INICIO: 12:30 PM   SEP 22/2003 LUN

OBJETIVOS:

1- Descrimina el valor de los conceptos del recargo o descuentos seg£n
   en el registro donde se encuentre ubicado.

2- Retorna Nil

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION VlrConDes(nVlrDiv,aVlrCon,lSiCert)

*>>>>DESCRIPCION DE PARAMETROS
/*     nVlrDiv                              // @Valor a Discriminar
       aVlrCon                              // @Valor de los Conceptos
       lSiCert                              // .T. Si Certificado */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL i := 0                         // Contador
       LOCAL nVlrCon                        // Valor del Concepto
       LOCAL cCodigoTco := ''               // C¢digo del Concepto
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DE LOS CONCEPTOS
       IF EMPTY(DES->cConcepDes)
	  VlrCon('??','POR CLASIFICAR  ',nVlrDiv,aVlrCon)
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DE LOS CONCEPTOS

*>>>>DESCRIMINACION DEL VALOR
       lSiCert := IF(lSiCert==NIL,.F.,lSiCert)
       FOR i := 1 TO LEN(ALLTRIM(DES->cConcepDes))/2

***********LOCALIZACION DEL CONCEPTO
	     cCodigoTco := SUBS(DES->cConcepDes,i*2-1,2)
	     lLocCodigo('cCodigoCon','CON',cCodigoTco)

	     nVlrCon := nVlrConDes(cCodigoTco)
	    *Valor del Concepto
***********FIN LOCALIZACION DEL CONCEPTO

***********SUMA DEL CONCEPTO DESCRIMINADO
	     IF nVlrCon # 0

*---------------RESTA DEL VALOR DESCRIMINADO
		  IF nVlrCon <= nVlrDiv
		     nVlrDiv -= nVlrCon
		  ELSE
		     nVlrCon := nVlrDiv
		     nVlrDiv := 0
		  ENDIF
*---------------FIN RESTA DEL VALOR DESCRIMINADO

*---------------SUMA DEL CONCEPTO DESCRIMINADO
		  IF lSiCert
		     IF CON->lSiCertCon
			VlrCon(IF(EMPTY(CON->cCodCerCon),;
				  cCodigoTco,CON->cCodCerCon),;
			       IF(EMPTY(CON->cNomCerCon),;
				  CON->cNombreCon,CON->cNomCerCon),;
			       nVlrCon,aVlrCon)
		     ENDIF
		  ELSE
		     VlrCon(cCodigoTco,CON->cNombreCon,nVlrCon,aVlrCon)
		  ENDIF
*---------------FIN SUMA DEL CONCEPTO DESCRIMINADO

	     ENDIF
***********FIN SUMA DEL CONCEPTO DESCRIMINADO

***********ANALISIS DE DECISION
	     IF nVlrDiv == 0
		EXIT
	     ENDIF
***********FIN ANALISIS DE DECISION

       ENDFOR
       RETURN NIL
*>>>>FIN DESCRIMINACION DEL VALOR

/*************************************************************************
* TITULO..: VALOR DEL CONCEPTO EN DESCUENTOS                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 22/2003 LUN A
       Bucaramanga, Colombia        INICIO: 12:20 PM   SEP 22/2003 LUN

OBJETIVOS:

1- Calcula el Valor del Concepto facturado en el recibo

2- Retorna el Valor del Concepto

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nVlrConDes(cCodCon)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodCon                              // C¢digo del Concepto */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nVlrCon := 0                   // Valor del Concepto
       LOCAL nNroPos := 0                   // N£mero de la posici¢n
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CALCULA EL VALOR DEL CONCEPTO
       SELECT DES
       IF cCodCon $ DES->cConcepDes
	  nNroPos := (AT(cCodCon,;
			 DES->cConcepDes)+1)/2
	  nVlrCon := &('nVlrCo'+;
		       STR(nNroPos,1)+'Des')
       ENDIF
       RETURN nVlrCon
*>>>>FIN CALCULA EL VALOR DEL CONCEPTO

/*************************************************************************
* TITULO..: VALOR DEL CONCEPTOS FACTURADOS                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 12/2005 MAR A
       Bucaramanga, Colombia        INICIO: 02:00 PM   JUL 12/2005 MAR

OBJETIVOS:

1- Calcula el Valor total de los conceptos facturados del mes y por
   anticipado sin incluir los descuetos,ayudas,recargos etc.

2- Retorna el Valor total de los Conceptos facturados

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nVlrConFac()

*>>>>DECLARACION DE VARIABLES
       LOCAL i := 0                         // Contador
       LOCAL nMesIni := 0                   // Mes Inicial
       LOCAL nMesFin := 0                   // Mes Final
       LOCAL nVlrCon := 0                   // Valor del Concepto
       LOCAL nVlrMes := 0                   // Valor del Mes

       LOCAL cCodigoTco := ''               // C¢digo del Concepto
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DESCRIMINACION DEL VALOR
       FOR i := 1 TO LEN(ALLTRIM(PAG->cConcepPag))/2

***********LOCALIZACION DEL CONCEPTO
	     cCodigoTco := SUBS(PAG->cConcepPag,i*2-1,2)
	     lLocCodigo('cCodigoCon','CON',cCodigoTco)

	     nVlrCon := nVlrConPag(cCodigoTco,'PAG')
	    *Valor del Concepto
***********FIN LOCALIZACION DEL CONCEPTO

***********CALCULO DE LOS MESES DE FACTURACION
	     nMesIni := PAG->nMesIniPag
	     nMesFin := PAG->nMesFinPag
	     IF PAG->nMesIniPag == PAG->nMesFinPag .AND.;
		lHayAntici(PAG->nMesIniPag,PAG->cIniFinPag)

		nMesIni := 0
		nMesFin := 0
		cIniFinPag(i,PAG->cIniFinPag,@nMesIni,@nMesFin)

	     ENDIF
	     nVlrMes += nVlrCon * nNroMesFac(nMesIni,nMesFin)
***********FIN CALCULO DE LOS MESES DE FACTURACION

       ENDFOR
       RETURN nVlrMes
*>>>>FIN DESCRIMINACION DEL VALOR