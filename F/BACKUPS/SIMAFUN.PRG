/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		      BIBLIOTECAS DE FUNCIONES GENERALES

OBJETIVOS:

- Definici¢n de funciones generales para el SIMA

***************************************************************************
*-------------------- DECLARACION DE LAS FUNCIONES -----------------------*
**************************************************************************/

*>>>>DECLARACION DE CONSTANTES GENERALES
       #INCLUDE "inkey.ch"
*>>>>FIN DECLARACION DE CONSTANTES GENERALES

/*************************************************************************
* TITULO..: MAESTROS HABILITADOS                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAR 14/2005 LUN A
       Bucaramanga, Colombia        INICIO: 03:30 PM   MAR 14/2005 LUN

OBJETIVOS:

1- Retorna por referencia los param‚tros de la funci¢n marcados con @

2- Permite activar los maestros habilitados

3- Retorna los Maestros habilitados

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MaeHab(lShared,nModCry,fArchvo,cMaeAlu,cJornad,cCamMae,cCamJor)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos
       nModCry                              // Modo de Protecci¢n
       fArchvo                              // Archivo del A¤o
       cMaeAlu                              // Maestros Habilitados
       cJornad                              // Jornanda Habilitada
       cCamMae                              // Campo Maestro Habilitados
       cCamJor                              // Campo Jornadas Habilitas */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL       i := 0                   // Contador
       LOCAL aUseDbf := {}                  // Vector para Apertura de Varias Dbfs
       LOCAL cMaeHab := ''                  // Maestros Habilitados
       LOCAL cJorHab := ''                  // Jornadas Habilitadas
       LOCAL cMaeEst := ''                  // Maestro de Estudiantes
       LOCAL cMaeAct := ''                  // Maestro Actual
       LOCAL cJorEst := ''                  // Jornadas Habilitadas
       LOCAL cJorAct := ''                  // Jornada Actual
*>>>>FIN DECLARACION DE VARIABLES

*>>>>AREAS DE TRABAJO
       aUseDbf := {}
       AADD(aUseDbf,{.T.,fArchvo,'ANO',NIL,lShared,nModCry})
*>>>>FIN AREAS DE TRABAJO

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbfs(aUseDbf)
	  cError('ABRIENDO ARCHIVOS')
	  CloseDbf('ANO')
	  RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       lHayErr := .T.
       DO CASE
       CASE ANO->(RECCOUNT()) == 0
       OTHERWISE
	    lHayErr :=.F.
       ENDCASE

       IF lHayErr
	  CloseDbf('ANO')
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>HABILITACION MAESTROS HABILITADOS
       cMaeHab := &cCamMae
       cJorHab := &cCamJor
       CloseDbf('ANO')

       IF !EMPTY(cMaeHab)
	  FOR i := 1 TO LEN(ALLTRIM(cMaeAlu))/3
	      cMaeAct := SUBS(cMaeAlu,i*3-2,3)
	      IF cMaeAct $ cMaeHab
		 cMaeEst += cMaeAct
	      ENDIF
	  NEXT
	  IF !EMPTY(cMaeEst)
	     cMaeAlu := cMaeEst
	  ENDIF
       ENDIF
*>>>>FIN HABILITACION MAESTROS HABILITADOS

*>>>>HABILITACION JORNADAS HABILITADAS
       IF !EMPTY(cJorHab)
	  FOR i := 1 TO LEN(cJornad)
	      cJorAct := SUBS(cJornad,i,1)
	      IF cJorAct $ cJorHab
		 cJorEst += cJorAct
	      ENDIF
	  NEXT
	  IF !EMPTY(cJorEst)
	     cJornad := cJorEst
	  ENDIF
       ENDIF
       RETURN NIL
*>>>>FIN HABILITACION JORNADAS HABILITADAS

/*************************************************************************
* TITULO..: SELECCION DEL NIVEL DE ESTUDIOS                              *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 08/1995 LUN A
       Bucaramanga, Colombia        INICIO: 06:00 PM   MAY 08/1995 LUN

OBJETIVOS:

1)- Retorna por referencia los param‚tros de la funci¢n marcados con @

2)- Permite activar el nivel de estudios Jardin, Primaria o Bachillerato

3)- Retorna las tres iniciales del nivel de estudios

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cNivelEst(nNroFil,nNroCol,cMaeAlu,cNivTxt)

*>>>>PARAMETROS DE LA FUNCION
/*     nNroFil                              // N£mero de la fila
       nNroCol                              // N£mero de la columna
       cMaeAlu				    // Maestros habilitados
       cNivTxt				    // @Texto del nivel escogido */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 1                   // Contador
       LOCAL aMenus  := {}                  // Declaracion de Menus
       LOCAL nNroOpc := 1                   // N£mero de Opci¢n
       LOCAL cMaeAct := ''                  // Maestro Actual
*>>>>DECLARACION DE VARIABLES

*>>>>PREPARACION DEL NIVEL DE ESTUDIOS HABILITADOS
       IF 'JAR' $ cMaeAlu
	  AADD(aMenus,i)
	  aMenus[i++] := 'JARDIN'
       ENDIF

       IF 'PRI' $ cMaeAlu
	  AADD(aMenus,i)
	  aMenus[i++] := 'PRIMARIA'
       ENDIF

       IF 'BTO' $ cMaeAlu
	  AADD(aMenus,i)
	  aMenus[i++] := 'BACHILLERATO'
       ENDIF
*>>>>FIN PREPARACION DEL NIVEL DE ESTUDIOS HABILITADOS

*>>>>SELECCION DE LA JORNADA
       IF LEN(cMaeAlu) # 3
	  SAVE SCREEN
	  DO WHILE .T.

	     nNroOpc := nMenu(aMenus,NIL,nNroFil,nNroCol,'NIVEL',NIL,1,.F.)
	     IF nNroOpc <> 0
		EXIT
	     ENDIF
	  ENDDO
	  RESTORE SCREEN
       ENDIF
*>>>>FIN SELECCION DE LA JORNADA

*>>>>ASIGNACION DEL MAESTRO ACTUAL
       cNivTxt := aMenus[nNroOpc]
       cMaeAct := IF(aMenus[nNroOpc] == 'BACHILLERATO','BTO',;
		    SUBS(aMenus[nNroOpc],1,3))
       RETURN ALLTRIM(cMaeAct)
*>>>>FIN SELECCION DE LA JORNADA

/*************************************************************************
* TITULO..: SELECCION DE LA JORNADA DE ESTUDIO                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE 12/1994 JUE A
       Bucaramanga, Colombia        INICIO: 06:00 PM   ENE 12/1994 JUE

OBJETIVOS:

1)- Retorna por referencia los param‚tros de la funci¢n marcados con @

2)- Permite escoger la jornada de estudio

3)- Retorna las tres iniciales de la jornada

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cJornada(nNroFil,nNroCol,cJornad,cJorTxt)

*>>>>PARAMETROS DE LA FUNCION
/*     nNroFil                              // N£mero de la fila
       nNroCol                              // N£mero de la columna
       cJornad			            // Jornadas de estudio
       cJorTxt			            // @Jornada escogida */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL aMenus  := {}                  // Declaracion de Menus
       LOCAL nNroOpc := 1                   // N£mero de Opci¢n
       LOCAL       i := 1                   // Contador
*>>>>FIN DECLARACION DE VARIABLES

*>>>>SELECCION DE LA JORNADA
       IF 'D' $ cJornad
	  AADD(aMenus,i)
	  aMenus[i++] := 'DIURNA'
       ENDIF

       IF 'N' $ cJornad
	  AADD(aMenus,i)
	  aMenus[i++] := 'NOCTURNA'
       ENDIF

       IF 'M' $ cJornad
	  AADD(aMenus,i)
	  aMenus[i++] := 'MA¥ANA'
       ENDIF

       IF 'T' $ cJornad
	  AADD(aMenus,i)
	  aMenus[i++] := 'TARDE'
       ENDIF

       IF 'A' $ cJornad
	  AADD(aMenus,i)
	  aMenus[i++] := 'ADICIONAL'
       ENDIF

       IF LEN(cJornad) <> 1
	  SAVE SCREEN
	  DO WHILE .T.
	     nNroOpc := nMenu(aMenus,NIL,nNroFil,nNroCol,'JORNADAS',NIL,1)
	     IF nNroOpc <> 0
		EXIT
	     ENDIF
	  ENDDO
	  RESTORE SCREEN
       ENDIF

       cJorTxt := aMenus[nNroOpc]
       RETURN SUBS(aMenus[nNroOpc],1,3)
