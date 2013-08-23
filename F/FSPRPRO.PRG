/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAR 11/96 LUN A
       Colombia, Bucaramanga        INICIO: 10:30 AM   MAR 11/96 LUN

OBJETIVOS:

1)- Crea la estructura del archivo

2)- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfPro(lShared,PathPro,FilePro,fNtxPro)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Sistema Compartido
       PathPro				    // Path del Archivo
       FilePro				    // Nombre del Archivo
       fNtxPro				    // Archivo de Indices */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL cUnidad := ''                  // Unidad de Disco
       LOCAL PathAct := ''                  // Path Actual
       LOCAL GetList := {}                  // Variable del sistema

       LOCAL aDbfPro := {{"cCodigoPro","Character",06,0},;
			 {"cNombrePro","Character",25,0},;
			 {"cApelliPro","Character",25,0},;
			 {"lCargOkPro","Logical"  ,01,0},;
			 {"cPasWorPro","Character",10,0},;
			 {"dUltIngPro","Date"     ,08,0},;
			 {"cUltIngPro","Character",08,0}}
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CAMBIO A LA UNIDAD DE DISKETTE
       PathAct := cPathAct()
       IF PathPro == 'A:' .OR. PathPro == 'B:'
	  cUnidad := DISKNAME()
	  IF !DISKCHANGE(PathPro)
	     cError('NO SE CAMBIO A LA UNIDAD '+PathPro)
	  ENDIF
       ENDIF
*>>>>FIN CAMBIO A LA UNIDAD DE DISKETTE

*>>>>CREACION DE LA ESTRUCTURA
       DO CASE
       CASE DIRCHANGE(PathPro) == 0 .OR. PathPro == 'A:' .OR. PathPro == 'B:'
	    DBCREATE(FilePro,aDbfPro,"DBFNTX")

       CASE DIRCHANGE(PathPro) == -3
	    cError('NO EXISTE EL DIRECTORIO: '+PathPro)

       CASE DIRCHANGE(PathPro) == -5
	    cError('NO TIENE DERECHOS EN: '+PathPro)
       ENDCASE
*>>>>FIN CREACION DE LA ESTRUCTURA

*>>>>CAMBIO A LA UNIDAD DEL DISCO DURO
       IF PathPro == 'A:' .OR. PathPro == 'B:'
	  IF !DISKCHANGE(cUnidad)
	     cError('NO SE CAMBIO A LA UNIDAD '+cUnidad)
	  ENDIF
       ENDIF
       DIRCHANGE(PathAct)
       RETURN NIL
*>>>>FIN CAMBIO A LA UNIDAD DEL DISCO DURO

/*************************************************************************
* TITULO DE LA FUNCION..: RECUPERACION DE LA ESTRUCTURA                  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAR 11/96 LUN A
       Colombia, Bucaramanga        INICIO: 10:40 AM   MAR 11/96 LUN

OBJETIVOS:

1)- Recupera la estructura del archivo

2)- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RecuDbfPro(lShared,PathPro,FilePro,fNtxPro)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                        // .T. Sistema Compartido
       PathPro			      // Path del Archivo
       FilePro			      // Nombre del Archivo
       fNtxPro			      // Archivo de Indice */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>RECUPERA LA ESTRUCTURA DEL ARCHIVO
       SAVE SCREEN
       cError("SE BORRO EL ARCHIVO "+PathPro+'\'+FilePro,;
	      "Error Grave. TOME NOTA",;
	      "Al Presionar Cualquier tecla se crea el archivo")

       Termometro(0,"CREANDO LA ESTRUCTURA DE PROFESOR")
       Termometro(100)

       CreaDbfPro(lShared,PathPro,FilePro,fNtxPro)
       RESTORE SCREEN
       RETURN NIL
*>>>>FIN RECUPERA LA ESTRUCTURA DEL ARCHIVO

