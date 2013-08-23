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

/*************************************************************************
* TITULO..: VALOR DE LOS CONCEPTOS DEL A¥O                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC 06/2002 VIE A
       Bucaramanga, Colombia        INICIO: 06:15 PM   DIC 06/2002 VIE

OBJETIVOS:

1- Descrimina todos los Conceptos del A¤o

2- Retorna Nil


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lVlrConAno(aVlrCon,lSiCert,fNtxDes)

*>>>>DESCRIPCION DE PARAMETROS
/*     aVlrCon                              // Valor de los Conceptos
       lSiCert                              // .T. Certificado
       fNtxDes                              // Archivo Indice del Descuento */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
       LOCAL aRegPag := {}                  // Registro de Pagos
       LOCAL nRegDes := 0                   // Registro del Descuento
       LOCAL nRegPag := 0                   // Registro de Pagos
*>>>>FIN DECLARACION DE VARIABLES

*>>>>IMPRESION DE LOS PAGOS
       aRegPag := aRegPagos(PAG->cCodigoEst)
       SELECT PAG
       PAG->(DBGOTOP())

       DO WHILE .NOT. PAG->(EOF())

	  nRegPag := PAG->(RECNO())
	  DES->(DBSETINDEX(fNtxDes))
	  lHayErr := !lVlrConRec(aVlrCon,lSiCert)
	  DES->(DBCLEARINDEX())

**********FILTRACION DE LOS DESCUENTOS,RECARGOS Y ABONOS DEL ESTUDIANTE
	    SELECT DES
	    SET FILTER TO DES->cCodigoEst == PAG->cCodigoEst
	    DES->(DBGOTOP())
	    IF DES->(EOF())
	       SET FILTER TO
	       PAG->(DBSKIP())
	       LOOP
	    ENDIF
**********FIN FILTRACION DE LOS DESCUENTOS,RECARGOS Y ABONOS DEL ESTUDIANTE

**********IMPRESION DEL LOS ABONOS
	    IF .NOT. DES->(EOF())
	       SELECT DES
	       DES->(DBGOTOP())
	       DO WHILE .NOT. DES->(EOF())

*-----------------VALIDACION DEL ABONO
		    IF !(DES->nNroMesDes == PAG->nMesIniPag .AND.; // Abono
			 DES->nTipDesDes == 3 .AND. !DES->lDesEfeDes)

			 DES->(DBSKIP())
			 LOOP

		    ENDIF
*-----------------FIN VALIDACION DEL ABONO

*-----------------DESCRIMINACION DEL ABONO
		    nRegDes := DES->(RECNO())
		    DES->(DBSETINDEX(fNtxDes))
		    DES->(DBGOTO(nRegDes))
		    lHayErr := !lVlrConAbo(aVlrCon,lSiCert)
		    DES->(DBCLEARINDEX())

		    PAG->(DBGOTO(nRegPag))
*-----------------FIN DESCRIMINACION DEL ABONO

		  DES->(DBSKIP())

	       ENDDO
	    ENDIF
**********FIN IMPRESION DEL LOS ABONOS

	  PAG->(DBSKIP())

       ENDDO
       RETURN lHayErr
*>>>>FIN IMPRESION DE LOS PAGOS

