/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		BIBLIOTECAS DE FUNCIONES GENERALES DE CLIENTES

OBJETIVOS:

- Definici¢n de funciones generales para el SIMA

***************************************************************************
*-------------------- DECLARACION DE LAS FUNCIONES -----------------------*
**************************************************************************/

*>>>>DECLARACION DE CONSTANTES GENERALES
       #INCLUDE "inkey.ch"
*>>>>FIN DECLARACION DE CONSTANTES GENERALES

/*************************************************************************
* TITULO..: ESTADO DE CUENTA                                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 29/2004 JUE A
       Colombia,Bucaramanga         INICIO: 02:45 PM   JUL 29/2004 JUE

OBJETIVOS:

1- Debe estar en uso el maestro de alumnos habilitado

2- Debe estar en uso el archivo el archivo de clientes

3- Visualiza el estado de cuenta del cliente

4- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION EstadoCta(lShared,nModCry,cNomSis,cNomEmp,cNomUsr,cAnoUsr,;
		   cPatSis,cJorTxt,nFilInf,nColInf,cMaeAct,cTitulo,;
		   lModReg,cCodEst,cMaeAlu,cNalias,cPatMae,cPatCar)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Archivos Compartidos
       nModCry			            // Modo de Proteci¢n Dbf
       cNomSis                              // Nombre del Sistema
       cNomEmp                              // Nombre de la Empresa
       cNomUsr                              // Nombre del Usuario
       cAnoUsr                              // A¤o del Usuario
       cPatSis                              // Path del Sistema
       cJorTxt                              // Jornada escogida
       nFilInf                              // Fila de Impresi¢n
       nColInf                              // Columna de Impresi¢n
       cMaeAct			            // Maestro Actual
       cTitulo                              // T¡tulo de la Pantalla
       lModReg                              // .T. Modificar Registros
       cCodEst                              // C¢digo del Estudiante
       cMaeAlu                              // Maestros Habilitados
       cNalias                              // Alias del que Invoca
       cPatMae                              // Path del Maestro de Estudiantes
       cPatCar                              // Path de la Cartera */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"          // Declaraci¢n de Archivos

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL nNroFil := 0                   // Fila de lectura
       LOCAL nNroCol := 0                   // Columna de lectura
       LOCAL cNomEst := ''                  // Nombre del Estudiante
       LOCAL cCodGru := ''                  // C¢digo del Grupo
       LOCAL cNotCli := ''                  // Nota del Cliente
       LOCAL cTxtTem := ''                  // Texto Temporal
       LOCAL oBrowse := NIL                 // Browse del Archivo

       LOCAL bCodF02 := NIL                 // Code Block asignado a F2
       LOCAL bCodF03 := NIL                 // Code Block asignado a F3
       LOCAL bCodF04 := NIL                 // Code Block asignado a F4
       LOCAL bCodF05 := NIL                 // Code Block asignado a F5
       LOCAL bCodF06 := NIL                 // Code Block asignado a F6
       LOCAL bCodF09 := NIL                 // Code Block asignado a F9

       MEMVA xClrSys			    // Color del Sistema
       LOCAL cSayTxt := ''                  // Color del Texto fijo
       LOCAL cSayDat := ''                  // Color para los datos
       LOCAL cClrMar := ''                  // Color del Marco y Fondo
       LOCAL cClrTit := ''                  // Color T¡tulo del Marco

       FIELD cCodigoGru
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DESACTIVACION DE LAS TECLAS DE FUNCION
      bCodF02 := SETKEY(K_F2)
      bCodF03 := SETKEY(K_F3)
      bCodF04 := SETKEY(K_F4)
      bCodF05 := SETKEY(K_F5)
      bCodF06 := SETKEY(K_F6)
      bCodF09 := SETKEY(K_F9)

      SETKEY(K_F2,NIL)
      SETKEY(K_F3,NIL)
      SETKEY(K_F4,NIL)
      SETKEY(K_F5,NIL)
      SETKEY(K_F6,NIL)
      SETKEY(K_F9,NIL)
*>>>>FIN DESACTIVACION DE LAS TECLAS DE FUNCION

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !EMPTY(cPatMae)

	  IF !lUseMae(lShared,cPatMae,cMaeAlu,cAnoSis) .OR.;
	     !lUseDbf(.T.,cPatCar+'\'+;
		      fCarAno+cAnoUsr+ExtFile,'CAA',NIL,lShared,nModCry)

	     cError('ABRIENDO ARCHIVOS DE ESTUDIANTES')
	     CloseMae(cMaeAlu)
	     CloseDbf('CAA')
	     IF !EMPTY(cNalias)
		SELECT &cNalias
	     ENDIF
	     RETURN NIL
	  ENDIF

       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>BUSQUEDA DEL MAESTRO ACTUAL
       IF !EMPTY(cNalias)
	  cMaeAct := cMaeAct(cCodEst,cMaeAlu)
       ENDIF
*>>>>FIN BUSQUEDA DEL MAESTRO ACTUAL

*>>>>PREPARACION DE LAS VARIABLES DE ARCHIVO
       FileCli := cPatSis+'\CLIENTES\CL'+;
		  &cMaeAct->cCodigoGru+cAnoSis+ExtFile

       FilePag := cPatSis+'\PAGOS\PA'+;
		  &cMaeAct->cCodigoGru+cAnoSis+ExtFile
