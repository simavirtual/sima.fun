/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		BIBLIOTECAS DE FUNCIONES GENERALES DE PAGOS

OBJETIVOS:

- Definici¢n de funciones generales para el SIMA

***************************************************************************
*-------------------- DECLARACION DE LAS FUNCIONES -----------------------*
**************************************************************************/

*>>>>DECLARACION DE CONSTANTES GENERALES
       #INCLUDE "inkey.ch"
*>>>>FIN DECLARACION DE CONSTANTES GENERALES

/*************************************************************************
* TITULO DE LA FUNCION..: LOCALIZACION DEL CODIGO DEL PAGO               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 15/94 VIE A
						       JUL 15/94 VIE
OBJETIVOS:

1- Valida si existe el c¢digo del estudiante en el archivo de Pagos

2- Debe estar en uso el archivo de Pagos correspondiente

3- Retorna .T. si existe el codigo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lLocCodPag(cCodPag,nMesIni,lMensaj)

*>>>>PARAMETROS DE LA FUNCION
/*     cCodPag			            // C¢digo del Pago
       nMesIni                              // Mes inicial del pago
       lMensaj                              // .T. Mostrar mensaje de error */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL lExiste := .T.                 // .T. = Existe el c¢digo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DEL CODIGO
       lMensaj := IF(lMensaj == NIL,.T.,lMensaj)
       SELECT PAG
       GO TOP
       LOCATE FOR PAG->cCodigoEst == cCodPag .AND.;
		  PAG->nMesIniPag == nMesIni

       IF .NOT. FOUND()
	  IF lMensaj
	     cError('EL CODIGO '+cCodPag+' DEL ESTUDIANTE '+;
		    'NO TIENE PAGO PARA EL MES DE '+cMes(nMesIni,10))
	  ENDIF
	  lExiste := .F.
       ENDIF
       RETURN lExiste
*>>>>FIN LOCALIZACION DEL CODIGO

/*************************************************************************
* TITULO DE LA FUNCION..: VALOR DE LOS INTERESES DEL PAGO                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 10/98 LUN A
       Colombia, Bucaramanga        INICIO: 12:23 PM   AGO 10/98 LUN

OBJETIVOS:

1- Calcula el valor de los intereses que fueron facturados tomando los
   valores del registro de pagos

2- Debe estar ubicado en el respectivo registro del archivo pagos

3- Retorna el valor de los intereses.

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nVlrIntPag(lIntPen,nMesIni,nMesAmn)

*>>>>PARARAMETROS DE LA FUNCION
/*     lIntPen                              // .T. Interese por porcentaje
       nMesIni                              // Mes Inicial del recibo
       nMesAmn                              // Mes de Amnist¡a */
*>>>>FIN PARARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL nVlrInt := 0                   // Valor de los intereses
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CALCULO DE LOS INTERESES
       IF lIntPen
	  IF nMesIni # nMesAmn
	     nVlrInt := ROUND(((PAG->nSdoAntPag+PAG->nVlrMesPag)*;
				PAG->nIntMorPag)/100,0)
	  ELSE
	     nVlrInt := ROUND((PAG->nVlrMesPag*PAG->nIntMorPag)/100,0)
	  ENDIF
       ELSE
	   nVlrInt := PAG->nVlrMorPag
       ENDIF
       RETURN ABS(nVlrInt)
*>>>>FIN CALCULO DE LOS INTERESES

/*************************************************************************
* TITULO..: VALOR DE LOS INTERESES NO PAGO                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAR 01/2010 LUN A
       Colombia, Bucaramanga        INICIO: 10:00 AM   MAR 01/2010 LUN

OBJETIVOS:

1- Calcula el valor de los intereses por el no pago valores del registro de pagos

2- Debe estar ubicado en el respectivo registro del archivo pagos

3- Retorna el valor de los intereses.

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nVlrIntNoP(lIntPen,nMesIni,nMesAmn)

*>>>>PARARAMETROS DE LA FUNCION
/*     lIntPen                              // .T. Interese por porcentaje
       nMesIni                              // Mes Inicial del recibo
       nMesAmn                              // Mes de Amnist¡a */
*>>>>FIN PARARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL nVlrInt := 0                   // Valor de los intereses
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CALCULO DE LOS INTERESES
       IF lIntPen
	  IF nMesIni # nMesAmn
	     nVlrInt := ROUND(((PAG->nSdoAntPag+PAG->nVlrMesPag)*;
				PAG->nIntDeuPag)/100,0)
	  ELSE
	     nVlrInt := ROUND((PAG->nVlrMesPag*PAG->nIntDeuPag)/100,0)
	  ENDIF
       ELSE
	   nVlrInt := PAG->nVlrDeuPag
       ENDIF
       RETURN ABS(nVlrInt)
*>>>>FIN CALCULO DE LOS INTERESES

/*************************************************************************
* TITULO..: RESGISTROS DE LOS PAGOS                                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 11/2003 LUN A
       Colombia, Bucaramanga        INICIO: 02:30 PM   AGO 11/2003 LUN

OBJETIVOS:

1- Crea un vector con los n£meros de los registros de los recibos impresos

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aRegPagos(cCodEst)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiantes */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL aRegPag := {}                  // Registro de pagos
*>>>>FIN DECLARACION DE VARIABLES

*>>>>FILTRACION DE LOS PAGOS
       SELECT PAG
       SET FILTER TO PAG->cCodigoEst == cCodEst
       PAG->(DBGOTOP())
       IF PAG->(EOF())
	  SET FILTER TO
	  RETURN aRegPag
       ENDIF
*>>>>FIN FILTRACION DE LOS PAGOS

*>>>>RECORRIDO DEL ARCHIVO
       SELECT PAG
       GO TOP
       DO WHILE .NOT. PAG->(EOF())
	  AADD(aRegPag,PAG->(RECNO()))
	  PAG->(DBSKIP())
       ENDDO
*       SET FILTER TO   // Agregada
       RETURN aRegPag
*>>>>FIN RECORRIDO DEL ARCHIVO

/*************************************************************************
* TITULO..: UBICACION A UN REGISTRO                                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 16/2003 JUE A
       Colombia, Bucaramanga        INICIO: 05:45 PM   OCT 16/2003 JUE

OBJETIVOS:

1- Se ubica en un registro especifico

2- Retorna .T. Si pudo ubicarse en el registro

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lDbGoTo(cNalias,aNroReg,nNroPos)

*>>>>DESCRIPCION DE PARAMENTROS
/*     cNalias                              // Alias del Archivo
       aNroReg                              // Registros del Archivo
       nNroPos                              // N£mero del Indice */
*>>>>FIN DESCRIPCION DE PARAMENTROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .T.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DE DECISION
       DO CASE
       CASE LEN(aNroReg) == 0

       CASE EMPTY(nNroPos)

       CASE nNroPos > LEN(aNroReg)

       CASE nNroPos < 0

       OTHERWISE
	    lHayErr := .F.
       ENDCASE
*>>>>FIN ANALISIS DE DECISION

*>>>>UBICACION DEL REGISTRO
       IF !lHayErr
	  SELECT &cNalias
	  DBGOTO(aNroReg[nNroPos])
       ENDIF
       RETURN !lHayErr
*>>>>FIN UBICACION DEL REGISTRO

/*************************************************************************
* TITULO DE LA FUNCION..: DETALLES DE PAGOS HASTA EL MES ACTUAL          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 10/99 VIE A
       Colombia, Bucaramanga        INICIO: 09:30 PM   SEP 10/99 VIE

OBJETIVOS:

1- Crea un vector con los detalles de cada pago hasta encontrar el mes actual

2- El objetivo de este vector es permitir la Actualizaci¢n del Estado de Cuenta

3- Retorna por referencia los param‚tros marcados con @

4- Retorna .T. si se creo el vector sin problemas.


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lDetPag(cCodEst,aDetPag,nMesIni,nUltPag)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante
       aDetPag                              // @Detalles de los pagos
       nMesIni                              // @Mes Inicial del pago
       nUltPag                              // Ultimo recibo de pago */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
       LOCAL nRegAct := 0                   // Registro Actual
*>>>>FIN DECLARACION DE VARIABLES


*>>>>LOCALIZACION DEL ULTIMO PAGO
       IF nMesIni # 1
	  IF aDetPag[LEN(aDetPag),6] # 0
	     PAG->(DBGOTO(aDetPag[LEN(aDetPag),6]))
	  ENDIF
       ENDIF
*>>>>FIN LOCALIZACION DEL ULTIMO PAGO

*>>>>DETALLES DE LOS PAGOS
       DO WHILE .T.

**********PREGUNTA SI EXISTE ABONO
	    IF nMesIni # 1 .AND. LEN(aDetPag) == PAG->nMesIniPag
	       nMesIni++
	    ENDIF