/*************************************************************************
* TITULO..: PAGOS DEL RECIBO POR CONCEPTOS                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 05/2003 VIE A
       Bucaramanga, Colombia        INICIO: 11:20 PM   SEP 05/2003 VIE

OBJETIVOS:

1- Permite descriminar los pagos de recibos por conceptos.

*  VlrConAbo(cCodEst),VlrConPag(cCodEst)

2- Retorna .F. Si no hay problemas

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lVlrConRec(aVlrCon,lSiCert,nVlrAbo)

*>>>>DESCRIPCION DE PARAMETROS
/*       aVlrCon                            // Valor de los Conceptos
	 lSiCert                            // .T. Si Certificado
	 nVlrAbo                            // @Valor del Abono */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
       LOCAL       i := 0                   // Contador
       LOCAL nSdoAnt := 0                   // Saldo Anterior
       LOCAL nMorAnt := 0                   // Mora Anterior
       LOCAL nVlrMes := 0                   // Valor del Mes
       LOCAL nIntMes := 0                   // Valor Intereses del Mes
       LOCAL nRegAct := 0                   // Registro Actual
       LOCAL aRegPag := {}                  // Registro de Pagos
       LOCAL aVlrDes := {}                  // Valor Descuentos
       LOCAL aPagPar := {}                  // Pago Parcial
       LOCAL nVlrRec := 0                   // Valor Recargos
       LOCAL nMesRec := 0                   // Mes del Recargo
       LOCAL nRegDes := 0                   // Registro del Descuento
       LOCAL nVlrDes := 0                   // Valor del Descuento
       LOCAL nMesDes := 0                   // Mes del Descuento
       LOCAL nPagPar := 0                   // Pago Parcial
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DESCRIMINACION DEL VALOR DEL MES
       lSiCert := IF(lSiCert == NIL,.F.,lSiCert)
       nVlrAbo := IF(nVlrAbo == NIL,0,nVlrAbo)
       IF (PAG->cEstadoPag == 'P'  .OR.;
	   PAG->cEstadoPag == 'A') .AND.;
	   !EMPTY(PAG->dFecPagPag)

	   nVlrMes := nVlrConFac()

	   VlrConPag(@nVlrMes,aVlrCon,lSiCert)

       ENDIF
*>>>>FIN CALCULO DE LOS VALORES CANCELADOS

*>>>>DESCRIMINACION DE LOS INTERESES DEL MES
       IF PAG->cEstadoPag == 'A'
	  nIntMes := nVlrIntPag(CAA->lIntPenCaA,;
				PAG->nMesIniPag,;
				CAA->nMesAmnCaA)

	  IF lSiCert
	     VlrCon('INT',;
		    SUBS('INTERESES'+SPACE(16),1,16),;
		    nIntMes,;
		    aVlrCon)
	  ELSE
	     VlrCon('MES',;
		    SUBS('INT PAGO MES'+SPACE(16),1,16),;
		    nIntMes,;
		    aVlrCon)
	  ENDIF
       ENDIF
*>>>>FIN DESCRIMINACION DE LOS INTERESES

*>>>>DESCRIMINACION DE LOS INTESESES ANTERIORES
       IF (PAG->cEstadoPag == 'P'  .OR.;
	   PAG->cEstadoPag == 'A') .AND.;
	   !EMPTY(PAG->dFecPagPag)

	 IF PAG->nMorAntPag # 0
	    nMorAnt := PAG->nMorAntPag
	    IF lSiCert
	       VlrCon('INT',;
		      SUBS('INTERESES'+SPACE(16),1,16),;
		      nMorAnt,;
		      aVlrCon)
	    ELSE
	       VlrCon('ANT',;
		      SUBS('INT PAGO ANT'+SPACE(16),1,16),;
		      nMorAnt,;
		      aVlrCon)
	    ENDIF
	 ENDIF

       ENDIF
*>>>>FIN DESCRIMINACION DE LOS INTESESES ANTERIORES

*>>>>DESCRIMINACION DEL SALDO ANTERIOR
       IF (PAG->cEstadoPag == 'P'  .OR.;
	   PAG->cEstadoPag == 'A') .AND.;
	   !EMPTY(PAG->dFecPagPag)

	  nSdoAnt := PAG->nSdoAntPag
	  IF nSdoAnt # 0

	     nRegAct := PAG->(RECNO())
	     aRegPag := aRegPagos(PAG->cCodigoEst)
	     PAG->(DBGOTO(nRegAct))

	     i := ASCAN(aRegPag,{|aArray| aArray == nRegAct})
	     DO WHILE nSdoAnt > 0

		i--
		lHayErr := !lDbGoTo('PAG',aRegPag,i)

		IF PAG->cEstadoPag == 'D'

		   nMesRec := PAG->nMesIniPag
		   nVlrRec := PAG->nVlrRecPag
		   nSdoAnt -= nVlrRec

		   VlrConPag(@nSdoAnt,aVlrCon,lSiCert)

		ENDIF

	     ENDDO
	     PAG->(DBGOTO(nRegAct))
	  ENDIF
       ENDIF
