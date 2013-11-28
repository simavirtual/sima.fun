/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		BIBLIOTECAS DE FUNCIONES GENERALES DE NIVELES

OBJETIVOS:

- Definici¢n de funciones generales para el SIMA

***************************************************************************
*-------------------- DECLARACION DE LAS FUNCIONES -----------------------*
**************************************************************************/

*>>>>DECLARACION DE CONSTANTES GENERALES
       #INCLUDE "inkey.ch"
*>>>>FIN DECLARACION DE CONSTANTES GENERALES

/*************************************************************************
* TITULO DE LA FUNCION..: CONVERSION DEL CODIGO DEL NIVEL                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 10/96 SAB A
       Colombia, Bucaramanga        INICIO: 07:55 PM   FEB 10/96 SAB

OBJETIVOS:

1- Converte el C¢digo Nivel de Jardin al C¢digo
    que se necesite de acuerdo al par metro

2- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cConverNiv(cCodNiv)

*>>>>PARAMETROS DE LA FUNCION
/*       cCodNiv                            // C¢digo del Nivel */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL aNivels := {{'12','MA'},;
			 {'13','CA'},;
			 {'14','PA'},;
			 {'15','PR'},;
			 {'16','JA'},;
			 {'00','TR'}}       // Equivalencias de nivel
       LOCAL      i := 0                    // Contador
       LOCAL      j := 0                    // Contador
       LOCAL cNivel := ''                   // Nivel
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL PARAMETRO
       IF ISDIGIT(cCodNiv)
	  IF VAL(cCodNiv) < 12 .AND. VAL(cCodNiv) > 16
	     cError('MAL PASADO EL CODIGO DEL NIVEL')
	     RETURN NIL
	  ENDIF
       ENDIF
*>>>>FIN VALIDACION DEL PARAMETRO

*>>>>CONVERSION DEL NIVEL NUMERICO
       j := 1
       IF ISALPHA(cCodNiv)
	  j := 2
       ENDIF

       FOR i:=1 TO LEN(aNivels)
	   IF aNivels[i,j] == cCodNiv
	      cNivel := aNivels[i,IF(j==1,2,1)]
	      EXIT
	   ENDIF
	   cNivel := cCodNiv
       ENDFOR
       RETURN cNivel
*>>>>CONVERSION DEL NIVEL

/*************************************************************************
* TITULO DE LA FUNCION..: VALIDACION DEL CODIGO DE JARDIN O PRIMARIA     *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 10/95 SAB A
       Colombia, Bucaramanga        INICIO: 09:40 AM   FEB 10/95 SAB

OBJETIVOS:

1)- Valida en el c¢digo del nivel

2)- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCodJar(cCodNiv,cMaeAlu)

*>>>>PARAMETROS DE LA FUNCION
/*     cCodNiv                              // C¢digo del nivel
       cMaeAlu                              // Maestros habilitados */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .T.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL NIVEL ALFABETICO
      IF 'JAR' $ cMaeAlu .AND. ISALPHA(cCodNiv)
	  IF cCodNiv == 'MA' .OR. cCodNiv == 'CA' .OR.;
	     cCodNiv == 'PA' .OR. cCodNiv == 'PR' .OR.;
	     cCodNiv == 'JA'
	     lHayErr := .F.
             cCodNiv := cConverNiv(cCodNiv)
	  ENDIF
       ENDIF

       IF 'PRI' $ cMaeAlu .AND. lHayErr .AND. ISALPHA(cCodNiv)
	  IF cCodNiv == 'TR'
	     lHayErr := .F.
	     cCodNiv := cConverNiv(cCodNiv)
	  ENDIF
       ENDIF
*>>>>FIN VALIDACION DEL NIVEL ALFABETICO

