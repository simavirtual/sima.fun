/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		BIBLIOTECAS DE FUNCIONES GENERALES DE DESCUENTOS

OBJETIVOS:

- Definici¢n de funciones generales para el SIMA

***************************************************************************
*-------------------- DECLARACION DE LAS FUNCIONES -----------------------*
**************************************************************************/

*>>>>DECLARACION DE CONSTANTES GENERALES
       #INCLUDE "inkey.ch"
*>>>>FIN DECLARACION DE CONSTANTES GENERALES

/*************************************************************************
* TITULO DE LA FUNCION..: CREACION DE LA ESTRUCTURA                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC 21/94 JUE A
						       DIC 21/94 JUE
OBJETIVOS:

1)- Crea la estructura del archivo Descuentos

2)- Retorna NIL

SINTAXIS:

   CreaDbfDes(PathDes,FileDes,fNtxDes)

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfDes(lShared,nModCry,PathDes,FileDes,fNtxDes,aStrDbf)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       PathDes				    // Path del Archivo
       FileDes				    // Nombre del Archivo
       fNtxDes				    // Archivo de Indices
       aStrDbf                              // @Estructura de las bases */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL PathAct := ''                  // Path Actual

       LOCAL aDbfDes := {{"cCodigoEst","Character",06,0},; // C¢digo del Estudiante
			 {"cApelliEst","Character",30,0},; // Apellido del Estudiante
			 {"cNombreEst","Character",30,0},; // Nombre del Estudiante
			 {"nNroMesDes","Numeric"  ,02,0},; // N£mero del Mes del Descuento
			 {"nMesModDes","Numeric"  ,02,0},; // Mes modificado por el Abono
			 {"nTipDesDes","Numeric"  ,02,0},; // Tipo de Descuento
			 {"lDesEfeDes","Logical"  ,01,0},; // .T. Descuento del Efectivo .F. No Descuento de Efectio implica ingreso
			 {"cDescriDes","Character",40,0},; // Descripci¢n del Descuento
			 {"nValorDes" ,"Numeric"  ,10,2},; // Valor del Descuento
			 {"nMorAnoDes","Numeric"  ,10,2},; // Mora Abonada A¤o Anterior
			 {"nSdoAnoDes","Numeric"  ,10,2},; // Saldo Abonada A¤o Anterior
			 {"dFechaDes" ,"Date"     ,08,0},; // Fecha del Descuento
			 {"nSdoAnoPag","Numeric"  ,10,2},; // Saldo del a¤o Anterior
			 {"nMorAnoPag","Numeric"  ,10,2},; // Valor Mora del a¤o Anterior
			 {"nSdoAntPag","Numeric"  ,10,2},; // Saldo Anterior del abono
			 {"nMorAntPag","Numeric"  ,10,2},; // Valor Mora Anterior del abono
			 {"nVlrMesPag","Numeric"  ,10,2},; // Valor del Mes del Abono
			 {"nVlrMorPag","Numeric"  ,10,2},; // Valor de la mora
			 {"nAnoSdoPag","Numeric"  ,10,2},; // Saldo del a¤o Anterior
			 {"nAnoMorPag","Numeric"  ,10,2},; // Valor Mora del a¤o Anterior
			 {"nSdoAntDes","Numeric"  ,10,2},; // Saldo Anterior
			 {"nMorAntDes","Numeric"  ,10,2},; // Valor Mora Anterior
			 {"nVlrMesDes","Numeric"  ,10,2},; // Valor del Mes del Abono
			 {"nVlrMorDes","Numeric"  ,10,2},; // Valor de la mora
			 {"nAboOtrDes","Numeric"  ,10,2},; // Valor del Abono otros meses
			 {"nNroFacCaA","Numeric"  ,12,0},; // N£mero Consecutivo de la Factura
			 {"cCodigoFpg","Character",02,0},; // Forma de Forma de Pago. Ej: Por Banco,Por Caja,Tarjeta Debito,Tarjeta Cr‚dito.
			 {"cNroFpgDes","Character",20,0},; // N£mero del Documento de la forma de pago.
			 {"cConcepDes","Character",16,0},; // Conceptos del Pago
			 {"nVlrCo1Des","Numeric"  ,10,2},; // Valor del Concepto No. 1
			 {"nVlrCo2Des","Numeric"  ,10,2},; // Valor del Concepto No. 2
			 {"nVlrCo3Des","Numeric"  ,10,2},; // Valor del Concepto No. 3
			 {"nVlrCo4Des","Numeric"  ,10,2},; // Valor del Concepto No. 4
			 {"nVlrCo5Des","Numeric"  ,10,2},; // Valor del Concepto No. 5
			 {"nVlrCo6Des","Numeric"  ,10,2},; // Valor del Concepto No. 6
			 {"nVlrCo7Des","Numeric"  ,10,2},; // Valor del Concepto No. 7
			 {"nVlrCo8Des","Numeric"  ,10,2},; // Valor del Concepto No. 8
			 {"cCodigoBan","Character",02,0},; // C¢digo del Banco
			 {"cNomUsrDes","Character",10,0},; // Nombre del Usuario
			 {"dFecUsrDes","Date"     ,08,0},; // Fecha del Usuario
			 {"cHorUsrDes","Character",10,0},; // Hora del Usuario
			 {"lAboActDes","Logical"  ,01,0},; // .T. Actualizado el Abono
			 {"cNombreCon","Character",16,0}}  // Nombre del Concepto
*>>>>FIN DECLARACION DE VARIABLES

*>>>>RETORNO DE LA ESTRUCTURA
       IF !EMPTY(aStrDbf)
	  aStrDbf := aDbfDes
	  RETURN NIL
       ENDIF
*>>>>FIN RETORNO DE LA ESTRUCTURA

*>>>>CREACION DE LA ESTRUCTURA
       PathAct := cPathAct()
       DO CASE
       CASE DIRCHANGE(PathDes) == 0
	    DBCREATE(FileDes,aDbfDes,"DBFNTX")
	    Proteger(FileDes,nModCry)

       CASE DIRCHANGE(PathDes) == -3
	    cError('NO EXISTE EL DIRECTORIO: '+PathDes)

       CASE DIRCHANGE(PathDes) == -5
	    cError('NO TIENE DERECHOS EN: '+PathDes)
       ENDCASE

       DIRCHANGE(PathAct)
       RETURN NIL
*>>>>FIN CREACION DE LA ESTRUCTURA