*>>>>FIN DESCRIMINACION DEL SALDO ANTERIOR

*>>>>DESCRIMINACION DEL RECARGO
       IF nVlrRec # 0
	  nRegDes := DES->(RECNO())
	  IF (lSekCodDes(PAG->cCodigoEst,nMesRec,.F.) .AND.;
			  DES->nTipDesDes == 2) .AND.;
			  DES->nValorDes == nVlrRec     // Recargo
	     VlrConDes(nVlrRec,aVlrCon,lSiCert)
	  ELSE
	     VlrCon('REC',;
		    SUBS('ERROR EN RECARGO'+SPACE(16),1,16),;
		    nVlrRec,;
		    aVlrCon)
	  ENDIF
	  DES->(DBGOTO(nRegDes))
       ENDIF
*>>>>FIN DESCRIMINACION DEL RECARGO

*>>>>DESCRIMINACION DEL RECARGO DEL MES
       nVlrRec := 0
       IF (PAG->cEstadoPag == 'P'  .OR.;
	   PAG->cEstadoPag == 'A') .AND.;
	   !EMPTY(PAG->dFecPagPag)
	   nVlrRec := PAG->nVlrRecPag
       ENDIF

       IF nVlrRec # 0
	  nRegDes := DES->(RECNO())
	  IF (lSekCodDes(PAG->cCodigoEst,PAG->nMesIniPag,.F.) .AND.;
			  DES->nTipDesDes == 2) .AND.;
			  DES->nValorDes == nVlrRec     // Recargo
	     VlrConDes(nVlrRec,aVlrCon,lSiCert)
	  ELSE
	     VlrCon('REC',;
		    SUBS('ERROR DEL RECARGO MES'+SPACE(16),1,16),;
		    nVlrRec,;
		    aVlrCon)
	     lHayErr := .T.
	  ENDIF
	  DES->(DBGOTO(nRegDes))
       ENDIF
*>>>>FIN DESCRIMINACION DEL RECARGO DEL MES

*>>>>DESCRIMINACION DEL PAGO PARCIAL DEL MES
       aPagPar := {}
       nPagPar := 0
       IF (PAG->cEstadoPag == 'P'  .OR.;
	   PAG->cEstadoPag == 'A') .AND.;
	   !EMPTY(PAG->dFecPagPag)
	   nPagPar := PAG->nPagParPag
       ENDIF
       IF nPagPar # 0

	  nRegDes := DES->(RECNO())
	  IF (lSekCodDes(PAG->cCodigoEst,PAG->nMesIniPag,.F.) .AND.;
			  DES->nTipDesDes == 4) .AND.;
			  DES->nValorDes == nPagPar     // Pago Parcial
	     VlrConDes(nPagPar,aPagPar,lSiCert)
	  ELSE
	     VlrCon('PAR',;
		    SUBS('ERROR PAGO PARCIAL'+SPACE(16),1,16),;
		    nPagPar,;
		    aPagPar)
	     lHayErr := .T.
	  ENDIF
	  DES->(DBGOTO(nRegDes))
	  SumArrCon(aVlrCon,aPagPar,.F.)
       ENDIF
*>>>>FIN DESCRIMINACION DEL PAGO PARCIAL DEL MES

*>>>>DESCRIMINACION DEL DESCUENTO DEL MES
       aVlrDes := {}
       nVlrDes := 0
       IF (PAG->cEstadoPag == 'P'  .OR.;
	   PAG->cEstadoPag == 'A') .AND.;
	   !EMPTY(PAG->dFecPagPag)
	   nVlrDes := PAG->nVlrDesPag
       ENDIF

       IF nVlrDes # 0
	  nRegDes := DES->(RECNO())
	  IF (lSekCodDes(PAG->cCodigoEst,PAG->nMesIniPag,.F.) .AND.;
			  DES->nTipDesDes == 1) .AND.;
			  DES->nValorDes == nVlrDes     // Descuento
	     VlrConDes(nVlrDes,aVlrDes,lSiCert)
	  ELSE
	     VlrCon('DES',;
		    SUBS('ERROR EN DESCUENTO'+SPACE(16),1,16),;
		    nVlrDes,;
		    aVlrDes)
	     lHayErr := .T.
	  ENDIF
	  DES->(DBGOTO(nRegDes))
	  SumArrCon(aVlrCon,aVlrDes,.F.)
       ENDIF
       RETURN !lHayErr
