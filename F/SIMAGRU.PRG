/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		 BIBLIOTECAS DE FUNCIONES GENERALES DE GRUPOS

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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 03/95 MIE A
       Colombia, Bucaramanga        INICIO: 01:07 PM   MAY 03/95 MIE

OBJETIVOS:

1)- Crea la estructura del archivo Grupos

2)- Retorna NIL

SINTAXIS:

   CreaDbfGru(PathGru,FileGru,fNtxGru)

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfGru(lShared,PathGru,FileGru,lIntUno,fNtxGru,aStrDbf)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Sistema Compartido
       PathGru				    // Path del Archivo
       FileGru				    // Nombre del Archivo
       lIntUno			            // Sistema Integrado
       fNtxGru				    // Archivo de Indices
       aStrDbf                              // Estructura del Archivo */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL PathAct := ''                  // Path Actual

       LOCAL aDbfGru := {{"cCodigoGru","Character",04,0},; // C¢digo del Grupo
			 {"cIdentiGru","Character",02,0},; // Identificaci¢n del Grupo. A,B, etc
			 {"cNombreGru","Character",20,0},; // Nombre del Grupo
			 {"cNivEduGru","Character",30,0},; // Nivel de Edudcacion. Preescolar,BP,BS,MV
			 {"cCodigoPro","Character",06,0},; // Titular del Grupo No. 1
			 {"cCodProPro","Character",06,0},; // Titular del Grupo No. 2
			 {"nNroAluGru","Numeric"  ,03,0},; // N£mero de Alumnos
			 {"nNroTemGru","Numeric"  ,03,0},; // N£mero de Alumnos Temporal
			 {"nNroDivGru","Numeric"  ,02,0},; // N£mero de la Division en que pertenece el grupo
			 {"nVlrTemGru","Numeric"  ,10,2},; // Valor temporal
			 {"cPromedGru","Character",20,0},; // Promedio del grupo
			 {"cMatConGru","Character",04,0},; // Materia para la Conducta
			 {"cMatDisGru","Character",04,0},; // Materia para la Disciplina
			 {"cEntSalGru","Character",20,0},; // Hora de Entra y salida del grupo
			 {"cMinClaGru","Character",03,0},; // Minutos dictados por clase.
			 {"cHorSemGru","Character",04,0},; // Horas semanales
			 {"cHorAnoGru","Character",04,0},; // Horas anuales
			 {"cHorLunGru","Character",250,0},; // Horario del Lunes
			 {"cHorMarGru","Character",250,0},; // Horario del Martes
			 {"cHorMieGru","Character",250,0},; // Horario del Miercoles
			 {"cHorJueGru","Character",250,0},; // Horario del Jueves
			 {"cHorVieGru","Character",250,0},; // Horario del Viernes
			 {"cHorSabGru","Character",250,0},; // Horario del Sabado
			 {"cHorDomGru","Character",250,0},; // Horario del Domingo
			 {"cJvfCalGru","Character",15,0}}   // Juicio Valorativo Calculado. Tres digitos por periodo. 101 =>1:Clase 01:Metodo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>RETORNO DE LA ESTRUCTURA
       IF !EMPTY(aStrDbf)
	  aStrDbf := aDbfGru
	  RETURN NIL
       ENDIF
*>>>>FIN RETORNO DE LA ESTRUCTURA

*>>>>CREACION DE LA ESTRUCTURA
       PathAct := cPathAct()
       DO CASE
       CASE DIRCHANGE(PathGru) == 0
	    DBCREATE(FileGru,aDbfGru,"DBFNTX")

       CASE DIRCHANGE(PathGru) == -3
	    cError('NO EXISTE EL DIRECTORIO: '+PathGru)

       CASE DIRCHANGE(PathGru) == -5
	    cError('NO TIENE DERECHOS EN: '+PathGru)
       ENDCASE

       DIRCHANGE(PathAct)
       RETURN NIL
*>>>>FIN CREACION DE LA ESTRUCTURA