*>>>>FIN SELECCION DE LA JORNADA

/*************************************************************************
* TITULO..: JORNADA DE ESTUDIO ACTUAL                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAR 15/2005 MAR A
       Bucaramanga, Colombia        INICIO: 06:00 PM   MAR 15/2005 MAR

OBJETIVOS:

3- Retorna las tres iniciales de la jornada Actual

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cIniJor(cJorAct,cJorTxt)

*>>>>PARAMETROS DE LA FUNCION
/*     cJorAct			            // Jornada Actual
       cJorTxt			            // @Jornada escogida */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL aMenus  := {}                  // Declaracion de Menus
       LOCAL nNroOpc := 1                   // N£mero de Opci¢n
       LOCAL       i := 1                   // Contador
*>>>>FIN DECLARACION DE VARIABLES

*>>>>SELECCION DE LA JORNADA
       DO CASE
       CASE 'D' == cJorAct
	  cJorTxt := 'DIURNA'

       CASE 'N' == cJorAct
	  cJorTxt := 'NOCTURNA'

       CASE 'M' == cJorAct
	  cJorTxt := 'MA¥ANA'

       CASE 'T' == cJorAct
	  cJorTxt := 'TARDE'

       CASE 'A' == cJorAct
	  cJorTxt := 'ADICIONAL'
       ENDCASE

       RETURN SUBS(cJorTxt,1,3)
*>>>>FIN SELECCION DE LA JORNADA

/*************************************************************************
* TITULO..: SELECCION DEL RANGO DE MESES A COBRAR                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 13/1994 JUE A
       Bucaramanga, Colombia        INICIO: 07:00 PM   AGO 13/1994 JUE


OBJETIVOS:

1- Captura el rango de meses para un recibo por adelantado

2- Retorna por referencia los param‚tros de la funci¢n marcados con @

3- Retorna NIL

SINTAXIS:
  MesIniFin(04,30,@nMesiniTpa,@nMesfinTpa)

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MesIniFin(nNroFil,nNroCol,nMesIni,nMesFin)

*>>>>PARAMETROS DE LA FUNCION
/*     nNroFil                      // Fila para la impresi¢n
       nNroCol                      // Columna para la impresi¢n
       nMesIni                      // @Mes Inicial del pago
       nMesFin                      // @Mes Final del pago */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan                // Salvar Pantalla
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CAPTURA Y VALIDACION DEL RANGO DE MESES A PAGAR
       cSavPan := SAVESCREEN(0,0,24,79)
       DO WHILE .T.

**********CAPTURA DEL RANGO DE MESES
	    nMesIni := nMesano(nNroFil,nNroCol,;
		       'Mes Inicial para el pago de la Pensi¢n',.F.)
	    IF nMesIni # 0
	       nMesFin := nMesano(nNroFil+3,nNroCol,;
		       'Mes Final para el pago de la Pensi¢n',.F.)
	    ELSE
	       nMesFin := 0
	    ENDIF
**********FIN CAPTURA DEL RANGO DE MESES

**********VALIDACION DE LOS MESES DE PAGO
	    DO CASE
	    CASE nMesIni == 0 .OR. nMesFin == 0
		 EXIT

	    CASE nMesIni > nMesFin
		 cError ('EL MES INICIAL NO PUEDE SER MAYOR AL MES FINAL')
		 RESTSCREEN(0,0,24,79,cSavPan)
		 LOOP
	    ENDCASE
**********FIN VALIDACION DE LOS MESES DE PAGO

**********PREGUNTA DE DECISION
	    IF lPregunta('DESEA CORREGIR LOS MESES? No Si')
	       RESTSCREEN(0,0,24,79,cSavPan)
	       LOOP
	    ELSE
	       EXIT
	    ENDIF
**********FIN PREGUNTA DE DECISION

       ENDDO
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN NIL
*>>>>FIN CAPTURA Y VALIDACION DEL RANGO DE MESES A PAGAR

/*************************************************************************
* TITULO..: INTERVALO DE NUMEROS DE LISTA                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC 26/1994 LUN A
       Bucaramanga, Colombia        INICIO: 04:00 PM   DIC 26/1994 LUN

OBJETIVOS:

1- Permite leer un intervalo de n£meros de lista de estudiantes

2- Retorna por referencia los param‚tros de la funci¢n marcados con @

3- Retorna .T. si se leyeron n£meros de lista

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lNrosLista(nFilPal,nColPal,nNroIni,nNroFin)

*>>>>PARAMETROS DE LA FUNCION
/*     nFilPal                              // Fila Superior
       nColPal                              // Columna Superior
       nNroFil                              // @N£mero de Fila
       nNroFin                              // @N£mero de lista Final */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL cMsgTxt := ''                  // Texto variable
       LOCAL nNroFil := 0                   // N£mero de Fila
       LOCAL nNroCol := 0                   // N£mero de Columna
       LOCAL GetList := {}                  // Variable del sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CAPTURA DE LOS NUMEROS DE LISTA
       nNroIni := 1
       nNroFin := 0
       nNroFil := nFilPal
       nNroCol := nColPal
       cMsgTxt := 'NRO LISTA    : '
       @ nNroFil,  nNroCol SAY cMsgTxt
       @ nNroFil+1,nNroCol SAY 'NRO HASTA    : '
       @ nNroFil,  nNroCol+LEN(cMsgTxt) GET nNroIni PICT '99'
       @ nNroFil+1,nNroCol+LEN(cMsgTxt) GET nNroFin PICT '99'
       READ
       RETURN IF(nNroIni == 0,.F.,.T.)
*>>>>FIN CAPTURA DE LOS NUMEROS DE LISTA

/*************************************************************************
* TITULO ..: VALIDACION DEL DOCUMENTO                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 20/2004 JUE A
       Colombia, Bucaramanga        INICIO: 10:40 PM   MAY 20/2004 JUE

OBJETIVOS:

1- Valida si un documento de identidad esta correcto

2- Retorna .T. Si no se encontraron problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lDocNitOk(cDocNit,cTipDoc)

*>>>>DESCRIPCION DE PARAMETROS
/*     cDocNit                              // N£mero del Documento
       cTipDoc                              // Tipo de Documento */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
       LOCAL nLenDoc := 0                   // Longitud del Documento
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DE DECISION
       nLenDoc := LEN(ALLTRIM(cDocNit))
       lHayErr := .T.
       DO CASE
       CASE '.' $ cDocNit
       CASE nLenDoc == 0
       CASE nLenDoc < 6
       CASE nLenDoc > 8
       OTHERWISE
	   lHayErr := .F.
       ENDCASE
       RETURN !lHayErr
*>>>>FIN ANALISIS DE DECISION

/*************************************************************************
* TITULO ..: NOMBRE DE LA PERSONA                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 08/2004 JUE A
       Colombia, Bucaramanga        INICIO: 04:30 PM   JUL 08/2004 JUE

OBJETIVOS:

1- Retorna el nombre de la persona

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cNomPer(cApeUno,cApeDos,cNomUno,cNomDos,nTipNom,nLenNom)

*>>>>DESCRIPCION DE PARAMETROS
/*     cApeUno                              // Primer Apellido
       cApeDos                              // Segundo Apellido
       cNomUno                              // Primer Nombre
       cNomDos                              // Segundo Nombre
       nTipNom                              // Tipo de Nombre. 1=>Apellidos y Nombres 2=>Nombres y Apellidos
       nLenNom                              // Longitud del Nombre */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cNomPer := ''                  // Nombre de la Persona
       LOCAL cApelli := ''                  // Apellidos
       LOCAL cNombre := ''                  // Nombres
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CREACION DEL NOMBRE
       nTipNom := IF(EMPTY(nTipNom),1,nTipNom)
       nLenNom := IF(EMPTY(nLenNom),40,nLenNom)
       cApelli := ALLTRIM(cApeUno)+' '+ALLTRIM(cApeDos)
       cNombre := ALLTRIM(cNomUno)+' '+ALLTRIM(cNomDos)

       IF nTipNom == 1
	  cNomPer := cApelli+' '+cNombre
       ELSE
	  cNomPer := cNombre+' '+cApelli
       ENDIF
       cNomPer := SUBS(cNomPer+SPACE(nLenNom),1,nLenNom)
       RETURN cNomPer