*>>>>FIN DESCRIMINACION DEL DESCUENTO DEL MES

/*************************************************************************
* TITULO..: ABONOS POR CONCEPTOS                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 17/2003 MIE A
       Bucaramanga, Colombia        INICIO: 12:20 PM   SEP 17/2003 MIE

OBJETIVOS:

1- Permite descriminar los abono por conceptos.

2- Debe estar ubicado en el registro del abono en descuentos y en pagos
   en el mes del abono

2- Retorna Nil

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lVlrConAbo(aVlrCon,lSiCert)

*>>>>DESCRIPCION DE PARAMETROS
/*     aVlrCon                              // Valor de los Conceptos
       lSiCert                              // .T. Si Certificado */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .T.                 // .T. Hay Error
       LOCAL       i := 0                   // Indice de los pagos
       LOCAL nSdoAnt := 0                   // Saldo Anterior
       LOCAL nVlrMes := 0                   // Valor del Mes
       LOCAL nIntMes := 0                   // Valor Intereses del Mes
       LOCAL nRegAct := 0                   // Registro Actual
       LOCAL aRegPag := {}                  // Registro de Pagos

       LOCAL nDeuAbo := 0                   // Valor de la Deuda Abonada
       LOCAL nMorAnt := 0                   // Valor de la Mora Abonada
       LOCAL nMorMes := 0                   // Mora del Mes
       LOCAL nVlrRec := 0                   // Valor Recargos
       LOCAL nMesRec := 0                   // Mes del Recargo
       LOCAL nRegDes := 0                   // Registro del Descuento
       LOCAL lAboOpo := .T.                 // .T. Abono Oportuno
       LOCAL lHayPag := .F.                 // .T. Hay Pago
       LOCAL nRegPag := 0                   // Registro de Pagos
       LOCAL cEstado := ''                  // Estado de Pago
       LOCAL nIntMor := 0                   // Porcentaje de la Mora
       LOCAL nMesInt := 0                   // Mes del Interes

       LOCAL aDetPag := {}                  // Detalles de los pagos
       LOCAL aPagAbo := {}                  // Calculos de los Abonos
*>>>>FIN DECLARACION DE VARIABLES

*>>>>REGISTROS DE LOS PAGOS
       nRegAct := PAG->(RECNO())
       aRegPag := aRegPagos(PAG->cCodigoEst)
       PAG->(DBGOTO(nRegAct))
       i := ASCAN(aRegPag,{|aArray| aArray == nRegAct})
*>>>>FIN REGISTROS DE LOS PAGOS

*>>>>INICIALIZACION DE LOS DETALLES DE PAGO
       AADD(aDetPag,{0,0,0,0,'',0})
       AADD(aDetPag,{0,0,0,0,'',0})
      *1- Mes Inicial de Pago,
      *2- Deuda Anterior despu‚s de Abono,
      *3- Mora Anterior despu‚s de Abono
      *4- Valor del Mes
      *5- Por Pagar
      *6- Estado de Pago
      *7- Registro de pagos
*>>>>FIN INICIALIZACION DE LOS DETALLES DE PAGO