/*************************************************************************
* TITULO DE LA FUNCION..: RECUPERACION DE LA ESTRUCTURA                  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 03/95 MIE A
       Colombia, Bucaramanga        INICIO: 01:15 PM   MAY 03/95 MIE

OBJETIVOS:

1)- Recupera la estructura del archivo de Grupos

2)- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RecuDbfGru(lShared,PathGru,FileGru,lIntUno,fNtxGru)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Sistema Compartido
       PathGru				    // Path del Archivo
       FileGru				    // Nombre del Archivo
       lIntUno			            // Sistema Integrado
       fNtxGru				    // Archivo de Indices */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>RECUPERA LA ESTRUCTURA DEL ARCHIVO
       SAVE SCREEN
       cError("SE BORRO EL ARCHIVO "+PathGru+'\'+FileGru,;
	      "Error Grave. TOME NOTA",;
	      "Al Presionar Cualquier tecla se crea el archivo")
       Termometro(0,"CREANDO LA ESTRUCTURA DE GRUPOS")
       Termometro(100)
       CreaDbfGru(lShared,PathGru,FileGru,lIntUno,fNtxGru)
       RESTORE SCREEN
       RETURN NIL
*>>>>FIN RECUPERA LA ESTRUCTURA DEL ARCHIVO

/*************************************************************************
* TITULO..: ACTUALIZACION DE LA ESTRUCTURA                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 04/99 JUE A
       Colombia, Bucaramanga        INICIO: 03:00 PM   NOV 04/99 JUE

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

FUNCTION nActStrGru(lShared,PathArc,cNomArc)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Sistema Compartido
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
       IF !lUseDbf(.T.,PathArc+'\'+cNomArc,'GRU',NIL,lShared)
	  cError('ABRIENDO EL ARCHIVO DE GRUPOS')
	  CloseDbf('GRU')
	  RETURN nNroErr := 1
       ENDIF
       aStrOld := GRU->(DBSTRUCT())
       CloseDbf('GRU')
       CreaDbfGru(lShared,PathArc,cNomArc,,,@aStrNew)
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
       IF lCambio .AND. lShared
	  cError('El Archivo GRUPOS su Estructura Esta DesActualizada.',;
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
	  FileTem := SUBS(cNomArc,1,AT('.',cNomArc))+'STR'
	  cSavPan := SAVESCREEN(0,0,24,79)
	  IF !lStrucFile(lShared,;
			 PathArc+'\'+cNomArc,;
			 PathArc+'\'+FileTem,;
			 {||CreaDbfGru(lShared,PathArc,FileTem)})
	     cError('NO SE ACTUALIZO LA ESTRUCTURA DEL ARCHIVO')
	     nNroErr := 1
	  ENDIF
	  RESTSCREEN(0,0,24,79,cSavPan)
       ENDIF
       RETURN nNroErr
*>>>>FIN ACTUALIZACION DE LA STRUCTURA


/*************************************************************************
* TITULO..: INTERVALO DE GRUPOS                                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC 26/1994 LUN A
       Colombia, Bucaramanga        INICIO: 05:30 PM   DIC 26/1994 LUN

OBJETIVOS:

1- Debe estar en uso el archivo de grupos

2- Retorna por referencia los param‚tros de la funci¢n marcados con @

3- Permite selecionar un intervalo de grupos.

4- Retorna .T. si se ley¢ un intervalo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lIntervGru(nNroFil,nNroCol,nRegIni,nRegFin,lIniFin)

*>>>>PARAMETROS DE LA FUNCION
/*     nNroFil                              // N£mero de la fila
       nNroCol                              // N£mero de la Columna
       nRegIni                              // @Registro Inicial
       nRegFin                              // @Registro Final
       lIniFin                              // @ .T. Todos los Grupos */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL cMsgTxt := ''                  // Texto variable
       LOCAL nFilSup := 0                   // Fila superior
       LOCAL nColSup := 0                   // Colunma superior
       LOCAL nFilInf := 0                   // Fila inferior
       LOCAL nColInf := 0                   // Columna inferior
       LOCAL nRegTem := 0                   // Registro temporal
       LOCAL nIniReg := 0                   // Registro Inicial
       LOCAL nFinReg := 0                   // Registro Final
*>>>>FIN DECLARACION DE VARIABLES