/*************************************************************************
* TITULO DE LA FUNCION..: RECUPERACION DE LA ESTRUCTURA                  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC 21/94 JUE A
						       DIC 21/94 JUE
OBJETIVOS:

1)- Recupera la estructura del archivo de Descuentos

2)- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RecuDbfDes(lShared,nModCry,PathDes,FileDes,fNtxDes)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                        // .T. Sistema Compartido
       nModCry                        // Modo de Protecci¢n
       PathDes			      // Path del Archivo
       FileDes			      // Nombre del Archivo
       fNtxDes			      // Archivo de Indice */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>RECUPERA LA ESTRUCTURA DEL ARCHIVO
       SAVE SCREEN
       cError("SE BORRO EL ARCHIVO "+PathDes+'\'+FileDes,;
	      "Error Grave. TOME NOTA",;
	      "Al Presionar Cualquier tecla se crea el archivo")
       Termometro(0,"CREANDO LA ESTRUCTURA DE DESCUENTOS")
       Termometro(100)
       CreaDbfDes(lShared,nModCry,PathDes,FileDes,fNtxDes)
       RESTORE SCREEN
       RETURN NIL
*>>>>FIN RECUPERA LA ESTRUCTURA DEL ARCHIVO

/*************************************************************************
* TITULO DE LA FUNCION..: ACTUALIZACION DE LA ESTRUCTURA                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 13/99 VIE A
       Colombia, Bucaramanga        INICIO: 06:30 PM   AGO 13/99 VIE

OBJETIVOS:

1)- Actualiza la Estructura del Archivo

2)- Retorna el N£mero de Error:
    0 => No hay Error
	 Estructura Actualizada
	 Estructura Sin problemas
    1 => Estructura No Actualizada

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nActStrDes(lShared,nModCry,PathArc,cNomArc)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       PathArc				    // Path del Archivo
       cNomArc				    // Nombre del Archivo */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL nNroErr := 0                   // N£mero del Error
       LOCAL       i := 0                   // Contador
       LOCAL aStrNew := {'1'}               // Estructura Nueva
       LOCAL aStrOld := {}                  // Estructura Vieja
       LOCAL lCambio := .F.                 // .T. Cambio la Estructura
       LOCAL FileTem := ''                  // Archivo temporal
*>>>>FIN DECLARACION DE VARIABLES