*>>>>LOCALIZACION DEL PAGO MES DEL ABONO
       lHayPag := lLocCodPag(DES->cCodigoEst,DES->nNroMesDes,.F.)
       IF lHayPag

	  nRegPag := PAG->(RECNO())
	  nIntMor := PAG->nIntMorPag
	  nMesInt := PAG->nMesIniPag
	  cEstado := PAG->cEstadoPag

	  IF DES->dFechaDes <= PAG->dPagExtPag
	     aDetPag[2,1] := DES->nNroMesDes
	     aDetPag[2,2] := DES->nSdoAntPag
	     aDetPag[2,3] := DES->nMorAntPag
	     aDetPag[2,4] := DES->nVlrMesPag
	     aDetPag[2,5] := cEstado
	     aDetPag[2,6] := nRegPag
		  lAboOpo := .T.
	  ELSE
	     aDetPag[2,1] := DES->nNroMesDes
	     aDetPag[2,2] := DES->nSdoAntPag+DES->nVlrMesPag
	     aDetPag[2,3] := DES->nMorAntPag+;
			     nVlrInt(DES->nSdoAntPag+DES->nVlrMesPag)
		  lAboOpo := .F.
	  ENDIF
       ELSE
	  RETURN !lHayErr
       ENDIF
*>>>>FIN LOCALIZACION DEL PAGO MES DEL ABONO

*>>>>LOCALIZACION DEL PAGO MES MODIFICADO
       IF lHayPag .AND. lLocCodPag(DES->cCodigoEst,;
				   IF(DES->nMesModDes==0,;
				      DES->nNroMesDes,;
				      DES->nMesModDes),.F.)

	  IF lAboOpo
	     aDetPag[1,1] := DES->nMesModDes
	     aDetPag[1,2] := DES->nSdoAntDes
	     aDetPag[1,3] := DES->nMorAntDes
	     aDetPag[1,4] := DES->nVlrMesDes
	     aDetPag[1,5] := PAG->cEstadoPag
	     aDetPag[1,6] := PAG->(RECNO())
	  ELSE
	     aDetPag[1,1] := DES->nNroMesDes
	     aDetPag[1,2] := DES->nSdoAntPag
	     aDetPag[1,3] := DES->nMorAntPag
	     aDetPag[1,4] := DES->nVlrMesPag
	     aDetPag[1,5] := cEstado
	     aDetPag[1,6] := nRegPag
	  ENDIF
       ELSE
	  lHayPag := .F.
       ENDIF
*>>>>FIN LOCALIZACION DEL PAGO MES MODIFICADO

*>>>>APLICACION DEL ABONO
       IF !lHayPag .OR. !lAbonos(1,DES->dFechaDes,DES->nValorDes,2,;
				 aDetPag,@aPagAbo)
	  RETURN !lHayErr
       ENDIF
*>>>>FIN APLICACION DEL ABONO

*>>>>DESCRIMINACION DE LA DEUDA
       nDeuAbo := aDetPag[2,2] - aPagAbo[3,1]
       nMorAnt := aDetPag[2,3] - aPagAbo[3,2]

       IF lAboOpo
	  i--  // Se ubica en el mes Anterior
       ELSE
	  PAG->(DBGOTO(nRegPag))
	  nMorMes := nVlrInt(nDeuAbo)
	  nMorAnt -= nMorMes
       ENDIF
*>>>>FIN DESCRIMINACION DE LA DEUDA

*>>>>ANALISIS DE DECISION
       IF DES->nValorDes # nDeuAbo+nMorAnt+nMorMes
	  RETURN !lHayErr
       ENDIF
*>>>>FIN ANALISIS DE DECISION

*>>>>DESCRIMINACION DE LOS INTESESES ANTERIORES
       lSiCert := IF(lSiCert==NIL,.F.,lSiCert)
       IF nMorAnt # 0
	  IF lSiCert
	     VlrCon('INT',;
		    SUBS('INTERESES'+SPACE(16),1,16),;
		    nMorAnt,;
		    aVlrCon)
	  ELSE
	     VlrCon('ANT',;
		    SUBS('INT PAGO ANT'+SPACE(16),1,16),;
		    nMorAnt,;
		    aVlrCon)
	  ENDIF
       ENDIF
*>>>>FIN DESCRIMINACION DE LOS INTESESES ANTERIORES

*>>>>DESCRIMINACION DE LOS INTESESES DEL MES
       IF nMorMes # 0
	  VlrCon('INT',;
		 SUBS('INT PAGO '+cMes(nMesInt,3)+SPACE(16),1,16),;
		 nMorMes,;
		 aVlrCon)
       ENDIF