**********FIN PREGUNTA SI EXISTE ABONO

**********LOCALIZACION DEL SIGUIENTE PAGO
	    IF nMesIni # 1
	       IF !lLocCodPag(cCodEst,nMesIni,.F.)
		  IF nMesIni > nUltPag
		     nMesIni--
		     EXIT
		  ENDIF
	       ENDIF
	    ENDIF
**********FIN LOCALIZACION DEL SIGUIENTE PAGO

**********INICIALIZACION DE LOS DETALLES DE PAGO
	    AADD(aDetPag,{0,0,0,0,'',0})
	   *1- Mes Inicial de Pago,
	   *2- Deuda Anterior despu‚s de Abono,
	   *3- Mora Anterior despu‚s de Abono
	   *4- Valor del Mes
	   *5- Estado de Pago
	   *6- Registro de pagos
**********FIN INICIALIZACION DE LOS DETALLES DE PAGO

**********VALIDACION DEL MES INICIAL
	    IF nMesIni # PAG->nMesIniPag
	       nMesIni++
	       LOOP
	    ENDIF
**********FIN VALIDACION DEL MES INICIAL


**********DETALLES DEL PAGO
	    SELECT PAG
	    aDetPag[nMesIni,1] := PAG->nMesIniPag  // Mes Inicial
	    aDetPag[nMesIni,4] := nMesPag()        // Valor del Mes
	    aDetPag[nMesIni,5] := PAG->cEstadoPag  // Forma de Pago

	    aDetPag[nMesIni,6] := PAG->(RECNO())

	    IF nMesIni # 1 .AND. aDetpag[nMesIni-1,5] == 'D'
	       aDetPag[nMesIni,2] := aDetPag[nMesIni-1,2]+;
				     aDetPag[nMesIni-1,4]
	      *Deuta Anterior = Deuda Anterior + Valor del mes

	       nRegAct := PAG->(RECNO())
	       PAG->(DBGOTO(aDetPag[nMesIni-1,6]))
	      *Mes Anterior

	       IF PAG->nMesAmnPag == PAG->nMesIniPag  //  Ú Valor del Mes
		  aDetPag[nMesIni,3] := nIntNoP(aDetPag[nMesIni-1,4])+;
					aDetPag[nMesIni-1,3]
	       ELSE
						      //  Ú Deuda Anterior
		  aDetPag[nMesIni,3] := nIntNoP(aDetPag[nMesIni,2])+;
					aDetPag[nMesIni-1,3]
	       ENDIF
	     *ÀMora Anterior mes Actual = Intereses del Mes +;
	     *			          Mora Anterior mes Anterior

	       PAG->(DBGOTO(nRegAct))
	    ENDIF
	  *ÀSaldo Actual
**********FIN DETALLES DEL PAGO

       ENDDO
       SELECT PAG
       PAG->(DBGOTO(aDetPag[LEN(aDetPag),6]))
       RETURN .NOT. lHayErr
*>>>>DETALLES DE LOS PAGOS

/*************************************************************************
* TITULO DE LA FUNCION..: DETALLES DE PAGOS HASTA ABONOS                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 25/99 MIE A
       Colombia, Bucaramanga        INICIO: 08:45 PM   AGO 25/99 MIE

OBJETIVOS:

1- Crea un vector con los detalles de cada pago hasta encontrar un abono.

2- El objetivo de este vector es permitir la Actualizaci¢n de los abonos.

3- Retorna por referencia los param‚tros marcados con @

4- Retorna .T. si se creo el vector sin problemas.


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lDetPagAbo(cCodEst,aDetPag,nMesIni,nUltPag)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante
       aDetPag                              // @Detalles de los pagos
       nMesIni                              // @Mes Inicial del pago
       nUltPag                              // Ultimo recibo de Pago */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
       LOCAL nIniAnt := 0                   // Mes Inicial Anterior
       LOCAL nDeuAnt := 0                   // Deuda Anterior
       LOCAL nMorAnt := 0                   // Mora Anterior
       LOCAL nMorMes := 0                   // Interes del Mes
       LOCAL nMesAnt := 0                   // Valor del Mes Anterior
       LOCAL nRegAct := 0                   // Registro Actual
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DEL ULTIMO PAGO
       IF nMesIni # 1
	  IF aDetPag[LEN(aDetPag),6] # 0
	     PAG->(DBGOTO(aDetPag[LEN(aDetPag),6]))
	  ENDIF
       ENDIF
*>>>>FIN LOCALIZACION DEL ULTIMO PAGO

*>>>>DETALLES DE LOS PAGOS
       DO WHILE .T.

**********PREGUNTA SI EXISTE ABONO
	    IF nMesIni # 1 .AND. LEN(aDetPag) == PAG->nMesIniPag
	       IF nMesIni < DES->nNroMesDes+1
		  nMesIni++
	       ELSE
		  EXIT
	       ENDIF
	    ENDIF
**********FIN PREGUNTA SI EXISTE ABONO

**********LOCALIZACION DEL SIGUIENTE PAGO
	    IF nMesIni # 1
	       IF !lLocCodPag(cCodEst,nMesIni,.F.)
		  IF nMesIni > nUltPag
		     nMesIni--
		     EXIT
		  ENDIF
	       ENDIF
	    ENDIF
**********FIN LOCALIZACION DEL SIGUIENTE PAGO

**********INICIALIZACION DE LOS DETALLES DE PAGO
	    AADD(aDetPag,{0,0,0,0,'',0})
	   *1- Mes Inicial de Pago,
	   *2- Deuda Anterior despu‚s de Abono,
	   *3- Mora Anterior despu‚s de Abono
	   *4- Valor del Mes
	   *5- Estado de Pago
	   *6- Registro de pagos
**********FIN INICIALIZACION DE LOS DETALLES DE PAGO

**********VALIDACION DEL MES INICIAL
	    IF nMesIni # PAG->nMesIniPag
	       nMesIni++
	       LOOP
	    ENDIF
**********FIN VALIDACION DEL MES INICIAL

**********DETALLES DEL PAGO
	    SELECT PAG
	    aDetPag[nMesIni,1] := PAG->nMesIniPag  // Mes Inicial
	    aDetPag[nMesIni,4] := nMesPag()     // Valor del Mes en pagos
	    aDetPag[nMesIni,5] := PAG->cEstadoPag  // Forma de Pago

	    aDetPag[nMesIni,6] := PAG->(RECNO())

	    nIniAnt := nIniAnt(aDetPag)
	    IF nIniAnt # 1 .AND. aDetpag[nIniAnt,5] == 'D'

	       nDeuAnt := aDetPag[nIniAnt,2]+aDetPag[nIniAnt,4]
	      *Deuta Anterior = Deuda Anterior + Valor del mes

	       aDetPag[nMesIni,2] := nDeuAnt

	       nMesAnt := aDetPag[nMesIni,4]  // Valor del Mes
	       nMorMes := nIntNoP(nDeuAnt+nMesAnt)

	       nRegAct := PAG->(RECNO())
	       PAG->(DBGOTO(aDetPag[nIniAnt,6]))
	      *Mes Anterior

	       IF PAG->nMesAmnPag == PAG->nMesIniPag

		  IF aDetpag[nIniAnt,5] == 'D'
					       //  Ú Valor del Mes
		     nMorAnt := nIntNoP(aDetPag[nIniAnt,4])+;
					   aDetPag[nIniAnt,3]
		  ELSE
					       //  Ú Valor del Mes
		     nMorAnt := nIntMes(aDetPag[nIniAnt,4])+;
					aDetPag[nIniAnt,3]
		  ENDIF

		  aDetPag[nMesIni,3] := nMorAnt
	       ELSE

		  IF aDetpag[nIniAnt,5] == 'D'
					       //  Ú Deuda Anterior
		     nMorAnt := nIntNoP(aDetPag[nMesIni,2])+;
					aDetPag[nIniAnt,3]
		  ELSE
					       //  Ú Deuda Anterior
		     nMorAnt := nIntMes(aDetPag[nMesIni,2])+;
					aDetPag[nIniAnt,3]
		  ENDIF


		  aDetPag[nMesIni,3] := nMorAnt
					
	       ENDIF
	     *ÀMora Anterior mes Actual = Intereses del Mes +;
	     *			          Mora Anterior mes Anterior

	       PAG->(DBGOTO(nRegAct))

	    ELSE

	      IF nIniAnt # 1 .AND.;
		 (aDetpag[nIniAnt,5] == 'P' .OR.;
		  aDetpag[nIniAnt,5] == 'A')

		  nDeuAnt := 0
		  nMorAnt := 0
		  nMesAnt := 0
		  nMorMes := 0
	      ENDIF

	      aDetPag[nMesIni,2] := nDeuAnt+nMesAnt
	      aDetPag[nMesIni,3] := nMorAnt+nMorMes
	    *ÀDeuda y Mora anterior del Mes Anterior

	    ENDIF
	  *ÀSaldo Actual