*>>>>IMPRESION DE ENCABEZADOS
       cMsgTxt ='GRADO INICIAL:'
       @ nNroFil  ,nNroCol SAY cMsgTxt
       @ nNroFil+1,nNroCol SAY 'GRADO FINAL  :'
*>>>>FIN IMPRESION DE ENCABEZADOS

*>>>>CAPTURA DEL INTERVALO INICIAL
	SELECT GRU
	nNroCol = nNroCol + LEN(cMsgTxt)
	nFilSup := nNroFil
	nColSup := nNroCol
	IF nFilSup+RECCOUNT() > 22
	   nFilInf := 21
	ELSE
	   nFilInf := nFilSup + RECCOUNT()
	ENDIF
	nColInf := nColSup+3

	GRU->(DBGOTOP())
	nIniReg := GRU->(RECNO())
	nRegIni := nBrowseDbf(nFilSup,nColSup,nFilInf,nColInf,;
			      {||GRU->cCodigoGru})
	IF nRegIni == 0
	   RETURN .F.
	ENDIF
	GRU->(DBGOTO(nRegIni))
	@ nFilSup,nColSup SAY GRU->cCodigoGru
*>>>>FIN CAPTURA DEL INTERVALO INICIAL

*>>>>CAPTURA DEL INTERVALO FINAL
       GRU->(DBGOBOTTOM())
       nFinReg := GRU->(RECNO())

       GRU->(DBGOTOP())
       nRegFin := nBrowseDbf(nFilSup+1,nColSup,nFilInf,nColInf,;
			     {||GRU->cCodigoGru})
       IF nRegFin == 0
	  RETURN .F.
       ENDIF
       GRU->(DBGOTO(nRegFin))
       @ nFilSup+1,nColSup SAY GRU->cCodigoGru
*>>>>FIN CAPTURA DEL INTERVALO FINAL

*>>>>INTERCAMBIO DE REGISTROS
       IF nRegIni > nRegFin
	  nRegTem = nRegIni
	  nRegIni = nRegFin
	  nRegFin = nRegTem
       ENDIF
*>>>>FIN INTERCAMBIO DE REGISTROS

*>>>>ANALISIS DE TODOS LOS REGISTROS
       lIniFin := .F.
       IF nRegIni == nIniReg .AND. nRegFin == nFinReg
	  lIniFin := .T.
       ENDIF
       RETURN .T.
*>>>>FIN ANALISIS DE TODOS LOS REGISTROS

/*************************************************************************
* TITULO DE LA FUNCION..: VALIDACION DEL GRUPO                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 09/95 MAR A
       Colombia, Bucaramanga        INICIO: 10:20 AM   MAY 09/95 MAR

OBJETIVOS:

1- Debe estar en uso el archivo Grupos

2- Realiza la validaci¢n del c¢digo del grupo

3- Retorna .T. si hay problemas

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValGrupo(nNroFil,nNroCol,cCodGru,nRegGru)

*>>>>PARAMETROS DE LA FUNCION
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cCodGru                              // Codigo del grupo
       nRegGru                              // @Registro del Grupo */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>VALIDACION DEL CODIGO DEL CONCEPTO
       IF !lLocCodigo('cCodigoGru','GRU',cCodGru)
	  lSelGrupo(nNroFil,nNroCol,@nRegGru)
	  IF nRegGru == 0
	     cCodGru := cSpaField('GRU','cCodigoGru')
	  ELSE
	     GO nRegGru
	     cCodGru := GRU->cCodigoGru
	  ENDIF
       ELSE
	  nRegGru := RECNO()
       ENDIF
       RETURN .T.
*>>>>FIN VALIDACION DEL CODIGO DEL CONCEPTO

/*************************************************************************
* TITULO DEL PROGRAMA..: SELECCION DE UN GRUPO                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 09/95 MAR A
       Colombia, Bucaramanga        INICIO: 10:50 AM   MAY 09/95 MAR

OBJETIVOS:

1- Debe estar en uso el archivo de grupos

2- Retorna por referencia los param‚tros de la funci¢n marcados con @

3- Permite escoger un grupo determinado

4- Retorna .T. si escogio el grupo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lSelGrupo(nNroFil,nNroCol,nNroReg,cTitulo)

*>>>>PARAMETROS DE LA FUNCION
/*     nNroFil                              // N£mero de la fila
       nNroCol                              // N£mero de la Columna
       nNroReg		                    // @N£mero del registro escogido
       cTitulo                              // T¡tulo de lectura */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL nFilSup := 0                   // Fila superior
       LOCAL nColSup := 0                   // Colunma superior
       LOCAL nFilInf := 0                   // Fila inferior
       LOCAL nColInf := 0                   // Columna inferior