*>>>>VALIDACION DEL NIVEL NUMERICO
      IF 'JAR' $ cMaeAlu .AND. !lHayErr
	  IF (VAL(cCodNiv) >= 12 .AND. VAL(cCodNiv) <= 16)
	     lHayErr := .F.
	  ENDIF
       ENDIF

       IF 'PRI' $ cMaeAlu .AND. !lHayErr
	  IF (VAL(cCodNiv) >= 0 .AND. VAL(cCodNiv) <= 5)
	     lHayErr := .F.
	  ENDIF
       ENDIF
	  
       RETURN !lHayErr
*>>>>FIN VALIDACION DEL NIVEL NUMERICO

/*************************************************************************
* TITULO DE LA FUNCION..: VALIDACION DEL CODIGO DEL NIVEL                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE 03/95 MIE A
       Colombia, Bucaramanga        INICIO: 11:40 AM   ENE 03/95 MIE

OBJETIVOS:

1)- Valida en el c¢digo del nivel

2)- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCodNiv(cCodNiv,cMaeAlu,lMensaj)

*>>>>PARAMETROS DE LA FUNCION
/*     cCodNiv                              // C¢digo del nivel
       cMaeAlu                              // Maestros habilitados
       lMensaj                              // .T. Imprimir Mensaje */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DE LOS PARAMETROS
       lMensaj := IF(lMensaj == NIL,.T.,lMensaj)
*>>>>FIN ANALISIS DE LOS PARAMETROS

*>>>>VALIDACION DEL NIVEL PARA JARDIN
       IF ISALPHA(cCodNiv)
	  IF !lValCodJar(@cCodNiv,cMaeAlu)
	     IF lMensaj
		cError('EL GRADO ESPECIFICADO NO ESTA DISPONIBLE')
		RETURN lHayErr
	     ENDIF
	  ENDIF
       ENDIF
*>>>>FIN VALIDACION DEL NIVEL PARA GUARDERIA O JARDIN

*>>>>VALIDACION DEL CODIGO
       IF !EMPTY(cCodNiv)
	  DO CASE
	  CASE cMaeAlu $ 'JARPRIBTO' .AND. LEN(cMaeAlu) == 9 .AND.;
	       VAL(cCodNiv) >= 0 .AND. VAL(cCodNiv) <= 16
	       lHayErr := .F.

	  CASE cMaeAlu $ 'JARPRI' .AND. LEN(cMaeAlu) == 6 .AND.;
	       ((VAL(cCodNiv) >= 12 .AND. VAL(cCodNiv) <= 16) .OR.;
	       (VAL(cCodNiv)  >= 0  .AND. VAL(cCodNiv) <= 5))
	       lHayErr := .F.

	  CASE cMaeAlu $ 'JARBTO' .AND. LEN(cMaeAlu) == 6 .AND.;
	       ((VAL(cCodNiv) >= 12 .AND. VAL(cCodNiv) <= 16) .OR.;
	       (VAL(cCodNiv)  >= 6  .AND. VAL(cCodNiv) <= 11))
	       lHayErr := .F.

	  CASE cMaeAlu $ 'JARPRIBTO' .AND. LEN(cMaeAlu) == 9 .AND.;
	       ((VAL(cCodNiv) >= 12 .AND. VAL(cCodNiv) <= 16) .OR.;
	       (VAL(cCodNiv)  >= 0  .AND. VAL(cCodNiv) <= 11))
	       lHayErr := .F.

	  CASE cMaeAlu $ 'GUAPRIBTO' .AND. LEN(cMaeAlu) == 9 .AND.;
	       ((VAL(cCodNiv) >= 12 .AND. VAL(cCodNiv) <= 14) .OR.;
	       (VAL(cCodNiv)  >= 1  .AND. VAL(cCodNiv) <= 11))
	       lHayErr := .F.

	  CASE cMaeAlu $ 'JARPRI'   .AND. LEN(cMaeAlu) == 6 .AND.;
	       ((VAL(cCodNiv) >= 12 .AND. VAL(cCodNiv) <= 16) .OR.;
	       (VAL(cCodNiv)  >= 0  .AND. VAL(cCodNiv) <= 5))
	       lHayErr := .F.

	  CASE (cMaeAlu $ 'JARBTO'  .AND. LEN(cMaeAlu) == 6) .AND.;
	       ((VAL(cCodNiv) >= 12 .AND. VAL(cCodNiv) <= 16) .OR.;
	       (VAL(cCodNiv) >= 6   .AND. VAL(cCodNiv) <= 11))
	       lHayErr := .F.

	  CASE cMaeAlu $ 'PRIBTO' .AND. LEN(cMaeAlu) == 6 .AND.;
	       VAL(cCodNiv) >= 0 .AND. VAL(cCodNiv) <= 11
	       lHayErr := .F.

	  CASE cMaeAlu $ 'JAR' .AND. LEN(cMaeAlu) == 3 .AND.;
	       VAL(cCodNiv) >= 12 .AND. VAL(cCodNiv) <= 16
	       lHayErr := .F.

	  CASE cMaeAlu $ 'PRI' .AND. LEN(cMaeAlu) == 3 .AND.;
	       VAL(cCodNiv) >= 0 .AND. VAL(cCodNiv) <= 5
	       lHayErr := .F.

	  CASE cMaeAlu $ 'BTO' .AND. LEN(cMaeAlu) == 3 .AND.;
	       VAL(cCodNiv) >= 6 .AND. VAL(cCodNiv) <= 11
	       lHayErr := .F.

	  OTHERWISE
	       lHayErr := .T.
	       IF lMensaj
		  cError('EL GRADO ESPECIFICADO NO ESTA DISPONIBLE')
	       ENDIF
	  ENDCASE

       ENDIF
       RETURN !lHayErr
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO DEL PROGRAMA..: LECTURA DE LOS NIVELES                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE 03/96 MIE A
       Colombia, Bucaramanga        INICIO: 04:20 PM   ENE 03/96 MIE