**********FIN DETALLES DEL PAGO

       ENDDO
       SELECT PAG
       IF ASCAN(aDetPag,{|aArray|aArray[1] == DES->nNroMesDes}) # 0
	  PAG->(DBGOTO(aDetPag[DES->nNroMesDes,6]))
       ELSE
	  lHayErr := .T.
       ENDIF

       RETURN .NOT. lHayErr
*>>>>DETALLES DE LOS PAGOS


FUNCTION nIniAnt(aDetPag)

LOCAL       i := 0
LOCAL nMesIni := 1

FOR i := LEN(aDetPag)-1 TO 1 STEP -1
    IF aDetPag[i,1] # 0
       nMesIni := aDetPag[i,1]
       EXIT
    ENDIF
ENDFOR
RETURN nMesIni



/*************************************************************************
* TITULO..: DETALLES DE PAGOS HASTA ABONOS                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 25/99 MIE A
       Colombia, Bucaramanga        INICIO: 08:45 PM   AGO 25/99 MIE

OBJETIVOS:

1- Calcula el interes del mes de acuerdo a deuda pasada como parametro

2- Se debe estar ubicado en el registro de pagos correspondiente.

3- Retorna el valor de los interese del mes

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nIntMes(nVlrDeu)

*>>>>DESCRIPCION DE PARAMETROS
/*     nVlrDeu                              // Valor de la Deuda */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nVlrInt := 0                   // Valor de los intereses
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CALCULO DE LOS INTERESES
       IF PAG->lIntPenPag
	  nVlrInt := ROUND((ABS(nVlrDeu)*PAG->nIntMorPag)/100,0)
       ELSE
	  nVlrInt := PAG->nVlrMorPag
       ENDIF
       RETURN nVlrInt
*>>>>FIN CALCULO DE LOS INTERESES

/*************************************************************************
* TITULO..: DETALLES DE PAGOS HASTA ABONOS                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 25/99 MIE A
       Colombia, Bucaramanga        INICIO: 08:45 PM   AGO 25/99 MIE

OBJETIVOS:

1- Calcula el interes del mes de acuerdo a deuda pasada como parametro

2- Se debe estar ubicado en el registro de pagos correspondiente.

3- Retorna el valor de los interese del mes

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nIntNoP(nVlrDeu)

*>>>>DESCRIPCION DE PARAMETROS
/*     nVlrDeu                              // Valor de la Deuda */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nVlrInt := 0                   // Valor de los intereses
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CALCULO DE LOS INTERESES
       IF PAG->lIntPenPag
	  nVlrInt := ROUND((ABS(nVlrDeu)*PAG->nIntDeuPag)/100,0)
       ELSE
	  nVlrInt := PAG->nVlrMorPag
       ENDIF
       RETURN nVlrInt
*>>>>FIN CALCULO DE LOS INTERESES


/*************************************************************************
* TITULO..: VALOR DEL MES                                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 25/99 VIE A
       Colombia, Bucaramanga        INICIO: 05:45 PM   JUN 25/99 VIE

OBJETIVOS:

1- Totaliza el valor de todos los conceptos facturados para un mes

2- Retorna el total del valor del mes

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nVlrMes(aVlrCon)

*>>>>DESCRIPCION DE PARAMESTROS
/*     aVlrCon                              // @Valor de los Conceptos */
*>>>>FIN DESCRIPCION DE PARAMESTROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL nNroPos := 0                   // N£mero de la posici¢n
       LOCAL nVlrCon := 0                   // Valor del Concepto
       LOCAL nVlrMes := 0                   // Valor del Mes
       LOCAL nTotMes := 0                   // Total del Mes

       LOCAL cCodigoTco := ''               // C¢digo del Concepto
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CALCULO DEL VALOR DEL MES
       nVlrMes := 0
       aVlrCon := {}
       FOR i := 1 TO LEN(ALLTRIM(PAG->cConcepPag))/2

***********LOCALIZACION DEL VALOR DEL CONCEPTO
	     cCodigoTco := SUBS(PAG->cConcepPag,i*2-1,2)

	     SELECT PAG
	     IF cCodigoTco $ PAG->cConcepPag
		nNroPos := (AT(cCodigoTco,PAG->cConcepPag)+1)/2
		nVlrCon := &('PAG->nVlrCo'+STR(nNroPos,1)+'Pag')
	     ELSE
		nVlrCon := 0
	     ENDIF

	     IF lLocCodigo('cCodigoCon','CON',cCodigoTco)
		IF CON->lDesEfeDes
		   nVlrMes -= nVlrCon
		ELSE
		   nVlrMes += nVlrCon
		ENDIF
	     ELSE
		nVlrMes += nVlrCon
	     ENDIF

	     AADD(aVlrCon,nVlrCon)
***********FIN LOCALIZACION DEL VALOR DEL CONCEPTO

       ENDFOR
       nTotMes := nVlrMes - PAG->nVlrBecPag - PAG->nVlrDesPag -;
			    PAG->nDesGenPag - PAG->nPagParPag +;
			    PAG->nVlrRecPag + PAG->nRecGenPag
       RETURN nTotMes
*>>>>FIN CALCULO DEL VALOR DEL MES

/*************************************************************************
* TITULO..: VALOR DEL MES EN PAGOS                                       *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 25/99 VIE A
       Colombia, Bucaramanga        INICIO: 05:45 PM   JUN 25/99 VIE

OBJETIVOS:

1- Totaliza el valor de todos los conceptos facturados para un mes

2- Retorna el total del valor del mes

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nMesPag(aVlrCon)

*>>>>DESCRIPCION DE PARAMESTROS
/*     aVlrCon                              // @Valor de los Conceptos */
*>>>>FIN DESCRIPCION DE PARAMESTROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL nNroPos := 0                   // N£mero de la posici¢n
       LOCAL nVlrCon := 0                   // Valor del Concepto
       LOCAL nVlrMes := 0                   // Valor del Mes
       LOCAL nTotMes := 0                   // Total del Mes
       LOCAL nBecMes := 0                   // Valor de la Beca Mensual

       LOCAL cCodigoTco := ''               // C¢digo del Concepto
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CALCULO DEL VALOR DEL MES
       nVlrMes := 0
       aVlrCon := {}
       FOR i := 1 TO LEN(ALLTRIM(PAG->cConcepPag))/2

***********LOCALIZACION DEL VALOR DEL CONCEPTO
	     cCodigoTco := SUBS(PAG->cConcepPag,i*2-1,2)

	     IF cCodigoTco $ PAG->cConcepPag
		nNroPos := (AT(cCodigoTco,PAG->cConcepPag)+1)/2
		nVlrCon := &('PAG->nVlrCo'+STR(nNroPos,1)+'Pag')
	     ELSE
		nVlrCon := 0
	     ENDIF

	     IF lLocCodigo('cCodigoCon','CON',cCodigoTco)
		IF CON->lDesEfeDes
		   nVlrMes -= nVlrCon
		ELSE
		   nVlrMes += nVlrCon
		ENDIF
	     ELSE
		nVlrMes += nVlrCon
	     ENDIF

	     AADD(aVlrCon,nVlrCon)
***********FIN LOCALIZACION DEL VALOR DEL CONCEPTO

       ENDFOR
       lBecaMes('PE',@nBecMes)
       nTotMes := nVlrMes - nBecMes - PAG->nVlrDesPag -;
			    PAG->nDesGenPag - PAG->nPagParPag +;
			    PAG->nVlrRecPag + PAG->nRecGenPag
       RETURN nTotMes
*>>>>FIN CALCULO DEL VALOR DEL MES

/*************************************************************************
* TITULO..: VALOR DEL BECA MENSUAL                                       *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAR 16/2007 VIE A
       Colombia, Bucaramanga        INICIO: 11:15 AM   MAR 16/2007 VIE

OBJETIVOS:

1- Permite calcular el valor de la beca del solo mes, no teniendo presente
   el valor de las becas por pagos anticipados.

2- Retorna el valor de la beca del solo mes.

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lBecaMes(cCodCon,nBecMes)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodCon                              // C¢digo del Concepto
       nBecMes                              // Valor de la Beca del Mes */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nMesIni := 0                   // Mes Inicial
       LOCAL nMesFin := 0                   // Mes Final
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALOR DE LA BECA MENSUAL
       IF PAG->nVlrBecPag == 0
	  nBecMes := PAG->nVlrBecPag
	  RETURN .T.
       ENDIF

       IF !lIniFinCon(cCodCon,@nMesIni,@nMesFin)
	  RETURN .F.
       ENDIF

       nBecMes := PAG->nVlrBecPag/nNroMesFac(nMesIni,nMesFin)
       RETURN .T.
*>>>>FIN VALOR DE LA BECA MENSUAL