*>>>>FIN DECLARACION DE VARIABLES

*>>>>IMPRESION DE ENCABEZADOS
       cTitulo := IF(cTitulo == NIL,'',cTitulo)
       @ nNroFil,nNroCol SAY cTitulo
*>>>>FIN IMPRESION DE ENCABEZADOS

*>>>>SELEECION DEL GRUPO
	SELECT GRU
	nNroCol = nNroCol + LEN(cTitulo)
	nFilSup := nNroFil
	nColSup := nNroCol
	IF nFilSup+RECCOUNT() > 22
	   nFilInf := 21
	ELSE
	   nFilInf := nFilSup + RECCOUNT() - 1
	ENDIF
	nColInf := nColSup+3

	GRU->(DBGOTOP())
	nNroReg := nBrowseDbf(nFilSup,nColSup,nFilInf,nColInf,;
			      {||GRU->cCodigoGru})
	IF nNroReg == 0
	   RETURN .F.
	ENDIF
	GRU->(DBGOTO(nNroReg))
	@ nFilSup,nColSup SAY GRU->cCodigoGru
	RETURN .T.
*>>>>FIN SELEECION DEL GRUPO

/*************************************************************************
* TITULO..: LECTURA DEL CODIGO DEL GRUPO                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 26/2002 MAR A
       Colombia, Bucaramanga        INICIO: 03:00 PM   FEB 26/2002 MAR

OBJETIVOS:

1- Lee el c¢digo el C¢digo del Grupo

2- Valida el c¢digo del nivel

3- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lLeeCodGru(nNroFil,nNroCol,cCodGru,cMaeAct)

*>>>>PARAMETROS DE LA FUNCION
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cCodGru				    // C¢digo del Grupo
       cMaeAct                              // Maestro Actual */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavLin := ''                  // Salvar l¡nea
       LOCAL cCodNiv := ''                  // C¢digo del Nivel
       LOCAL lLeeyo  := .F.                 // .T. Ley¢ el c¢digo
       LOCAL GetList := {}                  // Variable del sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CAPTURA DEL CODIGO
       cCodGru := SPACE(04)
       @ nNroFil,nNroCol+2 SAY 'GRUPO:' GET cCodGru PICT '9999';
			   VALID lValGrupo(nNroFil,nNroCol+9,@cCodGru) .OR.;
				 EMPTY(cCodGru)

       READ

       lLeeyo := .T.
       IF LASTKEY() == K_ESC
	  lLeeyo := .F.
       ENDIF
       RETURN lLeeyo
*>>>>FIN CAPTURA DEL CODIGO

/*************************************************************************
* TITULO..: GRABACION GRUPOS DEL A¥O                                     *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 09/2011 JUE A
       Colombia, Bucaramanga        INICIO: 11:50 PM   JUN 09/2011 JUE

OBJETIVOS:

1- Pone en uso los archivos de grupos

2- Retorna por referencia los param‚tros de la funci¢n marcados con @

3- Retorna .T. si no se presentaron problemas


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION GruposAno(lShared,cPatCon,cPatSis,cAnoUsr,cMaeAlu)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Compartir Archivos
       cPatCon                              // Path de la Contabilidad
       cPatSis                              // Path del sistema
       cAnoUsr                              // A¤o del usuario
       cMaeAlu                              // Maestros habilitados */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema

       LOCAL aUseDbf := {}                  // Vector para Apertura de Varias Dbfs
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Sin Proteci¢n Inicial 2=>Con Proteci¢n Inicial

       LOCAL       i := 0                   // Contador
       LOCAL cMaeAct := ''                  // Maestro Actual
*>>>>FIN DECLARACION DE VARIABLES