/*************************************************************************
* TITULO..: LECTURA DEL USUARIO DEL PROFESOR                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 08/2008 SAB A
       Colombia, Bucaramanga        INICIO: 11:45 AM   JUN 08/2008 SAB

OBJETIVOS:

1- Lee el C¢digo del profesor

2- Verifica la Clave del Profesor

3- Crea el directorio de notas si se est  trabanjando el disco duro

4- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cUsrPro(aP1,aP2,aP3,cAnoIng)

*>>>>DESCRIPCION DE PARAMETROS
/*     aP1                                  // Parametros Generales
       aP2                                  // Parametros Generales
       aP3                                  // Parametros Generales
       cAnoIng                              // A¤o del Ingreso */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION PARAMETROS
       LOCAL lShared := xPrm(aP1,'lShared') // .T. Sistema Compartido
       LOCAL nModCry := xPrm(aP1,'nModCry') // Modo de Protecci¢n
       LOCAL cCodSui := xPrm(aP1,'cCodSui') // C¢digo del Sistema
       LOCAL cNomSis := xPrm(aP1,'cNomSis') // Nombre del Sistema
     *ÀDetalles del Sistema

       LOCAL cEmpPal := xPrm(aP1,'cEmpPal') // Nombre de la Empresa principal
       LOCAL cNitEmp := xPrm(aP1,'cNitEmp') // Nit de la Empresa
       LOCAL cNomEmp := xPrm(aP1,'cNomEmp') // Nombre de la Empresa
       LOCAL cNomSec := xPrm(aP1,'cNomSec') // Nombre de la Empresa Secundario
       LOCAL cCodEmp := xPrm(aP1,'cCodEmp') // C¢digo de la Empresa
     *ÀDetalles de la Empresa

       LOCAL cNomUsr := xPrm(aP1,'cNomUsr') // Nombre del Usuario
       LOCAL cAnoUsr := xPrm(aP1,'cAnoUsr') // A¤o del usuario
       LOCAL cAnoSis := xPrm(aP1,'cAnoSis') // A¤o del sistema
       LOCAL cPatSis := xPrm(aP1,'cPatSis') // Path del sistema
     *ÀDetalles del Usuario

       LOCAL PathW01 := xPrm(aP1,'PathW01') // Sitio del Sistema No.01
       LOCAL PathW02 := xPrm(aP1,'PathW02') // Sitio del Sistema No.02
       LOCAL PathW03 := xPrm(aP1,'PathW03') // Sitio del Sistema No.03
       LOCAL PathW04 := xPrm(aP1,'PathW04') // Sitio del Sistema No.04
       LOCAL PathW05 := xPrm(aP1,'PathW05') // Sitio del Sistema No.05
       LOCAL PathW06 := xPrm(aP1,'PathW06') // Sitio del Sistema No.06
       LOCAL PathW07 := xPrm(aP1,'PathW07') // Sitio del Sistema No.07
       LOCAL PathW08 := xPrm(aP1,'PathW08') // Sitio del Sistema No.08
       LOCAL PathW09 := xPrm(aP1,'PathW09') // Sitio del Sistema No.09
       LOCAL PathW10 := xPrm(aP1,'PathW10') // Sitio del Sistema No.10
     *ÀSitios del Sistema

       LOCAL PathUno := xPrm(aP1,'PathUno') // Path de Integraci¢n Uno
       LOCAL PathDos := xPrm(aP1,'PathDos') // Path de Integraci¢n Dos
       LOCAL PathTre := xPrm(aP1,'PathTre') // Path de Integraci¢n Tres
       LOCAL PathCua := xPrm(aP1,'PathCua') // Path de Integraci¢n Cuatro
     *ÀPath de Integraci¢n

       LOCAL nFilPal := xPrm(aP1,'nFilPal') // Fila Inferior Men£ principal
       LOCAL nFilInf := xPrm(aP1,'nFilInf') // Fila Inferior del SubMen£
       LOCAL nColInf := xPrm(aP1,'nColInf') // Columna Inferior del SubMen£
     *ÀDetalles Tecnicos

       LOCAL cMaeAlu := xPrm(aP1,'cMaeAlu') // Maestros habilitados
       LOCAL cMaeAct := xPrm(aP1,'cMaeAct') // Maestro Actual
       LOCAL cJorTxt := xPrm(aP1,'cJorTxt') // Jornada escogida
     *ÀDetalles Acad‚micos

       LOCAL cUnidad := xPrm(aP1,'cUnidad') // Unidad del Sima
       LOCAL cCodPro := xPrm(aP1,'cCodPro') // C¢digo del Profesor
       LOCAL cPatPro := xPrm(aP1,'cPatPro') // Path del Profesor
       LOCAL cNomPro := xPrm(aP1,'cNomPro') // Nombre del Profesor
       LOCAL PathSCO := xPrm(aP1,'PathSCO') // Path de Simacont.Usb