*>>>>FIN CREACION DEL NOMBRE

/*************************************************************************
* TITULO ..: NOMBRE DEL MAESTRO ACTUAL                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 26/2005 JUE A
       Colombia, Bucaramanga        INICIO: 12:00 AM   MAY 26/2005 JUE

OBJETIVOS:

1- Retorna el nombre de la persona

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cTxtMaeAct(cMaeAct)

*>>>>DESCRIPCION DE VARIABLES
       LOCAL cMaeTxt := ''
*>>>>FIN DESCRIPCION DE VARIABLES

*>>>>NOMBRE DEL MAESTRO ACTUAL
       DO CASE
       CASE cMaeAct == 'JAR'
	    cMaeTxt := 'JARDIN'
       CASE cMaeAct == 'PRI'
	    cMaeTxt := 'PRIMARIA'
       CASE cMaeAct == 'BTO'
	    cMaeTxt := 'BACHILLERATO'
       ENDCASE
       RETURN cMaeTxt
*>>>>FIN NOMBRE DEL MAESTRO ACTUAL

/*************************************************************************
* TITULO..: LECTURA DEL NUMERO DEL PERIODO                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 31/95 MIE A
       Colombia, Bucaramanga        INICIO: 10:05 AM   MAY 31/95 MIE

OBJETIVOS:

1- Lee y valida el n£mero del peri¢do con el cual se este trabajando

2- Retorna el n£mero de peri¢do

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nLeeNroPer(nNroFil,nNroCol,nFilPal,nTotPer,nPerAct,lPerAct)

*>>>>PARAMETROS DE LA FUNCION
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       nFilPal                              // Fila Principal
       nTotPer			            // Total de Peri¢dos
       nPerAct			            // Periodo Actual
       lPerAct                              // .T. Leer Periodo Actual */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavLin := ''                  // Salvar lineas
       LOCAL cSavLi1 := ''                  // Salvar lineas
       LOCAL nNroPer := 0                   // N£mero del Periodo
       LOCAL GetList := {}                  // Variable del sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DE PARAMETROS
       IF !nPerAct == NIL .AND. nPerAct == 0
	  cError('NO SE HA DEFINIDO EL PERIODO ACTUAL')
	  RETURN nNroPer
       ENDIF

       nTotPer := IF(nTotPer == NIL,5,nTotPer)
       nPerAct := IF(nPerAct == NIL,0,nPerAct)
       lPerAct := IF(lPerAct == NIL,.F.,lPerAct)

       IF nPerAct > nTotPer
	  cError('EL PERIODO ACTUAL NO DEBE SER MAYOR AL TOTAL DE PERIODOS')
	  RETURN nNroPer
       ENDIF
*>>>>FIN VALIDACION DE PARAMETROS

*>>>>CAPTURA Y CONFIRMACION DEL NUMERO DEL BIMESTRE
       cSavLin := SAVESCREEN(nNroFil,nNroCol,nNroFil,79)
       cSavLi1 := SAVESCREEN(21,0,22,79)
       Centrar('Entre el N£mero de Peri¢do',21)
       DO WHILE .T.

***********CAPTURA DE NUMERO DEL BIMESTRE
	     nNroPer := 0
	     DO CASE
	     CASE EMPTY(nPerAct) .AND. !lPerAct

		@ nNroFil,nNroCol GET nNroPer;
				  VALID nNroPer <= nTotPer;
				  PICT '9'
		READ

	     CASE !EMPTY(nPerAct) .AND. lPerAct

		  DO WHILE .T.
		     @ nNroFil,nNroCol GET nNroPer;
				       PICT '9'
		     READ
		     IF nNroPer # 0 .AND. nNroPer # nPerAct
			cError('DEBE DIGITAR EL PERIODO HABILITADO')
			LOOP
		     ELSE
			EXIT
		     ENDIF
		  ENDDO

	     OTHERWISE
		cError('ERROR EN LA LECTURA DEL PERIODO')
	     ENDCASE
***********FIN CAPTURA DE NUMERO DEL BIMESTRE

***********CONFIRMACION DEL NUMERO DEL BIMESTRE
	     IF nNroPer # 0
		IF lPregunta('DESEA CORREGIR EL PERIODO? Si No')
		   LOOP
		ENDIF
	     ENDIF
	     EXIT
***********FIN CONFIRMACION DEL NUMERO DEL BIMESTRE

       ENDDO
       IF nNroPer <> 0
	  @ nFilPal,65 SAY 'Peri¢do No. '+STR(nNroPer,1)
       ENDIF
       RESTSCREEN(nNroFil,nNroCol,nNroFil,79,cSavLin)
       RESTSCREEN(21,0,22,79,cSavLi1)
       RETURN nNroPer
*>>>>CAPTURA Y CONFIRMACION DEL NUMERO DEL BIMESTRE