*>>>>SELECCION DE LAS AREAS DE TRABAJO
       IF !lUseDbf(.T.,PathArc+'\'+cNomArc,'DES',NIL,lShared,nModCry)
	  cError('ABRIENDO EL ARCHIVO DE DESCUENTOS')
	  CloseDbf('DES',PathArc+'\'+cNomArc,nModCry)
	  RETURN nNroErr := 1
       ENDIF
       aStrOld := DES->(DBSTRUCT())
       CloseDbf('DES',PathArc+'\'+cNomArc,nModCry)
       CreaDbfDes(lShared,nModCry,PathArc,cNomArc,NIL,@aStrNew)
*>>>>FIN SELECCION DE LAS AREAS DE TRABAJO

*>>>>VALIDACION DE LA ESTRUCTURA
       lCambio := .T.
       IF LEN(aStrNew) == LEN(aStrOld)
	  lCambio := .F.
	  nNroErr := 1
       ENDIF

       IF !lCambio
	  FOR i := 1 TO LEN(aStrNew)
	      IF UPPER(aStrNew[i,1]) # UPPER(aStrOld[i,1]) .OR.;
		 UPPER(SUBS(aStrNew[i,2],1,1)) # UPPER(SUBS(aStrOld[i,2],1,1)) .OR.;
		 aStrNew[i,3] # aStrOld[i,3] .OR.;
		 aStrNew[i,4] # aStrOld[i,4]
		 lCambio := .T.
		 EXIT
	      ENDIF
	  ENDFOR
       ENDIF
*>>>>FIN VALIDACION DE LAS STRUCTURAS

*>>>>CONFIRMACION DE LA ACTUALIZACION
       IF lCambio
	  cError('El Archivo DESCUENTOS su Estructura Esta DesActualizada.',;
		 'ATENCION',;
		 'Para Actualizarla NO Debe Haber Ning£n Usuario en la Red.')
	  lCambio := lPregunta('DESEA ACTUALIZAR LA ESTRUCTURA? No Si')
	  IF !lCambio
	     nNroErr := 1
	  ENDIF
       ENDIF
*>>>>FIN CONFIRMACION DE LA ACTUALIZACION

*>>>>ACTUALIZACION DE LA STRUCTURA
       IF lCambio
	  nNroErr := 0
	  FileTem := SUBS(cNomArc,1,AT('.',cNomArc))+'STR'
	  cSavPan := SAVESCREEN(0,0,24,79)
	  IF !lStrucFile(lShared,;
			 PathArc+'\'+cNomArc,;
			 PathArc+'\'+FileTem,;
			 {||CreaDbfDes(lShared,nModCry,PathArc,FileTem)},;
			 nModCry)
	     cError('NO SE ACTUALIZO LA ESTRUCTURA DEL ARCHIVO')
	     nNroErr := 1
	  ENDIF
	  RESTSCREEN(0,0,24,79,cSavPan)
       ENDIF
       RETURN nNroErr
*>>>>FIN ACTUALIZACION DE LA STRUCTURA

/*************************************************************************
* TITULO DE LA FUNCION..: ENCONTRAR EL CODIGO DEL CLIENTE CON DESCUENTO  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 09/94 SAB A
						       JUL 09/94 SAB
OBJETIVOS:

1- Debe estar en uso el archivo de Descuentos indexado

2- Verifica la existencia del c¢digo del Descuento

3- Deja el archivo en el registro del c¢digo del Descuento si este existe.

4- Retorna .F. si no se presentaron problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lSekCodDes(cCodEst,nMesDes,lMensaj)

*>>>>PARAMETROS DE LA FUNCION
/*     cCodDes			            // C¢digo del Estudiante
       nMesDes			            // Mes del Descuento
       lMensaj                              // .T. Mostrar mensaje error */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL lExiste := .T.                 // .T. Existe el c¢digo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DEL CODIGO
       lMensaj := IF(lMensaj == NIL,.T.,lMensaj)
       SELECT DES
       GO TOP

       IF !DBSEEK(cCodEst+STR(nMesDes,2))
	  IF lMensaj
	     cError('NO EXISTE DESCUENTO O RECARGO PARA EL CODIGO: '+;
		    cCodEst+' PARA EL MES DE '+cMes(nMesDes,10))
	  ENDIF
	  lExiste := .F.
       ENDIF
*>>>>FIN LOCALIZACION DEL CODIGO

*>>>>LOCALIZACION DE SOLO EL DESCUENTO O RECARGO
       IF lExiste .AND. DES->nTipDesDes == 3    // Descarta el abono

	  LOCATE FOR DES->cCodigoEst = cCodEst .AND.;
		     DES->nNroMesDes = nMesDes .AND.;
		     DES->nTipDesDes # 3
	 *Localiza el Descuento o Recargo

	  lExiste := .F.
	  IF FOUND()
	     lExiste := .T.
	  ENDIF
       ENDIF
*>>>>FIN LOCALIZACION DE SOLO EL DESCUENTO O RECARGO

*>>>>VALIDACION DE LA BUSQUEDA DEL DESCUENTO
       IF lExiste
	  IF DES->cCodigoEst # cCodEst .AND. DES->nNroMesDes # nMesDes
	     cError('ESTA FALLANDO LA BUSQUEDA DEL DESCUENTO')
	     lExiste := .F.
	  ENDIF
       ENDIF
       RETURN lExiste
*>>>>FIN VALIDACION DE LA BUSQUEDA DEL DESCUENTO

/*************************************************************************
* TITULO..: APLICACION DEL ABONO                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 13/1994 SAB A
       Colombia,Bucaramanga         INICIO: 02:00 PM   AGO 13/1994 SAB

OBJETIVOS:

1- Aplica un abono a un vector de pagos

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lAbonos(nMesAbo,dFecAbo,nVlrAbo,nMesAfe,aDetPag,aPagAbo)

*>>>>DESCRIPCION DE PARAMETROS
/*     nMesAbo			            // Mes del Abono
       dFecAbo			            // Fecha del Abono
       nVlrAbo			            // Valor del Abono
       nMesAfe			            // Mes Modificado o Afectado
       aDetPag                              // Detalles del Pago
       aPagAbo                              // @Pagos despues de Abonos */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nRegAct := 0                   // Registro Actual de pagos

       LOCAL nMesExt := 0                   // Mes Extemporaneo.
       LOCAL nMesAnt := 0                   // Mes Anterior
       LOCAL nSdoAct := 0                   // Saldo Actual para el Abono
       LOCAL nSdoMor := 0                   // Mora Actual para el Abono
       LOCAL lAboOpo := .T.                 // .F. Abono Extemporaneo
       LOCAL nPropor := 0                   // Porcentaje de la Proporci¢n.
       LOCAL nSaldo  := 0                   // Saldo despu‚s de Abono
       LOCAL nDeuAct := 0                   // Deuda Actual
       LOCAL nMorAct := 0                   // Mora Actual
       LOCAL nDeuMod := 0                   // Deuda Modificado
       LOCAL nMorMod := 0                   // Mora Modidifcado
       LOCAL nMesMod := 0                   // Mes Modificado

       LOCAL nMorAbo := 0                   // Mora del Abono
       LOCAL nIntMes := 0                   // Interes del Mes
       LOCAL nIntMod := 0                   // Interes Modificado
       LOCAL nDeuAbo := 0                   // Deuda del Abono
       LOCAL nIntInt := 0
       LOCAL nVlrMes := 0
       LOCAL nIntAbo := 0
       LOCAL nIntAct := 0
       LOCAL nIntDeu := 0                   // Interes por Mora para el no pago
       LOCAL lHayPag := .F.                 // .T. Hay Pago
*>>>>FIN DECLARACION DE VARIABLES

*>>>>INICIALIZACION DEL VECTOR DEL ABONO
       aPagAbo := {}
       AADD(aPagAbo,{0,0,0})
       AADD(aPagAbo,{0,0,0})
       AADD(aPagAbo,{0,0,0})
*>>>>INICIALIZACION DEL VECTOR DEL ABONO

*>>>>CALCULO DEL SALDO PARA DESCONTAR EL ABONO EN FECHA OPORTUNA
       nRegAct := PAG->(RECNO())
       PAG->(DBGOTO(aDetPag[nMesAbo,6]))

       IF dFecAbo <= PAG->dPagExtPag
	  lAboOpo := .T.                       // Abono oportuno

	  nSdoAct := aDetPag[nMesAbo,2]        // Saldo Anterior mes Abono
	  nSdoMor := aDetPag[nMesAbo,3]        // Mora Anterior mes Abono

	  IF nMesAbo+1 == LEN(aDetPag)
	     nMesExt := nMesAbo+1
	     nMesAnt := nMesAbo
	  ELSE
	     nMesExt := LEN(aDetPag)
	     nMesAnt := nMesExt - 1
	  ENDIF

       ENDIF
*>>>>FIN CALCULO DEL SALDO PARA DESCONTAR EL ABONO EN FECHA OPORTUNA

*>>>>CALCULO DEL SALDO PARA DESCONTAR EL ABONO EN FECHA EXTEMPORANEA
       IF dFecAbo > PAG->dPagExtPag

**********ANALISIS DEL MES EXTEMPORANEO
	    lAboOpo := .F.
	    IF nMesAbo+1 == LEN(aDetPag)

	       nMesExt := nMesAbo+1
	       nMesAnt := nMesAbo

	       nSdoAct := aDetPag[nMesExt,2]
	      *Saldo Anterior Mes Extemporaneo

	       nSdoMor := aDetPag[nMesExt,3]
	      *Mora Anterior mes Posterior

	       nIntAct := ROUND((nSdoMor*100)/nSdoAct,0)
	      *Interes de Proporci¢n

	    ELSE

	       nMesExt := LEN(aDetPag)
	       nMesAnt := nMesExt - 1

	       IF aDetpag[nMesExt,5] == 'D' .OR. aDetpag[nMesExt,5] == '*'

		  nSdoAct := aDetPag[nMesExt,2]+aDetPag[nMesExt,4]

	       /* Deuda Mes Extemporaneo =
			Saldo Anterior Mes Extemporaneo +
			Valor del Mes Extemporaneo */

		  nSdoMor := nIntNoP(nSdoAct)+aDetPag[nMesExt,3]

	       /* Mora Mes Extemporaneo =
		       Interes del Mes Extemporaneo +
		       Mora Mes Extemporaneo */

/*                Ejemplo No.2. Manual del tesorero
		  1)- Calcular el porcentaje de la proporci¢n de la deuda
		      actual y los intereses por cobrar: */

		  nIntAct := ROUND((nSdoMor*100)/nSdoAct,0)
		 *Interes de Proporci¢n. Documentado

	       ENDIF

	    ENDIF
**********FIN ANALISIS DEL MES EXTEMPORANEO

       ENDIF
*>>>>FIN CALCULO DEL SALDO PARA DESCONTAR EL ABONO EN FECHA EXTEMPORANEA

*>>>>VALIDACION DEL SALDO PARA DESCONTAR EL ABONO
       IF nSdoAct+nSdoMor == 0
	  RETURN .F.  // Error
       ENDIF
*>>>>FIN VALIDACION DEL SALDO PARA DESCONTAR EL ABONO

*>>>>CALCULOS PARA EL ABONO OPORTUNO MES DEL ABONO
       IF lAboOpo

**********SALDO ACTUAL
	    nIntAct := ROUND((aDetPag[nMesAbo,3]*100)/aDetPag[nMesAbo,2],0)
	    nSaldo  := nSdoAct+nSdoMor-nVlrAbo
**********FIN SALDO ACTUAL

**********MES DEL ABONO
	    PAG->(DBGOTO(aDetPag[nMesAbo,6]))
	    nDeuAbo := ROUND((nSaldo*100)/(100+nIntAct),0)
	    nMorAbo := nSaldo - nDeuAbo
	    nVlrMes := aDetPag[nMesAbo,4]

	    PAG->(DBGOTO(aDetPag[nMesAfe,6]))  // Modificado Bethelemitas
	    nIntMes := ROUND((nDeuAbo*PAG->nIntDeuPag)/100,0)
	    PAG->(DBGOTO(aDetPag[nMesAbo,6]))  // Modificado Bethelemitas

	    aPagAbo[2,1] := nDeuAbo
	    aPagAbo[2,2] := nMorAbo
	    aPagAbo[2,3] := nVlrMes
**********FIN MES DEL ABONO

**********MES MODIFICADO
	    IF nMesAfe # 0  // Modificado

	       PAG->(DBGOTO(aDetPag[nMesAfe,6]))
	       IF PAG->nMesAmnPag == PAG->nMesIniPag

		  nIntInt := (nSdoMor*100)/aDetPag[nMesAfe,3]

		  nMorMod := ROUND((nMorAbo*100)/nIntInt,0)
		  nIntMod := nMorAbo - nMorMod
		  nMesMod := ROUND((nIntMod*100)/PAG->nIntDeuPag,0)
		  nDeuMod := nDeuAbo - nMesMod

		  nMesAnt := nMesExt

	       ELSE
		  nIntMod := ROUND((aDetPag[nMesAfe,3]*100)/aDetPag[nMesAfe,2],0)
		  nMorMod := nMorAbo-nIntMes
		  nDeuMod := ROUND((nMorMod*100)/nIntMod,0)
		  nMesMod := nDeuAbo-nDeuMod
	       ENDIF

	       aPagAbo[1,1] := nDeuMod
	       aPagAbo[1,2] := nMorMod
	       aPagAbo[1,3] := nMesMod

	    ENDIF
**********FIN MES MODIFICADO

**********MES POSTERIOR AL ABONO
	    PAG->(DBGOTO(aDetPag[nMesAnt,6]))
	    IF PAG->nMesAmnPag == PAG->nMesIniPag
	       nIntMes := ROUND(((ABS(nVlrMes))*PAG->nIntDeuPag)/100,0)
	    ELSE
	       nIntMes := ROUND(((nDeuAbo+ABS(nVlrMes))*PAG->nIntDeuPag)/100,0)
	    ENDIF

	    IF PAG->cEstadoPag == 'D'
	       aPagAbo[3,1] := nDeuAbo+nVlrMes
	       aPagAbo[3,2] := nMorAbo+nIntMes
	    ENDIF
	    aPagAbo[3,3] := aDetPag[nMesExt,4]
**********FIN MES POSTERIOR AL ABONO

       ENDIF
*>>>>FIN CALCULOS PARA EL ABONO OPORTUNO MES DEL ABONO

*>>>>CALCULOS PARA EL ABONO EXTEMPORANEO MES DEL ABONO
       IF .NOT. lAboOpo

**********SALDO ACTUAL
/*          Ejemplo No.2. Manual del tesorero
	    2)- Restar el abono del Saldo Actual
		para calcular el nuevo saldo:  */

	    nSaldo  := nSdoAct+nSdoMor-nVlrAbo
	  *ÀDocumentado

/*          Ejemplo No.2. Manual del tesorero
	    3)- Calcular la deuda actual a partir del nuevo saldo: */

	    nDeuAct := ROUND((nSaldo*100)/(100+nIntAct),0)
	  *ÀDocumentado.

/*          Ejemplo No.2. Manual del tesorero
	    4)- Por diferencia calcular el nuevo
		interes por cobrar actual: */

	    nMorAct := nSaldo-nDeuAct
	  *ÀDocumentado
**********FIN SALDO ACTUAL

**********MES DEL ABONO
	    PAG->(DBGOTO(aDetPag[nMesAbo,6]))
	    IF PAG->nMesAmnPag == PAG->nMesIniPag
	       nIntInt := (nSdoMor*100)/aDetPag[nMesAbo,3]
	       nMorAbo := ROUND((nMorAct*100)/nIntInt,0)
	       nIntMes := nMorAct - nMorAbo
	       nVlrMes := ROUND((nIntMes*100)/PAG->nIntDeuPag,0)
	       nDeuAbo := nDeuAct-nVlrMes
	    ELSE
	       nIntAbo := ROUND((aDetPag[nMesAbo,3]*100)/;
				 aDetPag[nMesAbo,2],0)

/*             Ejemplo No.2. Manual del Tesorero
	       5)- Calcular el inter‚s por cobrar el mes: */

	       nIntMes := ROUND((nDeuAct*PAG->nIntDeuPag)/100,0)
	     *ÀDocumentado

/*             Ejemplo No.2. Manual del Tesorero
	       6)- Por diferencia calcular el
		   interes por cobrar anterior: */

	       nMorAbo := nMorAct-nIntMes
	     *ÀDocumentado

	       IF PAG->nIntDeuPag == 0 .AND.;
		  PAG->nVlrMesPag == 0
		  nDeuAbo := nDeuAct
	       ELSE
		  nDeuAbo := ROUND((nMorAbo*100)/nIntAbo,0)
	       ENDIF
	     *ÀModificado

	       nVlrMes := nDeuAct-nDeuAbo
	    ENDIF

	    aPagAbo[2,1] := nDeuAbo
	    aPagAbo[2,2] := nMorAbo
	    aPagAbo[2,3] := nVlrMes
**********FIN MES DEL ABONO

**********MES MODIFICADO
	    IF nMesAfe # 0  // Modificado

*==============VALIDACION DE LA EXISTENCIA REGISTRO MES AFECTADO
		 lHayPag := lLocCodPag(PAG->cCodigoEst,nMesAfe,.F.)
		 IF lHayPag
		    PAG->(DBGOTO(aDetPag[nMesAfe,6]))
		 ENDIF
*==============FIN VALIDACION DE LA EXISTENCIA REGISTRO MES AFECTADO

*==============CALCULOS
		 IF PAG->nMesAmnPag == PAG->nMesIniPag
		    IF lHayPag
		       nIntInt := (aDetPag[nMesAbo,3]*100)/aDetPag[nMesAfe,3]

		       nMorMod := ROUND((nMorAbo*100)/nIntInt,0)
		       nIntMod := nMorAbo - nMorMod
		       nMesMod := ROUND((nIntMod*100)/PAG->nIntDeuPag,0)
		       nDeuMod := nDeuAbo - nMesMod
		    ELSE
		       nIntInt := 0
		       nMorMod := 0
		       nIntMod := 0
		       nMesMod := 0
		       nDeuMod := 0
		     *ÀNo existe el mes afectado
		    ENDIF
		 ELSE
		    IF lHayPag
		       nIntMod := ROUND((aDetPag[nMesAfe,3]*100)/;
					 aDetPag[nMesAfe,2],0)

		       nIntMes := ROUND((nDeuAbo*PAG->nIntDeuPag)/100,0)

		       nMorMod := nMorAbo-nIntMes
		       nDeuMod := ROUND((nMorMod*100)/nIntMod,0)
		       nMesMod := nDeuAbo-nDeuMod
		    ELSE
		       nIntMod := 0
		       nIntMes := 0
		       nMorMod := 0
		       nDeuMod := 0
		       nMesMod := 9
		     *ÀNo existe el mes afectado
		    ENDIF
		 ENDIF
*==============FIN CALCULOS

	       aPagAbo[1,1] := nDeuMod
	       aPagAbo[1,2] := nMorMod
	       aPagAbo[1,3] := nMesMod
	    ENDIF
**********FIN MES MODIFICADO

**********MES POSTERIOR AL ABONO
	    aPagAbo[3,1] := nDeuAct
	    aPagAbo[3,2] := nMorAct
	    aPagAbo[3,3] := aDetPag[nMesExt,4]
**********FIN MES POSTERIOR AL ABONO

       ENDIF
       PAG->(DBGOTO(nRegAct))
       RETURN .T.
*>>>>FIN CALCULOS PARA EL ABONO EXTEMPORANEO MES DEL ABONO

/*************************************************************************
* TITULO DE LA FUNCION..: ESTADO DE CUENTA                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAR 14/95 MAR A
       Colombia,Bucaramanga         INICIO: 11:00 AM   MAR 14/95 MAR

OBJETIVOS:

1)- Debe estar en uso el maestro de alumnos habilitado

2)- Debe estar en uso el archivo el archivo de clientes

3)- Visualiza el estado de cuenta del cliente

4)- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RelDesEst(lShared,nModCry,cNomSis,cNomEmp,nFilInf,nColInf,;
		   cMaeAct,cPatSis,lModReg,cCodEst,cMaeAlu,cNalias)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Archivos Compartidos
       nModCry                              // Modo de Protecci¢n
       cNomSis                              // Nombre del Sistema
       cNomEmp                              // Nombre de la Empresa
       nFilInf                              // Fila de Impresi¢n
       nColInf                              // Columna de Impresi¢n
       cMaeAct                              // Maestro Actual
       cPatSis                              // Path del sistema
       lModReg                              // .T. Modificar Registros
       cCodEst                              // C¢digo del Estudiante
       cMaeAlu                              // Maestro Habilitados
       cNalias                              // Alias del que Invoca */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"           // Archivos Compartidos

       LOCAL bCodF02 := NIL                 // Code Block asignado a F2
       LOCAL bCodF03 := NIL                 // Code Block asignado a F3
       LOCAL bCodF04 := NIL                 // Code Block asignado a F4
       LOCAL bCodF05 := NIL                 // Code Block asignado a F5
       LOCAL bCodF06 := NIL                 // Code Block asignado a F6

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cCodigo := ''                  // Codigo del cliente
       LOCAL lClose  := .F.                 // .T. Cerrar Archivo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DESACTIVACION DE LAS TECLAS DE FUNCION
       bCodF02 := SETKEY(K_F2)
       bCodF03 := SETKEY(K_F3)
       bCodF04 := SETKEY(K_F4)
       bCodF05 := SETKEY(K_F5)
       bCodF06 := SETKEY(K_F6)

       SETKEY(K_F2,NIL)
       SETKEY(K_F3,NIL)
       SETKEY(K_F4,NIL)
       SETKEY(K_F5,NIL)
       SETKEY(K_F6,NIL)
*>>>>FIN DESACTIVACION DE LAS TECLAS DE FUNCION

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF ALIAS(SELECT('CAA')) # 'CAA'

	  lClose := .T.
	  IF !lUseDbf(.T.,cPatSis+'\'+fCarAno+cAnoPath(cPatSis)+ExtFile,;
			 'CAA',NIL,lShared,nModCry)

	     cError('ABRIENDO CONFIGURACION A¥O CARTERA')
	     CloseDbf('CAA')
	     RETURN NIL
	  ENDIF

       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbf(.T.,cPatSis+'\'+FileDes,'DES',NIL,lShared,nModCry)
	  cError('ABRIENDO EL ARCHIVO DE DESCUENTOS')
	  CloseDbf('DES',cPatSis+'\'+FileDes,nModCry)
	  SELECT &cMaeAct
	  IF !EMPTY(cNalias)
	     SELECT &cNalias
	  ENDIF
	  IF lClose
	     CloseDbf('CAA')
	  ENDIF
	  RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>ANALISIS DEL CODIGO DEL ESTUDIANTE
       IF !EMPTY(cNalias)
	  cCodigo := cCodEst
       ELSE
	  cCodigo := &cMaeAct->cCodigoEst
       ENDIF
*>>>>FIN ANALISIS DEL CODIGO DEL ESTUDIANTE

*>>>>FILTRACION DE LOS DESCUENTOS DEL ESTUDIANTE
       cSavPan := SAVESCREEN(0,0,24,79)
       SELECT DES
       SET FILTER TO DES->cCodigoEst == cCodigo
       IF EOF()
	  cError('NO EXISTEN DESCUENTOS PARA EL ESTUDIANTE')
       ELSE
	  lModReg := IF(EMPTY(lModReg),.F.,lModReg)
	  DES->(CtrlBrw(lShared,oBrowseDes(lShared,nFilInf,nColInf,22,78,lModReg)))
       ENDIF
*>>>>FIN FILTRACION DE LOS DESCUENTOS DEL ESTUDIANTE

*>>>>ACTIVACION DE LAS TECLAS DE FUNCION
       SETKEY(K_F2,bCodF02)
       SETKEY(K_F3,bCodF03)
       SETKEY(K_F4,bCodF04)
       SETKEY(K_F5,bCodF05)
       SETKEY(K_F6,bCodF06)

       SET FILTER TO
       RESTSCREEN(0,0,24,79,cSavPan)
       CloseDbf('DES',cPatSis+'\'+FileDes,nModCry)
       SELECT &cMaeAct
       IF !EMPTY(cNalias)
	  SELECT &cNalias
       ENDIF
       IF lClose
	  CloseDbf('CAA')
       ENDIF
       RETURN NIL
*>>>>ACTIVACION DE LAS TECLAS DE FUNCION

/*************************************************************************
* TITULO DE LA FUNCION..: OBJETO BROWSE DE SOLO DESCUENTOS 	         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 09/96 MAR A
       Bucaramanga, Colombia        INICIO: 02:15 PM   JUL 09/96 MAR

OBJETIVOS:

1- Define el objeto Browse del archivo Descuentos sin incluir detalles
   del estudiante

SINTAXIS:

 oBrowse := oBrowseDes(00,00,24,79,'94')

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrowseDes(lShared,nFilSup,nColSup,nFilInf,nColInf,lModReg)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Archivos Compartidos
       nFilSup	                            // Fila Superior
       nColSup	                            // Columna Superior
       nFilInf	                            // Fila Inferior
       nColInf	                            // Columna Inferior
       lModReg                              // .T. Modificar Registros */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL oColumn := NIL                 // Columna del objeto
       LOCAL oBrowse := NIL		    // Browse de Descuentos
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DEFINICION DEL OBJETO BROWSE
       oBrowse := TBROWSEDB(nFilSup+1,nColSup+1,nFilInf-1,nColInf-1)
      *Definici¢n de Objeto y asignaci¢n de las coordenadas

       oBrowse:ColSep    := '³'
       oBrowse:HeadSep   := 'Ä'

       lModReg := IF(EMPTY(lModReg),.F.,lModReg)
       oBrowse:Cargo     := {'<<RELACION DE DESCUENTOS>>',;
			     IF(lModReg,'<DEL>Borrar ','')+;
			     '<ESC> REGRESAR'}

     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras


       SELECT DES
       oColumn	     := TBCOLUMNNEW('CODIGO',{||DES->cCodigoEst})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CLASE',;
			{||IF(DES->(EOF()),SPACE(12),;
			   cNombreDes(DES->nTipDesDes,12))})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('DESCRIPCION;DEL ABONO',;
				    {||DES->cDescriDes})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','cDescriDes'},;
			 {'PICTURE','@!'}}
       oColumn:Width := 50
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       IF lModReg
	  oColumn := TBCOLUMNNEW('VALOR;DEL ABONO',{||DES->nValorDes})
	  oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nValorDes'},;
			    {'PICTURE','9999999.99'}}
       ELSE
	  oColumn	     := TBCOLUMNNEW('VALOR;DEL ABONO',;
				       {||IF(DES->(EOF()),SPACE(12),;
					DES->nValorDes)})
	  oColumn:Cargo := {{'MODI',.F.}}
       ENDIF
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       IF lModReg
	  oColumn := TBCOLUMNNEW('DEUDA A¥O;ANTERIOR',{||DES->nSdoAnoDes})
	  oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nSdoAnoDes'},;
			    {'PICTURE','9999999.99'}}
       ELSE
	  oColumn	     := TBCOLUMNNEW('DEUDA A¥O;ANTERIOR',;
				       {||IF(DES->(EOF()),SPACE(12),;
					DES->nSdoAnoDes)})
	  oColumn:Cargo := {{'MODI',.F.}}
       ENDIF
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       IF lModReg
	  oColumn := TBCOLUMNNEW('MORA A¥O;ANTERIOR',{||DES->nMorAnoDes})
	  oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nMorAnoDes'},;
			    {'PICTURE','9999999.99'}}
       ELSE
	  oColumn	     := TBCOLUMNNEW('DEUDA A¥O;ANTERIOR',;
				       {||IF(DES->(EOF()),SPACE(12),;
					DES->nMorAnoDes)})
	  oColumn:Cargo := {{'MODI',.F.}}
       ENDIF
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('DESCUENTO DE;EFECTIVO',{||DES->lDesEfeDes})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','lDesEfeDes'},;
			 {'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       IF lModReg
	  oColumn := TBCOLUMNNEW('FECHA;DEL ABONO',;
				 {||DES->dFechaDes})
	  oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','dFechaDes'},;
			    {'PICTURE','@!'}}
       ELSE
	  oColumn := TBCOLUMNNEW('FECHA;DEL ABONO',;
				 {||cFecha(DES->dFechaDes)})
	  oColumn:Cargo := {{'MODI',.F.}}
       ENDIF

       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       IF lModReg
	  oColumn := TBCOLUMNNEW('MES DEL;ABONO',{||DES->nNroMesDes})
	  oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nNroMesDes'},;
			    {'PICTURE','99'}}
       ELSE
	  oColumn := TBCOLUMNNEW('MES DEL;ABONO',;
				 {||IF(DES->(EOF()),SPACE(10),;
						    cMes(DES->nNroMesDes))})
	  oColumn:Cargo := {{'MODI',.F.}}
       ENDIF
       oColumn:Width := 10
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('RECIBO No',{||DES->nNroFacCaA})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nNroFacCaA'},;
			 {'PICTURE','999999999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('SDOANT A¥O ANTERIOR;ANTES DEL ABONO',;
				    {||DES->nSdoAnoPag})
       IF lModReg
	  oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nSdoAnoPag'},;
			    {'PICTURE','9999999.99'}}
       ELSE
	  oColumn:Cargo := {{'MODI',.F.}}
       ENDIF
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('MORA ANT A¥O ANTERIOR;ANTES DEL ABONO',;
				    {||DES->nMorAnoPag})
       IF lModReg
	  oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nMorAnoPag'},;
			    {'PICTURE','9999999.99'}}
       ELSE
	  oColumn:Cargo := {{'MODI',.F.}}
       ENDIF
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('SALDO ANTERIOR;DEL ABONO',;
				    {||DES->nSdoAntPag})
       IF lModReg
	  oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nSdoAntPag'},;
			    {'PICTURE','9999999.99'}}
       ELSE
	  oColumn:Cargo := {{'MODI',.F.}}
       ENDIF
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('MORA ANTERIOR;DEL ABONO',;
				    {||DES->nMorAntPag})
       IF lModReg
	  oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nMorAntPag'},;
			    {'PICTURE','9999999.99'}}
       ELSE
	  oColumn:Cargo := {{'MODI',.F.}}
       ENDIF
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('VALOR DEL MES;DEL ABONO',;
				    {||DES->nVlrMesPag})
       IF lModReg
	  oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nVlrMesPag'},;
			    {'PICTURE','9999999.99'}}
       ELSE
	  oColumn:Cargo := {{'MODI',.F.}}
       ENDIF
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       IF !CAA->lIntPenCaA
	  oColumn := TBCOLUMNNEW('VALOR DE;LA MORA',{||DES->nVlrMorPag})
	  IF lModReg
	     oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nVlrMorPag'},;
			       {'PICTURE','9999999.99'}}
	  ELSE
	     oColumn:Cargo := {{'MODI',.F.}}
	  ENDIF
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF lModReg
	  oColumn := TBCOLUMNNEW('MES;AFECTADO',{||DES->nMesModDes})
	  oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nMesModDes'},;
			    {'PICTURE','99'}}
       ELSE
	  oColumn	     := TBCOLUMNNEW('MES;AFECTADO',;
				       {||IF(DES->(EOF()),SPACE(10),;
					     cMes(DES->nMesModDes))})
	  oColumn:Cargo := {{'MODI',.F.}}
       ENDIF
       oColumn:Width := 10
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('SDOANT A¥O ANTERIOR;MES AFECATODO ANTES DEL ABONO',;
				    {||DES->nAnoSdoPag})
       IF lModReg
	  oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nAnoSdoPag'},;
			    {'PICTURE','9999999.99'}}
       ELSE
	  oColumn:Cargo := {{'MODI',.F.}}
       ENDIF
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('MORA ANT A¥O ANTERIOR;MES AFECTADO ANTES DEL ABONO',;
				    {||DES->nAnoMorPag})
       IF lModReg
	  oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nAnoMorPag'},;
			    {'PICTURE','9999999.99'}}
       ELSE
	  oColumn:Cargo := {{'MODI',.F.}}
       ENDIF
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna


       oColumn	     := TBCOLUMNNEW('SALDO ANTERIOR;MES AFECTADO',;
				    {||DES->nSdoAntDes})
       IF lModReg
	  oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nSdoAntDes'},;
			    {'PICTURE','9999999.99'}}
       ELSE
	  oColumn:Cargo := {{'MODI',.F.}}
       ENDIF
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('MORA ANTERIOR;MES AFECTADO',;
				    {||DES->nMorAntDes})
       IF lModReg
	  oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nMorAntDes'},;
			    {'PICTURE','9999999.99'}}
       ELSE
	  oColumn:Cargo := {{'MODI',.F.}}
       ENDIF
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('VALOR DEL MES;MES AFECTADO',;
				    {||DES->nVlrMesDes})
       IF lModReg
	  oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nVlrMesDes'},;
			    {'PICTURE','9999999.99'}}
       ELSE
	  oColumn:Cargo := {{'MODI',.F.}}
       ENDIF
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       IF !CAA->lIntPenCaA
	  oColumn := TBCOLUMNNEW('VALOR MORA;MES AFECTADO',;
				{||DES->nVlrMorDes})
	  IF lModReg
	     oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nVlrMorDes'},;
			       {'PICTURE','9999999.99'}}
	  ELSE
	     oColumn:Cargo := {{'MODI',.F.}}
	  ENDIF
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       oColumn	     := TBCOLUMNNEW('VALOR ABONO;MES AFECTADO',;
				    {||DES->nAboOtrDes})
       IF lModReg
	  oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nAboOtrDes'},;
			    {'PICTURE','9999999.99'}}
       ELSE
	  oColumn:Cargo := {{'MODI',.F.}}
       ENDIF
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       IF CAA->lForPagCaA
	  oColumn	     := TBCOLUMNNEW('TIPO;DE PAGO',{||DES->cCodigoFpg})
	  oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','cCodigoFpg'},;
			    {'PICTURE','@!'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       IF CAA->lForPagCaA
	  oColumn := TBCOLUMNNEW('DOCUMENTO DEL;TIPO DE PAGO',;
				{||DES->cNroFpgDes})
	  oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','cNroFpgDes'},;
			    {'PICTURE','@!'}}
	  oBrowse:ADDCOLUMN(oColumn)
	*ÀDefinici¢n Columna
       ENDIF

       oColumn	     := TBCOLUMNNEW('CONCEPTOS',{||DES->cConcepDes})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','cConcepDes'},;
			 {'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('VLR CON No. 1', {||DES->nVlrCo1Des})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nVlrCo1Des'},;
			 {'PICTURE','9999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('VLR CON No. 2', {||DES->nVlrCo2Des})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nVlrCo2Des'},;
			 {'PICTURE','9999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('VLR CON No. 3', {||DES->nVlrCo3Des})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nVlrCo3Des'},;
			 {'PICTURE','9999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('VLR CON No. 4', {||DES->nVlrCo4Des})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nVlrCo4Des'},;
			 {'PICTURE','9999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('VLR CON No. 5', {||DES->nVlrCo5Des})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nVlrCo5Des'},;
			 {'PICTURE','9999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('VLR CON No. 6', {||DES->nVlrCo6Des})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nVlrCo6Des'},;
			 {'PICTURE','9999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('VLR CON No. 7', {||DES->nVlrCo7Des})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nVlrCo7Des'},;
			 {'PICTURE','9999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('VLR CON No. 8', {||DES->nVlrCo8Des})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','nVlrCo8Des'},;
			 {'PICTURE','9999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna


       oColumn	     := TBCOLUMNNEW('USUARIO', {||DES->cNomUsrDes})
       oColumn:Cargo := {{'MODI',.F.}}
/*
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','cNomUsrDes'},;
			 {'PICTURE','@!'}}
*/
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna


       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',{||cFecha(DES->dFecUsrDes)})
*       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',{||DES->dFecUsrDes})
       oColumn:Cargo := {{'MODI',.F.}}
/*
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','dFecUsrDes'},;
			 {'PICTURE','@!'}}
*/
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',{||DES->cHorUsrDes})
       oColumn:Cargo := {{'MODI',.F.}}
/*
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','DES'},{'FIELD','cHorUsrDes'},;
			 {'PICTURE','@X'}}
*/
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: TIPO DE DESCUENTO                                            *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 26/2003 VIE A
       Colombia, Bucaramanga        INICIO: 02:30 PM   SEP 26/2003 VIE

OBJETIVOS:

1- Debe estar ubicado en el Registro Respectivo

2- Describe el tipo de descuento

3- Retorna el Nombre del tipo de Descuento

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cTipDes()

*>>>>DESCRIPCION DE VARIABLES
       LOCAL cTipDes := ''                  // Nombre del Tipo de Descuento
*>>>>FIN DESCRIPCION DE VARIABLES

*>>>>ANALISIS DEL TIPO DE DESCUENTO
       DO CASE
       CASE DES->nTipDesDes == 1  // Descuento
	    cTipDes := 'DESCUENTO'

       CASE DES->nTipDesDes == 2  // Recargo
	    cTipDes := 'RECARGO'

       CASE DES->nTipDesDes == 3  .AND. !DES->lDesEfeDes // Abono
	    cTipDes := 'ABONO'

       CASE DES->nTipDesDes == 3 .AND. DES->lDesEfeDes // Abono Descuento
	    cTipDes := 'ABONO DESCUE'

       CASE DES->nTipDesDes == 4  // Pago Parcial
	    cTipDes := 'PAGO PARCIAL'

       OTHERWISE
	    cTipDes := 'ERROR TipoDes'
       ENDCASE
       RETURN cTipDes
*>>>>FIN ANALISIS DEL TIPO DE DESCUENTO

/*************************************************************************
* TITULO DE LA FUNCION..: VALIDACION DEL MES DEL DESCUENTO               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 12/94 MAR A
						       JUL 12/94 MAR
OBJETIVOS:

1- Debe estar en uso los archivos de Descuentos

2- Retorna por referencia los param‚tros de la funci¢n marcados con @

3- Valida el mes del descuento, en caso de error permite seleccionar
   el mes correcto

4- Retorna .T.

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValMesDes(nNroFil,nNroCol,nNroMes)

*>>>>PARAMETROS DE LA FUNCION
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       nNroMes				    // @N£mero del mes */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .T.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       DO CASE
       CASE nNroMes > 0 .AND. nNroMes <= 12
       OTHERWISE
	    nNroMes := VAL(cSelMes(nNroFil,nNroCol))
	    lHayErr := .F.
       ENDCASE
       RETURN .T.
*>>>>FIN FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO DE LA FUNCION..: TIPO DE DESCUENTO                              *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 10/96 MIE A
       Colombia,Bucaramanga         INICIO: 11:05 PM   JUL 10/96 MIE

OBJETIVOS:

1)- Obtiene la descripci¢n del tipo de descuento de acuerdo al tipo