*>>>>FIN DECLARACION PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "inkey.ch"                  // Declaraci¢n de teclas
       #INCLUDE "CAMPOS\ARC-USB.PRG"       // Archivos del Sistema

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL cSavLin := ''                  // Salvar linea
       LOCAL cPasWor := ''                  // PassWord creacion de Usuarios
       LOCAL lMensaj := .F.                 // No visualizar mensaje
       LOCAL lPasWor := .F.                 // .T. Validar PassWord
       LOCAL lHayStr := .T.                 // .F. No existen archivos Prof

       LOCAL nFilSup := 10                  // Fila Superior
       LOCAL nColSup := 30                  // Columna Superior
       LOCAL nFilInf := 15                  // Fila Inferior
       LOCAL nColInf := 52                  // Columna Inferior
       LOCAL       i := 1                   // Contador
       LOCAL PathAct := ''                  // Path Actual
       LOCAL cPatPro := ''                  // Path del Profesor
       LOCAL lCreaCar

       LOCAL GetList := {}                  // Variable del sistema
       LOCAL cCodigoTpr := ''               // C¢digo del profesor
*>>>>FIN DECLARACION DE VARIABLES

*>>>>PARAMENTROS ESPECIFICOS
       PathUno := IF(EMPTY(PathSCO),PathUno,PathSCO
*>>>>FIN PARAMENTROS ESPECIFICOS

*>>>>AREAS DE TRABAJO
       aUseDbf := {}
       AADD(aUseDbf,{.T.,PathUno+'\'+cPatSis+'\'+cMaeAct+'\'+;
			 FConTbl+cMaeAct+ExtFile,'TCO',NIL,lShared,nModCry})

       AADD(aUseDbf,{.T.,PathUno+'\'+cPatSis+;
			 FilePro+cAnoSis+ExtFile,'PRO',NIL,lShared,nModCry})
*>>>>FIN AREAS DE TRABAJO

*>>>>SELECCION DE LAS AREAS DE TRABAJO
       IF !lUseDbfs(aUseDbf)
	  cError('ABRIENDO ARCHIVOS')
	  CloseAll(aUseDbf)
	  RETURN NIL
       ENDIF
*>>>>FIN SELECCION DE LAS AREAS DE TRABAJO

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       lHayErr := .T.
       DO CASE
       CASE TCO->(RECCOUNT()) == 0
	    cError('NO EXISTEN CONFIGURACION DEL DE LA CONTABILIDAD')

       CASE PRO->(RECCOUNT()) == 0
	    cError('NO EXISTEN PROFESORES GRABADOS')

       OTHERWISE
	    lHayErr :=.F.
       ENDCASE
       IF lHayErr
	  CloseAll(aUseDbf)
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>FILTRACION DE LOS INDICADORES
       SELECT PRO
       SET FILTER TO PRO->lSiProfPro .AND. !PRO->lRetiroPro
       PRO->(DBGOTOP())
       IF PRO->(EOF())
	  cError('NO EXISTEN PROFESORES ACTIVOS')
	  CloseAll(aUseDbf)
	  RETURN NIL
       ENDIF
*>>>>FIN FILTRACION DE LOS INDICADORES

*>>>>LECTURA Y VALIDACION DEL PROFESOR USUARIO
       SET CURSOR ON
       SET COLOR TO I
       DISPBOX(nFilSup,nColSup,nFilInf,nColInf,"ÉÍ»º¼ÍÈº")
       SET COLOR TO

       cError('INGRESE SU CODIGO DE IDENTIFICACION','PROFESOR POR FAVOR')

       DO WHILE .T.

**********LECTURA DEL CODIGO DE IDENTIFICACION
	    cCodigoTpr := SPACE(06)
	    @ nFilSup+2,nColSup+2 SAY 'CODIGO :';
				  GET cCodigoTpr PICT '999999';
				  VALID lValProfes(05,10,@cCodigoTpr) .OR.;
				  EMPTY(cCodigoTpr)
	    READ
	    cCodPro := cCodigoTpr
**********FIN LECTURA DEL CODIGO DE IDENTIFICACION

**********ANALISIS PARA LA SALIDA
	    IF EMPTY(cCodigoTpr)
	       CloseDbf('PRO')
	       RETURN NIL
	    ENDIF
**********FIN ANALISIS PARA LA SALIDA

**********LECTURA DE LA CLAVE DE ACCESO
	    IF !lLeePasPro(nFilSup+3,nColSup+4)
	       CloseDbf('PRO')
	       cCodigoTpr := ''
	       RETURN NIL
	    ENDIF
	    cNomPro := ALLTRIM(PRO->cApelliPro)+' '+;
		       ALLTRIM(PRO->cNombrePro)+':'+cCodigoTpr
**********FIN LECTURA DE LA CLAVE DE ACCESO

**********VALIDACION DEL A¥O DE INGRESO
	    IF !EMPTY(cAnoIng)   .AND.;
	       PRO->cAnoUsrPro # cAnoUsr .AND.;
	       cAnoIng # cAnoUsr .AND.;
	       UPPER(cNomUsr) # 'SUPER'
	       cError('NO ESTA HABILITADO EL INGRESO AL '+cAnoUsr)
	       LOOP
	    ENDIF
**********FIN VALIDACION DEL A¥O DE INGRESO

**********PREGUNTA DE DECISION
	    IF !lPregunta(cNomPro+' DESEA CONTINUAR? Si No')
	       LOOP
	    ENDIF
**********FIN PREGUNTA DE DECISION

**********ANALISIS SI EL PROFESOR TIENE CARGA
	    IF !PRO->lCargasPro .OR. !(cMaeAct $ PRO->cMaeAluPro)
	       cError('NO TIENE CARGA ACADEMICA')
	       LOOP
	    ENDIF
**********FIN ANALISIS SI EL PROFESOR TIENE CARGA

**********CREACION DEL DIRECTORIO DEL PROFESOR
	    PathAct := cPathAct()
	    cPatPro := cPatSis+'\'+cMaeAct+'\'+cCodigoTpr
	    Mdir(cPatPro,PathAct)
	    EXIT
**********FIN CREACION DEL DIRECTORIO DEL PROFESOR

       ENDDO
*>>>>FIN LECTURA Y VALIDACION DEL PROFESOR USUARIO

*>>>>CREACION DE LAS ESTRUCTURAS
       lHayStr := .T.
       IF !FILE(cPatPro+'\'+FilePro+ExtFile) .AND.;
	  !FILE(cPatPro+'\'+FCarPro+cAnoSis+ExtFile)

	  CreaCarPro(lShared,cAnoUsr,cPatSis,PathUno,cMaeAct,cPatPro,;
		     cCodigoTpr,ALLTRIM(PRO->cApelliPro),;
		     ALLTRIM(PRO->cNombrePro))
	  lHayStr := .F.
       ENDIF
       ModNomPro(lShared,cPatPro,cCodigoTpr)
      *Modifica el Nombre local del Profesor
*>>>>FIN CREACION DE LAS ESTRUCTURAS

*>>>>ACTUALIZACION DE LOS ESTUDIANTES
       IF lHayStr

	  DO CASE
	  CASE 'JAR' $ cMaeAct
	       i := 1
	  CASE 'PRI' $ cMaeAct
	       i := 2
	  CASE 'BTO' $ cMaeAct
	       i := 3
	  ENDCASE

	  IF SUBS(PRO->cRevisaPro,i,1) == '1'

	     RevisarEst(lShared,cNomSis,cAnoUsr,;
			cPatPro,PathUno+'\'+cPatSis,cMaeAct,lAnoAct)

	     IF PRO->(lRegLock(lShared,.F.))
		REPL PRO->cRevisaPro WITH STUFF(PRO->cRevisaPro,i,1,'0')
		PRO->(DBCOMMIT())
	     ELSE
		cError('NO SE GRABA EL SWICTH DE LA ACTUALIZACION')
	     ENDIF
	     IF lShared
		PRO->(DBUNLOCK())
	     ENDIF
	  ENDIF
       ENDIF
       RETURN cPatPro
*>>>>FIN ACTUALIZACION DE LOS ESTUDIANTES

/*************************************************************************
* TITULO..: LECTURA DE LA CLAVE DEL PROFESOR                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 09/2008 DOM A
       Colombia, Bucaramanga        INICIO: 01:30 PM   JUN 09/2008 DOM

1- Permite leer la clave del profesor y verificarla

2- Debe estar en uso el archivo de profes de la contabilidad
   en el registro coreccto

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lLeePasPro(nNroFil,nNroCol,lValida)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // N£mero de la fila
       nNroCol                              // N£mero de la columna
       lValida                              // Validar la Clave */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cPasWor := ''                  // Clave del usuario
       LOCAL       i := 0                   // Contador
       LOCAL lPasWor := .T.                 // Clave Correcta
       LOCAL GetList := {}                  // Variable del sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LECTURA DE LA CLAVE DE ACCESO
       SET COLOR TO W/N,N/N,N

       DO WHILE i < 3
	  cPasWor := SPACE(10)
	  @ nNroFil,nNroCol SAY 'CLAVE:' GET cPasWor PICT 'XXXXXXXXXX'
	  READ

	  lValida := IF(lValida == NIL,.T.,lValida)
	  lPasWor := .F.

	  IF lValida
	     IF cPasWor == cLeeTxtCry(PRO->lSiCrypPro,PRO->cPasWorPro)
		lPasWor := .T.
		EXIT
	     ENDIF
	  ENDIF
	  i++
       ENDDO
       SET COLOR TO W/N,N/W,N
       RETURN lPasWor
*>>>>FIN LECTURA DE LA CLAVE

/*************************************************************************
* TITULO..: CREACION DE ARCHIVOS DEL PROFESOR                            *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 09/2008 DOM A
       Colombia, Bucaramanga        INICIO: 01:30 PM   JUN 09/2008 DOM

OBJETIVOS:

1- Debe venir validado la no existencia de la configuracion del profesor

2- Crea los archivos con la carga academica del profesor

3- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaCarPro(lShared,cAnoUsr,cPatSis,PathUno,;
		    cMaeAct,cPatPro,cCodPro,cApePro,cNomPro)

*>>>>DECLARACIO DE VARIABLES
       #INCLUDE "CAMPOS\ARC-SPR.PRG"       // Archivos del Sistema

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL lUseNtx := .F.                 // .T. Abrir Indices
       LOCAL nNroFil := 0                   // N£mero de la fila
       LOCAL lAnoAct := .T.                 // .T. A¤o Actual
       LOCAL nNroAlu := 1                   // N£mero de Alumnos
       LOCAL cUnidad := ''                  // Unidad de Disco
       LOCAL lHayMat := .T.                 // .T. Hay Materia

       LOCAL cNombreTes := ''               // Nombre del estudiante
       LOCAL lCargOkTpr := .T.              //.T.Profesor con Carga Academica
       LOCAL cCodigoTma := ''               // C¢digo de la Materia
       LOCAL cNombreTma := ''               // Nombre de la Materia
       LOCAL cCodigoTgr := ''               // C¢digo del Grupo
       LOCAL cCodigoTni := ''               // C¢digo del Nivel

       FIELD cCodigoGru                     // C¢digo del Grupo
       FIELD cCodigoNiv                     // C¢digo del Nivel
       FIELD cCodigoMat                     // C¢digo de la materia
*>>>>FIN DECLARACIO DE VARIABLES

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbf(.T.,PathUno+'\'+cPatSis+'\'+cMaeAct+'\'+;
		       FileCar+cMaeAct+ExtFile,'CAR',NIL,lShared)
	  cError('ABRIENDO EL ARCHIVO DE CARGAS')
	  CloseAll()
	  RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       lHayErr := .T.
       DO CASE
       CASE CAR->(RECCOUNT()) == 0
	    cError('NO APARECEN LAS CARGAS ACADEMICAS DE LOS PROFESORES')

       OTHERWISE
	    lHayErr :=.F.
       ENDCASE
       IF lHayErr
	  CloseAll()
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>ANALISIS SI TIENE CARGA ACADEMICA ASIGNADA
       lCargOkTpr := .F.
       IF lLocCodigo('cCodigoPro','CAR',cCodPro)
	  lCargOkTpr := .T.
       ENDIF
*>>>>FIN ANALISIS SI TIENE CARGA ACADEMICA ASIGNADA

*>>>>CREACION DE LAS ESTRUCTURAS DEL PROFESOR
       CreaDbfPro(lShared,cPatPro,FilePro+ExtFile)
       CreaDbfCaP(lShared,cPatPro,FCarPro+cAnoSis+ExtFile)
       CreaDbfMaP(lShared,cPatPro,FMatPro+cAnoSis+ExtFile)
       CloseDbf('PRO')
*>>>>FIN CREACION DE LAS ESTRUCTURAS DEL PROFESOR

*>>>>AREAS DE TRABAJO
       aUseDbf := {}

       AADD(aUseDbf,{.T.,PathUno+'\'+cPatSis+'\'+cMaeAct+'\'+;
			 FileAlu+cMaeAct+cAnoSis+ExtFile,cMaeAct,;
			 PathUno+'\'+cPatSis+'\'+cMaeAct+'\'+;
			 fNtxAlu+cMaeAct+cAnoSis+cExtNtx,lShared,nModCry})

       AADD(aUseDbf,{.T.,PathUno+'\'+cPatSis+'\'+cMaeAct+'\'+;
			 FileMat,'MAT',NIL,lShared,nModCry})

       AADD(aUseDbf,{.T.,cPatPro+'\'+;
			 FilePro+ExtFile,'PRO',NIL,lShared,nModCry})

       AADD(aUseDbf,{.T.,cPatPro+'\'+;
			 FCarPro+cAnoSis+ExtFile,'CAP',NIL,lShared,nModCry})

       AADD(aUseDbf,{.T.,cPatPro+'\'+;
			 FMatPro+cAnoSis+ExtFile,'MAP',NIL,lShared,nModCry})
*>>>>FIN AREAS DE TRABAJO

*>>>>SELECCION DE LAS AREAS DE TRABAJO
       IF !lUseDbfs(aUseDbf)
	  cError('ABRIENDO ARCHIVOS')
	  CloseAll(aUseDbf)
	  RETURN NIL
       ENDIF
*>>>>FIN SELECCION DE LAS AREAS DE TRABAJO

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       lHayErr := .T.
       SELECT &cMaeAct
       DO CASE
       CASE RECCOUNT() == 0
	    cError('NO ESTUDIANTES GRABADOS')

       CASE MAT->(RECCOUNT()) == 0
	    cError('NO APARECEN MATERIAS GRABADAS')

       CASE CAR->(RECCOUNT()) == 0
	    cError('NO APARECEN LAS CARGAS ACADEMICAS DE LOS PROFESORES')

       OTHERWISE
	    lHayErr :=.F.
       ENDCASE
       IF lHayErr
	  CloseAll(aUseDbf)
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>GRABACION DE LOS DATOS DEL PROFESOR
       IF PRO->(lRegLock(lShared,.T.))
	  REPL PRO->cCodigoPro WITH cCodPro
	  REPL PRO->cApelliPro WITH cApePro
	  REPL PRO->cNombrePro WITH cNomPro
	  REPL PRO->lCargOkPro WITH lCargOkTpr
	  PRO->(DBCOMMIT())
       ENDIF
       IF lShared
	  PRO->(DBUNLOCK())
       ENDIF
*>>>>FIN GRABACION DE LOS DATOS DEL PROFESOR

*>>>>FILTRACION DE LA CARGA ACADEMICA
       SELECT CAR
       SET FILTER TO CAR->cCodigoPro = cCodPro
       CAR->(DBGOTOP())
       IF CAR->(EOF())
	  cError('PARA '+cNomPro+' NO EXISTE CARGA ACADEMICA')
	  RETURN NIL
       ENDIF
*>>>>FIN FILTRACION DE LA CARGA ACADEMICA

*>>>>GRABACION DE LA CARGA ACADEMICA DEL PROFESOR
       nNroFil := nMarco(01,cNomPro+' POR FAVOR REVISE SU CARGA '+;
			    'ACADEMICA MIENTRAS SE GRABA')
       SELECT CAR
       CAR->(DBGOTOP())
       DO WHILE .NOT. CAR->(EOF())

**********LOCALIZACION DEL CODIGO DE LA MATERIA
	    cCodigoTgr := SUBS(CAR->cCodigoCar,5,4)
	    cCodigoTni := SUBS(CAR->cCodigoCar,5,2)
	    cCodigoTma := SUBS(CAR->cCodigoCar,1,4)

	    cNombreTma := 'MATERIA CON CODIGO: '+cCodigoTma+;
			  ' NO EXISTE'
	    IF cCodigoTma == '9999'
	       cNombreTma := 'MATERIA:'+REPL('_',22)
	    ENDIF


	    IF lLocCodigo('cCodigoMat','MAT',cCodigoTma)
	       cNombreTma := MAT->cNombreMat
	    ENDIF
**********FIN LOCALIZACION DEL CODIGO DE LA MATERIA

**********VISUALIZACION DE LA MATERIA
	    nNroFil++
	    @ nNroFil,01 SAY 'GRUPO:'+cCodigoTgr+'->'+ALLTRIM(cNombreTma)+' '+;
			     IF(CAR->nTipCarCar==0,'',;
				IF(CAR->nTipCarCar==1,': POR GRUPO',;
				   IF(CAR->nTipCarCar==2,': POR NIVEL',;
				      IF(CAR->nTipCarCar==3,': POR NIVELES',;
							    ': ERROR'))));
			     PICT "@S78"
	    IF nNroFil == 21
	       cPausa()
	       nNroFil := nMarco(01,cNomPro+' POR FAVOR REVISE '+;
				    'SU CARGA ACADEMICA MIENTRAS SE GRABA')
	    ENDIF
**********FIN VISUALIZACION DE LA MATERIA

**********GRABACION DE LA CARGA
	    IF CAP->(lRegLock(lShared,.T.))
	       REPL CAP->cCodigoCar WITH CAR->cCodigoCar
	       REPL CAP->nTipCarCar WITH CAR->nTipCarCar
	       REPL CAP->cNombreMat WITH cNombreTma
	       CAP->(DBCOMMIT())
	    ENDIF
	    IF lShared
	       CAP->(DBUNLOCK())
	    ENDIF
**********FIN GRABACION DE LA CARGA

**********GRABACION DE LAS MATERIAS DEL PROFESOR
	    IF TCO->cIndUnoTbl # cCodigoTma .AND.;
	       TCO->cIndDosTbl # cCodigoTma

	       SELECT MAP
	       IF TCO->lIndNivTbl
		  LOCATE FOR cCodigoNiv == cCodigoTni .AND.;
			     cCodigoMat == cCodigoTma
		  lHayMat := .F.
		  IF FOUND()
		     lHayMat := .T.
		  ENDIF
	       ELSE
		   lHayMat := lLocCodigo('cCodigoMat','MAP',cCodigoTma)
	       ENDIF

	       IF !lHayMat
		  IF MAP->(lRegLock(lShared,.T.))
		     IF TCO->lIndNivTbl
			REPL MAP->cCodigoNiv WITH cCodigoTni
		     ELSE
			REPL MAP->cCodigoNiv WITH SPACE(02)
		     ENDIF
		     REPL MAP->cCodigoMat WITH cCodigoTma
		     REPL MAP->cNombreMat WITH cNombreTma
		     MAP->(DBCOMMIT())
		  ENDIF
		  IF lShared
		     MAP->(DBUNLOCK())
		  ENDIF
	       ENDIF

	    ENDIF
**********FIN GRABACION DE LAS MATERIAS DEL PROFESOR

	  SELECT CAR
	  CAR->(DBSKIP())

       ENDDO
       SET FILTER TO
       cPausa()
*>>>>FIN GRABACION DE LA CARGA ACADEMICA EN ARCHIVOS

*>>>>CREACION DE LOS GRUPOS Y GRABACION DE LOS ALUMNOS
       SELECT CAP
       GO TOP
       DO WHILE .NOT. CAP->(EOF())

**********CREACION DE LA ESTRUCTURA DEL GRUPO
	    FNotPro := CAP->cCodigoCar+ExtFile
	    CreaDbfNoP(lShared,cPatPro,FNotPro)
**********FIN CREACION DE LA ESTRUCTURA DEL GRUPO

**********VALIDACION DE LA CARGA NORMAL
	    IF CAP->nTipCarCar # 0

	       @ 10,20 SAY 'PARA '+SUBS(cCodigoTgr,1,2)+;
			   ' CREANDO '+ALLTRIM(CAP->cNombreMat)
	       CAP->(DBSKIP())
	       CloseDbf('NOP')
	       LOOP
	    ENDIF
**********FIN VALIDACION DE LA CARGA NORMAL

**********SELECION DE LAS AREAS DE TRABAJO
	    IF !lUseDbf(.T.,cPatPro+'\'+FNotPro,'NOP',NIL,lShared)
	       cError('ABRIENDO EL ARCHIVO DE NOTAS '+FNotPro)
	       CloseAll(aUseDbf)
	       RETURN NIL
	    ENDIF
**********FIN SELECION DE LAS AREAS DE TRABAJO

**********FILTRACION DEL MAESTRO DE ALUMNOS
	    SELECT &cMaeAct
	    cCodigoTgr := SUBS(CAP->cCodigoCar,5,4)
	    SET FILTER TO cCodigoGru == cCodigoTgr
	    DBGOTOP()
	    IF EOF()
	       cError('NO EXISTEN ALUMNOS PARA EL GRUPO '+cCodigoTgr)
	       CloseAll(aUseDbf)
	       RETURN NIL
	    ENDIF
**********FIN FILTRACION DEL MAESTRO DE ALUMNOS

**********GRABACION DE LOS ALUMNOS DEL RESPECTIVO GRUPO
	    nNroFil := nMarco(01,'GRABANDO LOS ALUMNOS DE '+;
			      ALLTRIM(CAP->cNombreMat)+' '+;
			      'DEL GRUPO '+cCodigoTgr)
	    SELECT &cMaeAct
	    GO TOP
	    DO WHILE .NOT. EOF()

*--------------GRABACION DEL ALUMNO EN EL DISCO
		 IF NOP->(lRegLock(lShared,.T.))
		    REPL NOP->cCodigoEst WITH &cMaeAct->cCodigoEst
		    REPL NOP->cApelliEst WITH &cMaeAct->cApelliEst
		    REPL NOP->cNombreEst WITH &cMaeAct->cNombreEst
		    REPL NOP->lRetiroNoP WITH .F.
		    NOP->(DBCOMMIT())
		 ENDIF
		 IF lShared
		    NOP->(DBUNLOCK())
		 ENDIF
*--------------FIN GRABACION DEL ALUMNO EN EL DISCO

*--------------VISUALIZACION DEL ESTUDIANTE GRABADO
		 SELECT &cMaeAct
		 cNombreTes := ALLTRIM(&cMaeAct->cApelliEst)+' '+;
			       ALLTRIM(&cMaeAct->cNombreEst)
		 nNroFil++
		 @ nNroFil,01 SAY 'No. '+STR(nNroAlu++,2)+;
				  ' CODIGO: '+&cMaeAct->cCodigoEst+' '+;
				  cNombreTes+' ...'

		 IF nNroFil == 21
		    nNroFil := nMarco(01,'GRABANDO LOS ALUMNOS DE '+;
				      ALLTRIM(CAP->cNombreMat)+' DEL GRUPO '+;
				      cCodigoTgr)
		 ENDIF
*--------------FIN VISUALIZACION DEL ESTUDIANTE GRABADO


	       SKIP

	    ENDDO
	    SELECT &cMaeAct
	    SET FILTER TO
	    CloseDbf('NOP')
	    nNroAlu := 1
**********FIN GRABACION DE LOS ALUMNOS DEL RESPECTIVO GRUPO

	  CAP->(DBSKIP())

       ENDDO
       RETURN NIL
*>>>>FIN CREACION DE LOS GRUPOS Y GRABACION DE LOS ALUMNOS


/*************************************************************************
* TITULO..: MODIFICACION NOMBRE DEL PROFESOR                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 09/2008 DOM A
       Colombia, Bucaramanga        INICIO: 02:00 PM   JUN 09/2008 DOM

OBJETIVOS:

1- Modifica el nombre del Profesor local de acuerdo al archivo de los
   profesores de la contabilidad.

2- Debe estar en uso el archivo de profesore de la Contabilidad.

3- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION ModNomPro(lShared,cPatPro,cCodPro)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos
       cPatPro                              // Path del Profesor
       cCodPro                              // C¢digo del Profesor */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "CAMPOS\ARC-SPR.PRG"       // Archivos del Sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbf(.T.,cPatPro+'\'+;
		       FilePro+ExtFile,'PRL',NIL,lShared)
	  cError('ABRIENDO ARCHIVO PROFESOR LOCAL')
	  CloseDbf('PRL',cPatPro+'\'+FilePro+ExtFile)
	  RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>VALIDACION DE NOMBRE DEL PROFESOR
       IF ALLTRIM(PRO->cApelliPro) == ALLTRIM(PRL->cApelliPro) .AND.;
	  ALLTRIM(PRO->cNombrePro) == ALLTRIM(PRO->cNombrePro)
	  CloseDbf('PRL',cPatPro+'\'+FilePro+ExtFile)
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DE NOMBRE DEL PROFESOR

*>>>>ACTUALIZACION DEL NOMBRE DEL PROFESOR
       IF PRO->cCodigoPro == cCodPro
	  IF PRL->(lRegLock(lShared,.F.))
	     REPL PRL->cApelliPro WITH PRO->cApelliPro
	     REPL PRL->cNombrePro WITH PRO->cNombrePro
	     PRL->(DBCOMMIT())
	     cError('SE MODIFICO EL NOMBRE DEL PROFESOR')
	  ELSE
	     cError('NO SE ACTUALIZA EL NOMBRE LOCAL DEL PROFESOR')
	  ENDIF
	  IF lShared
	     PRL->(DBUNLOCK())
	  ENDIF
       ENDIF
       CloseDbf('PRL',cPatPro+'\'+FilePro+ExtFile)
       RETURN NIL
*>>>>FIN ACTUALIZACION DEL NOMBRE DEL PROFESOR