/*************************************************************************
* TITULO ..: BASE DE DATOS. SIMAWEB                                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 05/2005 LUN A
       Colombia, Bucaramanga        INICIO: 01:15 PM   SEP 05/2005 LUN

OBJETIVOS:

1- Crea las estructuras de las tablas de la base de datos para los
   boletines.

2- Retorna la estructura

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aStrDbfWww(cCodEmp,cNalias)

*>>>>DESCRIPCION DE PARAMETROS
/*    cCodEmp                              // C¢digo de la empresa
      cNalias                              // Alias del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL aDbfStr := {}                  // Estructura del Archivo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DE LAS TABLAS
       DO CASE
       CASE cNalias == 'EMP'

*===========TABLA DE EMPRESAS
	      AADD(aDbfStr,{"nIdeCodEmp","Numeric"  ,16,0}) // C¢digo de Identificaci¢n de la Empresa
	      AADD(aDbfStr,{"cCodigoEmp","Character",12,0}) // C¢digo de la Empresa
	      AADD(aDbfStr,{"cNombreEmp","Character",40,0}) // Nombre de la Empresa
	      AADD(aDbfStr,{"cWebEmp"   ,"Character",50,0}) // Web de la Empresa
*===========FIN TABLA DE EMPRESAS

       CASE cNalias == 'USR'

*===========TABLA DE USUARIOS
	      AADD(aDbfStr,{"nIdeCodEmp","Numeric"  ,16,0}) // C¢digo de Identificaci¢n del Usuario. Mal Insertado
	      AADD(aDbfStr,{"cCodigoEmp","Character",12,0}) // C¢digo de la Empresa
	      AADD(aDbfStr,{"cLoginUsr","Character",10,0}) // Login del Usuario
	      AADD(aDbfStr,{"cPasWorUsr","Character",17,0}) // PassWorde del Usuario
	      AADD(aDbfStr,{"cCodigoTus","Character",02,0}) // Tipo de Usuario
*===========FIN TABLA DE USUARIOS

       CASE cNalias == 'TUS'

*===========TABLA DE TIPO DE USUARIOS
	      AADD(aDbfStr,{"nIdeCodEmp","Numeric"  ,016,0}) // C¢digo de Identificaci¢n del Usuario. Mal Insertado
	      AADD(aDbfStr,{"cCodigoEmp","Character",012,0}) // C¢digo de la Empresa
	      AADD(aDbfStr,{"cCodigoTus","Character",002,0}) // C¢digo del Tipo de Usuario
	      AADD(aDbfStr,{"cNombreTus","Character",020,0}) // Nombre del Tipo de Usuario
	      AADD(aDbfStr,{'cUrlLnkTus','Character',060,0}) // Url del Link de la p gina
	      AADD(aDbfStr,{'cNivBolTus','Character',254,0}) // Nivel de Visualizaci¢n del Boletin. 1=>Todos,2=>Nivel,3=>Grupos,4=>Estudiante
*===========FIN TABLA DE TIPO DE USUARIOS

       CASE cNalias == 'WWW'

*===========TABLA CONFIGURACION DEL SISTEMA
	      AADD(aDbfStr,{"nIdeCodEmp","Numeric"  ,16,0}) // C¢digo de Identificaci¢n del Usuario. Mal Insertado
	      AADD(aDbfStr,{"cCodigoEmp","Character",12,0}) // C¢digo de la Empresa
	      AADD(aDbfStr,{'cUrlBolWww','Character',60,0}) // Url para el Boletin
	      AADD(aDbfStr,{'cExtBolWww','Character',04,0}) // Extensi¢n para el Boletin
	      AADD(aDbfStr,{'cUrlImgWww','Character',60,0}) // Url para las Imagenes
	      AADD(aDbfStr,{'cUrlFotWww','Character',60,0}) // Url para las Fotos
	      AADD(aDbfStr,{'cExtFotWww','Character',04,0}) // Extensi¢n para las Fotos
*===========FIN TABLA CONFIGURACION DEL SISTEMA

       CASE cNalias == 'PER'

*===========TABLA. PERSONAS
	      AADD(aDbfStr,{"nIdeCodPer","Numeric"  ,10,0}) // C¢digo de Identificaci¢n de la Persona
	      AADD(aDbfStr,{"cDocNitPer","Character",16,0}) // Documento de la Persona
	      AADD(aDbfStr,{"cTipNitPer","Character",01,0}) // Tipo de Documento
	      AADD(aDbfStr,{"cLugNitPer","Character",20,0}) // Tipo de Documento
	      AADD(aDbfStr,{"cApeUnoPer","Character",20,0}) // Primer Apellido
	      AADD(aDbfStr,{"cApeDosPer","Character",20,0}) // Segundo Apellido
	      AADD(aDbfStr,{"cNomUnoPer","Character",20,0}) // Primer Nombre
	      AADD(aDbfStr,{"cNomDosPer","Character",20,0}) // Segundo Nombre
*===========FIN TABLA. PERSONAS

       CASE cNalias == 'PNI'

*===========TABLA. PERFIL NIVEL
	      AADD(aDbfStr,{"nIdeCodPer","Numeric"  ,16,0}) // C¢digo de Identificaci¢n de la Persona
	      AADD(aDbfStr,{"cCodigoEmp","Character",12,0}) // C¢digo de la Empresa
	      AADD(aDbfStr,{"cNivBolPer","Character",02,0}) // Nivel del boletin
	      AADD(aDbfStr,{"cNombrePer","Character",20,0}) // Nombre de la Persona
	      AADD(aDbfStr,{"linkNivel","Character",100,0}) // Link del Nivel
*===========FIN TABLA. PERFIL NIVEL

       CASE cNalias == 'DOC'

*===========TABLA. DOCENTES
	      AADD(aDbfStr,{"nIdeCodEmp","Numeric"  ,16,0}) // C¢digo de Identificaci¢n del Usuario. Mal Insertado
	      AADD(aDbfStr,{"cCodigoEmp","Character",12,0}) // C¢digo de la Empresa
	      AADD(aDbfStr,{"cCodigoPro","Numeric"  ,06,0}) // C¢digo del Profesor
	      AADD(aDbfStr,{"cNombrePro","Character",26,0}) // Nombre del Profesor
	      AADD(aDbfStr,{"cApelliPro","Character",26,0}) // Apellido del Profesor
	      AADD(aDbfStr,{"lRetiroPro","Logical"  ,01,0}) // Retiro del Profesor
*===========FIN TABLA. DOCENTES

       CASE cNalias == 'ALU'

*===========TABLA. ALUMNOS
	      AADD(aDbfStr,{"nIdeCodEmp","Numeric"  ,16,0}) // C¢digo de Identificaci¢n del Usuario. Mal Insertado
	      AADD(aDbfStr,{"cCodigoEmp","Character",12,0}) // C¢digo de la Empresa
	      AADD(aDbfStr,{"cCodigoEst","Character",06,0}) // C¢digo del Estudiante
	      AADD(aDbfStr,{"cCodigoGru","Character",04,0}) // C¢digo del Grupo
	      AADD(aDbfStr,{"cApelliEst","Character",30,0}) // Apellido del Estudiante
	      AADD(aDbfStr,{"cNombreEst","Character",30,0}) // Nombre del Estudiante
	      AADD(aDbfStr,{"lRetiroEst","Logical"  ,01,0}) // .T. Retirado
	      AADD(aDbfStr,{"nHayWwwEst","Numeric"  ,01,0}) // Acceso a Internet
*===========FIN TABLA. ALUMNOS

       CASE cNalias == 'NIV'

*===========TABLA. NIVELES
	      AADD(aDbfStr,{"nIdeCodEmp","Numeric"  ,16,0}) // C¢digo de Identificaci¢n del Usuario. Mal Insertado
	      AADD(aDbfStr,{"cCodigoEmp","Character",12,0}) // C¢digo de la Empresa
	      AADD(aDbfStr,{"cCodigoNiv","Character",02,0}) // C¢digo del nivel
	      AADD(aDbfStr,{"cNombreNiv","Character",12,0}) // Nombre del Nivel
*===========FIN TABLA. NIVELES

       CASE cNalias == 'GRU'

*===========TABLA DE GRUPOS
	      AADD(aDbfStr,{"nIdeCodEmp","Numeric"  ,16,0}) // C¢digo de Identificaci¢n del Usuario. Mal Insertado
	      AADD(aDbfStr,{"cCodigoEmp","Character",12,0}) // C¢digo de la Empresa
	      AADD(aDbfStr,{"cCodigoGru","Character",04,0}) // C¢digo del Grupo
	      AADD(aDbfStr,{"cNombreGru","Character",20,0}) // Nombre del Grupo
	      AADD(aDbfStr,{"cNivEduGru","Character",20,0}) // Nivel de Edudcacion. Preescolar,BP,BS,MV
	      AADD(aDbfStr,{"cCodigoPro","Character",06,0}) // C¢digo del Profesor
	      AADD(aDbfStr,{"cCodProPro","Character",06,0}) // C¢digo del Profesor
*===========FIN TABLA DE GRUPOS

       CASE cNalias == 'MAT'

*===========TABLA DE MATERIAS
	      AADD(aDbfStr,{"nIdeCodEmp","Numeric"  ,16,0}) // C¢digo de Identificaci¢n del Usuario. Mal Insertado
	      AADD(aDbfStr,{"cCodigoEmp","Character",12,0}) // C¢digo de la Empresa
	      AADD(aDbfStr,{"cCodigoMat","Character",04,0}) // C¢digo de la Materia
	      AADD(aDbfStr,{"cNombreMat","Character",80,0}) // Nombre de la Materia (30)
	      AADD(aDbfStr,{"cTituloMat","Character",08,0}) // Alias de la Materia
	      AADD(aDbfStr,{"cCodigoPro","Character",06,0}) // C¢digo del Profesor
	      AADD(aDbfStr,{"nMatVarMat","Numeric"  ,01,0}) // 0=> Materia Fija 1=>Materia Variable por Nivel 2=>Materia Variable por Grupo. Ej: Como Ludicas
	      AADD(aDbfStr,{"lMatSelMat","Logical"  ,01,0}) // .T. Materia Selectiva
	      AADD(aDbfStr,{"lPorNivMat","Logical"  ,01,0}) // .T. Materia Selectiva por Nivel
*===========FIN TABLA DE MATERIAS

       CASE cNalias == 'CAR'

*===========TABLA. CARGAS ACADEMICAS
	      AADD(aDbfStr,{"nIdeCodEmp","Numeric"  ,16,0}) // C¢digo de Identificaci¢n del Usuario. Mal Insertado
	      AADD(aDbfStr,{"cCodigoEmp","Character",12,0}) // C¢digo de la Empresa
	      AADD(aDbfStr,{"cCodigoCar","Character",08,0}) // C¢digo de la Carga
	      AADD(aDbfStr,{"cCodigoPro","Character",06,0}) // C¢digo del Profesor
	      AADD(aDbfStr,{"nTipCarCar","Numeric"  ,01,0})  // Tipo de Carga. 0=>Normal 1=>Variable por Grupo 2=>Variable por Nivel 3=>Variable por Niveles
*===========FIN TABLA. CARGAS ACADEMICAS

       CASE cNalias == 'LIS'

*===========TABLA. LISTAS
	      AADD(aDbfStr,{"nIdeCodEmp","Numeric"  ,16,0}) // C¢digo de Identificaci¢n del Usuario. Mal Insertado
	      AADD(aDbfStr,{"cCodigoEmp","Character",12,0}) // C¢digo de la Empresa
	      AADD(aDbfStr,{"cCodigoEst","Character",06,0}) // C¢digo del Estudiante
	      AADD(aDbfStr,{"cCodigoGru","Character",04,0}) // C¢digo del Grupo
	      AADD(aDbfStr,{"nNroLisEst","Numeric"  ,03,0}) // N£mero de lista
	      AADD(aDbfStr,{"lRetGruNot","Logical"  ,01,0}) // .T. Retiro del Grupo
*===========FIN TABLA. LISTAS

       ENDCASE
       RETURN aDbfStr
*>>>>FIN DECLARACION DE LAS TABLAS

/*************************************************************************
* TITULO..: HAY NOTAS EN LOS JUICIOS VALORATIVOS                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 14/2006 JUE A
       Colombia, Bucaramanga        INICIO: 10:30 AM   SEP 14/2006 JUE

OBJETIVOS:

1- Verifica si los c¢digos de los juicios valorativos estan evaluados
   con notas n£mericas

2- Retorna .T. si los juicios se evaluan con nota n£merica.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lHayJnt(cEvaInd)

*>>>>DESCRIPCION DE PARAMETROS
/*     cEvaInd                              // Evaluaci¢n del Indicador */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL     i,j := 0                   // Contador
       LOCAL cNroEva := ''                  // N£meros de la evaluaci¢n del Indicador
       LOCAL lHayJnt := .F.                 // .T. Hay notas en los juicios valortativos
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DE DECISION
       cNroEva := '2'
       FOR i := 1 TO LEN(cNroEva)
	   FOR j := 1 TO 5                  // 5 Periodos
	       IF SUBS(cNroEva,i,1) == SUBS(cEvaInd,j,1)
		  lHayJnt := .T.
	       ENDIF
	   ENDFOR
	   IF lHayJnt
	      EXIT
	   ENDIF
       ENDFOR
       RETURN lHayJnt