*>>>>FIN PREPARACION DE LAS VARIABLES DE ARCHIVO

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbf(.T.,FileCli,'CLI',NIL,lShared,nModCry) .OR.;
	  !lUseDbf(.T.,FilePag,'PAG',NIL,lShared,nModCry) .OR.;
	  !lUseDbf(.T.,cPatSis+'\'+FileTar,'TAR',NIL,lShared,nModCry) .OR.;
	  !lUseDbf(.T.,cPatSis+'\'+FileDes,'DES',NIL,lShared,nModCry)

	  cError('POSIBLEMENTE NO ESTAN CREADOS LOS CLIENTES',;
		 'ERROR. ABRIENDO LOS ARCHIVOS DE CLIENTES Y PAGOS')

	  CloseDbf('CLI',FileCli,nModCry)
	  CloseDbf('PAG',FilePag,nModCry)
	  CloseDbf('DES',cPatSis+'\'+FileDes,nModCry)
	  CloseDbf('TAR',cPatSis+'\'+FileTar,nModCry)

	  IF !EMPTY(cPatMae)
	     CloseMae(cMaeAlu)
	     CloseDbf('CAA')
	  ELSE
	     SELECT &cMaeAct
	  ENDIF

	  IF !EMPTY(cNalias)
	     SELECT &cNalias
	  ENDIF
	  RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>LOCALIZACION DEL CLIENTE
       IF !lLocCodigo('cCodigoEst','CLI',&cMaeAct->cCodigoEst)
	  CloseDbf('CLI',FileCli,nModCry)
	  CloseDbf('PAG',FilePag,nModCry)
	  CloseDbf('DES',cPatSis+'\'+FileDes,nModCry)
	  CloseDbf('TAR',cPatSis+'\'+FileTar,nModCry)
	  SELECT &cMaeAct
	  cError('NO EXISTE EL ESTUDIATE EN EL GRUPO DE CLIENTES')

	  IF !EMPTY(cPatMae)
	     CloseMae(cMaeAlu)
	     CloseDbf('CAA')
	  ELSE
	     SELECT &cMaeAct
	  ENDIF

	  IF !EMPTY(cNalias)
	     SELECT &cNalias
	  ENDIF
	  RETURN NIL
       ENDIF
*>>>>FIN LOCALIZACION DEL CLIENTE

*>>>>ANALISIS DEL COLOR
       Colores(xColores(IF(!EMPTY(xClrSys),xClrSys[7],'')),;
	       @cSayTxt,@cSayDat,@cClrMar,@cClrTit)
*>>>>IF ANALISIS DEL COLOR

*>>>>IMPRESION DEL NOMBRE
       cSavPan := SAVESCREEN(0,0,24,79)
       cTitulo := IF(cTitulo == NIL,'ESTADO DE CUENTA DEL ESTUDIANTE',cTitulo)
       nNroFil := nMarco(nFilInf+1,cTitulo,22,'°',cClrMar+','+cClrTit)
       nNroCol := nColInf
       @ nNroFil,nNroCol+00 SAY 'CODIGO: '+&cMaeAct->cCodigoEst
       cSay(nNroFil,nNroCol,'CODIGO:',&cMaeAct->cCodigoEst)

       cSay(nNroFil,nNroCol+15,'NOMBRE:',RTRIM(&cMaeAct->cApelliEst)+' '+;
					       &cMaeAct->cNombreEst)
       IF &cMaeAct->nNroLisEst == CLI->(RECNO())
	  cSay(nNroFil,nNroCol+65,'CURSO:',&cMaeAct->cCodigoGru+'-'+;
					    STR(CLI->(RECNO()),2))
       ELSE
	  cSay(nNroFil,nNroCol+65,'CURSO:',&cMaeAct->cCodigoGru+'#'+;
					    STR(CLI->(RECNO()),2))
       ENDIF
*>>>>FIN IMPRESION DEL NOMBRE

*>>>>ANALISIS DE LA ACTIVACION DE LA MODIFICACION DE REGISTROS
       lModReg := IF(EMPTY(lModReg),.F.,lModReg)
       IF lModReg
	  SET COLOR TO R*
	  @ nNroFil-1,nNroCol SAY 'ACTIVA LA MODIFICACION'
	  SetClrTo()
       ENDIF
*>>>>FIN ANALISIS DE LA ACTIVACION DE LA MODIFICACION DE REGISTROS

*>>>>ANALISIS SI EL ESTUDIANTE ESTA RETIRADO
       IF &cMaeAct->lRetiroEst
	  SET COLOR TO G*
	  @ nNroFil+1,nNroCol+23 SAY 'RETIRADO'
	  SetClrTo()
       ENDIF
*>>>>FIN ANALISIS SI EL ESTUDIANTE ESTA RETIRADO

*>>>>IMPRESION DE LOS TITULOS
       nNroFil := nFilInf+5
       IF CLI->nBecIniCli # 0 .AND. CLI->nBecFinCli # 0
	  cSay(nNroFil,nNroCol+15,'BECADO:','DESDE '+;
				  cMes(CLI->nBecIniCli,3)+' A '+;
				  cMes(CLI->nBecFinCli,3)+' CON '+;
				  IF(EMPTY(CLI->nPorBecCli),;
				     TRANS(CLI->nVlrBecCli,'$999999'),;
				     'UN '+STR(CLI->nPorBecCli,3)+'%'))
       ELSE
	  cSay(nNroFil,nNroCol+15,'BECADO: NO')
       ENDIF

       DO CASE
       CASE EMPTY(CLI->cHayRepCli)
	    cTxtTem := 'EVALUACION: '

       CASE !EMPTY(CLI->cHayRepCli) .AND. SUBS(CLI->cHayRepCli,5,1) == ' '
	    cTxtTem := 'REPORTADO: '

       CASE !EMPTY(CLI->cHayRepCli) .AND. SUBS(CLI->cHayRepCli,5,1) # ' '
	    cTxtTem := 'REPORTADO(R): '
       ENDCASE

       cNotaCli(CLI->cCodigoEst,&cMaeAct->cCodigoGru,;
		ALLTRIM(CAA->cConPenCaA)+;
		ALLTRIM(&cMaeAct->cConcepEst),;
		CLI->nSdoActCli+CLI->nSdoMorCli,;
		TipoMora(CLI->cMesPagCli),CLI->cMesPagCli,@cNotCli)
       SET COLOR TO G*
       @nNroFil,nNroCol+52 SAY cTxtTem+cNotCli
       SetClrTo()

       SET COLOR TO G*
       @nNroFil,nNroCol SAY IF(CLI->nSdoActCli == 0,'PAZ Y SALVO','MOROSO')+;
			    ' '+ALLTRIM(SUBS(&cMaeAct->cPazSdoEst,1,1))
       SetClrTo()

       nNroFil++
       cSay(nNroFil,nNroCol,'SALDO ACTUAL:',STR(CLI->nSdoActCli+;
						CLI->nSdoMorCli+;
						CLI->nSdoAnoCli+;
						CLI->nMorAnoCli,10,2))

       cSay(nNroFil,nNroCol+25,'DEUDA:',STR(CLI->nSdoActCli,10,2))
       cSay(nNroFil,nNroCol+43,'MORA:',STR(CLI->nSdoMorCli,10,2))

       IF CAA->nRecNroCaA == 2
	  cSay(nNroFil,nNroCol+60,'A¥O ANT:',;
				   STR(CLI->nSdoAnoCli+;
				   CLI->nMorAnoCli,10,2))
       ENDIF

       IF !EMPTY(&cMaeAct->cConcepEst)
	  ConsultCon(nNroFil+1,nNroCol+00,&cMaeAct->cConcepEst)
       ENDIF

       cCodEst := &cMaeAct->cCodigoEst
       cNomEst := RTRIM(&cMaeAct->cApelliEst)+' '+&cMaeAct->cNombreEst
       cCodGru := &cMaeAct->cCodigoGru

       SELECT PAG
       SET FILTER TO PAG->cCodigoEst == cCodEst

       IF EOF()
	  cError('NO EXISTEN PAGOS REGISTRADOS PARA EL CLIENTE')

       ELSE
	  oBrowse := oConBrwPag(10,01,22,78,lModReg)
	  DO CASE
	  CASE 'CARTERA' $ cNomSis

	       SETKEY(K_F9,{||MenuEstCta(lShared,nModCry,cNomSis,cNomEmp,;
					 cNomUsr,cAnoUsr,cPatSis,cMaeAct,;
					 cJorTxt,cCodEst,cNomEst,cCodGru,;
					 oBrowse)})
	  CASE 'RIESGOS' $ cNomSis

	       SETKEY(K_F9,{||lValEstCta(lShared,nModCry,cNomSis,cNomEmp,;
					 cNomUsr,cAnoUsr,cPatSis,cCodEst,;
					 cNomEst,cCodGru,.F.,'1234',;
					 oBrowse)})

	  ENDCASE

	  PAG->(CtrlBrw(lShared,oBrowse))
	  SETKEY(K_F9,NIL)
       ENDIF
*>>>>FIN IMPRESION DE LOS DATOS

*>>>>ACTIVACION DE LAS TECLAS DE FUNCION
       SETKEY(K_F2,bCodF02)
       SETKEY(K_F3,bCodF03)
       SETKEY(K_F4,bCodF04)
       SETKEY(K_F5,bCodF05)
       SETKEY(K_F6,bCodF06)
       SETKEY(K_F9,bCodF09)

       RESTSCREEN(0,0,24,79,cSavPan)
       CloseDbf('CLI',FileCli,nModCry)
       CloseDbf('PAG',FilePag,nModCry)
       CloseDbf('DES',cPatSis+'\'+FileDes,nModCry)
       CloseDbf('TAR',cPatSis+'\'+FileTar,nModCry)

       IF !EMPTY(cPatMae)
	  CloseMae(cMaeAlu)
	  CloseDbf('CAA')
       ELSE
	  SELECT &cMaeAct
       ENDIF

       IF !EMPTY(cNalias)
	  SELECT &cNalias
       ENDIF
       RETURN NIL
*>>>>FIN ACTIVACION DE LAS TECLAS DE FUNCION

/*************************************************************************
* TITULO..: EVALUACION DEL CLIENTE                                       *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 09/2001 JUE A
       Colombia, Bucaramanga        INICIO: 11:00 PM   MAY 09/2001 JUE

OBJETIVOS:

1- Evalua al Cliente de acuerdo a la forma de pago

2- Retorna Nil


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cNotaCli(cCodEst,cCodGru,cCodCon,nSdoAct,cTipMor,cMesPag,cDesCla,;
		  nNroMes)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante
       cCodGru                              // C¢digo del Grupo
       cCodCon                              // C¢digo del Concepto
       nSdoAct                              // Saldo Actual
       cTipMor                              // Tipo de Mora
       cMesPag                              // Meses de Pago
       cDesCla                              // @Descripci¢n de la Clase
       nNroMes                              // @N£mero de Meses en Mora */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cClaMor := ''                  // Clasificaci¢n de la Mora
       LOCAL lHayAbo := .F.                 // .T. Hay Abono
       LOCAL nVlrMes := 0                   // Valor del Mes
       LOCAL lTreMes := 0                   // .T. Mas de 2 Mes de Mora
       LOCAL lSiPago := .F.                 // .T. Pago Recibos
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DEL ABONO
       SELECT DES
       GO TOP
       LOCATE FOR DES->cCodigoEst == cCodEst .AND.;
		  DES->nTipDesDes == 3 .AND. !DES->lDesEfeDes

       IF DES->(FOUND())
	  IF DES->nValorDes # 0
	     lHayAbo := .T.
	  ENDIF
       ENDIF
*>>>>FIN LOCALIZACION DEL ABONO

*>>>>TOTALIZACION DE LOS CONCEPTOS DEL MES
       lTreMes := .F.
       nVlrMes := nTotalCon(cCodGru,cCodCon)
       nNroMes := (nSdoAct / nVlrMes)
       IF nNroMes >= 3
	  lTreMes := .T.
       ENDIF
*>>>>FIN TOTALIZACION DE LOS CONCEPTOS DEL MES

*>>>>ANALISIS DE PAGOS DE RECIBOS
       lSiPago := .F.
       IF 'A' $ cMesPag .OR. 'P' $ cMesPag
	  lSiPago := .T.
       ENDIF
*>>>>FIN ANALISIS DE PAGOS DE RECIBOS

*>>>>RECLASIFICACION DE LA DEUDA
       DO CASE
       CASE cTipMor == 'A' .OR. cTipMor == 'I'
	    cClaMor := 'E'
	    cDesCla := 'EXCELENTE'

       CASE cTipMor == 'B'
	    cClaMor := 'B'
	    cDesCla := 'BUENO'

       CASE cTipMor == 'H'
	    cClaMor := 'A'
	    cDesCla := 'ACEPTABLE'

       CASE cTipMor == 'C' .OR. cTipMor == 'D'
	    cClaMor := 'R'
	    cDesCla := 'REGULAR'

       CASE (cTipMor == 'E'   .OR. cTipMor == 'F' .OR.;
	     cTipMor == 'G') .AND. (lHayAbo .OR. lSiPago)

	     IF lTreMes
		cClaMor := 'I'
		cDesCla := 'INSUFICIENTE'
		IF !lHayAbo .AND. lSiPago
		   cDesCla += '.'
		ENDIF
	     ELSE
		cClaMor := 'R'
		cDesCla := 'REGULAR.'
	     ENDIF

       CASE (cTipMor == 'E' .OR. cTipMor == 'F' .OR.;
	     cTipMor == 'G') .AND. (!lHayAbo .OR. !lSiPago)

	    cClaMor := 'D'
	    cDesCla := 'DEFICIENTE'

       OTHERWISE
	    cClaMor := ' '
       ENDCASE
       RETURN cClaMor
*>>>>FIN RECLASIFICACION DE LA DEUDA

/*************************************************************************
* TITULO..: CLASIFICACION DEL CREDITO                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 09/2001 JUE A
       Colombia, Bucaramanga        INICIO: 11:00 PM   MAY 09/2001 JUE

OBJETIVOS:

1- Clasifica el Credito de acuerdo a los meses de mora

2- Retorna Nil


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION TipoMora(cMesPag,cDesMor)

*>>>>DESCRIPCION DE PARAMETROS
/*     cMesPag                              // Meses de Pago
       cDesMor                              // @Descripci¢n de la Mora */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL cTipMor := ''                  // Tipo de Mora
       LOCAL nNroMes := 0                   // N£mero de Meses de Atraso
       LOCAL lPagOpo := .F.                 // Pago Oportuno
       LOCAL lPagExt := .F.                 // Pago Extemporaneo
       LOCAL lNoPago := .F.                 // Pago Extemporaneo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DE LOS MESES DE ATRASO
       FOR i := LEN(RTRIM(cMesPag)) TO 0 STEP -1

	   DO CASE
	   CASE SUBS(cMesPag,i,1) == 'P'
		lPagOpo := .T.

	   CASE SUBS(cMesPag,i,1) == 'A'
		lPagExt := .T.

	   CASE SUBS(cMesPag,i,1) == SPACE(01)
	   OTHERWISE
		IF !lPagOpo .AND. !lPagExt .AND. SUBS(cMesPag,i,1) == 'D'
		   nNroMes++
		ELSE
		   lNoPago := .T.
		ENDIF
	   ENDCASE
       ENDFOR
*>>>>FIN ANALISIS DE LOS MESES DE ATRASO

*>>>>CLASIFICACION DE LA DEUDA
       DO CASE
       CASE lPagOpo .AND. !lPagExt .AND. !lNoPago .AND. nNroMes == 0
	    cTipMor := 'A'
	    cDesMor := 'EXCELENTE'

       CASE lPagOpo .AND. lPagExt .AND. !lNoPago .AND. nNroMes == 0
	    cTipMor := 'B'
	    cDesMor := 'BUEN MANEJO'

       CASE nNroMes == 1
	    cTipMor := 'C'
	    cDesMor := 'MORA DE 1 MES'

       CASE nNroMes == 2
	    cTipMor := 'D'
	    cDesMor := 'MORA DE 2 MESES'

       CASE nNroMes == 3
	    cTipMor := 'E'
	    cDesMor := 'MORA DE 3 MESES'

       CASE nNroMes > 3 .AND. nNroMes <= 6
	    cTipMor := 'F'
	    cDesMor := 'MORA DE 3 A 6 MESES'

       CASE nNroMes > 6
	    cTipMor := 'G'
	    cDesMor := 'MORA MAYOR A 6 MESES'

       CASE (lPagOpo .AND. lPagExt .AND. lNoPago .AND. nNroMes == 0)  .OR.;
	    (lPagOpo .AND. !lPagExt .AND. lNoPago .AND. nNroMes == 0) .OR.;
	    (!lPagOpo .AND. lPagExt .AND. lNoPago .AND. nNroMes == 0)

	    cTipMor := 'H'
	    cDesMor := 'ACEPTABLE'

       CASE !lPagOpo .AND. lPagExt .AND. !lNoPago .AND. nNroMes == 0
	    cTipMor := 'I'
	    cDesMor := 'PAGOS EXTEMPORANEOS'

       ENDCASE
       RETURN cTipMor
*>>>>FIN CLASIFICACION DE LA DEUDA

/*************************************************************************
* TITULO..: SALDO ACTUAL A LA FECHA                                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 13/2004 VIE A
       Bucaramanga, Colombia	    INICIO: 05:00 PM   AGO 13/2004 VIE

OBJETIVOS:

1- Calcula el Saldo Actual a fecha de Corte

2- Retorna el Saldo Actual

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSdoActEst(cCodEst,lRetEst,cMaeAlu,nMesIni,lPrnFec,dFecPrn,;
		    nDeuAct,nMorAct)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante
       lRetEst                              // .T. Estudiante Retirado
       cMaeAlu                              // Maestros habilitados
       nMesIni                              // Mes Inicial
       lPrnFec                              // .T. Imprimir por Fechas
       dFecPrn                              // Fecha de Impresi¢n de Corte
       nDeuAct                              // @Deuda Actual
       nMorAct                              // @Mora Actual */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL cMaeAct := ''                  // Maestro Actual
       LOCAL lHayAlu := .T.                 // .T. Existe alumno
       LOCAL nMesFac := 0                   // Mes Facturado
       LOCAL lMesAct := .T.                 // .T. Mes Actual
       LOCAL lDeudor := .T.                 // .T. Deudor
       LOCAL lHayPag := .F.                 // .T. Hay pago
       LOCAL lFechOk := .T.                 // Fecha de Acuerdo al intervalo
       LOCAL aConAlu := {}                  // Conceptos por Estudiante
       LOCAL nTotSdo := 0                   // Total de los saldos
       LOCAL nVlrInt := 0                   // Valor de los intereses
       LOCAL nVlrPag := 0                   // Valor del pago de un mes o varios meses.
       LOCAL nVlrAbo := 0                   // Valor del Abono

       LOCAL nDiaMor := 0                   // Dias en Mora
       LOCAL nMesSdo := 0                   // Mes del saldo

       LOCAL nMesIniTpa := 0                // Mes Inicial del Pago
       LOCAL nSdoActTcl := 0                // Deuda Actual
       LOCAL nSdoMorTcl := 0                // Mora Actual
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS SI ES EL MES ACTUAL
       nMesIniTpa := nMesIni

       nMesFac := LEN(RTRIM(CLI->cMesPagCli))
       IF nMesIni < nMesFac
	  lMesAct := .F.
	  nMesIni := nMesIniTpa
       ELSE
	  IF CAA->nMtdSdoCaA # 98 // No se acumula saldos
	     nMesIni := nMesFac
	  ENDIF
	  lMesAct := .T.
       ENDIF
*>>>>FIN ANALISIS SI ES EL MES ACTUAL

*>>>>ANALISIS SI EL ESTUDIANTE ES MOROSO
	 aConAlu := {}
	 lDeudor := .F.
      nSdoActTcl := 0                // Deuda Actual
      nSdoMorTcl := 0                // Mora Actual

      IF .NOT. lPrnFec
	 IF lMesAct .AND. CLI->nSdoActCli+CLI->nSdoMorCli # 0
	    nSdoActTcl := CLI->nSdoActCli
	    nSdoMorTcl := CLI->nSdoMorCli
	    nTotSdo += nSdoActTcl+nSdoMorTcl
	    lDeudor := .T.
	 ENDIF
      ELSE
	 lMesAct := .F.
      ENDIF
*>>>>FIN ANALISIS SI EL ESTUDIANTE ES MOROSO

*>>>>LOCALIZACION DEL PAGO
       SELECT PAG
       SET FILTER TO
       PAG->(DBGOTOP())
       lHayPag := lLocCodPag(cCodEst,nMesIni,.F.)

       IF !lHayPag .AND. CAA->nMtdSdoCaA == 98 // No se acumula saldos
	  RETURN 0
       ENDIF
*>>>>FIN LOCALIZACION DEL PAGO

*>>>>ANALISIS DE LA FECHA DE PAGO
       lFechOk := .T.
       IF lPrnFec .AND. lHayPag
	  IF PAG->cEstadoPag == 'P' .OR. PAG->cEstadoPag == 'A'
	     IF PAG->dFecPagPag > dFecPrn
		lFechOk := .F.
	     ENDIF
	  ENDIF
       ENDIF
*>>>>FIN ANALISIS DE LA FECHA DE PAGO


*>>>>ANALISIS DE DECISION
       IF CAA->nMtdSdoCaA == 98 // No se acumula saldos
	  lMesAct := .F.
       ENDIF
*>>>>FIN ANALISIS DE DECISION


*>>>>ANALISIS DEL PAGO
       IF !lMesAct .AND. lHayAlu .AND. lHayPag

**********CALCULO DE LOS INTERESES
	    nVlrInt := nVlrIntPag(CAA->lIntPenCaA,;
				  PAG->nMesIniPag,;
				  CAA->nMesAmnCaA)
**********FIN CALCULO DE LOS INTERESES


**********ANALISIS DE LA FORMA DE PAGO
	    lDeudor := .F.
	    IF PAG->cEstadoPag = 'D' .OR. !lFechOk

*==============ANALISIS DEL RECIBO POR ADELANTADO
		 IF PAG->nMesIniPag == PAG->nMesFinPag
		    nVlrPag := PAG->nSdoAntPag+PAG->nVlrMesPag
		 ELSE
		    IF CAA->nMesAmnCaA == nMesIni
		       nVlrPag := PAG->nVlrMesPag
		    ELSE
		       nVlrPag := PAG->nSdoAntPag+PAG->nVlrMesPag
		    ENDIF
		 ENDIF
*==============FIN ANALISIS DEL RECIBO POR ADELANTADO

*==============ANALISIS DE LA AMNISTIA
		 IF CAA->nMesAmnCaA # nMesIni
		    nSdoActTcl := nVlrPag
		    nSdoMorTcl := PAG->nMorAntPag+nVlrInt
		 ELSE
		    nSdoActTcl := PAG->nSdoAntPag+nVlrPag
		    nSdoMorTcl := PAG->nMorAntPag+nVlrInt
		 ENDIF
		 IF nSdoActTcl+nSdoMorTcl == 0
		    lDeudor := .F.
		 ELSE
		    lDeudor := .T.
		 ENDIF
		 nTotSdo += nSdoActTcl+nSdoMorTcl
*==============FIN ANALISIS DE LA AMNISTIA

	    ENDIF
**********ANALISIS DE LA FORMA DE PAGO

       ELSE

**********SALDO DEL ESTUDIANTE RETIRADO
	    IF !lMesAct .AND. lRetEst .AND.;
	       CLI->nSdoActCli+CLI->nSdoMorCli # 0 .AND. lHayPag

	       nSdoActTcl := CLI->nSdoActCli
	       nSdoMorTcl := CLI->nSdoMorCli
	      *Saldo Anterior

	       nTotSdo += nSdoActTcl+nSdoMorTcl
	       lDeudor := .T.
	    ENDIF
**********FIN SALDO DEL ESTUDIANTE RETIRADO

       ENDIF
*>>>>FIN ANALISIS DEL PAGO

*>>>>DESCRIMIMACION DEL SALDO
       IF CAA->lPrnConCaA .AND. nSdoActTcl+nSdoMorTcl # 0
	  lHayErr := !lVlrConSdo(nSdoActTcl,nSdoMorTcl,aConAlu,;
				 @nDiaMor,@nMesSdo)
       ENDIF
*>>>>FIN DESCRIMIMACION DEL SALDO

*>>>>FILTRACION DEL ARCHIVO DE DESCUENTOS
       IF lPrnFec
	  SELECT DES
	  SET FILTER TO DES->cCodigoEst == cCodEst .AND.;
			DES->nTipDesDes == 3       .AND.;
			(DES->nNroMesDes == nMesIni .OR.;
			 DES->nMesModDes == nMesIni)

	  DES->(DBGOTOP())
	  IF DES->(EOF())
	     SET FILTER TO
	  ENDIF
       ENDIF
*>>>>FIN FILTRACION DEL ARCHIVO DE DESCUENTOS

*>>>>ANALISIS DEL ABONO
       IF lPrnFec

**********ANALISIS DE LOS ABONOS
	    DO WHILE .NOT. DES->(EOF())

*==============ANALISIS DE LA FECHA DE PAGO
		 nVlrAbo := 0
		 IF DES->dFechaDes > dFecPrn

		    IF DES->nNroMesDes == nMesIni
		       nVlrAbo := DES->nValorDes
		    ELSE
		       nVlrAbo := DES->nAboOtrDes
		    ENDIF

		       nTotSdo += nVlrAbo
		    nSdoActTcl += nVlrAbo

		    IF CAA->lPrnConCaA
		       lHayErr := !lVlrConAbo(aConAlu)
		    ENDIF
		  * Descriminaci¢n del Abono

		 ENDIF
		 DES->(DBSKIP())
*==============FIN ANALISIS DE LA FECHA DE PAGO

	    ENDDO
**********FIN ANALISIS DE LOS ABONOS

       ENDIF
       SET FILTER TO
*>>>>FIN ANALISIS DEL ABONO

*>>>>ANALISIS DEL SALDO
       nDeuAct := nSdoActTcl
       nMorAct := nSdoMorTcl
       IF nDeuAct+nMorAct == 0
	  IF .NOT. lDeudor
	     lDeudor := .F.
	  ENDIF
       ELSE
	  lDeudor := .T.
       ENDIF
       RETURN nDeuAct+nMorAct
*>>>>FIN ANALISIS DEL SALDO

/*************************************************************************
* TITULO..: VALIDACION DEL ESTADO CUENTA DEL ESTUDIANTE                  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 15/99 MIE A
       Colombia, Bucaramanga        INICIO: 03:40 PM   SEP 15/99 MIE

OBJETIVOS:

1- Valida el estado de cuenta del estudiante de acuerdo a los movimientos

2- Retorna Nil


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValEstCta(lShared,nModCry,cNomSis,cNomEmp,cNomUsr,;
		    cAnoUsr,cPatSis,cCodEst,cNomEst,cCodGru,;
		    lPrnArc,cOpcPrn,oBrowse)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       cNomSis                              // Nombre del Sistema
       cNomEmp                              // Nombre de la Empresa
       cNomUsr                              // Nombre del Usuario
       cAnoUsr                              // A¤o del usuario
       cPatSis                              // Path del Sistema
       cCodEst                              // C¢digo del Estudiante
       cAnoUsr                              // A¤o del Usuario
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
       oBrowse                              // Browse de Pagos */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"          // Declaraci¢n de Archivos

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cSavLin := ''                  // Salvar l¡nea
       LOCAL lHayErr := .F.                 // .T. Hay Error
       LOCAL Getlist := {}                  // Variable del sistema

       LOCAL  lError := .F.                 // .T. Hay Error
       LOCAL    i,j,k := 0                   // Contador
       LOCAL    cMes := ''                  // Mes Inicial de pago
       LOCAL nMesIni := 1                   // Mes Inicial
       LOCAL aDetPag := {}                  // Detalles de los pagos
       LOCAL aPagAbo := {}                  // Calculos de los Abonos
       LOCAL nMesAbo := 0                   // Mes del Abono
       LOCAL nMesMod := 0                   // Mes Modificado
       LOCAL nUltPag := 0                   // Ultimo recibo facturado

       LOCAL nRegAnt := 0                   // Registro Anterior
       LOCAL nRegAct := 0                   // Registro Actual
       LOCAL nRegPag := 0                   // Registro del pago
       LOCAL lHayPag := .F.                 // .T. Hay Pago
       LOCAL nFacMes := 0                   // Facturaci¢n del Mes
       LOCAL nAntici := 0                   // Anticipos
       LOCAL nVlrBec := 0                   // Valor de la Beca
       LOCAL aErrCta := {}                  // Errores del Estado de Cuenta
     *ÀVariables espec¡ficas
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ACTIVACION DE LA FUNCION
       lHayErr := .T.
       DO CASE
       CASE 'VIRREY SOLIS' $ cNomEmp .AND. cAnoUsr == '2010'
       OTHERWISE
	    lHayErr :=.F.
       ENDCASE
       IF lHayErr
	  cError('ESTADO DE CUENTA')
	  RETURN NIL
       ENDIF
*>>>>FIN ACTIVACION DE LA FUNCION


*>>>>VALIDACION DE ESTADO DE CUENTA
       cSavPan := SAVESCREEN(0,0,24,79)
       aErrCta := aValCtaEst(cCodEst)
       IF LEN(aErrCta) # 0
	  FOR i := 1 TO LEN(aErrCta)
	      cError(aErrCta[i])
	  ENDFOR
	  lError := .T.
       ENDIF
*>>>>FIN VALIDACION DE ESTADO DE CUENTA

*>>>>IMPRESION DE LA SIMULACION DE ESTADO DE CUENTA
       IF lPregunta('DESEA IMPRIMIR LA SIMULACION '+;
		    'DEL ESTADO DE CUENTA? No Si')

	  PrnEstado(lShared,cNomSis,cNomEmp,cNomUsr,;
		    cAnoUsr,cCodEst,ALLTRIM(cNomEst),cCodGru,;
		    lPrnArc,cOpcPrn)
       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN lError
*>>>>FIN IMPRESION DE LA SIMULACION DE ESTADO DE CUENTA

/*************************************************************************
* TITULO..: IMPRESION DE LA SIMULACION DE LOS ABONOS                     *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 27/99 VIE A
       Colombia, Bucaramanga        INICIO: 07:00 PM   AGO 27/99 VIE

OBJETIVOS:

1- Imprime los diferentes estados de cuenta antes y despues de cada
   abono

2- Retorna Nil


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION PrnEstado(lShared,cNomSis,cNomEmp,cNomUsr,;
		   cAnoUsr,cCodEst,cNomEst,cCodGru,;
		   lPrnArc,cOpcPrn)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       cNomSis                              // Nombre del Sistema
       cNomEmp                              // Nombre de la Empresa
       cNomUsr                              // Nombre del Usuario
       cAnoUsr                              // A¤o del usuario
       cCodEst                              // C¢digo del Estudiante
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "EPSONFX.PRG"               // Impresora EPSON FX
       #INCLUDE "FILES.PRG"          // Declaraci¢n de Archivos

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cSavLin := ''                  // Salvar l¡nea
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL lHayErr := .F.                 // .T. Hay Error
       LOCAL cIntUno := ''                  // Path de integraci¢n uno
       LOCAL cIntDos := ''                  // Path de integraci¢n dos
       LOCAL cIntTre := ''                  // Path de integraci¢n tres
       LOCAL cIntCua := ''                  // Path de integraci¢n cuatro
     *ÀVariables generales

       LOCAL nNroPag := 1                   // N£mero de p gina
       LOCAL lTamAnc := .F.                 // .T. Tama¤o Ancho
       LOCAL nLinTot := 0                   // L¡neas totales de control
       LOCAL nTotReg := 0                   // Total de registros
       LOCAL aCabeza := {}                  // Encabezado del informe
       LOCAL cCodIni := ''                  // C¢digos de impresi¢n iniciales
       LOCAL cCodFin := ''                  // C¢digos de impresi¢n finales
       LOCAL aNroCol := {}                  // Columnas de impresi¢n
       LOCAL aTitulo := {}                  // T¡tulos para impresi¢n
       LOCAL cCabCol := ''                  // Encabezado de Columna
       LOCAL aCabSec := {}                  // Encabezado Secundario
       LOCAL nLenPrn := 0                   // Longitud l¡nea de impresi¢n
       LOCAL lCentra := .F.                 // .T. Centrar el informe
       LOCAL nColCab := 0                   // Columna del encabezado
       LOCAL bPagina := NIL                 // Block de P gina
       LOCAL bCabeza := NIL                 // Block de Encabezado
       LOCAL bDerAut := NIL                 // Block Derechos de Autor
       LOCAL nLinReg := 1                   // L¡neas del registro
       LOCAL cTxtPrn := ''                  // Texto de impresi¢n
       LOCAL nOpcPrn := 0                   // Opci¢n de Impresi¢n
       LOCAL Getlist := {}                  // Variable del sistema
     *ÀVariables de informe

       LOCAL     j,k := 0                   // Contador
       LOCAL    cMes := ''                  // Mes Inicial de pago
       LOCAL nMesIni := 1                   // Mes Inicial
       LOCAL aDetPag := {}                  // Detalles de los pagos
       LOCAL aPagAbo := {}                  // Calculos de los Abonos
       LOCAL nMesAbo := 0                   // Mes del Abono
       LOCAL nMesMod := 0                   // Mes Modificado
       LOCAL nUltPag := 0                   // Ultimo recibo facturado
       LOCAL aVlrCon := {}                  // Valor de los Conceptos

       LOCAL nRegAnt := 0                   // Registro Anterior
       LOCAL nRegAct := 0                   // Registro Actual
       LOCAL nRegPag := 0                   // Registro del pago
       LOCAL lHayPag := .F.                 // .T. Hay pago
       LOCAL nFacMes := 0                   // Facturaci¢n del Mes
       LOCAL nAntici := 0                   // Anticipos
       LOCAL nVlrInt := 0                   // Valor de los intereses
       LOCAL nIntNoP := 0                   // Valor de los intereses no pago
       LOCAL nSdoAct := 0                   // Saldo Actual
       LOCAL nSdoMor := 0                   // Valor de la Mora
       LOCAL nTotPag := 0                   // Total a Pagar
       LOCAL lPagRec   := .F.                 // .T. Pago el recibo
     *ÀVariables espec¡ficas
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DEFINCION DEL ENCABEZADO
       nNroPag := 0
       lTamAnc := .F.

       nTotReg := 50+nLinTot
       aCabeza := {cNomEmp,cNomSis,;
		   'SIMULACION DEL ESTADO DE CUENTA.A¥O:'+cAnoUsr,;
		   cNomEst,;
		   'CODIGO: '+cCodEst+' GRUPO:'+cCodGru+'-'+;
					ALLTRIM(STR(CLI->(RECNO()),2)),;
		   nNroPag++,;
		   cTotPagina(nTotReg),lTamAnc}

/*
       cCodIni := DRAFT_ON+PICA+CONDEN_ON
       cCodFin := NEGRA_OF+DOBGOL_OF
*/

       cCodIni := PCL({'DraftOn','Pica','CondenOn'})
       cCodFin := PCL({'NegraOf','DobGolOf'})
*>>>>FIN DEFINCION DEL ENCABEZADO

*>>>>ENCABEZADOS DE COLUMNA
       aNroCol := {06,12,12,12,12,06,12,12,12,8,20}
       aTitulo := {'MES',;
		   'DEUDA ANT',;
		   'MORA ANT',;
		   'VALOR MES',;
		   'VLR A PAGAR',;
		   'ESTADO',;
		   'F.DE PAGO',;
		   'FECHA OPO',;
		   'FECHA EXT',;
		   'INTERES%',;
		   'OBSERVACION'}
       cCabCol := cRegPrint(aTitulo,aNroCol)
*>>>>FIN ENCABEZADOS DE COLUMNA

*>>>>ANALISIS PARA CENTRAR EL INFORME
       nLenPrn := n17Stan+10
       lCentra := .T.
       nColCab := 0
       IF lCentra
	  nColCab := (nLenPrn-LEN(cCabCol))/2
       ENDIF
       aCabSec := NIL
       bPagina := {||lPagina(nLinReg)}
       bCabeza := {||CabezaPrn(cCodIni,aCabeza,cCabCol,;
			       nColCab,cCodFin,aCabSec)}
       bDerAut := {||DerechosPrn(cNomSis,cNomEmp,n17Stan)}
*>>>>FIN ANALISIS PARA CENTRAR EL INFORME

*>>>>ACTIVACION DE LA IMPRESORA
       IF lPrnArc
	  SET DEVICE TO PRINT
       ELSE
	  FilePrn := cCodEst
	  nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,cOpcPrn,.F.,,,PathDoc)
	  IF EMPTY(nOpcPrn)
	     RETURN NIL
	  ENDIF
       ENDIF

       SendCodes(PCL('Reset'))
       EVAL(bCabeza)
      *Impresi¢n del Encabezado
*>>>>FIN ACTIVACION DE LA IMPRESORA

*>>>>IMPRESION DE LOS CALCULOS DEL ABONO
       cSavPan := SAVESCREEN(0,0,24,79)
       SET DEVICE TO SCREEN
       Termometro(0,'IMPRIMIENDO')
       Termometro(50,'IMPRIMIENDO')
       SET DEVICE TO PRINT

       nUltPag := nMesUltPag(cCodEst)
       nMesIni := 1
       SELECT DES
       GO TOP

       DO WHILE .NOT. DES->(EOF())

**********ANALISIS DEL ABONO
	    IF DES->nTipDesDes # 3
	       DES->(DBSKIP())
	       LOOP
	    ENDIF
**********FIN ANALISIS DEL ABONO

**********DETALLES DE PAGOS
	    IF .NOT. lDetPagAbo(cCodEst,@aDetPag,@nMesIni,nUltPag)
	       EXIT
	    ENDIF
	    nMesAbo := DES->nNroMesDes
	    nMesMod := DES->nMesModDes
	    nMesMod := IF(nMesMod == 0,nMesAbo,nMesMod)
**********FIN DETALLES DE PAGOS

**********VALIDACION DEL MES AFECTADO
	    lHayPag := lLocCodPag(cCodEst,nMesMod,.F.)
**********FIN VALIDACION DEL MES AFECTADO

**********IMPRESION DE LOS PAGOS
	    FOR k := 1 TO LEN(aDetPag)

		IF EMPTY(aDetpag[k,1])
		   LOOP
		ENDIF
		PAG->(DBGOTO(aDetPag[k,6]))

		cMes := IF(PAG->nMesAmnPag # PAG->nMesIniPag,;
			   cMes(aDetPag[k,1],3),;
			   LOWER(cMes(aDetPag[k,1],3)))

		aTitulo := {cMes+IF(k==nMesAbo .OR. k==nMesMod,'*',''),;
			    TRANS(aDetPag[k,2],"####,###,###"),;
			    TRANS(aDetPag[k,3],"####,###,###"),;
			    TRANS(aDetPag[k,4],"####,###,###"),;
			    TRANS(aDetPag[k,2]+aDetPag[k,3]+;
				  aDetPag[k,4],"####,###,###"),;
			    aDetPag[k,5],;
			    cFecha(PAG->dFecPagPag,3),;
			    cFecha(PAG->dPagOpoPag,3),;
			    cFecha(PAG->dPagExtPag,3),;
			    STR(PAG->nIntDeuPag,5,2),;
			    IF(lHayErr .AND. k==nMesMod,;
			      'NO APARECE FACTURADO ESTE MES','')}
		cTxtPrn := cRegPrint(aTitulo,aNroCol)
		lPrnReg(01,nColCab,cTxtPrn,bPagina,bDerAut,bCabeza)
	    ENDFOR
**********FIN IMPRESION DE LOS PAGOS

**********IMPRESION DE LOS DETALLES DEL ABONO
	    PAG->(DBGOTO(aDetPag[nMesAbo,6]))
	    aTitulo := {cMes(nMesAbo,3)+'*',;
			SPACE(10),;
			SPACE(01),;
			TRANS(DES->nValorDes,"####,###,###"),;
			SPACE(12),;
			'ABONO',;
			SPACE(12),;
			IF(DES->dFechaDes <= PAG->dPagExtPag,;
			   cFecha(DES->dFechaDes,3),''),;
			IF(DES->dFechaDes > PAG->dPagExtPag,;
			   cFecha(DES->dFechaDes,3),''),;
			SPACE(01),;
			SPACE(30)}
	    cTxtPrn := cRegPrint(aTitulo,aNroCol)
	    lPrnReg(01,nColCab,cTxtPrn,bPagina,bDerAut,bCabeza)

	    cTxtPrn := REPL('-',LEN(cTxtPrn))
	    lPrnReg(01,nColCab,cTxtPrn,bPagina,bDerAut,bCabeza)
**********FIN IMPRESION DE LOS DETALLES DEL ABONO

**********APLICACION DEL ABONO
	    IF .NOT. lAbonos(nMesAbo,DES->dFechaDes,;
			     DES->nValorDes,nMesMod,;
			     aDetPag,@aPagAbo)
	       SET DEVICE TO SCREEN
	       cError('NO SE APLICO EL ABONO DE '+cMes(nMesAbo))
	       SET DEVICE TO PRINT
	       EXIT
	    ENDIF
**********FIN APLICACION DEL ABONO

**********ACTUALIZACION DEL ABONO
	    IF lHayPag
	       aDetPag[nMesMod,2] := aPagAbo[1,1]     // Saldo Anterior
	       aDetPag[nMesMod,3] := aPagAbo[1,2]     // Mora Anterior
	       aDetPag[nMesMod,4] := aPagAbo[1,3]     // Valor del mes
	     *ÀMes Afectado

	    ENDIF

	    aDetPag[nMesAbo,2] := aPagAbo[2,1]     // Saldo Anterior
	    aDetPag[nMesAbo,3] := aPagAbo[2,2]     // Mora Anterior
	    aDetPag[nMesAbo,4] := aPagAbo[2,3]     // Valor del mes
	  *ÀMes del Descuento


	    IF LEN(aDetPag) == nMesAbo+1
	       aDetPag[nMesAbo+1,2] := aPagAbo[3,1]   // Saldo Anterior
	       aDetPag[nMesAbo+1,3] := aPagAbo[3,2]   // Mora Anterior
	       aDetPag[nMesAbo+1,4] := aPagAbo[3,3]   // Valor del mes
	    ENDIF
	  *ÀMes posterior al mes del abono
**********FIN ACTUALIZACION DEL ABONO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT DES
	    DES->(DBSKIP())

	    IF DES->(EOF())
	       SET DEVICE TO SCREEN
	       Termometro(100)
	       SET DEVICE TO PRINT
	    ENDIF
**********FIN AVANCE DEL SIGUIENTE REGISTRO

       ENDDO
       RESTSCREEN(0,0,24,79,cSavPan)
*>>>>FIN IMPRESION DE LOS CALCULOS DEL ABONO

*>>>>CONTINUACION DEL ESTADO DE CUENTA SIN ABONOS
       lDetPag(cCodEst,aDetPag,nMesIni,nUltPag)
*>>>>FIN CONTINUACION DEL ESTADO DE CUENTA SIN ABONOS

*>>>>IMPRESION DE LOS PAGOS
       FOR k := 1 TO LEN(aDetPag)

***********VERIFICACION QUE EXISTA EL PAGO
	     lHayErr := .F.
	     nRegPag := aDetPag[k,6]
	     IF EMPTY(nRegPag)
		LOOP
	     ENDIF
	     PAG->(DBGOTO(nRegPag))
***********FIN VERIFICACION QUE EXISTA EL PAGO

***********VALIDACION DE LOS REGISTROS DE PAGOS
	     IF !(aDetPag[k,2] == PAG->nSdoAntPag .AND.;
		  aDetPag[k,3] == PAG->nMorAntPag .AND.;
		  aDetPag[k,4] == PAG->nVlrMesPag)
		lHayErr := .T.
	     ENDIF
***********FIN VALIDACION DE LOS REGISTROS DE PAGOS

***********ANALISIS DEL ERROR
	     IF lHayErr

		SET DEVICE TO SCREEN
		cError('NO LE COINCIDEN LOS REGISTROS DEL MES DE '+;
		       cMes(k),'CODIGO: '+CLI->cCodigoEst)
		SET DEVICE TO PRINT

	     ENDIF
***********FIN ANALISIS DEL ERROR

***********IMPRESION DEL REGISTRO
	     cMes := IF(PAG->nMesAmnPag # PAG->nMesIniPag,;
			cMes(aDetPag[k,1],3),;
			LOWER(cMes(aDetPag[k,1],3)))

	     aTitulo := {cMes+IF(k==nMesAbo .OR. k==nMesMod,'*',''),;
			 TRANS(aDetPag[k,2],"####,###,###"),;
			 TRANS(aDetPag[k,3],"####,###,###"),;
			 TRANS(aDetPag[k,4],"####,###,###"),;
			 TRANS(aDetPag[k,2]+aDetPag[k,3]+;
			       aDetPag[k,4],"####,###,###"),;
			 aDetPag[k,5],;
			 cFecha(PAG->dFecPagPag,3),;
			 cFecha(PAG->dPagOpoPag,3),;
			 cFecha(PAG->dPagExtPag,3),;
			 STR(PAG->nIntDeuPag,5,2),;
			 IF(lHayErr,'NO COINCIDEN REGISTROS','')}
	     cTxtPrn := cRegPrint(aTitulo,aNroCol)
	     lPrnReg(01,nColCab,cTxtPrn,bPagina,bDerAut,bCabeza)
***********FIN IMPRESION DEL REGISTRO

       ENDFOR
       cTxtPrn := REPL('-',LEN(cTxtPrn))
       lPrnReg(01,nColCab,cTxtPrn,bPagina,bDerAut,bCabeza)
*>>>>FIN VALIDACION DE LOS PAGOS DESPUES DE ABONOS

*>>>>ANALISIS DE DECISION
       IF lHayErr
	  cTxtPrn := 'FAVOR REVISAR EXISTEN INCONSISTENCIAS'
	  lPrnReg(01,nColCab,cTxtPrn,bPagina,bDerAut,bCabeza)
       ENDIF

       k := LEN(aDetPag)
       PAG->(DBGOTO(aDetPag[k,6]))

       IF PAG->nMesIniPag # nUltPag
	  cTxtPrn := 'FAVOR REVISAR EXISTEN INCONSISTENCIAS.'
	  lPrnReg(01,nColCab,cTxtPrn,bPagina,bDerAut,bCabeza)
       ENDIF

       lPagRec := CLI->nSdoActCli+CLI->nSdoMorCli == 0 .AND.;
		  !EMPTY(PAG->dFecPagPag)              .AND.;
		  (PAG->cEstadoPag == 'P' .OR. PAG->cEstadoPag == 'A')
*>>>>FIN ANALISIS DE DECISION

*>>>>VALOR A PAGAR OPORTUNO
       IF .NOT. lHayErr .AND. !lPagRec .AND. PAG->cEstadoPag == '*'

	  nTotPag := PAG->nSdoAntPag+PAG->nMorAntPag+PAG->nVlrMesPag

	  cTxtPrn := 'VALOR A PAGAR OPORTUNO DEL RECIBO DE '+;
		     cMes(PAG->nMesIniPag,3)+' DEL '+cAnoUsr+' A '+;
		     cFecha(PAG->dPagOpoPag,3)+' ....... $'+;
		     ALLTRIM(TRANS(nTotPag,"####,###,###"))

	  lPrnReg(01,nColCab,cTxtPrn,bPagina,bDerAut,bCabeza)

       ENDIF
*>>>>FIN VALOR A PAGAR OPORTUNO

*>>>>VALOR A PAGAR EXTEMPORANEO
       IF .NOT. lHayErr .AND. !lPagRec .AND. PAG->cEstadoPag == '*'

	  nVlrInt := nIntMesPag(CAA->lIntPenCaA,;
				PAG->nSdoAntPag,;
				PAG->nVlrMesPag,;
				PAG->nMesIniPag,;
				CAA->nMesAmnCaA)

	  nTotPag := PAG->nSdoAntPag+PAG->nMorAntPag+PAG->nVlrMesPag+nVlrInt

	  cTxtPrn := 'VALOR A PAGAR EXTEMPORANEO DEL RECIBO DE '+;
		     cMes(PAG->nMesIniPag,3)+' DEL '+cAnoUsr+' A '+;
		     cFecha(PAG->dPagExtPag,3)+' ... $'+;
		     ALLTRIM(TRANS(nTotPag,"####,###,###"))

	  lPrnReg(01,nColCab,cTxtPrn,bPagina,bDerAut,bCabeza)

       ENDIF
*>>>>FIN VALOR A PAGAR EXTEMPORANEO

*>>>>VALOR A PAGAR NO PAGO
       IF .NOT. lHayErr  .AND. !lPagRec

	  nIntNoP := nIntMesNoP(CAA->lIntPenCaA,;
				PAG->nSdoAntPag,;
				PAG->nVlrMesPag,;
				PAG->nMesIniPag,;
				CAA->nMesAmnCaA)

	  nTotPag := PAG->nSdoAntPag+PAG->nMorAntPag+PAG->nVlrMesPag+nIntNoP

	  IF PAG->cEstadoPag == '*'
	     cTxtPrn := 'VALOR A PAGAR RECIBO DE '+;
			cMes(PAG->nMesIniPag,3)+' DEL '+cAnoUsr+' DESPUES '+;
			cFecha(PAG->dPagExtPag,3)+' .............. $'+;
			ALLTRIM(TRANS(nTotPag,"####,###,###"))
	  ELSE

	     IF CLI->nSdoActCli+CLI->nSdoMorCli == nTotPag
		cTxtPrn := 'SALDO ACTUAL DEL RECIBO DE '+;
			   cMes(PAG->nMesIniPag,3)+;
			   ' DEL '+cAnoUsr+;
			   '.VALOR A PAGAR .. $'+;
			   ALLTRIM(TRANS(nTotPag,"####,###,###"))
	     ELSE
		cTxtPrn := 'FAVOR REVISAR EXISTEN INCONSISTENCIAS EN EL SALDO ACTUAL'
	     ENDIF
	  ENDIF
	  lPrnReg(01,nColCab,cTxtPrn,bPagina,bDerAut,bCabeza)

       ENDIF
*>>>>FIN VALOR A PAGAR NO PAGO


*>>>>IMPRESION DERECHOS
       EVAL(bDerAut)
      *Derechos de Autor

       @ PROW()-PROW(),00 SAY ' '
      *Saca la ultima linea

       SET DEVICE TO SCREEN
       DES->(DBGOTO(nRegAct))
       VerPrn(nOpcPrn,FilePrn)
       RETURN NIL
*>>>>FIN IMPRESION DERECHOS

/*************************************************************************
* TITULO..: VALIDACION DE LA CUENTA DEL ESTUDIANTE                       *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 31/2005 MIE A
       Colombia, Bucaramanga        INICIO: 10:00 PM   AGO 31/2005 MIE

OBJETIVOS:

1- Valida el estado de cuenta de un estudiante

2- Debe estar en uso los archivos de Descuento,Pagos,Clientes

3- Retorna .T. si la cuenta no tiene problemas.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aValCtaEst(cCodEst,lMsgErr)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante
       lMsgErr                              // .T. Mensajes de Error */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cSavLin := ''                  // Salvar l¡nea
       LOCAL lHayErr := .F.                 // .T. Hay Error
       LOCAL Getlist := {}                  // Variable del sistema

       LOCAL  lError := .F.                 // .T. Hay Error
       LOCAL     j,k := 0                   // Contador
       LOCAL    cMes := ''                  // Mes Inicial de pago
       LOCAL nMesIni := 1                   // Mes Inicial
       LOCAL aDetPag := {}                  // Detalles de los pagos
       LOCAL aPagAbo := {}                  // Calculos de los Abonos
       LOCAL aSdoMes := {}                  // Saldo Anterior y valor del mes antes de abonos
       LOCAL nMesAbo := 0                   // Mes del Abono
       LOCAL nMesMod := 0                   // Mes Modificado
       LOCAL nUltPag := 0                   // Ultimo recibo facturado
       LOCAL cMsgErr := ''                  // Mensaje de Error
       LOCAL aMsgErr := {}                  // Mensajes de Error
       LOCAL lHayAbo := .T.                 // .T. Hay Abonos

       LOCAL nRegAnt := 0                   // Registro Anterior
       LOCAL nRegAct := 0                   // Registro Actual
       LOCAL nRegPag := 0                   // Registro del pago
       LOCAL lHayPag := .F.                 // .T. Hay Pago
       LOCAL nFacMes := 0                   // Facturaci¢n del Mes
       LOCAL nAntici := 0                   // Anticipos
       LOCAL nVlrBec := 0                   // Valor de la Beca
       LOCAL nIntMes := 0                   // Interese del Mes
       LOCAL nDeuCli := 0                   // Deuda del Cliente
       LOCAL nMorCli := 0                   // Mora del Cliente
     *ÀVariables espec¡ficas
*>>>>FIN DECLARACION DE VARIABLES


*>>>>ANALISIS DEL ALIAS
       IF ALIAS(SELECT('CAA')) == 'CAA'
	  IF CAA->nMtdFacCaA == 1
	     RETURN aMsgErr
	  ENDIF
       ENDIF
*>>>>FIN ANALISIS DEL ALIAS

*>>>>FILTRACION DEL ARCHIVO DE DESCUENTOS POR ESTUDIANTE
       lMsgErr := IF(lMsgErr == NIL,.T.,lMsgErr)

       SELECT DES
       SET FILTER TO DES->cCodigoEst == cCodEst .AND.;
		     DES->nTipDesDes == 3   // Abonos

       cSavPan := SAVESCREEN(0,0,24,79)

       IF lMsgErr
	  Termometro(0,'REVISANDO EL ESTADO DE CUENTA')
	  Termometro(10)
       ENDIF
*>>>>FIN FILTRACION DEL ARCHIVO DE DESCUENTOS POR ESTUDIANTE

*>>>>LOCALIZACION DEL PAGO
       IF PAG->cCodigoEst # cCodEst
	  lLocCodigo('cCodigoEst','PAG',cCodEst)
       ENDIF
*>>>>FIN LOCALIZACION DEL PAGO

*>>>>VALIDACION DEL ESTADO DE CUENTA
       AADD(aSdoMes,{0,;  // Mes Inicial
		     0,;  // Deuda Anterior
		     0,;  // Mora Anterior
		     0})  // Valor del Mes

       lHayAbo := .F.
       nMesIni := 1
       nUltPag := nMesUltPag(cCodEst)
       SELECT DES
       GO TOP
       DO WHILE .NOT. DES->(EOF())

**********ANALISIS DEL ABONO
	    IF DES->nTipDesDes # 3
	       DES->(DBSKIP())
	       LOOP
	    ENDIF
	    lHayAbo := .T.
**********FIN ANALISIS DEL ABONO


**********DETALLES DE PAGOS
	    IF .NOT. lDetPagAbo(cCodEst,@aDetPag,@nMesIni,nUltPag)
	       lError := .T.
	       EXIT
	    ENDIF
	    nMesAbo := DES->nNroMesDes
	    nMesMod := DES->nMesModDes
	    nMesMod := IF(nMesMod == 0,nMesAbo,nMesMod)
**********FIN DETALLES DE PAGOS


**********DETALLES DEL PAGO ANTES DEL ABONO
	    IF ASCAN(aSdoMes,{|aArray| aArray[1] == nMesAbo}) == 0
	       AADD(aSdoMes,{nMesAbo,DES->nSdoAntPag,;
				     DES->nMorAntPag,;
				     DES->nVlrMesPag})
	    ENDIF

	    IF ASCAN(aSdoMes,{|aArray| aArray[1] == nMesMod}) == 0
	       AADD(aSdoMes,{nMesMod,DES->nSdoAntDes,;
				     DES->nMorAntDes,;
				     DES->nVlrMesDes})
	    ENDIF
**********FIN DETALLES DEL PAGO ANTES DEL ABONO

**********VALIDACION DEL MES DEL ABONO
	    nRegAct := PAG->(RECNO())

	    IF !lLocCodPag(cCodEst,nMesAbo,.F.)
	       cMsgErr := cMes(nMesAbo)+' APARECE ELIMINADO '+;
			  'Y LO AFECTA UN ABONO DE '+cMes(nMesAbo)
	       AADD(aMsgErr,cMsgErr)

	       IF lMsgErr
		  cError(cMsgErr)
	       ENDIF
	    ENDIF
**********FIN VALIDACION DEL MES DEL ABONO

**********VALIDACION DEL MES AFECTADO
	    lHayPag := lLocCodPag(cCodEst,nMesMod,.F.)
	    IF !lHayPag
	       cMsgErr := cMes(nMesMod)+' APARECE ELIMINADO '+;
			  'Y LO AFECTA UN ABONO DE '+cMes(nMesAbo)
	       AADD(aMsgErr,cMsgErr)

	       IF lMsgErr
		  cError(cMsgErr)
	       ENDIF
	    ENDIF
**********FIN VALIDACION DEL MES AFECTADO

**********VALIDACION DE LOS PAGOS SIN ABONOS
	    FOR k := 1 TO LEN(aDetPag)

*---------------VERIFICACION QUE EXISTA EL PAGO
		  nRegPag := aDetPag[k,6]
		  IF EMPTY(nRegPag)
		     LOOP
		  ENDIF
		  PAG->(DBGOTO(nRegPag))
*---------------FIN VERIFICACION QUE EXISTA EL PAGO

*---------------VALIDACION DE LOS MESES MODIFICADOS POR EL ABONO
		  IF k == nMesAbo .OR. k == nMesMod
		     EXIT
		  ENDIF
*---------------FIN VALIDACION DE LOS MESES MODIFICADOS POR EL ABONO

*---------------VALIDACION DEL PAGO SIN ABONOS
		  IF !(aDetPag[k,2] == PAG->nSdoAntPag .AND.;
		       aDetPag[k,3] == PAG->nMorAntPag .AND.;
		       aDetPag[k,4] == PAG->nVlrMesPag)

		     lHayErr := .T.
		     lError  := lHayErr
		     EXIT
		  ENDIF
*---------------FIN VALIDACION DEL PAGO SIN ABONOS

	    ENDFOR

	    IF lMsgErr
	       Termometro(50)
	    ENDIF
**********FIN VALIDACION DE LOS PAGOS SIN ABONOS

**********ANALISIS DEL ERROR
	    IF lHayErr

	       cMsgErr := 'NO LE COINCIDEN LOS REGISTROS DEL MES DE '+;
			   cMes(k)+' antes DEL ABONO DE '+cMes(nMesAbo)
	       AADD(aMsgErr,cMsgErr)

	       IF lMsgErr
		  cError(cMsgErr)
	       ENDIF

	       EXIT
	    ENDIF
	    PAG->(DBGOTO(nRegAct))
**********FIN ANALISIS DEL ERROR

**********APLICACION DEL ABONO
	    IF .NOT. lAbonos(nMesAbo,DES->dFechaDes,;
			     DES->nValorDes,nMesMod,;
			     aDetPag,@aPagAbo)

	       cMsgErr := 'NO SE APLICO EL ABONO DE '+cMes(nMesAbo)
	       AADD(aMsgErr,cMsgErr)

	       IF lMsgErr
		  cError(cMsgErr)
	       ENDIF

	       EXIT
	    ENDIF
**********FIN APLICACION DEL ABONO

**********ACTUALIZACION DEL ABONO
	    IF lHayPag
	       aDetPag[nMesMod,2] := aPagAbo[1,1]     // Saldo Anterior
	       aDetPag[nMesMod,3] := aPagAbo[1,2]     // Mora Anterior
	       aDetPag[nMesMod,4] := aPagAbo[1,3]     // Valor del mes
	    ENDIF
	  *ÀMes Afectado

	    aDetPag[nMesAbo,2] := aPagAbo[2,1]     // Saldo Anterior
	    aDetPag[nMesAbo,3] := aPagAbo[2,2]     // Mora Anterior
	    aDetPag[nMesAbo,4] := aPagAbo[2,3]     // Valor del mes
	  *ÀMes del Descuento

	    IF LEN(aDetPag) == nMesAbo+1
	       aDetPag[nMesAbo+1,2] := aPagAbo[3,1]   // Saldo Anterior
	       aDetPag[nMesAbo+1,3] := aPagAbo[3,2]   // Mora Anterior
	       aDetPag[nMesAbo+1,4] := aPagAbo[3,3]   // Valor del mes
	    ENDIF
	  *ÀMes posterior al mes del abono
**********FIN ACTUALIZACION DEL ABONO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT DES
	    DES->(DBSKIP())
**********FIN AVANCE DEL SIGUIENTE REGISTRO

       ENDDO
       IF lMsgErr
	  Termometro(75)
       ENDIF
*>>>>FIN VALIDACION DEL ESTADO DE CUENTA


*>>>>VALIDACION DE LOS REGISTROS
       lDetPag(cCodEst,aDetPag,nMesIni,nUltPag)
       FOR k := 1 TO LEN(aDetPag)

***********VERIFICACION QUE EXISTA EL PAGO
	     lHayErr := .F.
	     nRegPag := aDetPag[k,6]
	     IF EMPTY(nRegPag)
		LOOP
	     ENDIF
	     PAG->(DBGOTO(nRegPag))
***********FIN VERIFICACION QUE EXISTA EL PAGO

/*

Pendiente por cuando el valor del mes es 0 por la aplicaci¢n
de un abono el sistema genera inconsistencia.

***********VALIDACION DE LA FACTURACION
	     j := ASCAN(aSdoMes,{|aArray| aArray[1] == PAG->nMesIniPag})

	     IF j == 0

		IF (PAG->nMesIniPag # PAG->nMesFinPag .OR.;
		    lHayAntici(PAG->nMesIniPag,PAG->cIniFinPag)) .AND.;
		    PAG->cEstadoPag == 'D'

		    cMsgErr := cValFacMes(cCodEst,PAG->nMesIniPag,;
					  PAG->nSdoAntPag,PAG->nMorAntPag,;
					  PAG->nVlrMesPag,PAG->nSdoAntPag+;
					  PAG->nMorAntPag+PAG->nVlrMesPag)
		ELSE
		    cMsgErr := cValFacMes(cCodEst,PAG->nMesIniPag,;
					  PAG->nSdoAntPag,PAG->nMorAntPag,;
					  PAG->nVlrMesPag,PAG->nVlrPagPag)
		ENDIF

	     ELSE

		cMsgErr := cValFacMes(cCodEst,PAG->nMesIniPag,;
				      aSdoMes[j,2],aSdoMes[j,3],aSdoMes[j,4],;
				      aSdoMes[j,2]+aSdoMes[j,3]+aSdoMes[j,4])
	     ENDIF

	     IF !EMPTY(cMsgErr)
		AADD(aMsgErr,cMsgErr)
		lHayErr := .T.
		lError  := lHayErr
	     ENDIF
***********FIN VALIDACION DE LA FACTURACION
*/

***********VALIDACION DE LOS REGISTROS DE PAGOS
	     IF !(aDetPag[k,2] == PAG->nSdoAntPag .AND.;
		  aDetPag[k,3] == PAG->nMorAntPag .AND.;
		  aDetPag[k,4] == PAG->nVlrMesPag)

		lHayErr := .T.
		lError  := lHayErr
	     ENDIF
***********FIN VALIDACION DE LOS REGISTROS DE PAGOS

***********ANALISIS DEL ERROR
	     IF lHayErr

		 cMsgErr := 'NO LE COINCIDEN LOS REGISTROS '+;
			    'DEL MES DE '+cMes(k)
		 AADD(aMsgErr,cMsgErr)

		 IF lMsgErr
		    cError(cMsgErr)
		 ENDIF
	     ENDIF
***********FIN ANALISIS DEL ERROR

       ENDFOR
*>>>>FIN VALIDACION DE LOS REGISTROS

*>>>>VALIDACION DEL SALDO ACTUAL
       lLocCodPag(cCodEst,nMesUltPag(cCodEst),.F.)
       DO CASE
       CASE PAG->cEstadoPag == 'P' .OR. PAG->cEstadoPag == 'A'
	    nDeuCli := 0
	    nMorCli := 0

       CASE PAG->cEstadoPag = 'D'
	    nDeuCli := PAG->nSdoAntPag+PAG->nVlrMesPag
	    nIntMes := nIntMesNew(nDeuCli)
	    nMorCli := PAG->nMorAntPag+nIntMes

       CASE PAG->cEstadoPag = '*'
	    nDeuCli := PAG->nSdoAntPag
	    nMorCli := PAG->nMorAntPag

       ENDCASE

       IF CLI->nSdoActCli # nDeuCli .OR.;
	  CLI->nSdoMorCli # nMorCli

	  cMsgErr := 'EL SALDO ACTUAL ESTA DESCUADRADO'
	  AADD(aMsgErr,cMsgErr)

	  IF lMsgErr
	     cError(cMsgErr)
	  ENDIF
	  lError  := .T.
       ENDIF
*>>>>FIN VALIDACION DEL SALDO ACTUAL

*>>>>VALIDACION DE ESTADO DE CUENTA
       IF .NOT. lError .AND. lMsgErr
	  cError('ESTADO DE CUENTA SIN PROBLEMAS')
       ENDIF

       IF lMsgErr
	  Termometro(100)
       ENDIF

       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN aMsgErr
*>>>>FIN VALIDACION DE ESTADO DE CUENTA

/*************************************************************************
* TITULO..: VALIDAR LA CUENTA DE LOS ESTUDIANTES                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 31/2005 MIE A
       Colombia, Bucaramanga        INICIO: 03:30 PM   AGO 31/2005 MIE

OBJETIVOS:

1- Valida el estado de cuenta de los estudiantes

2- Debe estar en uso los archivos, Descuentos, Grupos, Maestro de alumnos

3- Retorna Nil

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aValCuenta(lShared,nModCry,cNomSis,cAnoUsr,cMaeAlu,nGruIni,nGruFin,;
		    cPatCar)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       cNomSis                              // Nombre del Sistema
       cAnoUsr                              // A¤o del Usuario
       cMaeAlu                              // Maestros habilitados
       nGruIni                              // Registo inicial del Grupo
       nGruFin                              // Grupo Final del Grupo
       cPatCar                              // Path de la Cartera */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"          // Declaraci¢n de Archivos

       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema

       LOCAL       i := 0                   // Contador
       LOCAL cMaeAct := ''                  // Maestro Actual
       LOCAL cMsgErr := ''                  // Mensaje de Error
       LOCAL aErrCta := {}                  // Errores del Estado de Cuenta
       LOCAL aMsgErr := {}                  // Estudiantes con errores

       LOCAL cNombreTes := ''               // Nombre del Estudiante
*>>>>FIN DECLARACION DE VARIABLES

*>>>>RECORRIDO POR GRUPOS
       SELECT GRU
       GRU->(DBGOTO(nGruIni))
       DO WHILE GRU->(RECNO()) <= nGruFin

**********PREPARACION DE LAS VARIABLES DE ARCHIVO
	    FileCli := cPatCar+'\CLIENTES\CL'+;
			       GRU->cCodigoGru+cAnoSis+ExtFile

	    FilePag := cPatCar+'\PAGOS\PA'+;
			       GRU->cCodigoGru+cAnoSis+ExtFile
**********FIN PREPARACION DE LAS VARIABLES DE ARCHIVO

**********SELECION DE LAS AREAS DE TRABAJO
	    IF !lUseDbf(.T.,FileCli,'CLI',NIL,lShared,nModCry) .OR.;
	       !lUseDbf(.T.,FilePag,'PAG',NIL,lShared,nModCry)

	       cMsgErr := 'ABRIENDO LOS ARCHIVOS DE CLIENTES Y PAGOS.'+;
			  'GRUPO:'+GRU->cCodigoGru

	       AADD(aMsgErr,{'','','',cMsgErr})

	       CloseDbf('CLI')
	       CloseDbf('PAG')

	       SELECT GRU
	       GRU->(DBSKIP())
	       LOOP
	    ENDIF
**********FIN SELECION DE LAS AREAS DE TRABAJO

**********RECORRIDO POR GRUPOS
	    SELECT CLI
	    CLI->(DBGOTOP())
	    DO WHILE .NOT. CLI->(EOF())

*--------------LINEA DE ESTADO
		 LineaEstado('ºCODIGO: '+GRU->cCodigoGru+;
			     'ºGRUPO : '+CLI->cCodigoEst+;
			     'ºNo. '+STR(CLI->(RECNO()),2)+'/'+;
				     STR(CLI->(RECCOUNT()),2),cNomSis)
*--------------FIN LINEA DE ESTADO

*--------------ANALISIS SI EL ESTUDIANTE PERTENECE AL GRUPO
		 IF CLI->lRetGruCli
		    SELECT CLI
		    CLI->(DBSKIP())
		    LOOP
		 ENDIF
*--------------FIN ANALISIS SI EL ESTUDIANTE PERTENECE AL GRUPO

*--------------BUSQUEDA DEL CODIGO DEL ESTUDIANTE
		 IF !lSekCodMae(CLI->cCodigoEst,cMaeAlu,@cMaeAct,.F.)

		    cMsgErr := 'NO EXISTE EN EL ARCHIVO DE ALUMNOS'
		    AADD(aMsgErr,{CLI->cCodigoEst,GRU->cCodigoGru,;
				  '',cMsgErr})

		    SELECT CLI
		    CLI->(DBSKIP())
		    LOOP

		 ENDIF

		 cNombreTes := RTRIM(&cMaeAct->cApelliEst)+' '+;
			       RTRIM(&cMaeAct->cNombreEst)
*--------------FIN BUSQUEDA DEL CODIGO DEL ESTUDIANTE

*--------------VERIFICACION DEL GRUPO
		 IF &cMaeAct->cCodigoGru # GRU->cCodigoGru .AND.;
		    !(CLI->lRetGruCli)

		    cMsgErr := 'PERTENECE AL GRUPO: '+&cMaeAct->cCodigoGru
		    AADD(aMsgErr,{CLI->cCodigoEst,GRU->cCodigoGru,;
				  cNombreTes,cMsgErr})

		    SELECT CLI
		    CLI->(DBSKIP())
		    LOOP
		 ENDIF
*--------------FIN VERIFICACION DEL GRUPO

*--------------VALIDACION DEL ESTADO DE CUENTA
		 aErrCta := aValCtaEst(CLI->cCodigoEst,.F.)
		 IF LEN(aErrCta) # 0
		    FOR i := 1 TO LEN(aErrCta)
			AADD(aMsgErr,{CLI->cCodigoEst,GRU->cCodigoGru,;
				      cNombreTes,aErrCta[i]})
		    ENDFOR
		 ENDIF
*--------------FIN VALIDACION DEL ESTADO DE CUENTA

	       SELECT CLI
	       CLI->(DBSKIP())

	    ENDDO
**********RECORRIDO POR GRUPOS

	  SELECT GRU
	  GRU->(DBSKIP())

       ENDDO
       RETURN aMsgErr
*>>>>FIN RECORRIDO POR GRUPOS

/*************************************************************************
* TITULO..: SALDO ACTUAL A LA FECHA                                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 19/2004 JUE A
       Bucaramanga, Colombia	    INICIO: 02:40 PM   AGO 19/2004 JUE

OBJETIVOS:

1- Calcula el Saldo Actual a fecha de Corte

2- Retorna el Saldo Actual

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aSdoAct(cCodEst,nMesIni,dFecPrn,nDeuAct,;
		 nMorAct,aDetPag,nVlrPag,nVlrAbo)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante
       nMesIni                              // Mes Inicial del Pago
       dFecPrn                              // Fecha de Corte
       nDeuAct                              // @Deuda Actual
       nMorAct                              // @Mora Actual
       aDetPag                              // @Detalles de los Pagos
       nVlrPag                              // @Valor Pagado
       nVlrAbo                              // @Valor Abonos */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL       k := 0                   // Contador
       LOCAL nUltPag := 0                   // Ultimo recibo facturado
       LOCAL nMesFac := 1                   // Mes Facturado
       LOCAL aPagAbo := {}                  // Calculos de los Abonos
       LOCAL nMesAbo := 0                   // Mes del Abono
       LOCAL nMesMod := 0                   // Mes Modificado
       LOCAL lDeudor := .F.                 // .T. Deudor
       LOCAL nSdoAct := 0                   // Saldo Actual
*>>>>FIN DECLARACION DE VARIABLES

*>>>>FILTRACION DEL ARCHIVO DE DESCUENTOS POR ESTUDIANTE
       SELECT DES
       SET FILTER TO DES->cCodigoEst == cCodEst .AND.;
		     DES->nTipDesDes == 3   // Abonos
*>>>>FIN FILTRACION DEL ARCHIVO DE DESCUENTOS POR ESTUDIANTE

*>>>>RECORRIDO DE LOS ABONOS
       nVlrPag := 0
       nUltPag := nMesUltPag(cCodEst)

       aDetPag := {}
       SELECT DES
       DES->(DBGOTOP())
       DO WHILE .NOT. DES->(EOF())

**********ANALISIS DEL ABONO
	    IF DES->nTipDesDes # 3
	       DES->(DBSKIP())
	       LOOP
	    ENDIF
**********FIN ANALISIS DEL ABONO

**********DETALLES DE PAGOS
	    IF .NOT. lDetPagAbo(cCodEst,@aDetPag,@nMesFac,nUltPag)
	       EXIT
	    ENDIF
**********FIN DETALLES DE PAGOS

**********ANALISIS DE LA FECHA DEL ABONO
	    IF !EMPTY(dFecPrn) .AND. dFecPrn < DES->dFechaDes
	       DES->(DBSKIP())
	       LOOP
	    ENDIF
**********FIN ANALISIS DE LA FECHA DEL ABONO

**********LOCALIZACION MES MODIFICADO
	    nMesAbo := DES->nNroMesDes
	    nMesMod := DES->nMesModDes
	    IF nMesMod # 0 .AND. nMesMod <= LEN(RTRIM(CLI->cMesPagCli))
	       lLocCodPag(cCodEst,nMesMod)
	    ENDIF
**********FIN LOCALIZACION MES MODIFICADO

**********APLICACION DEL ABONO
	    nVlrAbo += DES->nValorDes
	    IF .NOT. lAbonos(nMesAbo,DES->dFechaDes,;
			     DES->nValorDes,nMesMod,;
			     aDetPag,@aPagAbo)
	       cError('NO SE APLICO EL ABONO DE '+cMes(nMesAbo))
	       EXIT
	    ENDIF
**********FIN APLICACION DEL ABONO

**********ACTUALIZACION DEL ABONO
	    IF nMesMod # 0
	       aDetPag[nMesMod,2] := aPagAbo[1,1]     // Saldo Anterior
	       aDetPag[nMesMod,3] := aPagAbo[1,2]     // Mora Anterior
	       aDetPag[nMesMod,4] := aPagAbo[1,3]     // Valor del mes
	     *ÀMes Afectado
	    ENDIF

	    aDetPag[nMesAbo,2] := aPagAbo[2,1]     // Saldo Anterior
	    aDetPag[nMesAbo,3] := aPagAbo[2,2]     // Mora Anterior
	    aDetPag[nMesAbo,4] := aPagAbo[2,3]     // Valor del mes
	  *ÀMes del Descuento

	    IF LEN(aDetPag) == nMesAbo+1
	       aDetPag[nMesAbo+1,2] := aPagAbo[3,1]   // Saldo Anterior
	       aDetPag[nMesAbo+1,3] := aPagAbo[3,2]   // Mora Anterior
	       aDetPag[nMesAbo+1,4] := aPagAbo[3,3]   // Valor del mes
	    ENDIF
	  *ÀMes posterior al mes del abono
**********FIN ACTUALIZACION DEL ABONO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT DES
	    DES->(DBSKIP())
**********FIN AVANCE DEL SIGUIENTE REGISTRO

       ENDDO
*>>>>FIN RECORRIDO DE LOS ABONOS

*>>>>CONTINUACION DEL ESTADO DE CUENTA SIN ABONOS
       lDetPag(cCodEst,aDetPag,@nMesFac,nUltPag)
       PAG->(DBGOTO(aDetPag[nMesIni,6]))
*>>>>FIN CONTINUACION DEL ESTADO DE CUENTA SIN ABONOS

*>>>>ANALISIS DE LA FORMA DE PAGO
       lDeudor := .F.
       IF aDetPag[nMesIni,5] == 'P' .OR. aDetPag[nMesIni,5] == 'A'

	  IF dFecPrn < PAG->dFecPagPag
	     lDeudor := .T.
	  ELSE

	     nVlrPag += PAG->nVlrPagPag
	     IF aDetPag[nMesIni,5] == 'A'
		nVlrPag += nVlrIntPag(PAG->lIntPenPag,;
				      PAG->nMesIniPag,;
				      PAG->nMesAmnPag)
	     ENDIF

	  ENDIF
       ENDIF
*>>>>FIN ANALISIS DE LA FORMA DE PAGO

*>>>>CALCULO DEL SALDO ACTUAL
       IF aDetPag[nMesIni,5] == 'D' .OR. lDeudor

	  nDeuAct := aDetPag[nMesIni,2]+; // Deuda Anterior
		     aDetPag[nMesIni,4]   // Valor del Mes

	  IF aDetPag[nMesIni,5] # 'P'
	     nMorAct := aDetPag[nMesIni,3]   // Mora Anterior
	     nMorAct += nIntMes(nDeuAct)     // Interes del Mes
	  ENDIF

       ENDIF
       nSdoAct := nDeuAct+nMorAct
       RETURN nSdoAct
*>>>>FIN CALCULO DEL SALDO ACTUAL