/*************************************************************************
* TITULO..: MES INICIAL Y MES FINAL DEL CONCEPTO                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAR 16/2007 VIE A
       Colombia, Bucaramanga        INICIO: 12:00 AM   MAR 16/2007 VIE

OBJETIVOS:

1- Retorna el mes inicial y final del codigo del concepto facturado

2- Retorna .T. si no hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lIniFinCon(cCodCon,nMesIni,nMesFin)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodCon                              // C¢digo del Concepto
       nMesIni                              // @Mes Inicial
       nMesFin                              // @Mes Final */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroPos := 0                   // N£mero de la posici¢n
       LOCAL cIniFin := ''                  // Mes Inicial del Concepto
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DE DECISION
       nMesIni := 0
       nMesFin := 0

       IF EMPTY(PAG->cIniFinPag)
	  nMesIni := PAG->nMesIniPag
	  nMesFin := PAG->nMesFinPag
       ELSE
	  nNroPos := AT(cCodCon,ALLTRIM(PAG->cConcepPag))
	  nNroPos := (nNroPos+1)/2  // Calcula la posici¢n. 2=Longitud

	  cIniFin := SUBS(PAG->cIniFinPag,nNroPos*4-3,4)
	  nMesIni := VAL(SUBS(cIniFin,1,2))
	  nMesFin := VAL(SUBS(cIniFin,3,2))
       ENDIF
       RETURN IF(nMesIni # 0 .AND. nMesFin # 0,.T.,.F.)
*>>>>FIN ANALISIS DE DECISION

/*************************************************************************
* TITULO..: LOCALIZAR ULTIMO RECIBO                                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ABR 19/2004 LUN A
       Colombia, Bucaramanga        INICIO: 05:00 PM   ABR 19/2004 LUN

OBJETIVOS:

1- Localiza el £ltimo recibo impreso

2- Retorna el mes del £ltimo recibo impreso.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nMesUltPag(cCodEst,nMesFin)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante
       nMesFin                              // @Mes Final del Recibo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nMesIni := 0                   // Mes Inicial del Pago
       LOCAL nRegPag := 0                   // Registro de pagos
*>>>>FIN DECLARACION DE VARIABLES

*>>>>FILTRACION DEL ARCHIVO
       nRegPag := PAG->(RECNO())
       SELECT PAG
       SET FILTER TO PAG->cCodigoEst == cCodEst
       PAG->(DBGOTOP())

       IF .NOT. PAG->(EOF())
	  PAG->(DBGOBOTTOM())
	  nMesIni := PAG->nMesIniPag
	  nMesFin := PAG->nMesFinPag
       ENDIF

       SET FILTER TO
       PAG->(DBGOTO(nRegPag))
       RETURN nMesIni
*>>>>FIN FILTRACION DEL ARCHIVO

/*************************************************************************
* TITULO..: LOCALIZAR PRIMER RECIBO                                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 29/2005 VIE A
       Colombia, Bucaramanga        INICIO: 03:00 PM   JUL 29/2005 VIE

OBJETIVOS:

1- Localiza el primer recibo impreso

2- Retorna el mes del £ltimo recibo impreso.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nMesIniPag(cCodEst,nMesFin)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante
       nMesFin                              // @Mes Final del Recibo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nMesIni := 0                   // Mes Inicial del Pago
       LOCAL nRegPag := 0                   // Registro de pagos
*>>>>FIN DECLARACION DE VARIABLES

*>>>>FILTRACION DEL ARCHIVO
       nRegPag := PAG->(RECNO())
       SELECT PAG
       SET FILTER TO PAG->cCodigoEst == cCodEst
       PAG->(DBGOTOP())

       IF .NOT. PAG->(EOF())
	  nMesIni := PAG->nMesIniPag
	  nMesFin := PAG->nMesFinPag
       ENDIF

       SET FILTER TO
       PAG->(DBGOTO(nRegPag))
       RETURN nMesIni
*>>>>FIN FILTRACION DEL ARCHIVO

/*************************************************************************
* TITULO..: NUMERO DE MESES CANCELADOS                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ABR 20/2004 MAR A
       Colombia, Bucaramanga        INICIO: 02:35 PM   ABR 20/2004 MAR

OBJETIVOS:

1- Calcula el total de n£mero de meses pagados.

2- Retorna el total de n£mero de meses pagados.

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nNroMesPag(aFecPag)

*>>>>DESCRIPCION DE PARAMETROS
/*     aFecPag                            // Fecha de Pago */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nTotPag := 0                 // Total meses pagados
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CALCULO DEL TOTAL DE MESES PAGADOS
       IF (PAG->cEstadoPag == 'P' .OR. PAG->cEstadoPag == 'A') .AND.;
	  !EMPTY(PAG->dFecPagPag)

	  IF PAG->nMesIniPag == PAG->nMesFinPag
	     nTotPag := PAG->nMesIniPag - 1
	  ELSE
	     nTotPag := PAG->nMesFinPag - PAG->nMesIniPag + 1
	  ENDIF
	  aFecPag := aFecha(PAG->dFecPagPag)
       ELSE
	  aFecPag := aFecha(CTOD('00/00/00'))
	  nTotPag := 0
       ENDIF
       RETURN nTotPag
*>>>>FIN CALCULO DEL TOTAL DE MESES PAGADOS

/*************************************************************************
* TITULO..: NUMERO DE COUTAS CANCELADAS                                  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 01/2004 MIE A
       Colombia, Bucaramanga        INICIO: 12:35 AM   SEP 01/2004 MIE

OBJETIVOS:

1- Calcula en n£mero de coutas canceladas

2- Retorna el n£mero de coutas canceladas

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nCoutasPag(aDetPag,nMesFac)

*>>>>DESCRIPCION DE PARAMETROS
/*     aDetPag                              // Detalles del Pago
       nMesFac                              // Mes Facturado	*/
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL nMesIni := 0                   // Mes Inicial Facturado
       LOCAL nCouPag := 0                   // Coutas pagadas */
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CALCULO DEL MES INICIAL
       FOR i := 1 TO LEN(aDetPag)
	   IF EMPTY(aDetPag[i,5])
	      LOOP
	   ENDIF
	   nMesIni := i
	   EXIT
       NEXT
*>>>>FIN CALCULO DEL MES INICIAL

*>>>>CALCULO DE LAS COUTAS CANCELADAS
       FOR i := nMesIni TO nMesFac
	   IF LEN(aDetPag) > i
	      IF aDetPag[i+1,2]+aDetPag[i+1,3] == 0  // Deuda+Mora
		 nCouPag++
	      ENDIF
	   ELSE
	      IF aDetPag[i,5] == 'P' .OR.;
		 aDetPag[i,5] == 'A'
		 nCouPag++
	      ENDIF
	   ENDIF
       NEXT
       RETURN nCouPag
*>>>>FIN CALCULO DE LAS COUTAS CANCELADAS

/*************************************************************************
* TITULO..: VALOR DEL MES PROMEDIO                                       *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 01/2004 MIE A
       Colombia, Bucaramanga        INICIO: 12:35 AM   SEP 01/2004 MIE

OBJETIVOS:

1- Calcula el valor del mes promedio

2- Retorna el valor promedio del valor

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nVlrMesPro(aDetPag,nMesFac)

*>>>>DESCRIPCION DE PARAMETROS
/*     aDetPag                              // Detalle de los pagos
       nMesFac                              // Mes facturado */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL	   i := 0                   // Contador
       LOCAL nMesIni := 0                   // Mes Inicial
       LOCAL nMeses  := 0                   // Meses facturados
       LOCAL nVlrMes := 0                   // Valor del Mes
       LOCAL nVlrTot := 0                   // Valor Total
       LOCAL nRegPag := 0                   // Registro de Pago
       LOCAL nTotMes := 0                   // Total de Meses
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CALCULO DEL MES INICIAL
       FOR i := 1 TO LEN(aDetPag)
	   IF EMPTY(aDetPag[i,5])
	      LOOP
	   ENDIF
	   nMesIni := i
	   EXIT
       NEXT
*>>>>FIN CALCULO DEL MES INICIAL

*>>>>CALCULO DEL VALOR DEL MES PROMEDIO
       nRegPag := PAG->(RECNO())

       FOR i := nMesIni TO nMesFac

	   IF EMPTY(aDetPag[i,1])
	      LOOP
	   ENDIF

	   PAG->(DBGOTO(aDetPag[i,6]))

	   nMeses := nNroMesFac(PAG->nMesIniPag,PAG->nMesFinPag)
	   nTotMes += nMeses

	   nVlrMes := nVlrMes()+PAG->nVlrBecPag
	   nVlrMes := nVlrMes-(PAG->nVlrBecPag/nMeses)
	   nVlrTot += nMeses*nVlrMes

       NEXT
       PAG->(DBGOTO(nRegPag))
       RETURN nVlrTot/nTotMes
*>>>>FIN CALCULO DEL VALOR DEL MES PROMEDIO

/*************************************************************************
* TITULO..: UBICACION DEL ULTIMO REGISTRO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 01/2004 MIE A
       Colombia, Bucaramanga        INICIO: 12:35 AM   SEP 01/2004 MIE

OBJETIVOS:

1- Se ubica en el ultimo recibo facturado

2- Retorna el numero del registro

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nUltRecPag(cCodEst)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nRegPag := 0                   // Registro de Pago
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DEL ULTIMO RECIBO
       SELECT PAG
       SET FILTER TO PAG->cCodigoEst == cCodEst
       PAG->(DBGOTOP())
       IF .NOT. PAG->(EOF())
	  PAG->(DBGOBOTTOM())
	  nRegPag := PAG->(RECNO())
	  SELECT PAG
	  PAG->(DBGOTO(nRegPag))
       ENDIF
       SET FILTER TO
       RETURN nRegPag
*>>>>FIN LOCALIZACION DEL ULTIMO RECIBO

/*************************************************************************
* TITULO..: HAY ANTICIPOS CONCEPTOS INDIVIDUALES                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 01/2005 MAR A
       Colombia, Bucaramanga        INICIO: 06:00 PM   FEB 01/2005 MAR

OBJETIVOS:

1- Analiza si se facturo anticipos en conceptos individuales

2- Retorna .T. Si hay anticipos

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lHayAntici(nIniPag,cIniFin)

*>>>>DESCRIPCION DE PARAMETROS
/*     nIniPag			            // Mes Inicial del Pago
       cIniFin                              // Mes Inicial y Final del pago */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL nMesIni := 0                   // Mes Inicial
       LOCAL nMesFin := 0                   // Mes Final
       LOCAL lHayAnt := .F.                 // .T. Hay Anticipos

       LOCAL cMeses  := ''                  // Mes Inicial y Final
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CALCULO DE LOS MESES FACTURADOS
       FOR i := 1 TO LEN(ALLTRIM(cIniFin))/4

	   cMeses  := SUBS(cIniFin,i*4-3,4)
	   nMesIni := VAL(SUBS(cMeses,1,2))
	   nMesFin := VAL(SUBS(cMeses,3,2))

	   IF nMesIni == 0 .OR. nMesFin == 0
	      LOOP
	   ENDIF

	   IF nMesIni # nMesFin
	      lHayAnt := .T.
	      EXIT
	   ENDIF

       NEXT
       RETURN lHayAnt
*>>>>FIN CALCULO DE LOS MESES FACTURADOS

/*************************************************************************
* TITULO..: MES INICIAL Y FINAL FACTURADOS                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE 16/2005 DOM A
       Bucaramanga, Colombia	    INICIO: 12:00 AM   ENE 16/2005 DOM

OBJETIVOS:

1- Permite armar los meses facturados de cada concepto

2- Retorna los meses facturados.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cIniFinPag(nNroCon,cIniFin,nMesIni,nMesFin)

*>>>>DECLARACION DE PARAMETROS
/*     nNroCon                              // N£mero del Concepto
       cIniFin				    // Meses Inicial y Final
       nMesIni                              // @Mes Inicial
       nMesFin                              // @Mes Final */
*>>>>FIN DECLARACION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cMesIni := ''                  // Mes Inicial
       LOCAL cMesFin := ''                  // Mes Final

       LOCAL cMeses  := ''                  // Mes Inicial y Final
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CALCULO DE LOS MESES FACTURADOS
       cMeses  := SUBS(cIniFin,nNroCon*4-3,4)

       cMesIni := SUBS(cMeses,1,2)
       cMesFin := SUBS(cMeses,3,2)

       nMesIni := VAL(cMesIni)
       nMesFin := VAL(cMesFin)

       RETURN cMeses
*>>>>FIN CALCULO DE LOS MESES FACTURADOS

/*************************************************************************
* TITULO..: MES INICIAL Y FINAL DEL CONCEPTO DE PENSION                  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE 16/2005 DOM A
       Bucaramanga, Colombia	    INICIO: 12:00 AM   ENE 16/2005 DOM

OBJETIVOS:

1- Deterima el mes inicial y final de la pension cancelada

2- Deja ubicado el registro de los pagos del ultimo recibo pagado

2- Retorna .T. si no hay problemas

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nIniFinPen(cCodEst,nIniPen,nFinPen)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante
       nIniPen                              // Mes Inicial de la Pension
       nFinPen                              // Mes Final de la Pension */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayPen := .F.                 // .T. Hay Pension
       LOCAL       i := 0                   // Contador
       LOCAL nRegAct := 0                   // Registro Actual
       LOCAL nRegPag := 0                   // N£mero del Registro
       LOCAL aDetPag := 0                   // Detalles de los Pagos
       LOCAL nNroCon := 0                   // N£mero del Concepto
       LOCAL nMesIni := 0                   // Mes Inicial
       LOCAL nMesFin := 0                   // Mes Final
*>>>>FIN DECLARACION DE VARIABLES

*>>>>RECIBOS FACTURADOS
       SELECT PAG
       nRegAct := PAG->(RECNO())
       aDetPag := aRegPagos(cCodEst)
       SET FILTER TO
*>>>>FIN RECIBOS FACTURADOS

*>>>>RECIBOS FACTURADOS
       nIniPen := 0
       nFinPen := 0
       FOR i := 1 TO LEN(aDetPag)

	   PAG->(DBGOTO(aDetPag[i]))

*==========ANALISIS DEL PAGO
	     nMesIni := 0
	     nMesFin := 0

	     nNroCon := AT('PE',PAG->cConcepPag)

	     IF (PAG->cEstadoPag == 'P' .OR. PAG->cEstadoPag == 'A') .AND.;
		!EMPTY(PAG->dFecPagPag) .AND. nNroCon # 0

		lHayPen := .T.
		nRegPag := PAG->(RECNO())

*---------------MES INICIAL Y FINAL DEL MES
		  IF EMPTY(PAG->cIniFinPag)
		     nMesIni := PAG->nMesIniPag
		     nMesFin := PAG->nMesFinPag
		  ELSE
		     cIniFinPag(nNroCon,PAG->cIniFinPag,@nMesIni,@nMesFin)
		  ENDIF
*---------------FIN MES INICIAL Y FINAL DEL MES

*---------------MES INICIAL PAGADO
		  IF i == 1
		     nIniPen := nMesIni
		     nFinPen := nMesFin
		  ENDIF
*---------------FIN MES INICIAL PAGADO

*---------------MES FINAL PAGADO
		  IF i # 1

		     IF nMesIni > nFinPen
			nFinPen := nMesIni
		     ENDIF

		     IF nMesFin > nFinPen
			nFinPen := nMesFin
		     ENDIF

		  ENDIF
*---------------FIN MES FINAL PAGADO

	     ENDIF
*==========FIN ANALISIS DEL PAGO

       NEXT
*>>>>FIN RECIBOS FACTURADOS

*>>>>MES INICIAL PAGADO
       IF lHayPen
	  PAG->(DBGOTO(nRegPag))
       ELSE
	  PAG->(DBGOTO(nRegAct))
       ENDIF
       RETURN nRegPag
*>>>>FIN MES INICIAL PAGADO

/*************************************************************************
* TITULO..: ULTIMO RECIBO Y MES ANTERIOR                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 23/2005 MAR A
       Colombia, Bucaramanga        INICIO: 10:00 AM   AGO 23/2005 MAR

OBJETIVOS:

1- Detemirma cual fue el £ltimo y anterio recibo impreso

2- Retorna el mes del £ltimo recibo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nRecUltAnt(cCodEst,nMesAnt)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante
       nMesAnt                              // Mes Anterior */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroReg := 0                   // N£mero de Recibo
       LOCAL nRegPag := 0                   // Registro de Pagos
       LOCAL aRegPag := {}                  // Registro de Pagos
       LOCAL nMesAct := 0                   // Mes Actual
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DE LOS RECIBOS
       SELECT PAG
       nRegPag := PAG->(RECNO())
       aRegPag := aRegPagos(cCodEst)
       SET FILTER TO
*>>>>FIN ANALISIS DE LOS RECIBOS

*>>>>ANALISIS DE LOS RECIBOS
       nMesAnt := 0
       DO CASE
       CASE LEN(aRegPag) == 1

	    nNroReg := aRegPag[1]
	    PAG->(DBGOTO(nNroReg))
	    nMesAct := PAG->nMesIniPag
	    nMesAnt := PAG->nMesIniPag

       CASE LEN(aRegPag) > 1

	    nNroReg := aRegPag[LEN(aRegPag)]
	    PAG->(DBGOTO(nNroReg))
	    nMesAct := PAG->nMesIniPag

	    nNroReg := aRegPag[LEN(aRegPag)-1]
	    PAG->(DBGOTO(nNroReg))
	    nMesAnt := PAG->nMesIniPag

       ENDCASE
       PAG->(DBGOTO(nRegPag))
       RETURN nMesAct
*>>>>FIN ANALISIS DE LOS RECIBOS

/*************************************************************************
* TITULO..: LOCALIZA EL MES DEL RECIBO DEL MES FACTURADO                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ABR 27/2006 ABR A
       Colombia, Bucaramanga        INICIO: 11:00 AM   ABR 27/2006 ABR

OBJETIVOS:

1- Localiza el mes del recibo del mes facturado, teniendo presente
   los recibos por adelantado.

2- Retorna el mes del recibo del mes facturado.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nRecMesFac(cCodEst,nMesFac)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante
       nMesFac			            // Mes Facturado */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL nRegPag := 0                   // Registro de Pagos
       LOCAL nNroReg := 0                   // N£mero de Recibo
       LOCAL nMesIni := 0                   // Mes Inicial del Recibo
       LOCAL aRegPag := {}                  // Registro de Pagos
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DE LOS RECIBOS
       SELECT PAG
       nRegPag := PAG->(RECNO())
       aRegPag := aRegPagos(cCodEst)
       SET FILTER TO
*>>>>FIN ANALISIS DE LOS RECIBOS

*>>>>ANALISIS DE LOS RECIBOS
       FOR i := 1 TO LEN(aRegPag)

	   nNroReg := aRegPag[i]
	   PAG->(DBGOTO(nNroReg))

	   IF nMesFac >= PAG->nMesIniPag .AND. nMesFac <= PAG->nMesFinPag

	      DO CASE
	      CASE PAG->nMesIniPag == PAG->nMesFinPag

		   nMesIni := PAG->nMesIniPag
		   EXIT

	      CASE PAG->nMesFinPag > PAG->nMesIniPag .AND.;
		   PAG->cEstadoPag # 'D'

		   nMesIni := PAG->nMesIniPag
		   EXIT

	      ENDCASE

	   ENDIF

       ENDFOR
       PAG->(DBGOTO(nRegPag))
       RETURN nMesIni
*>>>>FIN ANALISIS DE LOS RECIBOS

/*************************************************************************
* TITULO..: VALIDACION DE LA FACTURACION DEL MES                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAR 20/2007 MAR A
       Colombia, Bucaramanga        INICIO: 08:45 AM   MAR 20/2007 MAR

OBJETIVOS:

1- Permite validar la valores de la facturaci¢n del mes.

2- Retorna 0 si la cuenta no tiene problemas.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cValFacMes(cCodEst,nMesIni,nDeuAnt,nMorAnt,nVlrMes,nVlrPag)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante
       nMesIni                              // Mes Inicial de la Facturaci¢n.
       nDeuAnt                              // Deuda Anterior
       nMorAnt                              // Mora Anterior
       nVlrMes			            // Valor del Mes
       nVlrPag                              // Valor a Pagar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cHayErr := ''                  // Hay Error

       LOCAL       i := 0                   // Contador
       LOCAL nNroCon := 0                   // N£mero de Conceptos
       LOCAL nNroPos := 0                   // N£mero de la posici¢n
       LOCAL nVlrCon := 0                   // Valor del Concepto
       LOCAL nTotCon := 0                   // Valor total de los conceptos
       LOCAL nTotMes := 0                   // Valor del Mes
       LOCAL nBecMes := 0                   // Valor de la Beca Mensual
       LOCAL nMesFin := 0                   // Mes Final
       LOCAL nAntici := 0                   // Valor de los Anticipos
       LOCAL nTotPag := 0                   // Valor a Pagar

       LOCAL cCodigoTco := ''               // C¢digo del Concepto
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DE DECISION
       IF PAG->cCodigoEst # cCodEst .OR.;
	  PAG->nMesIniPag # nMesIni
	  RETURN 'CODIGO O MES INCORRECTO'
       ENDIF
*>>>>FIN ANALISIS DE DECISION

*>>>>VALIDACION DEL NUMERO DE CONCEPTOS
       nNroCon := LEN(ALLTRIM(PAG->cConcepPag))/2

       IF !EMPTY(PAG->cIniFinPag) .AND.;
	  LEN(ALLTRIM(PAG->cIniFinPag))/4 # nNroCon
	  RETURN 'MESES INDIVIDUALES INCORRECTO'
       ENDIF
*>>>>FIN VALIDACION DEL NUMERO DE CONCEPTOS

*>>>>VALIDACION DE LA FACTURACION DEL MES
       nTotCon := 0
       cHayErr := ''
       FOR i := 1 TO nNroCon

***********VALIDACION DEL CODIGO DEL CONCEPTO
	     cCodigoTco := SUBS(PAG->cConcepPag,i*2-1,2)

	     nNroPos := AT(cCodigoTco,PAG->cConcepPag)
	     IF lPar(nNroPos)
		cHayErr := cCodigoTco+' '+ALLTRIM(PAG->cConcepPag)
	     ENDIF
	     nNroPos := (nNroPos+1)/2
***********FIN VALIDACION DEL CODIGO DEL CONCEPTO

***********VALIDACION DEL VALOR DEL CONCEPTO
	     nVlrCon := &('PAG->nVlrCo'+STR(nNroPos,1)+'Pag')
	     IF EMPTY(cHayErr) .AND. nVlrCon == 0
		cHayErr :=  cCodigoTco+' SIN VALOR DEFINIDO'
	     ENDIF
	     nTotCon += nVlrCon
***********FIN VALIDACION DEL VALOR DEL CONCEPTO

***********VALIDACION MESES DE FACTURACION
	     IF !EMPTY(PAG->cIniFinPag)
		cIniFinPag(i,PAG->cIniFinPag,@nMesIni,@nMesFin)
	     ELSE
		nMesIni := PAG->nMesIniPag
		nMesFin := PAG->nMesFinPag
	     ENDIF

	     IF EMPTY(cHayErr) .AND. (nMesIni == 0 .OR. nMesFin == 0)
		cHayErr := 'MES INICIAL O FINAL EN CEROS'
	     ENDIF
***********FIN VALIDACION MESES DE FACTURACION

***********ANALISIS DE DECISION
	     IF !EMPTY(cHayErr)
		EXIT
	     ENDIF
***********FIN ANALISIS DE DECISION

***********CALCULO DE LOS ANTICIPOS
	     IF nNroMesFac(nMesIni,nMesFin)-1 > 0
		nAntici += nVlrCon*(nNroMesFac(nMesIni,nMesFin)-1)
	     ENDIF
***********FIN CALCULO DE LOS ANTICIPOS

       ENDFOR
*>>>>FIN VALIDACION DE LA FACTURACION DEL MES

*>>>>CALCULO DEL VALOR DEL MES
      IF EMPTY(cHayErr)
	 lBecaMes('PE',@nBecMes)
	 nTotMes := nTotCon - nBecMes - PAG->nVlrDesPag -;
			      PAG->nDesGenPag - PAG->nPagParPag +;
			      PAG->nVlrRecPag + PAG->nRecGenPag

      ENDIF
*>>>>FIN CALCULO DEL VALOR DEL MES

*>>>>VALIDACION DEL VALOR DEL MES
       IF EMPTY(cHayErr) .AND. nVlrMes # nTotMes
	  cHayErr := 'VALOR DEL MES INCORRECTO.'+cMes(nMesIni)
       ENDIF
*>>>>FIN VALIDACION DEL VALOR DEL MES

*>>>>VALIDACION DEL VALOR A PAGAR
       IF PAG->cEstadoPag == 'D'
	  nTotPag := nDeuAnt+nMorAnt+nTotMes-;
		     (PAG->nVlrBecPag - nBecMes)
       ELSE
	  nTotPag := nDeuAnt+nMorAnt+nTotMes+nAntici-;
		     (PAG->nVlrBecPag - nBecMes)
       ENDIF

       IF EMPTY(cHayErr) .AND. nTotPag # nVlrPag
	  cHayErr := 'VALOR A PAGAR INCORRECTO.'+cMes(nMesIni)
       ENDIF
       RETURN cHayErr
*>>>>FIN VALIDACION DEL VALOR A PAGAR

/*************************************************************************
* TITULO..: INTERESES DEL MES                                            *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 23/2007 VIE A
       Bucaramanga, Colombia        INICIO: 03:30 PM   JUN 23/2007 VIE

OBJETIVOS:

1- Calcula el valor de los intereses del Mes

2- Retorna el valor de los intereses.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nIntMesNew(nVlrDeu)

*>>>>DESCRIPCION DE PARAMETROS
/*     nVlrDeu                              // Valor de la deuda */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nVlrInt := 0                   // Valor de los intereses

       LOCAL nIntMor := 0                   // Intereses pago oportuno
       LOCAL nIntDeu := 0                   // Intereses no pago


       LOCAL nVlrMor := 0                   // Valor mora pago oportuno
       LOCAL nMorVlr := 0                   // Volor mora no pago
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DE DECISION
       IF PAG->lIntPenPag

	  nIntMor := PAG->nIntMorPag
	  nIntDeu := PAG->nIntDeuPag
	  IF nIntDeu == 0
	     nIntDeu := nIntMor
	  ENDIF
       ELSE
	  nVlrMor := PAG->nVlrMorPag
	  nMorVlr := PAG->nVlrDeuPag
	  IF nMorVlr == 0
	     nMorVlr := nVlrMor
	  ENDIF
       ENDIF
*>>>>FIN ANALISIS DE DECISION

*>>>>CALCULO DE LOS INTERESES
       IF PAG->lIntPenPag

	  IF PAG->cEstadoPag == '*' .OR.;
	     PAG->cEstadoPag == 'D'
	     nVlrInt := ROUND(((nVlrDeu)*nIntDeu)/100,0)
	  ELSE
	     nVlrInt := ROUND(((nVlrDeu)*nIntMor)/100,0)
	  ENDIF

       ELSE

	  IF PAG->cEstadoPag == '*' .OR.;
	     PAG->cEstadoPag == 'D'
	     nVlrInt := nMorVlr
	  ELSE
	     nVlrInt := nVlrMor
	  ENDIF

       ENDIF
       RETURN ABS(nVlrInt)
*>>>>FIN CALCULO DE LOS INTERESES

/*************************************************************************
* TITULO..: CONCEPTOS FACTURADOS                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 14/2008 SAB A
       Bucaramanga, Colombia        INICIO: 10:00 PM   JUN 14/2008 SAB

OBJETIVOS:

1- Calcula el pago de los conceptos

2- Retorna el pago de los conceptos

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aConcepFac(cCodEst)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL     i,j := 0                   // Contador
       LOCAL nNroReg := 0                   // N£mero de registro
       LOCAL aRegPag := 0                   // Registros de pagos

       LOCAL nMesIni := 0                   // Mes Inicial
       LOCAL nMesFin := 0                   // Mes Final
       LOCAL cCodCon := ''                  // Codigo del Concepto
       LOCAL cNomCon := ''                  // Nombre del Concepto
       LOCAL aDetArr := {}                  // Detalles del Array
       LOCAL aConFac := {}                  // Conceptos Facturados
*>>>>FIN DECLARACION DE VARIABLES

*>>>>REGISTROS DE PAGOS
       SELECT PAG
       nNroReg := PAG->(RECNO())
       aRegPag := aRegPagos(cCodEst)
*>>>>FIN REGISTROS DE PAGOS

*>>>>RECORRIDO DE LOS RECIBOS
       FOR i := 1 TO LEN(aRegPag)

	   PAG->(DBGOTO(aRegPag[i]))

***********ANALISIS DE LOS CONCEPTOS
	     FOR j := 1 TO LEN(ALLTRIM(PAG->cConcepPag))/2

*================MESES PAGADOS
		   cCodCon := SUBS(PAG->cConcepPag,j*2-1,2)
		   IF !lIniFinCon(cCodCon,@nMesIni,@nMesFin)
		      LOOP
		   ENDIF
*================FIN MESES PAGADOS

*================LOCALIZACION DEL REGISTRO
		   cNomCon :=cCodCon+' NO EXISTE'
		   IF lLocCodigo('cCodigoCon','CON',cCodCon)
		      cNomCon := CON->cNombreCon
		   ENDIF
*================FIN LOCALIZACION DEL REGISTRO

*================PAGOS DE CONCEPTOS
		   aDetArr := {}
		   AADD(aDetArr,{'cCodCon',cCodCon})
		   AADD(aDetArr,{'cNomCon',cNomCon})
		   AADD(aDetArr,{'nMesIni',PAG->nMesIniPag})
		   AADD(aDetArr,{'nMesFin',PAG->nMesFinPag})
		   AADD(aDetArr,{'nIniCon',nMesIni})
		   AADD(aDetArr,{'nFinCon',nMesFin})
		   AADD(aDetArr,{'cForPag',PAG->cEstadoPag})
		   AADD(aDetArr,{'nRegPag',PAG->(RECNO())})

		   AADD(aConFac,aDetArr)
*================FIN PAGOS DE CONCEPTOS

	     ENDFOR
***********FIN ANALISIS DE LOS CONCEPTOS

       ENDFOR
       PAG->(DBGOTO(nNroReg))
       RETURN aConFac
*>>>>FIN RECORRIDO DE LOS RECIBOS

/*************************************************************************
* TITULO..: TOTAL CONCEPTOS FACTURADOS                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 15/2008 DOM A
       Bucaramanga, Colombia        INICIO: 12:30 AM   JUN 15/2008 DOM

OBJETIVOS:

1- Calcula los conceptos pagados

2- Retorna los conceptos pagados

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aTotConFac(cCodEst)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL   i,j,k := 0                   // Contador

       LOCAL aArray1 := {}                  // Detalles de Array
       LOCAL aArray2 := {}                  // Detalles de Array

       LOCAL nNroReg := 0                   // N£mero de registro
       LOCAL cCodCon := ''                  // C¢digo del Concepto
       LOCAL cNomCon := ''                  // Nombre del Concepto
       LOCAL nIniCon := 0                   // Mes Inicial del Concepto
       LOCAL nFinCon := 0                   // Mes Final del Concepto
       LOCAL cForPag := ''                  // Forma de pago
       LOCAL cMesPag := ''                  // Meses de Pago
       LOCAL aTotFac := {}                  // Total Conceptos Facturados
       LOCAL aConFac := {}                  // Conceptos facturados
*>>>>FIN DECLARACION DE VARIABLES

*>>>>RECORRIDO DE LOS CONCEPTOS FACTURADOS
       nNroReg := PAG->(RECNO())
       aConFac := aConcepFac(cCodEst)
       PAG->(DBGOTO(nNroReg))

       FOR i := 1 TO LEN(aConFac)

***********LECTURA DE LOS CONCEPTOS FACTURADOS
	     aArray1 := aConFac[i]
	     cCodCon := xPrm(aArray1,'cCodCon')
	     cNomCon := xPrm(aArray1,'cNomCon')
	     nIniCon := xPrm(aArray1,'nIniCon')
	     nFinCon := xPrm(aArray1,'nFinCon')
	     cForPag := xPrm(aArray1,'cForPag')
***********FIN LECTURA DE LOS CONCEPTOS FACTURADOS

***********ANALISIS DE PAGO DE CONCEPTOS
	     aArray2 := {}
	     AADD(aArray2,cCodCon)   // Campo a Validar
	     AADD(aArray2,cNomCon)
	     AADD(aArray2,SPACE(12)) // Meses de Pago

	     ValRegArr(@aTotFac,aArray2,{1}) // Validar cCodCon
***********FIN ANALISIS DE PAGO DE CONCEPTOS

***********ANALISIS DE LA FORMA DE PAGO
	     j := ASCAN(aTotFac,{|aArray|aArray[1] == cCodCon})
	     cMesPag := aTotFac[j,3]

	     FOR k := nIniCon TO nFinCon
		 cMesPag := STUFF(cMesPag,k,1,cForPag)
	     ENDFOR
	     aTotFac[j,3] := cMesPag
***********FIN ANALISIS DE LA FORMA DE PAGO

       ENDFOR
*>>>>FIN RECORRIDO DE LOS CONCEPTOS FACTURADOS

*>>>>ANALISIS DE LOS MESES PAGADOS
       aArray1 := aTotFac
       aTotFac := {}

       FOR i := 1 TO LEN(aArray1)

***********LECTURA DEL CONCEPTO
	     cCodCon := aArray1[i,1]
	     cNomCon := aArray1[i,2]
	     cMesPag := aArray1[i,3]
***********FIN LECTURA DEL CONCEPTO

***********MES INICIAL DEL CONCEPTO
	     FOR j := 1 TO LEN(cMesPag)
		 cForPag := SUBS(cMespag,j,1)
		 IF !EMPTY(cForPag)
		    nIniCon := j
		    EXIT
		 ENDIF
	     ENDFOR
***********FIN MES INICIAL DEL CONCEPTO

***********MES FINAL DEL CONCEPTO
	     FOR j := LEN(cMesPag) TO 0 STEP -1
		 cForPag := SUBS(cMespag,j,1)
		 IF !EMPTY(cForPag)
		    nFinCon := j
		    EXIT
		 ENDIF
	     ENDFOR
***********FIN MES FINAL DEL CONCEPTO

***********PAGO DE CONCEPTOS
	     aArray2 := {}
	     AADD(aArray2,{'cCodCon',cCodCon})
	     AADD(aArray2,{'cNomCon',cNomCon})
	     AADD(aArray2,{'nIniCon',nIniCon})
	     AADD(aArray2,{'nFinCon',nFinCon})
	     AADD(aArray2,{'cMesPag',cMesPag})

	     AADD(aTotFac,aArray2)
***********FIN PAGO DE CONCEPTOS

       ENDFOR
       RETURN aTotFac
*>>>>ANALISIS DE LOS MESES PAGADOS

/*************************************************************************
* TITULO..: CONSULTAR LOS CONCEPTOS PAGADOS                              *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 16/2008 LUN A
       Colombia, Bucaramanga        INICIO: 10:30 PM   JUN 16/2008 LUN

OBJETIVOS:

1- Consulta los conceptos pagados

2- Retorna Nil


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION VisConPago(nFilInf,cCodEst)

*>>>>DECLARACION DE PARAMETROS
/*     nFilInf                              // Fila Inferior del SubMen£
       cCodEst                              // C¢digo del Estudiante */
*>>>>FIN DECLARACION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador

       LOCAL nNroFil := 0                   // N£mero de la fila
       LOCAL aNroCol := {}                  // Numeros de Columna
       LOCAL cCabeza := ''                  // Encabezado de columna

       LOCAL aConFac := {}                  // Conceptos pagados
       LOCAL aArrPrm := {}                  // Array de Parametros

       LOCAL cCodCon := ''                  // C¢digo del Concepto
       LOCAL cNomCon := ''                  // Nombre del Concepto
       LOCAL nIniCon := 0                   // Mes Inicial del Concepto
       LOCAL nFinCon := 0                   // Mes Final del Concepto
       LOCAL cMesPag := ''                  // Meses de Pago

       MEMVA xClrSys			    // Color del Sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>IMPRESION DE LOS ENCABEZADOS
       nNroFil := nMarco(nFilInf+1,'',22,'°')
       cCabeza := cRegPrint({'CONCEPTO',;
			     'MES INICIAL',;
			     'MES FINAL ',;
			     'MESES PAGOS '},;
			    {16,12,12,12},@aNroCol)
       @ nNroFil-2,01 SAY cCabeza
*>>>>FIN IMPRESION DE LOS ENCABEZADOS

*>>>>LECTURA DE LOS CONCEPTOS PAGADOS
       aConFac := aTotConFac(cCodEst)

       FOR i := 1 TO LEN(aConFac)

***********LECTURA DEL CONCEPTO PAGADO
	     aArrPrm := aConFac[i]

	     cCodCon := xPrm(aArrPrm,'cCodCon')
	     cNomCon := xPrm(aArrPrm,'cNomCon')
	     nIniCon := xPrm(aArrPrm,'nIniCon')
	     nFinCon := xPrm(aArrPrm,'nFinCon')
	     cMesPag := xPrm(aArrPrm,'cMesPag')
***********FIN LECTURA DEL CONCEPTO PAGADO

***********CONSULTA DEL CONCEPTO PAGADO
	     @ nNroFil,aNroCol[1] SAY cNomCon
	     @ nNroFil,aNroCol[2] SAY cMes(nIniCon)
	     @ nNroFil,aNroCol[3] SAY cMes(nFinCon)
	     @ nNroFil,aNroCol[4] SAY cMesPag
***********FIN CONSULTA DEL CONCEPTO PAGADO

***********CONTROL DE LA FILA DE VISUALIZACION
	     nNroFil++
	     IF nNroFil > 20
		cPausa()
		nNroFil := nMarco(nFilInf+1,'',22,'°')
		@ nNroFil-2,01 SAY cCabeza
	     ENDIF
***********CONTROL DE LA FILA DE VISUALIZACION

       ENDFOR
       cPausa()
       RETURN NIL
*>>>>FIN LECTURA DE LOS CONCEPTOS PAGADOS

/*************************************************************************
* TITULO..: VALOR DE LOS PAGOS                                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 01/2005 MIE A
       Colombia, Bucaramanga        INICIO: 05:30 PM   JUN 01/2005 MIE

OBJETIVOS:

1- Clasifica los pagos de acuerdo al a¤o y mes.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aVlrPagos(dFecPag,nVlrPag,aVlrPag,nTipPag,cCodBan)

*>>>>DESCRIPCION DE PARAMETROS
/*     dFecPag                              // Fecha de Pago
       nVlrPag                              // Valor Pagado
       aVlrPag                              // Valor de los Pagos
       nTipPag                              // Tipo de Pago. 1=Recibos 2=Abonos 3=Inscripciones 4=Pagos Parciales
       cCodBan                              // C¢digo del Banco  */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL     i,j := 0                   // Contadores
       LOCAL nAnoPag := 0                   // A¤o del Pago
       LOCAL nMesPag := 0                   // Mes del Pago
*>>>>FIN DECLARACION DE VARIABLES

*>>>>INICIALIZACION DEL PAGO
       nAnoPag := YEAR(dFecPag)
       nMesPag := MONTH(dFecPag)
       cCodBan := IF(cCodBan==NIL,'01',cCodBan)

       IF EMPTY(aVlrPag)

	  AADD(aVlrPag,{nAnoPag,;      // 1. A¤o
			nMesPag,;      // 2. Mes
			0,;            // 3. Recibos.        Tipo = 1
			0,;            // 4. Abonos          Tipo = 2
			0,;            // 5. Inscripciones   Tipo = 3
			0,;            // 6. Pagos Parciales Tipo = 4
			cCodBan})      // 7. C¢digo del Banco

	  aVlrPag[1][nTipPag+2] := nVlrPag

	  RETURN NIL
       ENDIF
*>>>>FIN INICIALIZACION DEL PAGO

*>>>>BUSQUEDA DEL PAGO
       FOR i := 1 TO LEN(aVlrPag)
	   IF aVlrPag[i][1] == nAnoPag .AND.;
	      aVlrPag[i][2] == nMesPag .AND.;
	      aVlrPag[i][7] == cCodBan
	      j := i
	      EXIT
	   ENDIF
       ENDFOR
*>>>>FIN BUSQUEDA DEL PAGO

*>>>>CLASIFICACION DEL PAGO
       IF j == 0
	  AADD(aVlrPag,{nAnoPag,;      // 1. A¤o
			nMesPag,;      // 2. Mes
			0,;            // 3. Recibos.        Tipo = 1
			0,;            // 4. Abonos          Tipo = 2
			0,;            // 5. Inscripciones   Tipo = 3
			0,;            // 6. Pagos Parciales Tipo = 4
			cCodBan})      // 7. C¢digo del Banco

	  aVlrPag[LEN(aVlrPag)][nTipPag+2] := nVlrPag

       ELSE
	  aVlrPag[j][nTipPag+2] += nVlrPag
       ENDIF
       RETURN NIL
*>>>>FIN CLASIFICACION DEL PAGO

/*************************************************************************
* TITULO..: VALOR DE LOS PAGOS                                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 01/2005 MIE A
       Colombia, Bucaramanga        INICIO: 05:30 PM   JUN 01/2005 MIE

OBJETIVOS:

1- Clasifica los pagos de acuerdo al a¤o y mes.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/


FUNCTION VerDetPag(aDetPag)

*>>>>DESCRIPCION DE PARAMETROS
/*     aDetPag                              // Detalles de los pagos */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL nNroFil := 0                   // N£mero de la Fila
       LOCAL aNroCol := {}                  // Numeros de Columna
       LOCAL cCabeza := ''                  // Encabezado de columna
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DEFINICION DEL ENCABEZADO
       cCabeza := cRegPrint({'MES  ',;
			     'DEUDA',;
			     'MORA',;
			     'VLR MES',;
			     'ESTADO',;
			     'REGI'},;
			    {6,12,12,12,14,04},@aNroCol)
*>>>>FIN DEFINICION DEL ENCABEZADO

*>>>>DETALLES DE LOS PAGOS
       IF LEN(aDetPag) > 0

**********CONSULTA
	    nNroFil := nMarco(10)
	    @ nNroFil-2,01 SAY cCabeza

	    FOR i := 1 TO LEN(aDetPag)
		@ nNroFil,aNroCol[1]+0 SAY cMes(aDetPag[i,1],3)
		@ nNroFil,aNroCol[2]-3 SAY aDetPag[i,2]
		@ nNroFil,aNroCol[3]-3 SAY aDetPag[i,3]
		@ nNroFil,aNroCol[4]-3  SAY aDetPag[i,4]
		@ nNroFil,aNroCol[5]-0  SAY aDetPag[i,5]
		@ nNroFil,aNroCol[6]-4  SAY aDetPag[i,6]
		nNroFil++
	    ENDFOR
**********FIN CONSULTA

       ELSE
	  cError('aDetPag ESTA VACIO')
       ENDIF
       RETURN NIL
*>>>>FIN DETALLES DE LOS PAGOS