*>>>>FIN ANALISIS DE DECISION

/*************************************************************************
* TITULO..: VALIDACION DEL CAMPO DE NOTAS EN LOS INDICADORES             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 14/2006 JUE A
       Colombia, Bucaramanga        INICIO: 10:30 AM   SEP 14/2006 JUE

OBJETIVOS:

1- Valida la estructura de un archivo de notas para verificar los campos
   necesarios para poder evaluar los indicadores con notas numericas.

2- Retorna .T. si existen los campos

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION HayCamJnt(lShared,cAnoUsr,cPatSis,cMaeAlu,lDebug)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos compartidos
       cAnoUsr                              // A¤o del Usuario
       cPatSis                              // Path del Sistema
       cMaeAlu                              // Maestros habilitados
       lDebug                               // .T. Depurar  */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"       // Archivos del Sistema

       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema

       LOCAL nModCry := 0                   // Modo de Protecci¢n
       LOCAL aStrNot := {}                  // Estructura de las notas

       LOCAL     i,j := 0                   // Contadores
       LOCAL cMaeAct := ''                  // Maestro actual
       LOCAL lHayCam := .F.                 // .T. Existen los Campos
       LOCAL lHayJnt := .F.                 // .T. Hay notas en juicios valortativos
       LOCAL cCampo  := ''                  // Campo del Archivo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DE LOS CAMPOS
       lDebug := IF(lDebug==NIL,.F.,lDebug)
       FOR i := 1 TO LEN(cMaeAlu)/3