*>>>>AREAS DE TRABAJO
       aUseDbf := {}

       cPatCon := IF(cPatSis $ cPatCon,cPatCon,cPatCon+'\'+cPatSis)

       AADD(aUseDbf,{.T.,cPatCon+'\'+;
			 'GRUPOS'+cAnoSis+'.DAT','TEM',NIL,lShared,nModCry})
*>>>>FIN AREAS DE TRABAJO

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbfs(aUseDbf)
	  cError('ABRIENDO ARCHIVO DEL GRUPO DEL A¥O:'+cAnoUsr)
	  CloseDbf('TEM')
	  RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>ANALISIS DE DECISION
       IF TEM->(RECCOUNT()) # 0
	  CloseDbf('TEM')
	  RETURN NIL
       ENDIF
*>>>>FIN ANALISIS DE DECISION

*>>>>RECORRIDO POR NIVEL
       FOR i := 1 TO LEN(cMaeAlu)/3

************SELECION DE LAS AREAS DE TRABAJO
	      cMaeAct := SUBS(cMaeAlu,i*3-2,3)

	      IF !lUseGru(lShared,cPatCon,cMaeAct,cAnoSis)
		 cError('ABRIENDO EL ARCHIVO DE GRUPOS DE '+cMaeAct)
		 LOOP
	      ENDIF
************FIN SELECION DE LAS AREAS DE TRABAJO

************RECORRIDO POR GRUPOS
	      SELECT GRU
	      GRU->(DBGOTOP())
	      DO WHILE .NOT. GRU->(EOF())

*================GRABACION DEL REGISTRO
		 IF TEM->(lRegLock(lShared,.T.))

		    REPL TEM->cCodigoGru WITH GRU->cCodigoGru
		    TEM->(DBCOMMIT())

		 ELSE
		    cError('NO SE GRABA EL REGISTRO')
		 ENDIF
		 IF lShared
		    TEM->(DBUNLOCK())
		 ENDIF
*================FIN GRABACION DEL REGISTRO

		 GRU->(DBSKIP())

	      ENDDO
************FIN RECORRIDO POR GRUPOS


       ENDFOR
       CloseDbf('GRU')
       CloseDbf('TEM')
       RETURN NIL
*>>>>FIN RECORRIDO POR NIVEL


/*************************************************************************
* TITULO..: BARRADO DEL NUMERO DEL ESTUDIANTES DEL GRUPO                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 13/2011 LUN A
       Colombia, Bucaramanga        INICIO: 11:50 PM   JUN 13/2011 LUN

OBJETIVOS:

1- Elimina el contador del n£mero de estudiantes por grupo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION DelNroGru(lShared,cPatCon,cPatSis,cAnoUsr,cMaeAlu)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Compartir Archivos
       cPatCon                              // Path de la Contabilidad
       cPatSis                              // Path del sistema
       cAnoUsr                              // A¤o del usuario
       cMaeAlu                              // Maestros habilitados */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema

       LOCAL aUseDbf := {}                  // Vector para Apertura de Varias Dbfs
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Sin Proteci¢n Inicial 2=>Con Proteci¢n Inicial

       LOCAL       i := 0                   // Contador
       LOCAL cMaeAct := ''                  // Maestro Actual
*>>>>FIN DECLARACION DE VARIABLES

*>>>>RECORRIDO POR NIVEL
       FOR i := 1 TO LEN(cMaeAlu)/3

************SELECION DE LAS AREAS DE TRABAJO
	      cMaeAct := SUBS(cMaeAlu,i*3-2,3)

	      IF !lUseGru(lShared,cPatCon+'\'+cPatSis,cMaeAct,cAnoSis)
		 cError('ABRIENDO EL ARCHIVO DE GRUPOS DE '+cMaeAct)
		 LOOP
	      ENDIF
************FIN SELECION DE LAS AREAS DE TRABAJO

************RECORRIDO POR GRUPOS
	      SELECT GRU
	      GRU->(DBGOTOP())
	      DO WHILE .NOT. GRU->(EOF())

*================GRABACION DEL REGISTRO
		 IF GRU->(lRegLock(lShared,.F.))

		    REPL GRU->nNroAluGru WITH 0
		    REPL GRU->nNroTemGru WITH 0
		    GRU->(DBCOMMIT())

		 ELSE
		    cError('NO SE GRABA EL REGISTRO')
		 ENDIF
		 IF lShared
		    GRU->(DBUNLOCK())
		 ENDIF
*================FIN GRABACION DEL REGISTRO

		 GRU->(DBSKIP())

	      ENDDO
************FIN RECORRIDO POR GRUPOS


       ENDFOR
       CloseDbf('GRU')
       RETURN NIL
*>>>>FIN RECORRIDO POR NIVEL


/*************************************************************************
* TITULO..: NUMERO NUMERO DEL ESTUDIANTES DEL GRUPO                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 13/2011 LUN A
       Colombia, Bucaramanga        INICIO: 11:50 PM   JUN 13/2011 LUN

OBJETIVOS:

1- Cuenta el n£mero de estudiantes de cada grupo.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION NroEstGru(lShared,cPatCon,cPatSis,cAnoUsr,cMaeAlu)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Compartir Archivos
       cPatCon                              // Path de la Contabilidad
       cPatSis                              // Path del sistema
       cAnoUsr                              // A¤o del usuario
       cMaeAlu                              // Maestros habilitados */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema

       LOCAL aUseDbf := {}                  // Vector para Apertura de Varias Dbfs
       LOCAL nModCry := 0                   // 0=>No Protecci¢n 1=>Sin Proteci¢n Inicial 2=>Con Proteci¢n Inicial
       LOCAL ExtFile := '.DAT'              // Extensi¢n del archivo

       LOCAL       i := 0                   // Contador
       LOCAL cMaeAct := ''                  // Maestro Actual
*>>>>FIN DECLARACION DE VARIABLES

*>>>>RECORRIDO POR NIVEL
       DelNroGru(lShared,cPatCon,cPatSis,cAnoUsr,cMaeAlu)

       FOR i := 1 TO LEN(cMaeAlu)/3

************SELECION DE LAS AREAS DE TRABAJO
	      cMaeAct := SUBS(cMaeAlu,i*3-2,3)
	      IF !lUseDbf(.T.,cPatCon+'\'+cPatSis+'\'+cMaeAct+'\'+;
			     'MAE'+cMaeAct+cAnoSis+ExtFile,;
			     cMaeAct,NIL,lShared) .OR.;
		 !lUseGru(lShared,cPatCon+'\'+cPatSis,cMaeAct,cAnoSis)
		 cError('ABRIENDO EL ARCHIVOS DE '+cMaeAct)
		 LOOP
	      ENDIF
************FIN SELECION DE LAS AREAS DE TRABAJO

************RECORRIDO POR GRUPOS
	      SELECT &cMaeAct
	      DBGOTOP()
	      DO WHILE .NOT. EOF()

*================LINEA DE ESTADO
		   LineaEstado(cMaeAct+':'+STR(RECNO(),4)+'/'+;
					   STR(RECCOUNT(),4),'')
*================FIN LINEA DE ESTADO

*================ANALSISIS DE DECISION
		   IF &cMaeAct->lRetiroEst

		      SELECT &cMaeAct
		      DBSKIP()
		      LOOP

		   ENDIF
*================FIN ANALSISIS DE DECISION

*================GRABACION DEL REGISTRO
		   IF lLocCodigo('cCodigoGru','GRU',&cMaeAct->cCodigoGru)

		      IF GRU->(lRegLock(lShared,.F.))

			 REPL GRU->nNroAluGru WITH GRU->nNroAluGru+1
			 GRU->(DBCOMMIT())

		      ELSE
			 cError('NO SE GRABA EL REGISTRO')
		      ENDIF
		      IF lShared
			 GRU->(DBUNLOCK())
		      ENDIF

		   ENDIF
*================FIN GRABACION DEL REGISTRO

		 SELECT &cMaeAct
		 DBSKIP()

	      ENDDO
	      CloseDbf('GRU')
	      CloseDbf(cMaeAct)
************FIN RECORRIDO POR GRUPOS

       ENDFOR

       RETURN NIL
*>>>>FIN RECORRIDO POR NIVEL