OBJETIVOS:

1- Retorna por referencia los param‚tros de la funci¢n marcados con @

2- Lee el intervalo de niveles y el n£mero de copias a imprimir

3- Retorna .T. para continuar

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lLeeNivels(nNroFil,nNroCol,cNivIni,cNivFin,nCopias,cMaeAlu,lMarcos)

*>>>>PARAMETROS DE LA FUNCION
/*     nNroFil                              // N£mero de la fila
       nNroCol                              // N£mero de la Columna
       cNivIni		                    // @Nivel Inicial
       cNivFin		                    // @Nivel Final
       nCopias		                    // @N£mero de copias
       cMaeAlu                              // Maestros Habilitados
       lMarcos                              // Encerrar con un marco */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL cMsgTxt                        // Texto variable
       LOCAL cNivTem			    // Nivel Temporal
       LOCAL Getlist := {}                  // Variable del sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>IMPRESION DE ENCABEZADOS
       cMsgTxt := 'GRADO INICIAL:'
       @ nNroFil  ,nNroCol SAY cMsgTxt
       @ nNroFil+1,nNroCol SAY 'GRADO FINAL  :'
       IF nCopias # NIL
	  @ nNroFil+2,nNroCol SAY 'NRO DE COPIAS:'
       ENDIF
*>>>>FIN IMPRESION DE ENCABEZADOS

*>>>>DIBUJO DEL MARCO
       lMarcos := IF(EMPTY(lMarcos),.F.,lMarcos)
       IF lMarcos
	  IF nCopias # NIL
	     @ nNroFil-1,nNroCol-1 TO nNroFil+3,nNroCol+LEN(cMsgTxt)+2 DOUBLE
	  ELSE
	     @ nNroFil-1,nNroCol-1 TO nNroFil+2,nNroCol+LEN(cMsgTxt)+2 DOUBLE
	  ENDIF
       ENDIF