**********AREAS DE TRABAJO
	    cMaeAct := SUBS(cMaeAlu,i*3-2,3)
	    aUseDbf := {}

	    AADD(aUseDbf,{.T.,PathSis+'\'+fSimaCo,'SCO',NIL,lShared,nModCry})

	    AADD(aUseDbf,{.T.,cPatSis+'\'+cMaeAct+'\'+;
			    FConTbl+cMaeAct+ExtFile,'TCO',NIL,lShared,nModCry})

	    AADD(aUseDbf,{.T.,cPatSis+'\'+cMaeAct+'\'+;
			      FileGru+cMaeAct+cAnoSis+ExtFile,'GRU',NIL,lShared,nModCry})
**********FIN AREAS DE TRABAJO

**********SELECION DE LAS AREAS DE TRABAJO
	    IF !lUseDbfs(aUseDbf)
	       cError('ABRIENDO ARCHIVOS')
	       CloseAll(aUseDbf)
	       RETURN NIL
	    ENDIF
**********FIN SELECION DE LAS AREAS DE TRABAJO

**********VALIDACION DE EXISTENCIA
	    GRU->(DBGOBOTTOM())
	    FileNot := cPatSis+'\'+cMaeAct+'\NOTAS'+'\'+;
		       'NT'+GRU->cCodigoGru+cAnoSis+ExtFile

	    IF .NOT. FILE(FileNot)
	       CloseAll(aUseDbf)
	       RETURN NIL
	    ENDIF
**********FIN VALIDACION DE EXISTENCIA

**********SELECION DE LAS AREAS DE TRABAJO
	    IF !lUseDbf(.T.,FileNot,'NOT',NIL,lShared)
	       cError('ABRIENDO EL ARCHIVO DE NOTAS DEL GRUPO '+;
		      GRU->cCodigoGru)
	       CloseAll(aUseDbf)
	       RETURN NIL
	    ENDIF
**********FIN SELECION DE LAS AREAS DE TRABAJO

**********ANALISIS DEL AREA ESCOGIDA
	    SELECT NOT
	    aStrNot := DBSTRUCT()

	    lHayCam := .F.
	    FOR j := 1 TO LEN(aStrNot)

		cCampo := aStrNot[j,1]
		IF UPPER(SUBS(cCampo,1,3)) == 'CN1'

		   IF lDebug
		      cError('ARCHIVO DE NOTAS VALIDADO '+cMaeAct+' '+cCampo)
		   ENDIF

		   lHayCam := .T.
		   EXIT
		ENDIF
	    ENDFOR
**********FIN ANALISIS DEL AREA ESCOGIDA

**********ANALISIS DE DECISION
	    lHayJnt := lHayJnt(TCO->cEvaIndTbl)
	    DO CASE
	    CASE lHayCam .AND. lHayJnt
		 // Configuraci¢n correcta

	    CASE lHayCam .AND. !lHayJnt
		 // Configuracion correcta

	    CASE !lHayCam .AND. lHayJnt
		 cError('ARCHIVO DE NOTAS SIN LOS CAMPOS CORRESPONDIENTES',;
			'ESTA HABILITADA LA VALIDACION DEL INDICADOR EN '+cMaeAct,;
			'FAVOR SOLICITAR SOPORTE')

	    CASE !lHayCam .AND. !lHayJnt
		 // Configuraci¢n correcta

	    ENDCASE
**********FIN ANALISIS DE DECISION

	  CloseAll(aUseDbf)

       ENDFOR
       CloseAll(aUseDbf)
       RETURN NIL
*>>>>FIN VALIDACION DE LOS CAMPOS

/*************************************************************************
* TITULO DEL PROGRAMA..: DETALLES DE LAS AREAS A IMPRIMIR                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 26/95 LUN A
       Colombia, Bucaramanga        INICIO: 02:50 PM   JUN 26/95 LUN

OBJETIVOS:

1- Prepara dos vectores con los detalles de las areas y materias a imprimir
   para el boletin.

2- Debe estar en uso los archivos de materias, plan, notas

3- Retorna por referencia los param‚tros de la funci¢n marcados con @

4- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION DetAreas(aNotAre,aNotMat,nNroBis)

*>>>>PARAMETROS DE LA FUNCION
/*     aNotAre                              // @Detalles de las areas
       aNotMat                              // @Detalles de las materias
       nNroBis                              // N£mero del Bimestre */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL aStrNot := {}                  // Vector con la estructura
       LOCAL cMatBol := ''                  // Nombre materia para boletin
       LOCAL cMatCer := ''                  // Nombre materia para certificado
       LOCAL lNoPrnM := .F.                 // .T. No Imprimir .F. Imprimir Materia en Boletin

       LOCAL cCodigoTma := ''               // C¢digo de la materia
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DE LAS AREAS Y MATERIAS
       SELECT NOT
       aStrNot := DBSTRUCT()
       FOR i:=1 TO LEN(aStrNot)

***********LOCALIZACION DEL AREA
	     IF SUBS(aStrNot[i][1],2,3) == 'ARE' .AND.;
		SUBS(aStrNot[i][1],8,3) # 'REC'

*---------------LOCALIZACION AREA PARA EL BOLETIN
		  cCodigoTma := SUBS(aStrNot[i][1],6,2)+'00'
		  IF !lLocCodigo('cCodigoMat','MAT',cCodigoTma,;
					'DEL AREA Campo No.'+str(i,3))
		     cError('EL CODIGO '+cCodigoTma+' NO EXISTE',;
			    aStrNot[i][1])
		     RETURN NIL
		  ENDIF
		  cMatBol := MAT->cNombreMat
*---------------FIN LOCALIZACION AREA PARA EL BOLETIN

*---------------LOCALIZACION DEL AREA EN PLAN ACADEMICO
		  IF !lLocCodigo('cCodigoMat','PLA',cCodigoTma,;
				 'DE LA MATERIA EN PLAN ACADEMICO')
		     RETURN NIL
		  ENDIF
*---------------FIN LOCALIZACION DEL AREA EN PLAN ACADEMICO

*---------------LOCALIZACION AREA PARA EL CERTIFICADO
		  cMatCer := ''
		  IF !EMPTY(PLA->cMatCerPla)
		     IF !lLocCodigo('cCodigoMat','MAT',PLA->cMatCerPla,;
					   'DEL AREA')
			RETURN NIL
		     ENDIF
		     cMatCer := MAT->cNombreMat
		  ENDIF
*---------------FIN LOCALIZACION AREA PARA EL CERTIFICADO

*---------------CREACION DE LOS DETALLES DEL AREA
		  lNoPrnM := IF(SUBS(PLA->cPrnBolPla,nNroBis,1)='1',.T.,.F.)
		  AADD(aNotAre,{PLA->nNroOrdPla,;
				SUBS(cCodigoTma,1,2),;
				cMatBol,;
				'NOT->'+aStrNot[i][1],;
				MAT->cTipMatMat,;                            // No.05 Tipo Materia o Area
				'NOT->cJ'+STR(nNroBis,1)+cCodigoTma+'Not',;  // No.06 Indicadores
				MAT->cTituloMat,;                            // No.07 Alias de la Materia
				"NOT->cAcum"+SUBS(cCodigoTma,1,2)+"Not",;    // No.08 Notas Acumuladas
				PLA->lCertifPla,;                            // No.09 .T. Entra en el certificado de notas
				IF(EMPTY(PLA->cMatCerPla),cMatBol,cMatCer),; // No.10 Materia para el Certificado
				PLA->cIntHorPla,;       // No.11 Intensidad Horaria
				lNoPrnM,;               // No.12 No Imprimir la Materia en el Boletin. Ej: 1:No Imprime  0:Si Imprime
				MAT->lModaliMat,;       // No.13 .T. Modalidad .F. No Modalidad
				'',;                    // No.14 Materias Selectivas
				MAT->lNoRecuMat,;       // No.15 =>Materia No Recuperable
				PLA->cIntCerPla,;       // No.16 =>Intensidad Horaria para el Certficado
				PLA->cPrnNotPla,;       // No.17 =>Imprimir la Nota en el Boletin
				PLA->cPrnBolPla,;       // No.18 =>No Imprimir la Materia en el Boletin. Ej: 1:No Imprime  0:Si Imprime
				MAT->lJvfCalMat,;       // No.19 =>.F. Calcula el Juicio Valorativo .T. No Calcula el Juicio Valorativo
				MAT->nMatVarMat,;       // No.20 => 0=>Materia Fija 1=>Materia Variable por Nivel 2=>Materia Variable por Grupo. Ej: Como Ludicas
				MAT->lMatSelMat,;       // No.21 =>.T. Materia Selectiva
				MAT->lCertifMat})       // No.22 =>Materia Fija de la Materia Variable. .T.=> Entra en el certificado de notas
*---------------FIN CREACION DE LOS DETALLES DEL AREA

	      ENDIF
***********FIN LOCALIZACION DEL AREA

***********LOCALIZACION DE LA MATERIA
	     IF SUBS(aStrNot[i][1],2,2) == 'NT' .AND.;
		SUBS(aStrNot[i][1],8,3) # 'REC'

*---------------LOCALIZACION MATERIA PARA EL BOLETIN
		  cCodigoTma := SUBS(aStrNot[i][1],4,4)

		  IF !lLocCodigo('cCodigoMat','MAT',cCodigoTma,;
					'DE LA MATERIA Campo No.'+str(i,3))
		     cError('EL CODIGO: '+cCodigoTma+' NO EXISTE')
		     RETURN NIL
		  ENDIF
		  cMatBol := MAT->cNombreMat
*---------------FIN LOCALIZACION MATERIA PARA EL BOLETIN

*---------------LOCALIZACION DE LA MATERIA EN PLAN ACADEMICO
		  IF !lLocCodigo('cCodigoMat','PLA',cCodigoTma,;
				 'DE LA MATERIA EN PLAN ACADEMICO')
		     RETURN NIL
		  ENDIF
*---------------FIN LOCALIZACION DE LA MATERIA EN PLAN ACADEMICO

*---------------LOCALIZACION AREA PARA EL CERTIFICADO
		  cMatCer := ''
		  IF !EMPTY(PLA->cMatCerPla)
		     IF !lLocCodigo('cCodigoMat','MAT',PLA->cMatCerPla,;
					   'DEL AREA')
			RETURN NIL
		     ENDIF
		     cMatCer := MAT->cNombreMat
		  ENDIF
*---------------FIN LOCALIZACION AREA PARA EL CERTIFICADO

*---------------LOCALIZACION DE LA MATERIA PARA EL CERTIFICADO
		  lNoPrnM := IF(SUBS(PLA->cPrnBolPla,nNroBis,1)='1',.T.,.F.)
		  AADD(aNotMat,{SUBS(cCodigoTma,1,2),;   // No.01
				cMatBol,;                // No.02 lDetAreEst => Reemplaza materia variable o selectiva
				PLA->cIntHorPla,;        // No.03
				'NOT->'+aStrNot[i][1],;  // No.04
				'NOT->cJ'+STR(nNroBis,1)+cCodigoTma+'Not',; // No.05
				'NOT->cFa'+cCodigoTma+'Not',; // No.06
				MAT->cTituloMat,;             // No.07
				"NOT->cAc"+cCodigoTma+"Not",; // No.08
				PLA->lCertifPla,;             // No.09
				IF(EMPTY(PLA->cMatCerPla),cMatBol,cMatCer),; // No.10
				SPACE(02)+cCodigoTma,; // No.11 lDetAreEst. SPACE(02) para el nivel+ Materia para los indicadores.
				lNoPrnM,;         // No.12
				MAT->lModaliMat,; // No.13
				'',;              // No.14 => lDetAreEst => Materias Selectivas
				MAT->lNoRecuMat,; // No.15 =>Materia No Recuperable
				PLA->cIntCerPla,; // No.16 =>Intensidad Horaria para el Certficado
				PLA->cPrnNotPla,; // No.17 =>Imprimir la Nota en el Boletin
				PLA->cPrnBolPla,; // No.18 =>No Imprimir la Materia en el Boletin. Ej: 1:No Imprime  0:Si Imprime
				MAT->lJvfCalMat,; // No.19 =>.F. Calcula el Juicio Valorativo .T. No Calcula el Juicio Valorativo
				MAT->nMatVarMat,; // No.20 => 0=>Materia Fija 1=>Materia Variable por Nivel 2=>Materia Variable por Grupo. Ej: Como Ludicas
				MAT->lMatSelMat,; // No.21 =>.T. Materia Selectiva
				MAT->lCertifMat}) // No.22 =>Materia Fija de la Materia Variable. .T.=> Entra en el certificado de notas
*---------------FIN LOCALIZACION DE LA MATERIA PARA EL CERTIFICADO

	     ENDIF
***********FIN LOCALIZACION DE LA MATERIA

       ENDFOR
       ASORT(aNotAre,,,{|x,y| x[1] < y[1]})
      *Ordena las areas seg£n el orden especificado

       RETURN NIL
*>>>>FIN LOCALIZACION DE LAS AREAS Y MATERIAS

/*************************************************************************
* TITULO..: MATERIA DEL CERTIFICADO                                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 05/2007 MAR A
       Colombia, Bucaramanga        INICIO: 02:50 PM   FEB 05/2007 MAR

OBJETIVOS:

1- Lee la materia que reemplaza el nombre de la materia en el boletin y en
   certificado.

2- Retorna la materia

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cMatCerPla(cMatCer,nNroPer)

*>>>>DECLARACION DE VARIABLES
/*     cMatCer                              // Materias del Certificado
       nNroPer                              // N£mero del Periodo */
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DE VARIABLES

*>>>>FIN DECLARACION DE VARIABLES

*>>>>MATERIA DEL CERTIFICADO
       IF LEN(cMatCer) == 4
       ELSE
       ENDIF
       RETURN NIL
*>>>>FIN MATERIA DEL CERTIFICADO


/*************************************************************************
* TITULO..: PARAMETOS GENERALES DEL SISTEMA                              *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE 02/2007 MIE A
       Bucaramanga, Colombia        INICIO: 09:00 AM   ENE 27/2007 MIE

OBJETIVOS:

1- Lee los parametros generales del sistema en variables locales.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lParam0102(aParams,;
		    lShared,nModCry,cCodSui,cNomSis,;
		    cEmpPal,cNitEmp,cNomEmp,cNomSec,cCodEmp,;
		    cNomUsr,cAnoUsr,cAnoSis,cPatSis,;
		    nFilPal,nFilInf,nColInf,;
		    PathW01,PathW02,PathW03,PathW04,PathW05,;
		    PathW06,PathW07,PathW08,PathW09,PathW10,;
		    PathUno,PathDos,PathTre,PathCua,;
		    cMaeAlu,cMaeAct,cJorTxt)

*>>>>DESCRIPCION DE PARAMETROS
/*     aParams                              // Parametros Generales

       lShared                              // @.T. Sistema Compartido
       nModCry                              // @Modo de Protecci¢n
       cCodSui                              // @C¢digo del Sistema
       cNomSis                              // @Nombre del Sistema
     *ÀDetalles del Sistema

       cEmpPal                              // @Nombre de la Empresa principal
       cNitEmp                              // @Nit de la Empresa
       cNomEmp                              // @Nombre de la Empresa
       cNomSec                              // @Nombre de la Empresa Secundario
       cCodEmp                              // @C¢digo de la Empresa
     *ÀDetalles de la Empresa

       cNomUsr                              // @Nombre del Usuario
       cAnoUsr                              // @A¤o del Usuario
       cAnoSis                              // @A¤o del Sistema
       cPatSis                              // @Path del sistema
     *ÀDetalles del Usuario

       nFilPal                              // @Fila Inferior Men£ principal
       nFilInf                              // @Fila Inferior del SubMen£
       nColInf                              // @Columna Inferior del SubMen£
     *ÀDetalles Tecnicos

       PathW01                              // @Sitio No.01 del Sistema
       PathW02                              // @Sitio No.02 del Sistema
       PathW03                              // @Sitio No.03 del Sistema
       PathW04                              // @Sitio No.04 del Sistema
       PathW05                              // @Sitio No.05 del Sistema
       PathW06                              // @Sitio No.06 del Sistema
       PathW07                              // @Sitio No.07 del Sistema
       PathW08                              // @Sitio No.08 del Sistema
       PathW09                              // @Sitio No.09 del Sistema
       PathW10                              // @Sitio No.10 del Sistema
     *ÀSitios del Sistema

       PathUno := ''                        // Path de Integraci¢n Uno
       PathDos := ''                        // Path de Integraci¢n Dos
       PathTre := ''                        // Path de Integraci¢n Tres
       PathCua := ''                        // Path de Integraci¢n Cuatro
     *ÀPath de Integraci¢n

       cMaeAlu                              // @Maestros habilitados
       cMaeAct                              // @Maestro Activo
       cJorTxt                              // @Jornada escogida */
     *ÀDetalles Acad‚micos
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DETALLES DEL SISTEMA
       lShared := xParams(aParams,'lShared')
       nModCry := xParams(aParams,'nModCry')
       cCodSui := xParams(aParams,'cCodSui')
       cNomSis := xParams(aParams,'cNomSis')

       IF lShared == NIL .OR.;
	  nModCry == NIL .OR.;
	  cCodSui == NIL .OR.;
	  cNomSis == NIL
	  lHayErr := .T.
       ENDIF
*>>>>FIN DETALLES DEL SISTEMA

*>>>>DETALLES DE LA EMPRESA
       cEmpPal := xParams(aParams,'cEmpPal')
       cNitEmp := xParams(aParams,'cNitEmp')
       cNomEmp := xParams(aParams,'cNomEmp')
       cNomSec := xParams(aParams,'cNomSec')
       cCodEmp := xParams(aParams,'cCodEmp')

       IF cEmpPal == NIL .OR.;
	  cNitEmp == NIL .OR.;
	  cNomEmp == NIL .OR.;
	  cNomSec == NIL .OR.;
	  cCodEmp == NIL
	  lHayErr := .T.
       ENDIF
*>>>>FIN DETALLES DE LA EMPRESA

*>>>>DETALLES DEL USUARIO
       cNomUsr := xParams(aParams,'cNomUsr')
       cAnoUsr := xParams(aParams,'cAnoUsr')
       cAnoSis := xParams(aParams,'cAnoSis')
       cPatSis := xParams(aParams,'cPatSis')

       IF cNomUsr == NIL .OR.;
	  cAnoUsr == NIL .OR.;
	  cAnoSis == NIL .OR.;
	  cPatSis == NIL
	  lHayErr := .T.
       ENDIF
*>>>>FIN DETALLES DEL USUARIO

*>>>>DETALLES TECNICOS
       nFilPal := xParams(aParams,'nFilPal')

       IF nFilInf # NIL
	  nFilInf := xParams(aParams,'nFilInf')
       ENDIF

       IF nColInf # NIL
	  nColInf := xParams(aParams,'nColInf')
       ENDIF

       IF nFilPal == NIL
	  lHayErr := .T.
       ENDIF
*>>>>FIN DETALLES TECNICOS

*>>>>SITIOS DEL SISTEMA
       PathW01 := xParams(aParams,'PathW01')
       PathW02 := xParams(aParams,'PathW02')
       PathW03 := xParams(aParams,'PathW03')
       PathW04 := xParams(aParams,'PathW04')
       PathW05 := xParams(aParams,'PathW05')
       PathW06 := xParams(aParams,'PathW06')
       PathW07 := xParams(aParams,'PathW07')
       PathW08 := xParams(aParams,'PathW08')
       PathW09 := xParams(aParams,'PathW09')
       PathW10 := xParams(aParams,'PathW10')

       IF PathW01 == NIL .OR.;
	  PathW02 == NIL .OR.;
	  PathW03 == NIL .OR.;
	  PathW04 == NIL .OR.;
	  PathW05 == NIL .OR.;
	  PathW06 == NIL .OR.;
	  PathW07 == NIL .OR.;
	  PathW08 == NIL .OR.;
	  PathW09 == NIL .OR.;
	  PathW10 == NIL
	  lHayErr := .T.
       ENDIF
*>>>>FIN SITIOS DEL SISTEMA

*>>>>PATH DE INTEGRACION
       PathUno := xParams(aParams,'PathUno')
       PathDos := xParams(aParams,'PathDos')
       PathTre := xParams(aParams,'PathTre')
       PathCua := xParams(aParams,'PathCua')
*>>>>FIN PATH DE INTEGRACION

*>>>>DETALLES ACADEMICOS
       cMaeAlu := xParams(aParams,'cMaeAlu')
       cMaeAct := xParams(aParams,'cMaeAct')
       cJorTxt := xParams(aParams,'cJorTxt')

       IF cMaeAlu == NIL .OR.;
	  cMaeAct == NIL .OR.;
	  cJorTxt == NIL
	  lHayErr := .T.
       ENDIF
       RETURN !lHayErr
*>>>>FIN DETALLES ACADEMICOS

/*************************************************************************
* TITULO..: PATH DEL SIMA                                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 06/2008 MIE A
       Colombia, Bucaramanga        INICIO: 10:30 AM   AGO 06/2008 MIE

1- Calcula el Path del Sima

2- Retorna el Path del Sima

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cPathSima()

*>>>>DECLARACION DE VARIABLES
       LOCAL cPatSim := ''                  // Path del Sima
*>>>>FIN DECLARACION DE VARIABLES

*>>>>PATH DEL SIMA
       cPatSim := SUBS(cPathAct(),1,RAT("\",cPathAct())-1)
       RETURN cPatSim
*>>>>FIN PATH DEL SIMA

/*************************************************************************
* TITULO..: LONGITUD DEL CODIGO DEL PERSONAL                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 28/2009 LUN A
       Colombia, Bucaramanga        INICIO:  08:00 AM  SEP 28/2009 LUN

OBJETIVOS:

1- Calcula la longitud del c¢digo del personal previamente asignado

2- Retorna la longitud del c¢digo del personal

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nLenCodDbf(cNalias,cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     cNalias                              // Alias de Archivo
       cCodigo                              // C¢digo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroReg := 0                   // N£mero del registro
       LOCAL nLenCod := 0                   // Longitud del c¢digo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CALCULO DE LA LONGITUD
       SELECT &cNalias
       nNroReg := RECNO()
       DBGOTOP()

       IF LEN(ALLTRIM(cCodigo)) == 0
	  nLenCod := 6
       ELSE
	  nLenCod := LEN(ALLTRIM(cCodigo))
       ENDIF
       DBGOTO(nNroReg)
       RETURN nLenCod
*>>>>FIN CALCULO DE LA LONGITUD

/*************************************************************************
* TITULO..: LECTURA DEL CODIGO DEL ASPIRANTE                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE 03/96 MIE A
       Colombia, Bucaramanga        INICIO: 03:40 PM   ENE 03/96 MIE

OBJETIVOS:

1)- Lee el n£mero de inscripci¢n del aspirante

2)- Retorna NIL

SINTAXIS:
  lLeeCodAdm()

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lLeeCodAdm(nNroFil,nNroCol,cNroIns,bValida)

*>>>>PARAMETROS DE LA FUNCION
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cNroIns			            // N£mero de la inscripci¢n
       bValida                              // Code Block de Validacion */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavLin := ''                  // Salvar l¡nea
       LOCAL lSalir  := .F.                 // .T. codigo con ceros. Salir
       LOCAL GetList := {}                  // Variable del sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CAPTURA DEL CODIGO
       SET ESCAPE ON   // Activa la <ESC> en los GET

       cSavLin := SAVESCREEN(21,0,21,79)
       Centrar('ENTRE EL NUMERO DE LA INSCRIPCION. '+;
	       '<ENTER> o <ESC> PARA TERMINAR',21)

       cNroIns := cSpaces('ADM','cNumeroAdm')

       @ nNroFil,nNroCol GET cNroIns PICT '9999';
			 VALID lCorrecion(@cNroIns) .AND.;
			 IF(EMPTY(cNroIns),.T.,EVAL(bValida))
       READ
       RESTSCREEN(21,0,21,79,cSavLin)
       SET ESCAPE OFF               // Activa la <ESC> en los GET

       IF LASTKEY() == K_ESC .OR. EMPTY(cNroIns)
	  lSalir := .T.
       ENDIF
       RETURN lSalir
*>>>>FIN CAPTURA DEL CODIGO

/*************************************************************************
* TITULO DE LA FUNCION..: LECTURA DEL CODIGO DEL ESTUDIANTE              *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 03/96 SAB A
       Colombia, Bucaramanga        INICIO: 01:50 PM   FEB 03/96 SAB

OBJETIVOS:

1- Deben estar en uso los maestros habilitados

2- Lee y valida el c¢digo del Estudiante de cualquier maestro

3- Retorna por referencia los param‚tros de la funci¢n marcados con @

4- Retorna el c¢digo del estudiante

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cCodEstMtr(nNroFil,nNroCol,cMaeAlu,cMaeAct,lAnoAct)

*>>>>PARAMETROS DE LA FUNCION
/*     nNroFil                              // N£mero de la fila
       nNroCol                              // N£mero de la Columna
       cMaeAlu                              // Meaestro Habilitados
       cMaeAct			            // @Alias del maestro
       lAnoAct                              // A¤o Actual */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL GetList := {}                  // Variable del sistema

       LOCAL cCodigoTes := ''               // C¢digo del estudiante
       LOCAL cNombreTes := ''               // Nombre del estudiante
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CAPTURA Y VALIDACION DEL CODIGO
       lAnoAct := IF(lAnoAct == NIL,.T.,lAnoAct)
       DO WHILE .T.

**********CAPTURA DEL CODIGO
	    cCodigoTes := SPACE(06)
	    @ nNroFil,nNroCol GET cCodigoTes PICT '999999';
				  VALID lCorrecion(@cCodigoTes) .AND.;
					HelpRead();
				  WHEN  {||HelpRead('POR FAVOR INGRESE EL '+;
						    'CODIGO DEL ESTUDIANTE')}
	    READ
	    IF EMPTY(cCodigoTes)
	       EXIT
	    ENDIF
**********FIN CAPTURA DEL CODIGO

**********VALIDACION EXISTENCIA DEL CODIGO
	    IF !lCodMaeMtr(cCodigoTes,cMaeAlu,@cMaeAct,lAnoAct)
	       cMaeAct := NIL
	       LOOP
	    ENDIF
	    EXIT
**********FIN VALIDACION EXISTENCIA CODIGO


       ENDDO
       RETURN cCodigoTes
*>>>>FIN CAPTURA Y VALIDACION DEL CODIGO

/*************************************************************************
* TITULO DEL PROGRAMA..: ENCONTRAR CODIGO DEL ESTUDIANTE                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 03/96 SAB A
       Colombia, Bucaramanga        INICIO: 01:45 PM   FEB 03/96 SAB

OBJETIVOS:

1- Permite encontrar el c¢digo del estudiante dentro de los maestros
   habilitados

2- Retorna por referencia los param‚tros de la funci¢n marcados con @

3- Retorna .T. si encontro el c¢digo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lCodMaeMtr(cCodEst,cMaeAlu,cNalias,lAnoAct,lMensaj)

*>>>>PARAMETROS DE LA FUNCION
/*     cCodEst			            // C¢digo del Alumno
       cMaeAlu                              // Maestros Habilitados
       cNalias                              // Alias del maestro del alumno
       lAnoAct                              // A¤o Actual
       lMensaj                              // .T. Mostrar Mensaje */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL  cAlias := ''                  // Alias del maestro
       LOCAL lExiste := .F.                 // .T. Existe el c¢digo
*>>>>FIN DECLARACION DE VARIABLES


*>>>>VALIDACION DEL CODIGO
       cNalias := NIL
       lAnoAct := IF(lAnoAct == NIL,.T.,lAnoAct)

       IF 'GUA' $ cMaeAlu

	   lExiste := .F.
	    cAlias := IF(lAnoAct,'GUA','GAN')
	   SELECT &cAlias
	   IF DBSEEK(cCodEst)
	      cNalias := cAlias
	      lExiste := .T.
	   ENDIF
       ENDIF

       IF 'JAR' $ cMaeAlu

	   lExiste := .F.
	    cAlias := IF(lAnoAct,'JAR','JAA')
	   SELECT &cAlias
	   IF DBSEEK(cCodEst)
	      cNalias := cAlias
	      lExiste := .T.
	   ENDIF
       ENDIF


       IF 'PRI' $ cMaeAlu .AND. !lExiste

	   lExiste := .F.
	    cAlias := IF(lAnoAct,'PRI','PRA')
	   SELECT &cAlias
	   IF DBSEEK(cCodEst)
	      cNalias := cAlias
	      lExiste := .T.
	   ENDIF
       ENDIF


       IF 'BTO' $ cMaeAlu .AND. !lExiste

	  lExiste := .F.
	   cAlias := IF(lAnoAct,'BTO','BTA')
	  SELECT &cAlias
	  IF DBSEEK(cCodEst)
	     cNalias := cAlias
	     lExiste := .T.
	  ENDIF
       ENDIF


       lMensaj := IF(lMensaj == NIL,.T.,lMensaj)
       IF !lExiste .AND. lMensaj
	  cError('EL CODIGO: '+cCodEst+' NO EXISTE')
       ENDIF
       RETURN lExiste
*>>>>FIN VALIDACION DEL CODIGO