*>>>>FIN DESCRIMINACION DE LOS INTESESES DEL MES

*>>>>DESCRIMINACION DEL ABONO
       IF nDeuAbo # 0
	  DO WHILE nDeuAbo > 0

*------------DESCRIMINACION DE LOS CONCEPTOS DEL MES
	       IF i # 0
		  lHayErr := !lDbGoTo('PAG',aRegPag,i)
	       ENDIF

	       nMesRec := PAG->nMesIniPag
	       nVlrRec := PAG->nVlrRecPag
	       nDeuAbo -= nVlrRec
	       VlrConPag(@nDeuAbo,aVlrCon,lSiCert)
	       i--     // Se ubica en el mes Anterior
*------------FIN DESCRIMINACION DE LOS CONCEPTOS DEL MES

*------------DESCRIMINACION DEL RECARGO
	       IF nVlrRec # 0

		  nRegDes := DES->(RECNO())
		  IF (lSekCodDes(PAG->cCodigoEst,nMesRec,.F.) .AND.;
				  DES->nTipDesDes == 2) .AND.;
				  DES->nValorDes == nVlrRec     // Recargo
		     VlrConDes(nVlrRec,aVlrCon,lSiCert)
		  ELSE
		     VlrCon('REC',;
			    SUBS('ERROR EN RECARGO'+SPACE(16),1,16),;
			    nVlrRec,;
			    aVlrCon)
		  ENDIF
		  DES->(DBGOTO(nRegDes))
	       ENDIF
*------------FIN DESCRIMINACION DEL RECARGO

	  ENDDO
	  PAG->(DBGOTO(nRegAct))
       ENDIF
       RETURN !lHayErr
*>>>>FIN DESCRIMINACION DEL ABONO

/*************************************************************************
* TITULO..: DISCRIMINACION CONCEPTOS DE MATRICULAS                       *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 30/2003 VIE A
       Bucaramanga, Colombia        INICIO: 10:30 AM   SEP 30/2003 VIE

OBJETIVOS:

1- Descrimina el valor de los conceptos de la Matricula seg£n el
   valor especificado.

2- Retorna Nil

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION VlrConMtr(nVlrDiv,aVlrCon,cCodGru,cNalias,lSiCert)

*>>>>DESCRIPCION DE PARAMETROS
/*     nVlrDiv                              // @Valor a Discriminar
       aVlrCon                              // @Valor de los Conceptos
       cCodGru                              // C¢digo del Grupo
       cNalias                              // Alias del Archivo
       lSiCert                              // .T. Si Certificado */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL nVlrCon := 0                   // Valor del Concepto

       LOCAL cCodigoTco := ''               // C¢digo del Concepto
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DESCRIMINACION DEL VALOR
       lSiCert := IF(lSiCert==NIL,.F.,lSiCert)
       cNalias := IF(EMPTY(cNalias),'PAG',cNalias)
       FOR i := 1 TO LEN(ALLTRIM(&cNalias->cConcepPag))/2

***********LOCALIZACION DEL VALOR DEL CONCEPTO
	     cCodigoTco := SUBS(&cNalias->cConcepPag,i*2-1,2)
	     lLocCodigo('cCodigoCon','CMT',cCodigoTco)

	     SELECT TMT
	     GO TOP
	     LOCATE FOR TMT->cCodigoGru == SUBS(cCodGru,1,2)+'00' .AND.;
			TMT->cCodigoCon == cCodigoTco

	     IF FOUND()
		nVlrCon := TMT->nValorTar
	     ELSE
		nVlrCon := 0
	       *No existe tarifa asignada
	     ENDIF
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
		     IF CMT->lSiCertCon
			VlrCon(IF(EMPTY(CMT->cCodCerCon),;
				  cCodigoTco,CMT->cCodCerCon),;
			       IF(EMPTY(CMT->cNomCerCon),;
				  CMT->cNombreCon,CMT->cNomCerCon),;
			       nVlrCon,aVlrCon)
		     ENDIF
		  ELSE
		     VlrCon(cCodigoTco,CMT->cNombreCon,nVlrCon,aVlrCon)
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