*>>>>FIN DIBUJO DEL MARCO

*>>>>LECTURA DE LOS NIVELES
       cNivIni := SPACE(02)
       cNivFin := SPACE(02)
       nNroCol := nNroCol + LEN(cMsgTxt)

       @ nNroFil  ,nNroCol GET cNivIni  PICT '@! XX';
			   VALID lValCodNiv(cNivIni,cMaeAlu)

       @ nNroFil+1,nNroCol GET cNivFin  PICT '@! XX';
			   VALID lValCodNiv(cNivFin,cMaeAlu)
       IF nCopias # NIL
	  nCopias := 1
	  @ nNroFil+2,nNroCol GET nCopias PICT '99'  VALID nCopias # 0
       ENDIF
       READ
*>>>>FIN LECTURA DE LOS NIVELES

*>>>>CONVERSION DEL NIVEL PARA JARDIN Y PRIMARIA
       IF 'JAR' $ cMaeAlu .OR. 'PRI' $ cMaeAlu
	  IF ISALPHA(cNivIni) .OR. '00' $ cNivIni
	     cNivIni := cConverNiv(cNivIni)
	  ENDIF
	  IF ISALPHA(cNivFin) .OR. '00' $ cNivIni
	     cNivFin := cConverNiv(cNivFin)
	  ENDIF
       ENDIF
*>>>>FIN CONVERSION DEL NIVEL PARA JARDIN Y PRIMARIA

*>>>>INTERCAMBIO DE NIVELES
       IF VAL(cNivIni) > VAL(cNivFin)
	  cNivTem := cNivIni
	  cNivIni := cNivFin
	  cNivFin := cNivTem
       ENDIF
       RETURN IF(EMPTY(cNivIni) .OR. EMPTY(cNivFin),.F.,;
		 lPregunta('DESEA CONTINUAR? Si No'))
*>>>>FIN INTERCAMBIO DE NIVELES

/*************************************************************************
* TITULO..: PROMOCION DE GRADO O NIVEL                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC 12/2003 VIE A
       Colombia, Bucaramanga        INICIO: 01:30 PM   DIC 12/2003 VIE

OBJETIVOS:

1- Calcula el grado de promoci¢n

2- Retorna el nivel de promoci¢n

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSgteNiv(nNivAct,lRepite)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNivAct                              // Nivel Actual
       lRepite                              // .T. Repitente */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>PROMOCION DEL NIVEL
       IF .NOT. lRepite
	  IF nNivAct == 16
	     nNivAct := 0
	  ELSE
	     nNivAct++
	  ENDIF
       ENDIF
       RETURN nNivAct
*>>>>FIN PROMOCION DEL NIVEL

/*************************************************************************
* TITULO DE LA FUNCION..: NOMBRE DEL NIVEL                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 11/96 DOM A
       Colombia, Bucaramanga        INICIO: 11:00 AM   FEB 11/96 DOM

OBJETIVOS:

1)- Determina el nombre del nivel

2)- Retorna el nombre del nivel

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cNomNiv(cCodNiv)

*>>>>PARAMETROS DE LA FUNCION
/*     cCodNiv                              // C¢digo del nivel */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL cNomNiv := ''                  // Nombre del nivel

       LOCAL aNivel  := {'PRIMERO','SEGUNDO','TERCERO','CUARTO','QUINTO',;
			 'SEXTO','SEPTIMO','OCTAVO','NOVENO' ,'DECIMO',;
			 'UNDECIMO','MATERNALES','CAMINADORES','PARVULOS',;
			 'PREJARDIN','JARDIN','TRANSICION'}

       i := IF(VALTYPE(cCodNiv)=='C',VAL(cCodNiv),cCodNiv)
       cNomNiv := IF(i==0,aNivel[17],aNivel[i])

       RETURN cNomNiv
*>>>>FIN DECLARACION DE VARIABLES