2)- Retorna del nombre del tipo de descuento

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cNombreDes(nTipDes,nNroLen)

*>>>>PARAMETROS DE LA FUNCION
/*     nTipDes                              // Tipo de Descuento
       nNroLen                              // Longitud del nombre */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL cNomDes := ''                  // Nombre del descuento
       LOCAL nDeuAct := 0                   // Deuda Actual
       LOCAL nMorAct := 0                   // Mora Actual
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DEL NOMBRE DEL DESCUENTO
       DO CASE
       CASE nTipDes == 1
	    cNomDes := 'DESCUENTO'
       CASE nTipDes == 2
	    cNomDes := 'RECARGO'
       CASE nTipDes == 3
	    cNomDes := 'ABONO'
       CASE nTipDes == 4
	    cNomDes := 'PAGO PARCIAL'
       OTHERWISE
	    cNomDes := 'ERROR'
       ENDCASE
       IF nNroLen # NIL
	  cNomDes := cNomDes+SPACE(nNroLen-LEN(cNomDes))
       ENDIF
       RETURN cNomDes
*>>>>FIN ANALISIS DEL NOMBRE DEL DESCUENTO

/*************************************************************************
* TITULO DE LA FUNCION..: ENCONTRA DESCUENTO RECARGO ABONO              *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 09/94 SAB A
						       JUL 09/94 SAB
OBJETIVOS:

1- Debe estar en uso el archivo de Descuentos indexado

2- Verifica la existencia del c¢digo del Descuento

3- Deja el archivo en el registro del c¢digo del Descuento si este existe.

4- Retorna .F. si no se presentaron problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lSekDesAbo(cCodEst,nMesDes,lMensaj)

*>>>>PARAMETROS DE LA FUNCION
/*     cCodDes			            // C¢digo del Estudiante
       nMesDes			            // Mes del Descuento
       lMensaj                              // .T. Mostrar mensaje error */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL lExiste := .T.                 // .T. Existe el c¢digo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DEL CODIGO
       lMensaj := IF(lMensaj == NIL,.T.,lMensaj)
       SELECT DES
       GO TOP
       IF !DBSEEK(cCodEst+STR(nMesDes,2))
	  IF lMensaj
	     cError('NO EXISTE DESCUENTO O RECARGO PARA EL CODIGO: '+;
		    cCodEst+' PARA EL MES DE '+cMes(nMesDes,10))
	  ENDIF
	  lExiste := .F.
       ENDIF
*>>>>FIN LOCALIZACION DEL CODIGO

*>>>>VALIDACION DE LA BUSQUEDA DEL DESCUENTO
       IF lExiste
	  IF DES->cCodigoEst # cCodEst .AND. DES->nNroMesDes # nMesDes
	     cError('ESTA FALLANDO LA BUSQUEDA DEL DESCUENTO')
	     lExiste := .F.
	  ENDIF
       ENDIF
       RETURN lExiste
*>>>>FIN VALIDACION DE LA BUSQUEDA DEL DESCUENTO