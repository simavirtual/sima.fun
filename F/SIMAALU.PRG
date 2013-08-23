/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		 BIBLIOTECAS DE FUNCIONES GENERALES DE ALUMNOS

OBJETIVOS:

- Definici¢n de funciones generales para el SIMA

***************************************************************************
*-------------------- DECLARACION DE LAS FUNCIONES -----------------------*
**************************************************************************/

*>>>>DECLARACION DE CONSTANTES GENERALES
       #INCLUDE "inkey.ch"
*>>>>FIN DECLARACION DE CONSTANTES GENERALES

/*************************************************************************
* TITULO..: APERTURA DE LOS MAESTROS DE LA CONTABILIDAD                  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 03/2002 MIE A
       Colombia, Bucaramanga        INICIO: 05:30 PM   JUL 03/2002 MIE

OBJETIVOS:

1)- Pone en uso los archivos de alumnos de la contabilidad habilitados

2)- Retorna por referencia los param‚tros de la funci¢n marcados con @

3)- Retorna .T. si no se presentaron problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lUseMae(lShared,cPatSis,cMaeAlu,cAnoSis,lNtxAlu)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Compartir Archivos
       cPatSis			            // Path del Sistema
       cMaeAlu                              // Maestros habilitados
       cAnoSis                              // A¤o del sistema
       lNtxAlu                              // .T. Indice del Archivo */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"          // Declaraci¢n de Archivos

       LOCAL lHayErr := .F.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>SELECION DE LAS AREAS DE TRABAJO
       lNtxAlu := IF(lNtxAlu == NIL,.T.,lNtxAlu)
       IF 'JAR' $ cMaeAlu

	  PathAlu := cPatSis+'\JAR\'
	  IF !lUseDbf(.T.,PathAlu+FMaeJar+cAnoSis+ExtFile,'JAR',;
			  IF(lNtxAlu,;
			     PathAlu+fNtxJar+cAnoSis+cExtNtx,;
			     NIL),;
			  lShared)
	     cError('ABRIENDO ARCHIVOS DE JARDIN EN '+PathAlu)
	     CloseAll()
	     RETURN .F.
	  ENDIF
       ENDIF

       IF 'PRI' $ cMaeAlu

	  PathAlu := cPatSis+'\PRI\'
	  IF !lUseDbf(.T.,PathAlu+FMaePri+cAnoSis+ExtFile,'PRI',;
			  IF(lNtxAlu,;
			     PathAlu+fNtxPri+cAnoSis+cExtNtx,;
			     NIL),;
			  lShared)
	     cError('ABRIENDO ARCHIVOS DE PRIMARIA EN '+PathAlu)
	     CloseAll()
	     RETURN .F.
	  ENDIF
       ENDIF

       IF 'BTO' $ cMaeAlu

	  PathAlu := cPatSis+'\BTO\'
	  IF !lUseDbf(.T.,PathAlu+FMaeBto+cAnoSis+ExtFile,'BTO',;
			  IF(lNtxAlu,;
			     PathAlu+fNtxBto+cAnoSis+cExtNtx,;
			     NIL),;
			  lShared)
	     cError('ABRIENDO ARCHIVOS DE BACHILLERATO EN '+PathAlu)
	     CloseAll()
	     RETURN .F.
	  ENDIF
       ENDIF
       RETURN .T.
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

/*************************************************************************
* TITULO DE LA FUNCION..: INDEXAR LOS ARCHIVOS DE ALUMNOS                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC 27/95 MIE A
       Colombia, Bucaramanga        INICIO: 05:40 PM   DIC 27/95 MIE

OBJETIVOS:

1)- Indexa los archivos maestros de alumnos

2)- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION IndexarAlu(lShared,cPatFil,cAnoSis,cMaeAlu)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Sistema Compartido
       cPatFil			            // Path del archivo
       cAnoSis                              // A¤o del sistema
       cMaeAlu                              // Maestros Habilitados */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"          // Declaraci¢n de Archivos

       LOCAL cPatTem := ''                  // Path Temporal

       FIELD cCodigoEst                     // C¢digo del Estudiante
       FIELD cNombreEst                     // Nombre del Estudiante
       FIELD cApelliEst                     // Apellido del Estudiante
*>>>>FIN DECLARACION DE VARIABLES

*>>>>SELECCION DE LAS AREAS DE TRABAJO
       IF 'JAR' $ cMaeAlu
	  cPatTem := cPatFil+'\JAR\'
	  IF !lUseDbf(.T.,cPatTem+;
			  FMaeJar+cAnoSis+ExtFile,'JAR',NIL,lShared)
	     cError('ABRIENDO ARCHIVOS DE JARDIN EN '+cPatFil)
	     CloseAll()
	     RETURN NIL
	  ENDIF
       ENDIF
*>>>>FIN SELECCION DE LAS AREAS DE TRABAJO

*>>>>CREACION DE INDEXES DE JARDIN
       IF 'JAR' $ cMaeAlu
	  Termometro(0,'INDEXANDO MAESTROS DE JARDIN')
	  Termometro(35)

	  SELECT JAR
	  fNtxJar := cPatTem+fNtxJar+cAnoSis+cExtNtx
	  INDEX ON cCodigoEst TO &fNtxJar

	  Termometro(70)
	  Ntx1Jar := cPatTem+Ntx1Jar+cAnoSis+cExtNtx
	  INDEX ON cApelliEst TO &Ntx1Jar

	  Termometro(100)
	  Ntx2Jar := cPatTem+Ntx2Jar+cAnoSis+cExtNtx
	  INDEX ON cNombreEst TO &Ntx2Jar
	  CloseDbf('JAR')
       ENDIF
*>>>>FIN CREACION DE INDEXES DE JARDIN

*>>>>SELECCION DE LAS AREAS DE TRABAJO
       IF 'PRI' $ cMaeAlu
	  cPatTem := cPatFil+'\PRI\'
	  IF !lUseDbf(.T.,cPatTem+;
			  FMaePri+cAnoSis+ExtFile,'PRI',NIL,lShared)
	     CloseAll()
	     RETURN NIL
	  ENDIF
       ENDIF
*>>>>FIN SELECCION DE LAS AREAS DE TRABAJO

*>>>>CREACION DE INDEXES DE PRIMARIA
       IF 'PRI' $ cMaeAlu
	  Termometro(0,'INDEXANDO MAESTROS DE PRIMARIA')
	  Termometro(35)

	  SELECT PRI
	  fNtxPri := cPatTem+fNtxPri+cAnoSis+cExtNtx
	  INDEX ON cCodigoEst TO &fNtxPri

	  Termometro(70)
	  Ntx1Pri := cPatTem+Ntx1Pri+cAnoSis+cExtNtx
	  INDEX ON cApelliEst TO &Ntx1Pri

	  Termometro(100)
	  Ntx2Pri := cPatTem+Ntx2Pri+cAnoSis+cExtNtx
	  INDEX ON cNombreEst TO &Ntx2Pri
	  CloseDbf('PRI')

       ENDIF
*>>>>FIN CREACION DE INDEXES DE PRIMARIA

*>>>>SELECCION DE LAS AREAS DE TRABAJO
       IF 'BTO' $ cMaeAlu
	  cPatTem := cPatFil+'\BTO\'
	  IF !lUseDbf(.T.,cPatTem+;
			  FMaeBto+cAnoSis+ExtFile,'BTO',NIL,lShared)
	     cError('ABRIENDO ARCHIVOS DE BACHILLERATO EN '+cPatFil)
	     CloseAll()
	     RETURN NIL
	  ENDIF
       ENDIF
*>>>>FIN SELECCION DE LAS AREAS DE TRABAJO

*>>>>CREACION DE INDEXES DE BACHILLERATO
       IF 'BTO' $ cMaeAlu
	  Termometro(0,'INDEXANDO A BACHILLERATO')
	  Termometro(35)

	  SELECT BTO
	  fNtxBto := cPatTem+fNtxBto+cAnoSis+cExtNtx
	  INDEX ON cCodigoEst TO &fNtxBto

	  Termometro(70)
	  Ntx1Bto := cPatTem+Ntx1Bto+cAnoSis+cExtNtx
	  INDEX ON cApelliEst TO &Ntx1Bto

	  Termometro(100)
	  Ntx2Bto := cPatTem+Ntx2Bto+cAnoSis+cExtNtx
	  INDEX ON cNombreEst TO &Ntx2Bto
	  CloseDbf('BTO')
       ENDIF
       RETURN NIL
*>>>>FIN CREACION DE INDEXES DE BACHILLERATO

/*************************************************************************
* TITULO..: LECTURA DEL CODIGO DEL ESTUDIANTE                            *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 03/2002 MIE A
       Colombia, Bucaramanga        INICIO: 05:40 PM   JUL 03/2002 MIE

OBJETIVOS:

1- Deben estar en uso los maestros habilitados

2- Lee y valida el c¢digo del Estudiante de cualquier maestro

3- Retorna por referencia los param‚tros de la funci¢n marcados con @

4- Retorna el c¢digo del estudiante

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cLeeCodEst(nNroFil,nNroCol,cMaeAlu,cMaeAct,nLenCod)

*>>>>PARAMETROS DE LA FUNCION
/*     nNroFil                              // N£mero de la fila
       nNroCol                              // N£mero de la Columna
       cMaeAlu                              // Meaestro Habilitados
       cMaeAct			            // @Maestro Actual
       nLenCod                              // Longitud del C¢digo */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       MEMVA xClrSys			    // Color del Sistema

       LOCAL       i := 0                   // C¢digo del Estudiante
       LOCAL cGetsSi := ''                  // Color del Get Selecionados
       LOCAL cGetsNo := ''                  // Color del Get No Seleccionados
       LOCAL cPictur := ''                  // Picture de lectura
       LOCAL GetList := {}                  // Variable del sistema

       LOCAL cCodigoTes := ''               // C¢digo del estudiante
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DEL COLOR
       Colores(xColores(IF(!EMPTY(xClrSys),xClrSys[1],'')),,;
	       @cGetsSi,@cGetsNo)
       cSetColor(','+cGetsSi+',,,'+cGetsNo)
*>>>>IF ANALISIS DEL COLOR

*>>>>CALCULO DE LA LONGITUD DEL CODIGO
       nLenCod := IF(EMPTY(nLenCod),6,nLenCod)
       FOR i := 1 TO nLenCod
	   cPictur += '9'
       ENDFOR
*>>>>FIN CALCULO DE LA LONGITUD DEL CODIGO

*>>>>CAPTURA Y VALIDACION DEL CODIGO
       DO WHILE .T.

**********CAPTURA DEL CODIGO
	    cCodigoTes := SPACE(nLenCod)
	    @ nNroFil,nNroCol GET cCodigoTes PICT cPictur;
				  VALID HelpRead();
				  WHEN  {||HelpRead('POR FAVOR INGRESE EL '+;
						    'CODIGO DEL ESTUDIANTE')}

	    READ
	    IF EMPTY(cCodigoTes)
	       EXIT
	    ENDIF
	    cCodigoTes := SUBS(cCodigoTes,1,6)
**********FIN CAPTURA DEL CODIGO

**********VALIDACION EXISTENCIA DEL CODIGO
	    IF !lSekCodMae(cCodigoTes,cMaeAlu,@cMaeAct)
	       LOOP
	    ENDIF
	    EXIT
**********FIN VALIDACION EXISTENCIA CODIGO

       ENDDO
       SET COLOR TO
       RETURN cCodigoTes
*>>>>FIN CAPTURA Y VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: ENCONTRAR CODIGO DEL ESTUDIANTE                              *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 03/2002 MIE A
       Colombia, Bucaramanga        INICIO: 05:35 PM   JUL 03/2002 MIE

OBJETIVOS:

1- Permite encontrar el c¢digo del estudiante dentro de los maestros
   habilitados

2- Retorna por referencia los param‚tros de la funci¢n marcados con @

3- Retorna .T. si encontro el c¢digo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lSekCodMae(cCodEst,cMaeAlu,cMaeAct,lMensaj)

*>>>>PARAMETROS DE LA FUNCION
/*     cCodEst			            // C¢digo del Alumno
       cMaeAlu                              // Maestros Habilitados
       cMaeAct			            // @Alias del maestro del alumno
       lMensaj                              // .T. Mostrar Mensaje */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL lExiste := .F.                 // .T. Existe el c¢digo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF 'JAR' $ cMaeAlu

	   cMaeAct := 'JAR'
	   lExiste := .F.
	   SELECT &cMaeAct
	   IF DBSEEK(cCodEst)
	      lExiste := .T.
	   ELSE
	      cMaeAct := NIL
	   ENDIF

       ENDIF

       IF 'PRI' $ cMaeAlu .AND. !lExiste

	   lExiste := .F.
	   cMaeAct := 'PRI'
	   SELECT &cMaeAct
	   IF DBSEEK(cCodEst)
	      lExiste := .T.
	   ELSE
	      cMaeAct := NIL
	   ENDIF
       ENDIF

       IF 'BTO' $ cMaeAlu .AND. !lExiste

	  lExiste := .F.
	  cMaeAct := 'BTO'
	  SELECT &cMaeAct
	  IF DBSEEK(cCodEst)
	     lExiste := .T.
	  ELSE
	     cMaeAct := NIL
	  ENDIF
       ENDIF

       lMensaj := IF(lMensaj == NIL,.T.,lMensaj)
       IF !lExiste .AND. lMensaj
	  cError('EL CODIGO: '+cCodEst+' NO EXISTE')
       ENDIF
       RETURN lExiste
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: IMPRESION DE CEDULAS A VERIFICAR                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 20/2004 JUE A
       Colombia, Bucaramanga        INICIO: 11:35 AM   MAY 20/2004 JUE

OBJETIVOS:

1- Imprime las c‚dulas que supuestamente estan mal digitadas.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION PrnCedVal(lShared,nModCry,cNomSis,cNomEmp,cNomUsr,;
		   cAnoUsr,cPatSis,cMaeAlu,cJorTxt,FileCfg,cExtCam)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       cNomSis                              // Nombre del Sistema
       cNomEmp                              // Nombre de la Empresa
       cNomUsr                              // Nombre del Usuario
       cAnoUsr				    // A¤o del Sistema
       cPatSis                              // Path del Sistema
       cMaeAlu                              // Maestros Habilitado
       cJorTxt                              // Jornada Escogida
       FileCfg                              // Archivo Configuraci¢n General
       cExtCam                              // Extensi¢n del Campo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"          // Declaraci¢n de Archivos

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL cFecPrn := ''                  // @Fecha de Impresi¢n
       LOCAL cHorPrn := ''                  // @Hora de Impresi¢n
       LOCAL cDiaPrn := ''                  // @D¡a de Impresi¢n
       LOCAL nNroPag := 1                   // N£mero de p gina
       LOCAL lTamAnc := .F.                 // .T. Tama¤o Ancho
       LOCAL nLinTot := 0                   // L¡neas totales de control
       LOCAL nTotReg := 0                   // Total de registros
       LOCAL aCabPrn := {}                  // Encabezado del informe General
       LOCAL aCabeza := {}                  // Encabezado del informe
       LOCAL cCodIni := ''                  // C¢digos de impresi¢n iniciales
       LOCAL cCodFin := ''                  // C¢digos de impresi¢n finales
       LOCAL aNroCol := {}                  // Columnas de impresi¢n
       LOCAL aTitPrn := {}                  // T¡tulos para impresi¢n
       LOCAL aRegPrn := {}                  // Registros para impresi¢n
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
     *ÀVariables de informe

       LOCAL       i := 0                   // Contador
       LOCAL cMaeAct := ''                  // Maestro Actual
       LOCAL cNombre := ''                  // Nombre del Familiar
       LOCAL cNomEst := ''                  // Nombre del Estudiante
       LOCAL lHayAlu := ''                  // .T. Validar los Estudiantes
*>>>>FIN DECLARACION DE VARIABLES

*>>>>AREAS DE TRABAJO
       aUseDbf := {}
       AADD(aUseDbf,{.T.,PathSis+'\'+FileCfg,'CFG',NIL,lSiRed,nModCry})
       AADD(aUseDbf,{.T.,PathSis+'\'+FilePrn,'PRN',NIL,lShared,nModCry})
*>>>>FIN AREAS DE TRABAJO

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbfs(aUseDbf)
	  cError('ABRIENDO ARCHIVOS')
	  CloseAll(aUseDbf)
	  RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       lHayErr := .T.
       DO CASE
       CASE CFG->(RECCOUNT()) == 0
	    cError('NO EXISTE CONFIGURACION GENERAL')

       CASE PRN->(RECCOUNT()) == 0
	    cError('NO EXISTEN IMPRESIORAS GRABADAS')

       OTHERWISE
	    lHayErr :=.F.
       ENDCASE
       IF lHayErr
	  CloseAll(aUseDbf)
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>LOCALIZACION DE LA IMPRESORA
       IF !lLocCodigo('nCodigoPrn','PRN',CFG->nCodigoPrn)
	  cError('NO EXISTE LA IMPRESORA QUE ESTA HABILITADA')
	  CloseAll(aUseDbf)
	  RETURN NIL
       ENDIF
*>>>>FIN LOCALIZACION DE LA IMPRESORA

*>>>>DEFINCION DEL ENCABEZADO
       nNroPag := 0
       lTamAnc := .F.

       nTotReg := 0

       aCabPrn := {cNomEmp,cNomSis,;
		   'A¥O: '+cAnoUsr+' JORNADA: '+cJorTxt,;
		   'CEDULAS A VERIFICAR Y CORREGIR',;
		   ''}

       aCabeza := {aCabPrn[1],aCabPrn[2],aCabPrn[3],aCabPrn[4],aCabPrn[5],;
		   nNroPag++,;
		   cTotPagina(nTotReg),lTamAnc}

       cCodIni := PCL({'DraftOn','Elite','CondenOn'})
       cCodFin := PCL({'NegraOf','DobGolOf'})
*>>>>FIN DEFINCION DEL ENCABEZADO

*>>>>ENCABEZADOS DE COLUMNA
       aNroCol := {06,06,40,40,10,16,20}
       aTitPrn := {'CODIGO','CURSO','ESTUDIANTE','FAMILIAR',;
		   'PARENTESCO','CEDULA','OBSERVACION'}
       cCabCol := cRegPrint(aTitPrn,aNroCol)
*>>>>FIN ENCABEZADOS DE COLUMNA

*>>>>ANALISIS PARA CENTRAR EL INFORME
       nLenPrn := PCL('n17Stan')
       lCentra := .F.
       nColCab := 0
       IF lCentra
	  nColCab := (nLenPrn-LEN(cCabCol))/2
       ENDIF
       aCabSec := NIL
       bPagina := {||lPagina(nLinReg)}
       bCabeza := {||CabezaPrn(cCodIni,aCabeza,cCabCol,;
			       nColCab,cCodFin,aCabSec,;
			       @cFecPrn,@cHorPrn,@cDiaPrn)}
       bDerAut := {||DerechosPrn(cNomSis,cNomEmp,nLenPrn)}
*>>>>FIN ANALISIS PARA CENTRAR EL INFORME

*>>>>ANALISIS DE DECISION
       lHayAlu := lPregunta('VALIDAR EL DOCUMENTO DEL ESTUDIANTE? No Si')
*>>>>FIN ANALISIS DE DECISION

*>>>>ACTIVACION DE LA IMPRESORA
       IF &('CFG->lPrnArc'+cExtCam)
	  SET DEVICE TO PRINT
       ELSE
	  FilePrn := 'valced'
	  nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,;
				 &('CFG->cOpcPrn'+cExtCam),.F.,.T.)
	  IF EMPTY(nOpcPrn)
	     RETURN NIL
	  ENDIF
       ENDIF
       SendCodes(PCL('Reset'))

       EVAL(bCabeza)
      *Impresi¢n del Encabezado

       AADD(aCabPrn,cFecPrn)
       AADD(aCabPrn,cHorPrn)
       AADD(aCabPrn,cDiaPrn)

       nHanXml := CreaFrmPrn(lShared,FilePrn,aNroCol,nOpcPrn,aCabPrn,aTitPrn)
*>>>>FIN ACTIVACION DE LA IMPRESORA

*>>>>FAMILIAS DE LOS MAESTROS HABILITADOS
       FOR i := 1 TO LEN(cMaeAlu)/3

***********AREAS DE TRABAJO
	     cMaeAct := SUBS(cMaeAlu,i*3-2,3)
	     aUseDbf := {}

	     AADD(aUseDbf,{.T.,cPatSis+'\'+cMaeAct+'\'+;
			       FileAlu+cMaeAct+cAnoSis+ExtFile,;
			       cMaeAct,NIL,lShared,nModCry})
***********FIN AREAS DE TRABAJO

***********SELECION DE LAS AREAS DE TRABAJO
	     IF !lUseDbfs(aUseDbf)
		cError('ABRIENDO ARCHIVOS')
		CloseAll(aUseDbf)
		RETURN NIL
	     ENDIF
***********FIN SELECION DE LAS AREAS DE TRABAJO

***********RECORRIDO DEL ARCHIVO
	     SELECT &cMaeAct
	     DO WHILE .NOT. EOF()

*--------------IMPRESION DE LA LINEA DE ESTADO
		 SET DEVICE TO SCREEN
		 LineaEstado('CODIGO:'+&cMaeAct->cCodigoEst+;
			     'ºGRUPO:'+&cMaeAct->cCodigoGru+;
			     'ºREGISTRO:'+;
			      STR(RECNO(),4)+'/'+;
			      STR(RECCOUNT(),4),'')
		 SET DEVICE TO PRINT
*--------------FIN IMPRESION DE LA LINEA DE ESTADO

*--------------IMPRESION DEL ESTUDIANTE
		 cNomEst := RTRIM(&cMaeAct->cApelliEst)+' '+;
			    RTRIM(&cMaeAct->cNombreEst)
		 cNomEst := SUBS(cNomEst+SPACE(40),1,40)

		 IF lHayAlu .AND. !lDocNitOk(&cMaeAct->cDocNitEst)

		    cNombre := ''
		    aRegPrn := {&cMaeAct->cCodigoEst,;
				&cMaeAct->cCodigoGru,;
				cNomEst,;
				cNombre,;
				'ESTUDIANTE',;
				&cMaeAct->cDocNitEst,;
				SPACE(01)}

		    lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
			    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
		 ENDIF
*--------------FIN IMPRESION DEL ESTUDIANTE

*--------------IMPRESION DEL PADRE
		 IF !&cMaeAct->lPadQepEst .AND.;
		    !lDocNitOk(&cMaeAct->cPadNitEst)

		    cNombre := RTRIM(&cMaeAct->cApePadEst)+' '+;
			       RTRIM(&cMaeAct->cNomPadEst)
		    cNombre := SUBS(cNombre+SPACE(40),1,40)

		    aRegPrn := {&cMaeAct->cCodigoEst,;
				&cMaeAct->cCodigoGru,;
				cNomEst,;
				cNombre,;
				'PADRE',;
				&cMaeAct->cPadNitEst,;
				SPACE(01)}

		     lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
			     aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)

		 ENDIF
*--------------FIN IMPRESION DEL PADRE

*--------------IMPRESION DE LA MADRE
		 IF !&cMaeAct->lPadQepEst .AND.;
		    !lDocNitOk(&cMaeAct->cMadNitEst)

		    cNombre := RTRIM(&cMaeAct->cApeMadEst)+' '+;
			       RTRIM(&cMaeAct->cNomMadEst)
		    cNombre := SUBS(cNombre+SPACE(40),1,40)

		    aRegPrn := {&cMaeAct->cCodigoEst,;
				&cMaeAct->cCodigoGru,;
				cNomEst,;
				cNombre,;
				'MADRE',;
				&cMaeAct->cMadNitEst,;
				SPACE(01)}

		     lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
			     aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)

		 ENDIF
*--------------FIN IMPRESION DE LA MADRE

*--------------IMPRESION DEL ACUDIENTE
		 IF !lDocNitOk(&cMaeAct->cAcuNitEst)

		    cNombre := RTRIM(&cMaeAct->cApeAcuEst)+' '+;
				  RTRIM(&cMaeAct->cNomAcuEst)
		    cNombre := SUBS(cNombre+SPACE(40),1,40)

		    aRegPrn := {&cMaeAct->cCodigoEst,;
				&cMaeAct->cCodigoGru,;
				cNomEst,;
				cNombre,;
				'ACUDIENTE',;
				&cMaeAct->cAcuNitEst,;
				SPACE(01)}

		     lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
			     aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)

		 ENDIF
*--------------FIN IMPRESION DEL ACUDIENTE

	       SELECT &cMaeAct
	       DBSKIP()

	     ENDDO
	     CloseDbf(cMaeAct)
***********FIN RECORRIDO DEL ARCHIVO

       NEXT
       CloseDbf(cMaeAct)

       VerPrn(nOpcPrn,FilePrn,nHanXml)
       SET DEVICE TO SCREEN
       RETURN NIL
*>>>>FIN FAMILIAS DE LOS MAESTROS HABILITADOS

/*************************************************************************
* TITULO..: INFORMACION DEL ASPIRANTE                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 02/96 VIE A
       Colombia, Bucaramanga        INICIO: 10:00 PM   FEB 02/96 VIE

OBJETIVOS:

1)- Debe estar en uso el archivo de admisiones en el registro del aspirante

2)- Visualiza la informaci¢n sobre el aspirante

3)- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION InfoAlu(nFilInf,nColInf,cMaeAct,cNomEmp,cNomSis,;
		 cCodEst,cMaeAlu,cNalias,oBrowse)

*>>>>PARAMETROS DE LA FUNCION
/*     nFilInf                              // Fila de Impresi¢n
       nColInf                              // Columna de Impresi¢n
       cMaeAct			            // Maestro Actual
       cNomEmp                              // Nombre de la Empresa
       cNomSis                              // Nombre del sistema
       cCodEst                              // C¢digo del Estudiante
       cMaeAlu                              // Maestros Habilitados
       cNalias                              // Alias del Archivo del Browse
       oBrowse                              // Browse del Archivo */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla

       LOCAL nNroFil := 0                   // Fila de lectura
       LOCAL nNroCol := 0                   // Columna de lectura
       LOCAL aMenus  := {}                  // Vector de declaracion de men£
       LOCAL aAyuda  := {}                  // Vector de ayudas para el men£
       LOCAL nNroOpc := 1                   // N£mero de Opci¢n
       LOCAL cTipCnt := ''                  // Tipo de Contratante
       LOCAL lHayFot := .F.                 // .T. Hay Fotocopia
*>>>>FIN DECLARACION DE VARIABLES

*>>>>MENU DE ACTUALIZACION
       AADD(aMenus,'1<INFORMACION PERSONAL    >')
       AADD(aMenus,'2<INFORMACION FAMILIAR    >')
       AADD(aMenus,'3<INFORMACION CONTRATANTES>')
       AADD(aAyuda,'Consulta la Informaci¢n Personal')
       AADD(aAyuda,'Consulta la Informaci¢n Familiar')
       AADD(aAyuda,'Consulta la Informaci¢n sobre los Contrates')


       nNroOpc := 1
       cSavPan := SAVESCREEN(0,0,24,79)
       nNroOpc := nMenu(aMenus,aAyuda,10,25,'CONSULTAR',NIL,1,.F.)
       RESTSCREEN(0,0,24,79,cSavPan)
       IF nNroOpc == 0
	  RETURN NIL
       ENDIF
*>>>>FIN MENU DE ACTUALIZACION

*>>>>IMPRESION DE LA LINEA DE ESTADO
       cSavPan := SAVESCREEN(0,0,24,79)
       LineaEstado('LICENCIA DE USO A FAVOR DE: '+cNomEmp,cNomSis)
*>>>>FIN IMPRESION DE LA LINEA DE ESTADO

*>>>>BUSQUEDA DEL ESTUDIANTE
       IF !EMPTY(cCodEst)
	  IF !lSekCodMae(cCodEst,cMaeAlu,@cMaeAct,.F.)
	     cError('EL CODIGO '+cCodEst+' DEL ESTUDIANTE NO EXISTE')
	     RETURN NIL
	  ENDIF
       ENDIF
*>>>>FIN BUSQUEDA DEL ESTUDIANTE

*>>>>IMPRESION DEL NOMBRE DEL CANDIDATOS
       nNroFil := nMarco(nFilInf+1,'INFORMACION DEL ESTUDIANTE',22,'°')
       nNroCol := nColInf

       IF nNroOpc == 1
	  @ nNroFil,nNroCol+00 SAY 'CODIGO: '+;
				   IF(cMaeAct == 'ADM',&cMaeAct->cNumeroAdm,;
						       &cMaeAct->cCodigoEst)
	  @ nNroFil,nNroCol+15 SAY 'NOMBRE: '+RTRIM(&cMaeAct->cNombreEst)+' '+;
					      &cMaeAct->cApelliEst
	  @ nNroFil,nNroCol+65 SAY 'CURSO : '+&cMaeAct->cCodigoGru
       ENDIF
*>>>>FIN IMPRESION DEL NOMBRE DEL CANDIDATOS

*>>>>IMPRSION DE LOS TITULOS
       DO CASE
       CASE nNroOpc == 1

	    nNroFil := nFilInf+6
	    @nNroFil,nNroCol+00 SAY 'NACIDO EN: '
	    @nNroFil++,nNroCol+36 SAY 'FECHA:'

	    @nNroFil  ,nNroCol+00 SAY 'DOCUMENTO:'
	    @nNroFil++,nNroCol+36 SAY 'DE:'
	    @nNroFil,nNroCol+00   SAY 'DIRECCION:'
	    @nNroFil  ,nNroCol+37 SAY 'BARRIO:'
	    @nNroFil++,nNroCol+61 SAY 'TELEFONO:'

       CASE nNroOpc == 2

	    nNroFil := nFilInf+3
	    @++nNroFil,nNroCol+00 SAY 'PADRE:'
	    @nNroFil++,nNroCol+42 SAY 'PROFESION:'
	    @nNroFil  ,nNroCol+00 SAY 'DOCUMENTO:'
	    @nNroFil  ,nNroCol+42 SAY 'DE:'
	    @++nNroFil,nNroCol+00 SAY 'EMPRESA:'
	    @nNroFil  ,nNroCol+34 SAY 'CARGO:'
	    @nNroFil++,nNroCol+61 SAY 'TELEFONO:'

	    @++nNroFil,nNroCol+00 SAY 'MADRE:'
	    @nNroFil++,nNroCol+42 SAY 'PROFESION:'
	    @nNroFil  ,nNroCol+00 SAY 'DOCUMENTO:'
	    @nNroFil  ,nNroCol+42 SAY 'DE:'
	    @++nNroFil  ,nNroCol+00 SAY 'EMPRESA:'
	    @nNroFil  ,nNroCol+34 SAY 'CARGO:'
	    @nNroFil++,nNroCol+61 SAY 'TELEFONO:'

	    @++nNroFil,nNroCol+00 SAY 'ACUDIENTE:'
	    @nNroFil  ,nNroCol+42 SAY 'TEL CASA:'
	    @nNroFil++,nNroCol+61 SAY 'TEL OFIC:'
	    @nNroFil  ,nNroCol+00 SAY 'DOCUMENTO:'
	    @nNroFil  ,nNroCol+42 SAY 'DE:'

       CASE nNroOpc == 3  // Contratantes

/*
	    nNroFil := nFilInf+3
	    @++nNroFil,nNroCol+00 SAY 'CONTRATANTE No.1:'

	    nNroFil++
	    @++nNroFil,nNroCol+00 SAY 'CONTRATANTE No.2:'

	    nNroFil++
	    @++nNroFil,nNroCol+00 SAY 'CONTRATANTE No.3:'

	    nNroFil++
	    @++nNroFil,nNroCol+00 SAY 'CONTRATANTE No.4:'
*/

	    nNroFil := nFilInf+3
	    @++nNroFil,nNroCol+00 SAY 'CONTRATANTE No.1:'
	    @++nNroFil,nNroCol+00 SAY 'DOCUMENTO:'

	    nNroFil++
	    @++nNroFil,nNroCol+00 SAY 'CONTRATANTE No.2:'
	    @++nNroFil  ,nNroCol+00 SAY 'DOCUMENTO:'

	    nNroFil++
	    @++nNroFil,nNroCol+00 SAY 'CONTRATANTE No.3:'
	    @++nNroFil  ,nNroCol+00 SAY 'DOCUMENTO:'

	    nNroFil++
	    @++nNroFil,nNroCol+00 SAY 'CONTRATANTE No.4:'
	    @++nNroFil  ,nNroCol+00 SAY 'DOCUMENTO:'


       ENDCASE
*>>>>FIN IMPRSION DE LOS TITULOS

*>>>>IMPRESION DE LOS DATOS
       SET COLOR TO I
       DO CASE
       CASE nNroOpc == 1

	    nNroFil := nFilInf+6
	    @nNroFil  ,nNroCol+10 SAY &cMaeAct->cLugNacEst
	    @nNroFil++,nNroCol+44 SAY &cMaeAct->dFecNacEst

	    @nNroFil  ,nNroCol+10 SAY &cMaeAct->cDocNitEst
	    @nNroFil++,nNroCol+39 SAY &cMaeAct->cLugNitEst
	    @nNroFil,nNroCol+10   SAY &cMaeAct->cDireccEst PICT "@!S25"
	    @nNroFil  ,nNroCol+44 SAY &cMaeAct->cBarrioEst PICT "@!"
	    @nNroFil++,nNroCol+70 SAY &cMaeAct->cTelefnEst PICT "@!S7"

       CASE nNroOpc == 2

	    nNroFil := nFilInf+3
	    @++nNroFil,nNroCol+07 SAY ALLTRIM(&cMaeAct->cNomPadEst)+' '+;
				      ALLTRIM(&cMaeAct->cApePadEst) PICT "@!S34"
	    @nNroFil++,nNroCol+52 SAY &cMaeAct->cProPadEst PICT "@!"
	    @nNroFil  ,nNroCol+10 SAY &cMaeAct->cPadNitEst PICT "@!"
	    @nNroFil++,nNroCol+45 SAY &cMaeAct->cPadLugEst PICT "@!"
	    @nNroFil  ,nNroCol+08 SAY &cMaeAct->cEmpPadEst PICT "@!"
	    @nNroFil  ,nNroCol+40 SAY &cMaeAct->cCarPadEst PICT "@!"
	    @nNroFil++,nNroCol+70 SAY &cMaeAct->cTelPadEst PICT "@!S7"

	    @++nNroFil,nNroCol+07 SAY ALLTRIM(&cMaeAct->cNomMadEst)+' '+;
				      ALLTRIM(&cMaeAct->cApeMadEst) PICT "@!S34"
	    @nNroFil++,nNroCol+52 SAY &cMaeAct->cProMadEst PICT "@!"
	    @nNroFil  ,nNroCol+10 SAY &cMaeAct->cMadNitEst PICT "@!"
	    @nNroFil++,nNroCol+45 SAY &cMaeAct->cMadLugEst PICT "@!"
	    @nNroFil  ,nNroCol+08 SAY &cMaeAct->cEmpMadEst PICT "@!"
	    @nNroFil  ,nNroCol+40 SAY &cMaeAct->cCarMadEst PICT "@!"
	    @nNroFil++,nNroCol+70 SAY &cMaeAct->cTelMadEst PICT "@!S7"

	    @++nNroFil,nNroCol+10 SAY &cMaeAct->cNomAcuEst PICT "@!S30"
	    @nNroFil  ,nNroCol+52 SAY &cMaeAct->cTe1AcuEst PICT "@!S7"
	    @nNroFil++,nNroCol+70 SAY &cMaeAct->cTe2AcuEst PICT "@!S7"
	    @nNroFil  ,nNroCol+10 SAY &cMaeAct->cAcuNitEst PICT "@!"
	    @nNroFil  ,nNroCol+45 SAY &cMaeAct->cAcuLugEst PICT "@!"

       CASE nNroOpc == 3

/*
	    nNroFil := nFilInf+3
	    @++nNroFil,nNroCol+18 SAY &cMaeAct->cNitCo1Est

	    nNroFil++
	    @++nNroFil,nNroCol+18 SAY &cMaeAct->cNitCo2Est

	    nNroFil++
	    @++nNroFil,nNroCol+18 SAY &cMaeAct->cNitCo3Est

	    nNroFil++
	    @++nNroFil,nNroCol+18 SAY &cMaeAct->cNitCo4Est
*/

	    nTipPerMae(&cMaeAct->cNitCo1Est,;
		       &cMaeAct->cPadNitEst,;
		       &cMaeAct->cMadNitEst,;
		       @cTipCnt)

	    nNroFil := nFilInf+3
	    @++nNroFil,nNroCol+18 SAY cTipCnt+': '+;
				  cLocCntrt(cMaeAct,'C1NOM')
	    @++nNroFil,nNroCol+11 SAY cLocCntrt(cMaeAct,'C1DOC',@lHayFot)+;
				  ' FOTOCOPIA: '+;
				  IF(lHayFot,'SI','NO')


	    nTipPerMae(&cMaeAct->cNitCo2Est,;
		       &cMaeAct->cPadNitEst,;
		       &cMaeAct->cMadNitEst,;
		       @cTipCnt)

	    nNroFil++
	    @++nNroFil,nNroCol+18 SAY cTipCnt+': '+;
				  cLocCntrt(cMaeAct,'C2NOM')
	    @++nNroFil,nNroCol+11 SAY cLocCntrt(cMaeAct,'C2DOC',@lHayFot)+;
				  ' FOTOCOPIA: '+;
				  IF(lHayFot,'SI','NO')

	    nTipPerMae(&cMaeAct->cNitCo3Est,;
		       &cMaeAct->cPadNitEst,;
		       &cMaeAct->cMadNitEst,;
		       @cTipCnt)

	    nNroFil++
	    @++nNroFil,nNroCol+18 SAY cTipCnt+': '+;
				  cLocCntrt(cMaeAct,'C3NOM')
	    @++nNroFil,nNroCol+11 SAY cLocCntrt(cMaeAct,'C3DOC',@lHayFot)+;
				  ' FOTOCOPIA: '+;
				  IF(lHayFot,'SI','NO')

	    nTipPerMae(&cMaeAct->cNitCo3Est,;
		       &cMaeAct->cPadNitEst,;
		       &cMaeAct->cMadNitEst,;
		       @cTipCnt)

	    nNroFil++
	    @++nNroFil,nNroCol+18 SAY cTipCnt+': '+;
				  cLocCntrt(cMaeAct,'C4NOM')
	    @++nNroFil,nNroCol+11 SAY cLocCntrt(cMaeAct,'C4DOC',@lHayFot)+;
				  ' FOTOCOPIA: '+;
				  IF(lHayFot,'SI','NO')


       ENDCASE
       SET COLOR TO

       cPausa()
       RESTSCREEN(0,0,24,79,cSavPan)

       IF !EMPTY(cCodEst)
	  SELECT &cNalias
	  oBrowse:FORCESTABLE()
       ENDIF
       RETURN NIL
*>>>>FIN IMPRESION DE LOS DATOS

/*************************************************************************
* TITULO..: BUSCAR EL CODIGO DEL ESTUDIANTE                              *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 02/1994 VIE A
       Colombia, Bucaramanga        INICIO: 10:00 PM   FEB 02/1994 VIE

OBJETIVOS:

1- Debe estar en uso los archivos de Alumnos

2- Busca el c¢digo del Estudiante

3- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION BuscarAlu(lShared,oBrowse,cMaeAct,cAnoSis,cIntUno)

*>>>>PARAMETROS DE LA FUNCION
/*     lShared                              // .T. Archivos Compartidos
       oBrowse				    // Browse del Archivo
       cMaeAct				    // Maestro Actual
       cAnoSis                              // A¤o del sistema
       cIntUno			            // Path de la contabilidad */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"          // Declaraci¢n de Archivos

       LOCAL nNroFil := 0                   // Fila de lectura
       LOCAL nNroCol := 0                   // Columna de lectura
       LOCAL nRegEst := 0                   // Registro del Pago
       LOCAL nColLin := 0                   // Columna de lectura de linea
       LOCAL nTecPul := 0                   // Tecla pulsada
       LOCAL nLenCam := 0                   // Longitud de campo a leer

       LOCAL aMenus  := {}                  // Declaracion de Menus
       LOCAL nNroOpc := 1                   // N£mero de Opci¢n
       LOCAL GetList := {}                  // Variable del sistema

       LOCAL cCodigoTes := ''               // C¢digo del estudiante
*>>>>FIN DECLARACION DE VARIABLES

*>>>>SELECCION DEL METODO DE BUSQUEDA
       aMenus := {'1<POR APELLIDO>',;
		  '2<POR NOMBRE  >',;
		  '3<POR CODIGO  >'}
       SAVE SCREEN
       nNroOpc := nMenu(aMenus,NIL,09,30,'BUSQUEDA',NIL,1,.F.)
       IF nNroOpc == 0
	  oBrowse:REFRESHALL()
	  oBrowse:FORCESTABLE()
	  RETURN NIL
       ENDIF
       RESTORE SCREEN
*>>>>FIN SELECCION DEL METODO DE BUSQUEDA

*>>>>ACTIVACION DE LOS INDICES
       SELECT &cMaeAct
       DO CASE
       CASE 'JAR' $ cMaeAct
	    DO CASE
	    CASE nNroOpc == 1
		 fNtxAlu := cIntUno+'\JAR\'+Ntx1Jar+cAnoSis+cExtNtx
	    CASE nNroOpc == 2
		 fNtxAlu := cIntUno+'\JAR\'+Ntx2Jar+cAnoSis+cExtNtx

	    CASE nNroOpc == 3
		 fNtxAlu := cIntUno+'\JAR\'+fNtxJar+cAnoSis+cExtNtx
	    ENDCASE

       CASE 'PRI' $ cMaeAct
	    DO CASE
	    CASE nNroOpc == 1
		 fNtxAlu := cIntUno+'\PRI\'+Ntx1Pri+cAnoSis+cExtNtx

	    CASE nNroOpc == 2
		 fNtxAlu := cIntUno+'\PRI\'+Ntx2Pri+cAnoSis+cExtNtx

	    CASE nNroOpc == 3
		 fNtxAlu := cIntUno+'\PRI\'+fNtxPri+cAnoSis+cExtNtx
	    ENDCASE

       CASE 'BTO' $ cMaeAct
	    DO CASE
	    CASE nNroOpc == 1
		 fNtxAlu := cIntUno+'\BTO\'+Ntx1Bto+cAnoSis+cExtNtx

	    CASE nNroOpc == 2
		 fNtxAlu := cIntUno+'\BTO\'+Ntx2Bto+cAnoSis+cExtNtx

	    CASE nNroOpc == 3
		 fNtxAlu := cIntUno+'\BTO\'+fNtxBto+cAnoSis+cExtNtx
	    ENDCASE
       ENDCASE
       DBCLEARIND()
       IF lShared
	  DBSETINDEX(fNtxAlu)
       ELSE
	  SET INDEX TO (fNtxAlu)
       ENDIF
       GO TOP
       oBrowse:GOTOP()
       oBrowse:REFRESHALL()
       oBrowse:FORCESTABLE()
*>>>>FIN ACTIVACION DE LOS INDICES

*>>>>IMPRESION DEL TITULO DE BUSQUEDA
       SET CURSOR ON
       DO CASE
       CASE nNroOpc == 1
	    nLenCam := LEN(cSpaces(cMaeAct,"cApelliEst"))
	    TitBuscar(nLenCam,@nNroFil,@nNroCol,'ENTRE EL APELLIDO:')

       CASE nNroOpc == 2
	    nLenCam := LEN(cSpaces(cMaeAct,"cNombreEst"))
	    TitBuscar(nLenCam,@nNroFil,@nNroCol,'ENTRE EL NOMBRE:')

       CASE nNroOpc == 3
	    nLenCam := LEN(cSpaces(cMaeAct,"cCodigoEst"))
	    TitBuscar(nLenCam,@nNroFil,@nNroCol)

       ENDCASE
       nColLin := nNroCol
*>>>>FIN IMPRESION DEL TITULO DE BUSQUEDA

*>>>>BUSQUEDA DEL REGISTRO
       DO WHILE .T.

**********IMPRESION DEL TITULO DE BUSQUEDA
	    DO CASE
	    CASE nNroOpc == 1
		 TitBuscar(nLenCam,@nNroFil,@nNroCol,'ENTRE EL APELLIDO:')
		 SET COLOR TO I
		 @nNroFil,nNroCol SAY cCodigoTes+;
				      SPACE(nLenCam-LEN(cCodigoTes))
		 SET COLOR TO

	    CASE nNroOpc == 2
		 TitBuscar(nLenCam,@nNroFil,@nNroCol,'ENTRE EL NOMBRE:')
		 SET COLOR TO I
		 @nNroFil,nNroCol SAY cCodigoTes+;
				      SPACE(nLenCam-LEN(cCodigoTes))
		 SET COLOR TO

	    CASE nNroOpc == 3
		 TitBuscar(nLenCam,@nNroFil,@nNroCol)
		 SET COLOR TO I
		 @nNroFil,nNroCol SAY cCodigoTes+;
				      SPACE(nLenCam-LEN(cCodigoTes))
		 SET COLOR TO

	    ENDCASE
**********FIN IMPRESION DEL TITULO DE BUSQUEDA

**********LECTURA DEL CARACTER
	    nTecPul := nLeeChr(nNroFil,nColLin)
	    IF nTecPul == 27 .OR. nTecPul == 13 .OR. LEN(cCodigoTes) == nLenCam
	       EXIT
	    ENDIF
	    cCodigoTes += CHR(nTecPul)
	    nColLin++
**********FIN LECTURA DEL CARACTER

**********BUSQUEDA DEL CODIGO
	    SELECT &cMaeAct
	    nRegEst := RECNO()
	    IF lSekCodMae(cCodigoTes,cMaeAct,cMaeAct,.F.)
	       nRegEst := RECNO()
	    ENDIF
	    GO TOP
	    oBrowse:GOTOP()
	    GO nRegEst
	    oBrowse:FORCESTABLE()
**********FIN BUSQUEDA DEL CODIGO

       ENDDO
       oBrowse:REFRESHALL()
       oBrowse:FORCESTABLE()
       RETURN NIL
*>>>>FIN BUSQUEDA DEL REGISTRO

/*************************************************************************
* TITULO..: SELECCION DEL MAESTRO ACTUAL                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ABR 26/2001 JUE A
       Colombia, Bucaramanga        INICIO: 01:00 PM   ABR 26/2001 JUE

OBJETIVOS:

1- Seleciona el Alias de acuerdo al nivel

2- Retorna retorna el alias del nivel

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cMaeAct(cCodEst,cMaeAlu)

*>>>>PARAMETROS DE LA FUNCION
/*     cCodEst := ''                      // C¢digo del Estudiante
       cMaeAlu := ''                      // Maestros Habilitados */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL cMaeAct := ''                 // Maestro Actual
*>>>>FIN DECLARACION DE VARIABLES

*>>>>BUSQUEDA DEL ESTUDIANTE
       lSekCodMae(cCodEst,cMaeAlu,@cMaeAct,.F.)
       RETURN cMaeAct
*>>>>FIN SELECCION DEL MAESTRO ACTUAL

/*************************************************************************
* TITULO..: SELECCION DEL MAESTRO ACTUAL DEL GRADO                       *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 26/2007 MIE A
       Colombia, Bucaramanga        INICIO: 05:30 PM   SEP 26/2007 MIE

OBJETIVOS:

1- Seleciona el Alias de acuerdo al Grado

2- Retorna retorna el alias del nivel

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cMaeActNiv(cCodNiv)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodNiv                              // C¢digo del nivel */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cMaeAct := ''                  // Maestro Actual
*>>>>FIN DECLARACION DE VARIABLES

*>>>>SELECCION DE MAESTRO ACTUAL
       DO CASE
       CASE VAL(cCodNiv) >= 0 .AND. VAL(cCodNiv) <= 5
	    cMaeAct := 'PRI'

       CASE VAL(cCodNiv) >= 6 .AND. VAL(cCodNiv) <= 11
	    cMaeAct := 'BTO'

       CASE VAL(cCodNiv) >= 12 .AND. VAL(cCodNiv) <= 16
	    cMaeAct := 'JAR'
       ENDCASE
       RETURN cMaeAct
*>>>>FIN SELECCION DE MAESTRO ACTUAL

/*************************************************************************
* TITULO..: DEUDA DEL ESTUDIANTE                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 17/2004 LUN A
       Colombia, Bucaramanga        INICIO: 08:00 AM   JUN 17/2004 LUN

OBJETIVOS:

1- Devuelve la deuda del Estudiante

2- Retorna de la Deuda del Estudiante


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nDeudaEst(lShared,cAnoUsr,PathCar,cCodEst,cCodGru)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // Archivos Compartidos
       cAnoUsr                              // A¤o del Usuario
       PathCar                              // Path de la Cartera
       cCodEst                              // C¢digo del Estudiante
       cCodGru                              // C¢digo del Grupo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL nModCry := 0                   // Modo de Protecci¢n
       LOCAL FileCli := ''                  // Archivo de Clientes
       LOCAL nSdoEst := 0                   // Saldo del Estudiante
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL PATH
       IF EMPTY(PathCar)
	  RETURN -1
       ENDIF
*>>>>FIN VALIDACION DEL PATH

*>>>>PREPARACION DE LAS VARIABLES DE ARCHIVO
       FileCli := PathCar+'\CLIENTES\CL'+;
			   cCodGru+cAnoSis+'.DAT'
*>>>>FIN PREPARACION DE LAS VARIABLES DE ARCHIVO

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbf(.T.,FileCli,'CLI',NIL,lShared,nModCry)
	  cError('ABRIENDO LOS ARCHIVOS DE CLIENTES')
	  CloseDbf('CLI')
	  RETURN -2
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       lHayErr := .T.
       DO CASE
       CASE CLI->(RECCOUNT()) == 0
       OTHERWISE
	    lHayErr :=.F.
       ENDCASE
       IF lHayErr
	  CloseDbf('CLI')
	  RETURN -3
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>LOCALIZACION DEL ESTUDIANTE
       IF !lLocCodigo('cCodigoEst','CLI',cCodEst)
	  CloseDbf('CLI')
	  RETURN -4
       ENDIF
*>>>>FIN LOCALIZACION DEL ESTUDIANTE

*>>>>LECTURA DEL SALDO ACTUAL
       nSdoEst := CLI->nSdoActCli+CLI->nSdoMorCli
       CloseDbf('CLI')
       RETURN nSdoEst
*>>>>FIN LECTURA DEL SALDO ACTUAL

/*************************************************************************
* TITULO..: LECTURA DEL TIPO DE PERSONA                                  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 16/2004 VIE A
       Bucaramanga, Colombia	    INICIO: 07:30 PM   JUL 16/2004 VIE

OBJETIVOS:

1- Determina si el contrante es el padre, la madre, el acudiente, o otra
   persona.

2- Retorna el tipo de persona que figura como contratante.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nTipPerMae(cDocNit,cPadNit,cMadNit,cTxtTip)

*>>>>DESCRIPCION DE PARAMETROS
/*     cDocNit                              // Documento de Identidad
       cPadNit                              // Documento del Padre
       cMadNit                              // Documento de la Madre
       cTxtTip                              // @Descripcion del tipo de contratante */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nTipPer := 0                   // Tipo de Persona
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DE LA CEDULA
       cTxtTip := ''
       IF EMPTY(cDocNit)
	  RETURN nTipPer
       ENDIF
*>>>>FIN VALIDACION DE LA CEDULA

*>>>>ANALISIS DE DECISION
       IF cDocNit == cPadNit                // Padre
	  nTipPer := 1
	  cTxtTip := 'PADRE'
       ELSE
	  IF cDocNit == cMadNit             // Madre
	     nTipPer := 2
	     cTxtTip := 'MADRE'
	  ELSE
	     nTipPer := 3                  // Otra Persona
	     cTxtTip := 'OTRA PERSONA'
	  ENDIF
       ENDIF
       RETURN nTipPer
*>>>>ANALISIS DE DECISION

/*************************************************************************
* TITULO..: ESTUDIANTE CON CONCEPTOS INDIVIDUALES                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 19/2008 JUE A
       Colombia, Bucaramanga        INICIO: 10:30 AM   JUN 19/2008 JUE

OBJETIVOS:

1- Busca los estudiantes que tienen asignandos conceptos individuales.

2- Deben estar en uso todos los maeestros de estudiantes habilitados.

3- Retorna un vector con la informaci¢n.


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aConcepEst(cMaeAct)

*>>>>DESCRIPCION DE PARAMETROS
/*     cMaeAct                              // Maestro Actual */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador

       LOCAL cCodEst := ''                  // C¢digo del Estudiante
       LOCAL cNomEst := ''                  // Nombre del Estudiante
       LOCAL cApeEst := ''                  // Apellido del Estudiante
       LOCAL cCodGru := ''                  // C¢digo del Grupo
       LOCAL lRetEst := .F.                 // .T. Estudiante Retirado
       LOCAL cConcep := ''                  // Conceptos del Estudiante

       LOCAL cCodCon := ''                  // C¢digo del Concepto
       LOCAL cNomCon := ''                  // Nombre del Concepto
       LOCAL nIniCoE := ''                  // Mes Inicial por facturar
       LOCAL nFinCoE := ''                  // Mes Final por facturar
       LOCAL cPagCoE := ''                  // Meses pagados

       LOCAL aConcep := {}                  // Conceptos del Estudiante
       LOCAL aConce1 := {}                  // Conceptos del Estudiante

       LOCAL aTotFac := {}                  // Total conceptos facturados
       LOCAL aConFac := {}                  // Conceptos facturados

       LOCAL aTotCon := {}                  // Total Conceptos
       LOCAL aEstCon := {}                  // Estudiante con Conceptos

       LOCAL aTotCoE := {}                  // Conceptos del Estudiante
       LOCAL aEstCoE := {}                  // Conceptos del Estudiante
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DEL CONCEPTO
       cCodEst := &cMaeAct->cCodigoEst

       IF EMPTY(&cMaeAct->cConcepEst)
	  SELECT COE
	  COE->(DBGOTOP())
	  LOCATE FOR COE->cCodigoEst == cCodEst
	  IF .NOT. COE->(FOUND())
	     RETURN aConcep
	  ENDIF
       ENDIF
*>>>>FIN LOCALIZACION DEL CONCEPTO

*>>>>DETALLES DEL ESTUDIANTE
       cCodGru := &cMaeAct->cCodigoGru
       cNomEst := &cMaeAct->cNombreEst
       cApeEst := &cMaeAct->cApelliEst
       lRetEst := &cMaeAct->lRetiroEst
       cConcep := &cMaeAct->cConcepEst

       aConcep := {}
       AADD(aConcep,{'cCodEst',cCodEst})
       AADD(aConcep,{'cCodGru',cCodGru})
       AADD(aConcep,{'cNomEst',cNomEst})
       AADD(aConcep,{'cApeEst',cApeEst})
       AADD(aConcep,{'lRetEst',lRetEst})
       AADD(aConcep,{'cConcep',cConcep})

       aTotFac := aTotConFac(cCodEst)
       AADD(aConcep,{'aTotFac',aTotFac})
*>>>>DETALLES DEL ESTUDIANTE

*>>>>CONCEPTOS INDIVIDUALES
       FOR i := 1 TO LEN(ALLTRIM(cConcep))/2

***********LOCALIZACION DEL CONCEPTO
	     cCodCon := SUBS(cConcep,i*2-1,2)

	     cNomCon := cCodCon+' NO EXISTE'
	     IF lLocCodigo('cCodigoCon','CON',cCodCon)
		cNomCon := CON->cNombreCon
	     ENDIF
***********FIN LOCALIZACION DEL CONCEPTO

***********CONCEPTOS DEL ESTUDIANTE
	     aEstCon := {}
	     AADD(aEstCon,{'cCodCon',cCodCon})
	     AADD(aEstCon,{'cNomCon',cNomCon})

	     AADD(aTotCon,aEstCon)
***********FIN CONCEPTOS DEL ESTUDIANTE

***********CONCEPTOS INDIVIDUALES
	     IF !lLocatePrm(aConce1,'cCodCon',cCodCon)
		AADD(aConce1,{'cCodCon',cCodCon})
	     ENDIF
***********FIN CONCEPTOS INDIVIDUALES

       ENDFOR
       AADD(aConcep,{'aTotCon',aTotCon})
*>>>>FIN CONCEPTOS INDIVIDUALES

*>>>>CONCEPTOS FACTURADOS
       aTotFac := aTotConFac(cCodEst)
       FOR i := 1 TO LEN(aTotFac)
	   aConFac := aTotFac[i]
	   cCodCon := xPrm(aConFac,'cCodCon')

	   IF !lLocatePrm(aConce1,'cCodCon',cCodCon)
	      AADD(aConce1,{'cCodCon',cCodCon})
	   ENDIF

       ENDFOR
*>>>>FIN CONCEPTOS FACTURADOS

*>>>>CONCEPTOS POR ESTUDIANTES
       FOR i := 1 TO LEN(aConce1)

	   cCodCon := aConce1[i,2]

***********LOCALIZACION DEL CONCEPTO
	     cNomCon := cCodCon+' NO EXISTE'
	     IF lLocCodigo('cCodigoCon','CON',cCodCon)
		cNomCon := CON->cNombreCon
	     ENDIF
***********FIN LOCALIZACION DEL CONCEPTO

***********LOCALIZACION DEL CONCEPTO
	     SELECT COE
	     COE->(DBGOTOP())
	     LOCATE FOR COE->cCodigoEst == cCodEst .AND.;
			COE->cCodigoCon == cCodCon

	     IF .NOT. COE->(FOUND())
		LOOP
	     ENDIF
***********FIN LOCALIZACION DEL CONCEPTO

***********CONCEPTOS POR FACTURAR
	     cCodCon := COE->cCodigoCon
	     nIniCoE := COE->nMesIniPag
	     nFinCoE := COE->nMesFinPag
	     cPagCoE := COE->cMesPagCli

	     aEstCoE := {}
	     AADD(aEstCoE,{'cCodCon',cCodCon})
	     AADD(aEstCoE,{'cNomCon',cNomCon})
	     AADD(aEstCoE,{'nIniCoE',nIniCoE})
	     AADD(aEstCoE,{'nFinCoE',nFinCoE})
	     AADD(aEstCoE,{'cPagCoE',cPagCoE})

	     AADD(aTotCoE,aEstCoE)
***********CONCEPTOS POR FACTURAR

       ENDFOR
       AADD(aConcep,{'aTotCoE',aTotCoE})
       RETURN aConcep
*>>>>FIN CONCEPTOS POR ESTUDIANTES

/*************************************************************************
* TITULO DEL PROGRAMA..: ENCONTRAR EL NOMBRE DEL ALUMNO                  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 27/94 LUN A
						       JUN 27/94 LUN
OBJETIVOS:

1- Deben estar en uso los maestros habilitados

2- Permite encontrar el nombre del estudiante dentro de los archivos
   de Bachillerato,Primari,Jardin

3- Si el nombre del estudiante se incluye en un browse de debe pasar
   el Alias del Archivo del Browse

4- Retorna el nombre del Estudiante

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cSekNomAlu(cCodEst,cMaeAlu,cAlias,lMensaj)

*>>>>PARAMETROS DE LA FUNCION
/*     cCodEst                                // C¢digo del Estudiante
       cMaeAlu				      // Maestros habilitados
       cAlias                                 // Alias diferente al maestro
       lMensaj                              // .T. Mostrar Mensaje */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL cNalias := ''                    // Alias del maestro

       LOCAL cNombreTes := ''                 // Nombre del estudiante
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS SI EL ESTUDIANTE ESTA RETIRADO
       IF lSekCodMae(cCodEst,cMaeAlu,@cNalias,lMensaj)
	  cNombreTes := &cNalias->cCodigoGru+' '+;
			RTRIM(&cNalias->cApelliEst)+' '+;
			RTRIM(&cNalias->cNombreEst)
	  IF &cNalias->lRetiroEst
	     cNombreTes := 'RETIRADO '+cNombreTes
	  ENDIF

       ELSE
	  cNombreTes := 'ALUMNO NO EXISTE'
       ENDIF
       IF cAlias # NIL
	  SELECT &cAlias
       ENDIF
       RETURN cNombreTes
*>>>>FIN ANALISIS SI EL ESTUDIANTE ESTA RETIRADO

/*************************************************************************
* TITULO..: LOCALIZAR LOS CONTRATANTES                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 16/2004 JUE A
       Colombia, Bucaramanga        INICIO: 04:00 PM   SEP 16/2004 JUE

OBJETIVOS:

1- Permite localizar todos los contratantes del estudiante.

2- Retorna un vector con los nombres de los contratantes.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aCntrtnts(cMaeAct)

*>>>>DESCRIPCION DE PARAMETROS
/*     cMaeAct                              // Maestro Actual */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL cDocNit := ''                  // Documento del Contrante
       LOCAL cTipNit := ''                  // Tipo de Documento
       LOCAL cLugDoc := ''                  // Lugar del Documento
       LOCAL cNombre := ''                  // Nombres
       LOCAL cApelli := ''                  // Apellidos
       LOCAL lHayFot := .F.                 // Hay Fotocopia

       LOCAL nTipPer := 0                   // Tipo de Persona
       LOCAL aDatCnt := {}                  // Datos del Contratante
*>>>>FIN DECLARACION DE VARIABLES

*>>>>RECORRIDO POR LOS CONTRATANTES
       FOR i := 1 TO 4

***********ANALISIS DEL CONTRATANTE
	     cDocNit := &(cMaeAct+'->cNitCo'+STR(i,1)+'Est')
	     cTipNit := &(cMaeAct+'->cTipCo'+STR(i,1)+'Est')

	     nTipPer := nTipPerMae(cDocNit,;
				   &cMaeAct->cPadNitEst,;
				   &cMaeAct->cMadNitEst)
***********FIN ANALISIS DEL CONTRATANTE

**********LECTURA DATOS DE LOS CONTRATANTES
	    DO CASE
	    CASE nTipPer == 1  // Padre

		 cNombre := ALLTRIM(&cMaeAct->cNomPadEst)
		 cApelli := ALLTRIM(&cMaeAct->cApePadEst)
		 cLugDoc := ALLTRIM(&cMaeAct->cPadLugEst)
		 lHayFot := &cMaeAct->lPadFotEst

	    CASE nTipPer == 2  // Madre

		 cNombre := ALLTRIM(&cMaeAct->cNomMadEst)
		 cApelli := ALLTRIM(&cMaeAct->cApeMadEst)
		 cLugDoc := ALLTRIM(&cMaeAct->cMadLugEst)
		 lHayFot := &cMaeAct->lMadFotEst

	    CASE nTipPer == 3  // Otra Persona

		 IF lLocNitPer(cDocNit,cTipNit)

		    cNombre := ALLTRIM(PER->cNomUnoPer)+' '+;
			       ALLTRIM(PER->cNomDosPer)

		    cApelli := ALLTRIM(PER->cApeUnoPer)+' '+;
			       ALLTRIM(PER->cApeDosPer)

		    cLugDoc := ALLTRIM(PER->cLugNitPer)

		    lHayFot := PER->lFotNitPer

		 ENDIF
	    ENDCASE
**********FIN LECTURA DATOS DE LOS CONTRATANTES

**********GRABACION DEL CONTRATANTE
	    IF !EMPTY(cDocNit)
	       cNombre := ALLTRIM(cNombre+' '+ALLTRIM(cApelli))
	       AADD(aDatCnt,{STR(i,1),;
			     ALLTRIM(cDocNit),;
			     cTipNit,;
			     cNombre,;
			     cLugDoc,;
			     lHayFot})
	    ENDIF
**********FIN GRABACION DEL CONTRATANTE

       NEXT
       RETURN aDatCnt
*>>>>FIN RECORRIDO POR LOS CONTRATANTES

/*************************************************************************
* TITULO..: LOCALIZAR LOS CONTRATANTES                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 16/2004 JUE A
       Colombia, Bucaramanga        INICIO: 04:00 PM   SEP 16/2004 JUE

OBJETIVOS:

1- Permite localizar todos los contratantes del estudiante.

2- Retorna un vector con los nombres de los contratantes.

SINTAXIS:

cLocCntrt(cMaeAct,'C1DOC')  // C1DOC,C1TIP,C1NOM

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cLocCntrt(cMaeAct,cCampo,lHayFot,aDatCnt)

*>>>>DESCRIPCION DE PARAMETROS
/*     cMaeAct                              // Maestro Habilitado
       cCampo                               // Campo del Contratante
       lHayFot                              // @ .T. Hay Fotocopia
       aDatCnt                              // Datos del Contratante */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 1                   // Contador
       LOCAL cDatCnt := ''                  // Dato del Contratante
       LOCAL nNroCnt := 0                   // N£mero del Contrante
       LOCAL nNroCol := 0                   // N£mero de Columna
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DE LOS DATOS DEL CONTRATANTE
       IF aDatCnt == NIL
	  aDatCnt := aCntrtnts(cMaeAct)
	  IF EMPTY(aDatCnt)
	     RETURN ''
	  ENDIF
       ENDIF
*>>>>FIN LOCALIZACION DE LOS DATOS DEL CONTRATANTE

*>>>>VALIDACION DE NUMERO DE CONTRATANTE
       nNroCnt := SUBS(cCampo,2,1)
       IF VAL(nNroCnt) > LEN(aDatCnt)
	  RETURN ''
       ENDIF
*>>>>FIN VALIDACION DE NUMERO DE CONTRATANTE

*>>>>ANALISIS DEL CONTRATANTE
       DO CASE
       CASE 'DOC' $ cCampo
	    nNroCol := 2

       CASE 'TIP' $ cCampo
	    nNroCol := 3

       CASE 'NOM' $ cCampo
	    nNroCol := 4

       CASE 'LUG' $ cCampo
	    nNroCol := 5

       ENDCASE
*>>>>FIN ANALISIS DEL CONTRATANTE

*>>>>BUSQUEDA DEL CONTRANTE
       lHayFot := .F.
       FOR i := 1 TO LEN(aDatCnt)
	   IF aDatCnt[i,1] == nNroCnt .AND. nNroCol # 0
	      cDatCnt := aDatCnt[i,nNroCol]
	      lHayFot := aDatCnt[i,6]
	   ENDIF
       NEXT
       RETURN cDatCnt
*>>>>FIN BUSQUEDA DEL CONTRANTE

/*************************************************************************
* TITULO..: GRABACION DE LOS CONTRATANTES                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 16/2004 VIE A
       Bucaramanga, Colombia	    INICIO: 02:00 PM   JUL 17/2004 DOM

OBJETIVOS:

1- Graba y actualiza la informaci¢n de los contratantes
   persona.

2- Retorna el documento digitado.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cGraFirCon(lShared,cNomUsr,nFirCon,cCodEst,cNomEst,cCodGru,;
		    cMaeAct,lHayLec,aDatCnt)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos
       cNomUsr                              // Nombre del Usuario
       nFirCon                              // N£mero del Contrante
       cCodEst                              // C¢digo del Estudiante
       cNomEst                              // Nombre del Estudiante
       cCodGru                              // Codigo del Grupo
       cMaeAct                              // Maestro Actual
       lHayLec                              // .T. Solo Leer Contrantes
       aDatCnt                              // Datos del Contratante */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroFil := 3                   // N£mero de la fila
       LOCAL nNroCol := 1                   // N£mero de la Columna
       LOCAL nFilIni := 0                   // Fila Inicial
       LOCAL lGrabar := .T.                 // .T. Grabar el registro
       LOCAL lInsReg := .F.                 // .T. Insertar el Registro

       LOCAL lSiQepd := .F.                 // .T. Fallecido
       LOCAL cTxtTip := ''                  // Descripci¢n del Contratante
       LOCAL nTipPer := 0                   // Tipo de Persona

       LOCAL cDocNit := ''                  // Documento del Contrante
       LOCAL cTipNit := ''                  // Tipo de Documento
       LOCAL cLugNit := ''                  // Lugar de Nacimiento
       LOCAL lFotNit := .F.                 // .T. Hay Fotocopia
       LOCAL cFotNit := SPACE(01)           // S=> Hay Fotocopia

       LOCAL cNombre := ''                  // Nombres
       LOCAL cApelli := ''                  // Apellidos
       LOCAL cApeUno := ''                  // Primer Apellido
       LOCAL cApeDos := ''                  // Apellido Dos
       LOCAL cNomUno := ''                  // Primer Nombre
       LOCAL cNomDos := ''                  // Segundo Nombre

       LOCAL dFecNac := CTOD('00/00/00')    // Fecha de Nacimiento
       LOCAL cLugNac := ''                  // Lugar de Nacimiento

       LOCAL cDirecc := ''                  // Direcci¢n de la Casa
       LOCAL cCiuDir := ''                  // Ciudad de la Direcci¢n
       LOCAL cTelefn := ''                  // Telefono

       LOCAL cDirEnv := ''                  // Direccion para la Correspondencia
       LOCAL cCiuEnv := ''                  // Ciudad para la Correspondencia

       LOCAL cTelTra := ''                  // Telefono del Trabajo
       LOCAL cCiuTra := ''                  // Ciudad del Trabajo

       LOCAL cEstrat := ''                  // Estrato
       LOCAL cSexFem := ''                  // Sexo de la Persona
       LOCAL lSexFem := .F.                 // Sexo de la Persona

       LOCAL GetList := {}                  // Variable del Sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VISUALIZACION DATOS DEL ESTUDIANTE
       nFilIni := nMarco(nNroFil,'CODIGO:'+cCodEst+' '+;
				 'GRUPO:'+cCodGru+' '+;
				 'NOMBRE:'+ALLTRIM(cNomEst),22,'°')

       @ nFilIni++,nNroCol SAY 'POR FAVOR INGRESE LOS DETALLES '+;
			       'CONTRANTE No.'+STR(nFirCon,1)
       nFilIni++
*>>>>FIN VISUALIZACION DATOS DEL ESTUDIANTE

*>>>>LECTURA DEL DOCUMENTO DE IDENTIFICACION
       cDocNit := &(cMaeAct+'->cNitCo'+STR(nFirCon,1)+'Est')

       DO WHILE .T.

	  @ nFilIni,nNroCol+00 SAY 'DOCUMENTO: ';
			       GET  cDocNit PICT "@!";
		    WHEN {||HelpRead('DIGITE EL DOCUMENTO DE IDENTIDAD')}
	  READ

	  IF EMPTY(cDocNit)
	     RETURN cDocNit
	  ENDIF

	  IF LEN(ALLTRIM(cDocNit)) <= 3
	     LOOP
	  ENDIF
	  EXIT
       ENDDO

       cTipNit := &(cMaeAct+'->cTipCo'+STR(nFirCon,1)+'Est')
       @ nFilIni,nNroCol+30 SAY 'TIPO:';
			   GET cTipNit PICT "@!";
			   VALID lValTipDoc(ROW(),COL()-1,@cTipNit,'145') .AND.;
				 !EMPTY(cTipNit);
			   WHEN {||HelpRead('DIGITE EL TIPO DE DOCUMENTO')}
       READ
*>>>>FIN LECTURA DEL DOCUMENTO DE IDENTIFICACION


*>>>>ANALISIS DEL CONTRATANTE
       nTipPer := nTipPerMae(cDocNit,;
			     &cMaeAct->cPadNitEst,;
			     &cMaeAct->cMadNitEst,;
			     @cTxtTip)
*>>>>FIN ANALISIS DEL CONTRATANTE

*>>>>LECTURA DE LOS DETALLES DEL CONTRATANTE
       SET ESCAPE ON
       lGrabar := .T.
       DO WHILE .T.

**********LECTURA DATOS DE LOS FAMILIARES
	    nNroFil := nFilIni
	    DO CASE
	    CASE nTipPer == 1 .AND. lGrabar // Padre

		 lSiQepd := &cMaeAct->lPadQepEst

		 cLugNit := &cMaeAct->cPadLugEst
		 cFotNit := IF(&cMaeAct->lPadFotEst,'S','N')

		 cNombre := &cMaeAct->cNomPadEst
		 cApelli := &cMaeAct->cApePadEst

		 dFecNac := &cMaeAct->dNacPadEst
		 cLugNac := &cMaeAct->cLugPadEst

		 cDirecc := &cMaeAct->cDireccEst
		 cCiuDir := &cMaeAct->cCiudadEst
		 cTelefn := &cMaeAct->cTelefnEst

		 cDirEnv := cDirecc
		 cCiuEnv := cCiuDir

		 cTelTra := &cMaeAct->cTelPadEst
		 cCiuTra := &cMaeAct->cCiuPadEst

		 cEstrat := STR(&cMaeAct->nEstratEst,1)
		 cSexFem := 'N'

	    CASE nTipPer == 2 .AND. lGrabar // Madre

		 lSiQepd := &cMaeAct->lMadQepEst

		 cLugNit := &cMaeAct->cMadLugEst
		 cFotNit := IF(&cMaeAct->lMadFotEst,'S','N')

		 cNombre := &cMaeAct->cNomMadEst
		 cApelli := &cMaeAct->cApeMadEst

		 dFecNac := &cMaeAct->dNacMadEst
		 cLugNac := &cMaeAct->cLugMadEst

		 cDirecc := &cMaeAct->cDireccEst
		 cCiuDir := &cMaeAct->cCiudadEst
		 cTelefn := &cMaeAct->cTelefnEst

		 cDirEnv := cDirecc
		 cCiuEnv := cCiuDir

		 cTelTra := &cMaeAct->cTelMadEst
		 cCiuTra := &cMaeAct->cCiuMadEst

		 cEstrat := STR(&cMaeAct->nEstratEst,1)
		 cSexFem := 'S'

	    CASE nTipPer == 3 .AND. lGrabar // Otra Persona

		 lInsReg := !lLocNitPer(cDocNit,cTipNit)

/* Se elimino porque duplica la digitaci¢n.
		 IF lInsReg
		    lManRegPer(lShared,cNomUsr,1,NIL,cDocNit)
		 ENDIF
*/

		 IF lInsReg

		    lSiQepd := .F.

		    cFotNit := ' '
		    cLugNit := cSpaces('PER','cLugNacPer')

		    cApeUno := cSpaces('PER','cApeUnoPer')
		    cApeDos := cSpaces('PER','cApeDosPer')
		    cNomUno := cSpaces('PER','cNomUnoPer')
		    cNomDos := cSpaces('PER','cNomDosPer')


		    dFecNac := CTOD('00/00/00')
		    cLugNac := cSpaces('PER','cLugNacPer')

		    cDirecc := cSpaces('PER','cDireccPer')
		    cCiuDir := cSpaces('PER','cCiudadPer')
		    cTelefn := cSpaces('PER','cTelefnPer')

		    cDirEnv := cSpaces('PER','cDirEnvPer')
		    cCiuEnv := cSpaces('PER','cBarEnvPer')

		    cTelTra := cSpaces('PER','cTelTraPer')
		    cCiuTra := cSpaces('PER','cCiuTraPer')

		    cEstrat := cSpaces('PER','cEstratPer')
		    cSexFem := ' '

		 ELSE
		    lSiQepd := PER->lSiQepdPer

		    cLugNit := PER->cLugNitPer
		    cFotNit := IF(PER->lFotNitPer,'S','N')

		    cApeUno := PER->cApeUnoPer
		    cApeDos := PER->cApeDosPer
		    cNomUno := PER->cNomUnoPer
		    cNomDos := PER->cNomDosPer

		    dFecNac := PER->dFecNacPer
		    cLugNac := PER->cLugNacPer

		    cDirecc := PER->cDireccPer
		    cCiuDir := PER->cCiudadPer
		    cTelefn := PER->cTelefnPer

		    cDirEnv := PER->cDirEnvPer
		    cCiuEnv := PER->cBarEnvPer

		    cTelTra := PER->cTelTraPer
		    cCiuTra := PER->cCiuTraPer

		    cEstrat := PER->cEstratPer
		    cSexFem := IF(PER->lSexFemPer,'F','M')
		 ENDIF
	    ENDCASE
**********FIN LECTURA DATOS DE LOS FAMILIARES

**********ANALISIS DE DECISION
	    IF lSiQepd
	       cError('ESTA PERSONA ESTA FALLECIDA')
	       RETURN cDocNit
	    ENDIF
**********FIN ANALISIS DE DECISION


**********LECTURA DE LA FOTOCOPIA DEL DOCUMENTO
	    @ nNroFil,nNroCol+40 SAY 'DE:';
				 GET cLugNit PICT "@!"

	    @ nNroFil-1,nNroCol+66 SAY 'FOTOCOPIA?'
	    @ nNroFil,nNroCol+66 GET cFotNit ;
				 VALID lValSiNo(ROW(),COL()-1,;
				       @cFotNit,@lFotNit)
**********LECTURA DE LA FOTOCOPIA DEL DOCUMENTO

**********LECTURA DEL NOMBRE
	    nNroFil += 2
	    IF nTipPer == 3

	       @nNroFil,nNroCol+0 SAY 'PRIMER APELLIDO:';
				  GET cApeUno PICT "@!" ;
				  VALID !EMPTY(cApeUno);
				  WHEN {||HelpRead('DIGITE EL '+;
						   'PRIMER APELLIDO')}

	       @nNroFil,nNroCol+38 SAY 'SEGUNDO APELLIDO:';
				   GET cApeDos PICT "@!" ;
				   WHEN {||HelpRead('DIGITE EL '+;
						   'SEGUNDO APELLIDO')}

	       nNroFil++
	       @nNroFil,nNroCol+0 SAY 'PRIMER NOMBRE:';
				  GET cNomUno PICT "@!" ;
				  VALID !EMPTY(cNomUno);
				  WHEN {||HelpRead('DIGITE EL '+;
						   'PRIMER NOMBRE')}

	       @nNroFil,nNroCol+38 SAY 'SEGUNDO NOMBRE:';
				   GET cNomDos PICT "@!" ;
				   WHEN {||HelpRead('DIGITE EL '+;
						    'SEGUNDO NOMBRE')}

	    ELSE
	       SET COLOR TO I
	       @nNroFil,nNroCol+0 SAY cTxtTip+':'
	       SET COLOR TO
	       @nNroFil,nNroCol+LEN(cTxtTip)+2 SAY ALLTRIM(cNombre)+' '+;
						   ALLTRIM(cApelli)
	    ENDIF
**********FIN LECTURA DEL NOMBRE

**********ACTUALIZACION DE LA INFORMACION
	    nNroFil += 2

	    @nNroFil,nNroCol+00 SAY 'FECHA DE NACIMIENTO:';
				  GET dFecNac PICT "@!" ;
				  VALID HelpRead();
				  WHEN {||HelpRead('FECHA')}

	    @nNroFil,nNroCol+33 SAY 'ESTRATO:';
				GET cEstrat PICT "9";
	      WHEN {||HelpRead('INGRESE EL NUMERO DEL ESTRATO')}


	    IF nTipPer == 3
	       @ nNroFil,nNroCol+46 SAY 'SEXO:';
				    GET cSexFem;
				    VALID lValSexo(ROW(),COL()-1,;
					  @cSexFem,@lSexFem)
	    ENDIF


	    nNroFil++
	    @++nNroFil,nNroCol+00 SAY 'DIRECCION CASA:';
				  GET cDirecc PICT "@!40";
	      WHEN {||HelpRead('INGRESE LA DIRECCION DE LA CASA')}


	    @++nNroFil,nNroCol+00 SAY 'CIUDAD:';
				  GET cCiuDir PICT "@!S30";
	      WHEN {||HelpRead('INGRESE LA CIUDAD DE LA DIRECCION DE LA CASA')}

	    @nNroFil,nNroCol+50 SAY 'TEL CASA:';
				  GET cTelefn PICT "@!S14";
	      WHEN {||HelpRead('INGRESE EL TELEFONO DE LA CASA')}

	    nNroFil += 2
	    @nNroFil,nNroCol+00 SAY 'CIUDAD TRABAJO:';
				GET cCiuTra PICT "@!S30";
	      WHEN {||HelpRead('INGRESE LA CIUDAD DEL TRABAJO')}

	    @nNroFil,nNroCol+47 SAY 'TEL TRABAJO:';
				GET cTelTra PICT "@!S14";
				VALID HelpRead('<ESC> ABANDONA LA GRABACION');
	      WHEN {||HelpRead('INGRESE EL TELEFONO DEL TRABAJO')}

	    IF nTipPer == 3
	       nNroFil += 1
	       @++nNroFil,nNroCol+00 SAY 'DIRECCION CORRESPONDENCIA:';
				     GET cDirEnv PICT "@!S50";
			  WHEN {||HelpRead('INGRESE LA DIRECCION PARA '+;
					   'ENVIO DE CORRESPONDENCIA')}

	       @++nNroFil,nNroCol+00 SAY 'CIUDAD CORRESPONDECIA:';
				     GET cCiuEnv PICT "@!S30";
				     VALID HelpRead('<ESC> ABANDONA LA GRABACION');
			  WHEN {||HelpRead('INGRESE LA CIUDAD PARA EL '+;
					   'ENVIO DE CORRESPONDENCIA')}
	       ENDIF
	    READ
**********FIN ACTUALIZACION DE LA INFORMACION

**********PREGUNTA DE DECISION
	    DO CASE
	    CASE LASTKEY() # K_ESC
		 IF !lPregunta('DESEA GRABAR? Si No')
		    lGrabar := .F.
		    LOOP
		 ELSE
		    lGrabar := .T.
		 ENDIF

	    CASE LASTKEY() == K_ESC
		 lGrabar := .F.
		 IF !lPregunta('DESEA ABANDONAR? Si No')
		    LOOP
		 ENDIF
		 EXIT
	    ENDCASE
**********FIN PREGUNTA DE DECISION

**********GRABACION O ACTUALIZACION DEL REGISTRO
	    lHayLec := IF(lHayLec == NIL,.F.,lHayLec)
	    IF lGrabar

	       DO CASE
	       CASE nTipPer == 1 // Padre

*===================ACTUALIZACION DE LOS DATOS DEL PADRE
		      SELECT &cMaeAct
		      IF lRegLock(lShared,.F.)

			 IF .NOT. lHayLec
			    REPL &(cMaeAct+'->cNitCo'+STR(nFirCon,1)+'Est') WITH cDocNit
			    REPL &(cMaeAct+'->cTipCo'+STR(nFirCon,1)+'Est') WITH cTipNit
			 ENDIF

			 REPL &cMaeAct->cPadLugEst WITH cLugNit

			 REPL &cMaeAct->lPadFotEst WITH lFotNit

			 REPL &cMaeAct->cNomPadEst WITH cNombre
			 REPL &cMaeAct->cApePadEst WITH cApelli

			 REPL &cMaeAct->dNacPadEst WITH dFecNac
			 REPL &cMaeAct->cDireccEst WITH cDirecc
			 REPL &cMaeAct->cCiudadEst WITH cCiuDir
			 REPL &cMaeAct->cTelefnEst WITH cTelefn
			 REPL &cMaeAct->cTelPadEst WITH cTelTra
			 REPL &cMaeAct->cCiuPadEst WITH cCiuTra
			 REPL &cMaeAct->nEstratEst WITH VAL(cEstrat)

			 IF lHayLec
			    AADD(aDatCnt,{STR(nFirCon,1),;
					  ALLTRIM(cDocNit),;
					  ALLTRIM(cTipNit),;
					  ALLTRIM(cNombre)+' '+;
						  ALLTRIM(cApelli),;
					  ALLTRIM(cLugNit),;
					  lFotNit})
			 ENDIF

		      ELSE
			  cError('NO SE GRABA EL REGISTRO')
		      ENDIF

		      DBCOMMIT()
		      IF lShared
			 DBUNLOCK()
		      ENDIF
*===================FIN ACTUALIZACION DE LOS DATOS DEL PADRE

	       CASE nTipPer == 2  // Madre

*===================ACTUALIZACION DE LOS DATOS DE LA MADRE
		      SELECT &cMaeAct
		      IF lRegLock(lShared,.F.)

			 IF .NOT. lHayLec
			    REPL &(cMaeAct+'->cNitCo'+STR(nFirCon,1)+'Est') WITH cDocNit
			    REPL &(cMaeAct+'->cTipCo'+STR(nFirCon,1)+'Est') WITH cTipNit
			 ENDIF

			 REPL &cMaeAct->cMadLugEst WITH cLugNit

			 REPL &cMaeAct->lMadFotEst WITH lFotNit

			 REPL &cMaeAct->cNomMadEst WITH cNombre
			 REPL &cMaeAct->cApeMadEst WITH cApelli

			 REPL &cMaeAct->dNacMadEst WITH dFecNac

			 REPL &cMaeAct->cDireccEst WITH cDirecc
			 REPL &cMaeAct->cCiudadEst WITH cCiuDir
			 REPL &cMaeAct->cTelefnEst WITH cTelefn

			 REPL &cMaeAct->cTelMadEst WITH cTelTra
			 REPL &cMaeAct->cCiuPadEst WITH cCiuTra

			 REPL &cMaeAct->nEstratEst WITH VAL(cEstrat)

			 IF lHayLec
			    AADD(aDatCnt,{STR(nFirCon,1),;
					  ALLTRIM(cDocNit),;
					  ALLTRIM(cTipNit),;
					  ALLTRIM(cNombre)+' '+;
						  ALLTRIM(cApelli),;
					  ALLTRIM(cLugNit),;
					  lFotNit})
			 ENDIF

		      ELSE
			  cError('NO SE GRABA EL REGISTRO')
		      ENDIF

		      DBCOMMIT()
		      IF lShared
			 DBUNLOCK()
		      ENDIF
*===================FIN ACTUALIZACION DE LOS DATOS DE LA MADRE

	       CASE nTipPer == 3  // Otra Persona

*===================ACTUALIZACION DE LOS DATOS DE LA PERSONA
		      IF PER->(lRegLock(lShared,lInsReg))


			 REPL PER->nIdeCodPer WITH PER->(RECNO())
			 IF lInsReg
			    REPL PER->cDocNitPer WITH cDocNit
			    REPL PER->cTipNitPer WITH cTipNit
			 ENDIF
			 REPL PER->cLugNitPer WITH cLugNit
			 REPL PER->lFotNitPer WITH lFotNit

			 REPL PER->cApeUnoPer WITH cApeUno
			 REPL PER->cApeDosPer WITH cApeDos
			 REPL PER->cNomUnoPer WITH cNomUno
			 REPL PER->cNomDosPer WITH cNomDos

			 REPL PER->dFecNacPer WITH dFecNac

			 REPL PER->cDireccPer WITH cDirecc
			 REPL PER->cCiudadPer WITH cCiuDir
			 REPL PER->cTelefnPer WITH cTelefn

			 IF EMPTY(cDirEnv) .OR. EMPTY(cCiuEnv)
			    cDirEnv := cDirecc
			    cCiuEnv := cCiuDir
			 ENDIF

			 REPL PER->cDirEnvPer WITH cDirEnv
			 REPL PER->cBarEnvPer WITH cCiuEnv

			 REPL PER->cTelTraPer WITH cTelTra
			 REPL PER->cCiuTraPer WITH cCiuTra

			 REPL PER->cEstratPer WITH cEstrat
			 REPL PER->lSexFemPer WITH lSexFem

			 IF lHayLec

			    AADD(aDatCnt,{STR(nFirCon,1),;
					  ALLTRIM(cDocNit),;
					  ALLTRIM(cTipNit),;
					  ALLTRIM(cNomUno)+' '+;
						  ALLTRIM(cNomDos)+' '+;
						  ALLTRIM(cApeUno)+' '+;
						  ALLTRIM(cApeDos),;
					  ALLTRIM(cLugNit),;
					  lFotNit})
			 ENDIF

		      ENDIF

		      PER->(DBCOMMIT())
		      IF lShared
			 PER->(DBUNLOCK())
		      ENDIF
*===================FIN ACTUALIZACION DE LOS DATOS DE LA PERSONA

*===================GRABACION DEL CONTRATANTE
		      SELECT &cMaeAct
		      IF lRegLock(lShared,.F.)

			 IF .NOT. lHayLec
			    REPL &(cMaeAct+'->cNitCo'+STR(nFirCon,1)+'Est') WITH cDocNit
			    REPL &(cMaeAct+'->cTipCo'+STR(nFirCon,1)+'Est') WITH cTipNit
			 ENDIF

		      ELSE
			  cError('NO SE GRABA EL REGISTRO')
		      ENDIF

		      DBCOMMIT()
		      IF lShared
			 DBUNLOCK()
		      ENDIF
*===================FIN GRABACION DEL CONTRATANTE

	       ENDCASE
	       EXIT
	    ENDIF
**********FIN GRABACION O ACTUALIZACION DEL REGISTRO

       ENDDO
       SET ESCAPE OFF
       RETURN cDocNit
*>>>>FIN LECTURA DE LOS DETALLES DEL CONTRATANTE

/*************************************************************************
* TITULO..: ACTUALIZACION DE LOS CONTRATANTES                            *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 27/2005 JUE A
       Bucaramanga, Colombia	    INICIO: 02:00 PM   OCT 27/2005 JUE

OBJETIVOS:

1- Actualiza la informaci¢n de los contratantes

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION ActFirCon(lShared,cNomUsr,nFirCon,cCodEst,cNomEst,cCodGru,;
		   cMaeAct)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos
       cNomUsr                              // Nombre del Usuario
       nFirCon                              // N£mero del Contrante
       cCodEst                              // C¢digo del Estudiante
       cNomEst                              // Nombre del Estudiante
       cCodGru                              // Codigo del Grupo
       cMaeAct                              // Maestro Actual */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroFil := 3                   // N£mero de la fila
       LOCAL nNroCol := 1                   // N£mero de la Columna
       LOCAL nFilIni := 0                   // Fila Inicial
       LOCAL lGrabar := .T.                 // .T. Grabar el registro
       LOCAL lInsReg := .F.                 // .T. Insertar el Registro

       LOCAL lSiQepd := .F.                 // .T. Fallecido
       LOCAL cTxtTip := ''                  // Descripci¢n del Contratante
       LOCAL nTipPer := 0                   // Tipo de Persona

       LOCAL cDocNit := ''                  // Documento del Contrante
       LOCAL cTipNit := ''                  // Tipo de Documento
       LOCAL cLugNit := ''                  // Lugar de Nacimiento
       LOCAL lFotNit := .F.                 // .T. Hay Fotocopia
       LOCAL cFotNit := SPACE(01)           // S=> Hay Fotocopia

       LOCAL cNombre := ''                  // Nombres
       LOCAL cApelli := ''                  // Apellidos
       LOCAL cApeUno := ''                  // Primer Apellido
       LOCAL cApeDos := ''                  // Apellido Dos
       LOCAL cNomUno := ''                  // Primer Nombre
       LOCAL cNomDos := ''                  // Segundo Nombre

       LOCAL dFecNac := CTOD('00/00/00')    // Fecha de Nacimiento
       LOCAL cLugNac := ''                  // Lugar de Nacimiento

       LOCAL cDirecc := ''                  // Direcci¢n de la Casa
       LOCAL cCiuDir := ''                  // Ciudad de la Direcci¢n
       LOCAL cTelefn := ''                  // Telefono

       LOCAL cDirEnv := ''                  // Direccion para la Correspondencia
       LOCAL cCiuEnv := ''                  // Ciudad para la Correspondencia

       LOCAL cTelTra := ''                  // Telefono del Trabajo
       LOCAL cCiuTra := ''                  // Ciudad del Trabajo

       LOCAL cEstrat := ''                  // Estrato
       LOCAL cSexFem := ''                  // Sexo de la Persona
       LOCAL lSexFem := .F.                 // Sexo de la Persona

       LOCAL GetList := {}                  // Variable del Sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VISUALIZACION DATOS DEL ESTUDIANTE
       nFilIni := nMarco(nNroFil,'CODIGO:'+cCodEst+' '+;
				 'GRUPO:'+cCodGru+' '+;
				 'NOMBRE:'+ALLTRIM(cNomEst),22,'°')

       @ nFilIni++,nNroCol SAY 'POR FAVOR ACTUALICE LA INFORMACION DEL '+;
			       'CONTRANTE No.'+STR(nFirCon,1)
       nFilIni++
*>>>>FIN VISUALIZACION DATOS DEL ESTUDIANTE

*>>>>VALIDACION DEL CONTRATANTE
       cDocNit := &(cMaeAct+'->cNitCo'+STR(nFirCon,1)+'Est')
       IF EMPTY(cDocNit)
	  cError('NO ESTA DEFINIDO EL CONTRATANTE No. '+STR(nFirCon,1))
	  RETURN NIL
       ENDIF
       @ nFilIni,nNroCol+00 SAY 'DOCUMENTO: '+cDocNit COLOR('I')
*>>>>FIN VALIDACION DEL CONTRATANTE

*>>>>LECTURA DEL DOCUMENTO DE IDENTIFICACION
       cTipNit := &(cMaeAct+'->cTipCo'+STR(nFirCon,1)+'Est')
       @ nFilIni,nNroCol+30 SAY 'TIPO:';
			   GET cTipNit PICT "@!";
			   VALID lValTipDoc(ROW(),COL()-1,@cTipNit,'145') .AND.;
				 !EMPTY(cTipNit);
			   WHEN {||HelpRead('DIGITE EL TIPO DE DOCUMENTO')}
       READ
*>>>>FIN LECTURA DEL DOCUMENTO DE IDENTIFICACION

*>>>>ANALISIS DEL CONTRATANTE
       nTipPer := nTipPerMae(cDocNit,;
			     &cMaeAct->cPadNitEst,;
			     &cMaeAct->cMadNitEst,;
			     @cTxtTip)
*>>>>FIN ANALISIS DEL CONTRATANTE

*>>>>LECTURA DE LOS DETALLES DEL CONTRATANTE
       SET ESCAPE ON
       lGrabar := .T.
       DO WHILE .T.

**********LECTURA DATOS DE LOS FAMILIARES
	    nNroFil := nFilIni
	    DO CASE
	    CASE nTipPer == 1 .AND. lGrabar // Padre

		 lSiQepd := &cMaeAct->lPadQepEst

		 cLugNit := &cMaeAct->cPadLugEst
		 cFotNit := IF(&cMaeAct->lPadFotEst,'S','N')

		 cNombre := &cMaeAct->cNomPadEst
		 cApelli := &cMaeAct->cApePadEst

		 dFecNac := &cMaeAct->dNacPadEst
		 cLugNac := &cMaeAct->cLugPadEst

		 cDirecc := &cMaeAct->cDireccEst
		 cCiuDir := &cMaeAct->cCiudadEst
		 cTelefn := &cMaeAct->cTelefnEst

		 cDirEnv := cDirecc
		 cCiuEnv := cCiuDir

		 cTelTra := &cMaeAct->cTelPadEst
		 cCiuTra := &cMaeAct->cCiuPadEst

		 cEstrat := STR(&cMaeAct->nEstratEst,1)
		 cSexFem := 'N'

	    CASE nTipPer == 2 .AND. lGrabar // Madre

		 lSiQepd := &cMaeAct->lMadQepEst

		 cLugNit := &cMaeAct->cMadLugEst
		 cFotNit := IF(&cMaeAct->lMadFotEst,'S','N')

		 cNombre := &cMaeAct->cNomMadEst
		 cApelli := &cMaeAct->cApeMadEst

		 dFecNac := &cMaeAct->dNacMadEst
		 cLugNac := &cMaeAct->cLugMadEst

		 cDirecc := &cMaeAct->cDireccEst
		 cCiuDir := &cMaeAct->cCiudadEst
		 cTelefn := &cMaeAct->cTelefnEst

		 cDirEnv := cDirecc
		 cCiuEnv := cCiuDir

		 cTelTra := &cMaeAct->cTelMadEst
		 cCiuTra := &cMaeAct->cCiuMadEst

		 cEstrat := STR(&cMaeAct->nEstratEst,1)
		 cSexFem := 'S'

	    CASE nTipPer == 3 .AND. lGrabar // Otra Persona

		 lInsReg := !lLocNitPer(cDocNit,cTipNit)

		 IF lInsReg
		    lManRegPer(lShared,cNomUsr,1,NIL,cDocNit)
		 ELSE
		    lManRegPer(lShared,cNomUsr,2,NIL,cDocNit)
		 ENDIF


		 IF lInsReg

		    lSiQepd := .F.

		    cFotNit := ' '
		    cLugNit := cSpaces('PER','cLugNacPer')

		    cApeUno := cSpaces('PER','cApeUnoPer')
		    cApeDos := cSpaces('PER','cApeDosPer')
		    cNomUno := cSpaces('PER','cNomUnoPer')
		    cNomDos := cSpaces('PER','cNomDosPer')


		    dFecNac := CTOD('00/00/00')
		    cLugNac := cSpaces('PER','cLugNacPer')

		    cDirecc := cSpaces('PER','cDireccPer')
		    cCiuDir := cSpaces('PER','cCiudadPer')
		    cTelefn := cSpaces('PER','cTelefnPer')

		    cDirEnv := cSpaces('PER','cDirEnvPer')
		    cCiuEnv := cSpaces('PER','cBarEnvPer')

		    cTelTra := cSpaces('PER','cTelTraPer')
		    cCiuTra := cSpaces('PER','cCiuTraPer')

		    cEstrat := cSpaces('PER','cEstratPer')
		    cSexFem := ' '

		 ELSE
		    lSiQepd := PER->lSiQepdPer

		    cLugNit := PER->cLugNitPer
		    cFotNit := IF(PER->lFotNitPer,'S','N')

		    cApeUno := PER->cApeUnoPer
		    cApeDos := PER->cApeDosPer
		    cNomUno := PER->cNomUnoPer
		    cNomDos := PER->cNomDosPer

		    dFecNac := PER->dFecNacPer
		    cLugNac := PER->cLugNacPer

		    cDirecc := PER->cDireccPer
		    cCiuDir := PER->cCiudadPer
		    cTelefn := PER->cTelefnPer

		    cDirEnv := PER->cDirEnvPer
		    cCiuEnv := PER->cBarEnvPer

		    cTelTra := PER->cTelTraPer
		    cCiuTra := PER->cCiuTraPer

		    cEstrat := PER->cEstratPer
		    cSexFem := IF(PER->lSexFemPer,'F','M')
		 ENDIF
	    ENDCASE
**********FIN LECTURA DATOS DE LOS FAMILIARES

**********ANALISIS DE DECISION
	    IF lSiQepd
	       cError('ESTA PERSONA ESTA FALLECIDA')
	       RETURN cDocNit
	    ENDIF
**********FIN ANALISIS DE DECISION

**********LECTURA DE LA FOTOCOPIA DEL DOCUMENTO
	    @ nNroFil,nNroCol+40 SAY 'DE:';
				 GET cLugNit PICT "@!"

	    @ nNroFil-1,nNroCol+66 SAY 'FOTOCOPIA?'
	    @ nNroFil,nNroCol+66 GET cFotNit ;
				 VALID lValSiNo(ROW(),COL()-1,;
				       @cFotNit,@lFotNit)
**********LECTURA DE LA FOTOCOPIA DEL DOCUMENTO

**********LECTURA DEL NOMBRE
	    nNroFil += 2
	    IF nTipPer == 3

	       @nNroFil,nNroCol+0 SAY 'PRIMER APELLIDO:';
				  GET cApeUno PICT "@!" ;
				  VALID !EMPTY(cApeUno);
				  WHEN {||HelpRead('DIGITE EL '+;
						   'PRIMER APELLIDO')}

	       @nNroFil,nNroCol+38 SAY 'SEGUNDO APELLIDO:';
				   GET cApeDos PICT "@!" ;
				   WHEN {||HelpRead('DIGITE EL '+;
						   'SEGUNDO APELLIDO')}

	       nNroFil++
	       @nNroFil,nNroCol+0 SAY 'PRIMER NOMBRE:';
				  GET cNomUno PICT "@!" ;
				  VALID !EMPTY(cNomUno);
				  WHEN {||HelpRead('DIGITE EL '+;
						   'PRIMER NOMBRE')}

	       @nNroFil,nNroCol+38 SAY 'SEGUNDO NOMBRE:';
				   GET cNomDos PICT "@!" ;
				   WHEN {||HelpRead('DIGITE EL '+;
						   'SEGUNDO NOMBRE')}

	    ELSE
	       SET COLOR TO I
	       @nNroFil,nNroCol+0 SAY cTxtTip+':'
	       SET COLOR TO
	       @nNroFil,nNroCol+LEN(cTxtTip)+2 SAY ALLTRIM(cNombre)+' '+;
						   ALLTRIM(cApelli)
	    ENDIF
**********FIN LECTURA DEL NOMBRE

**********ACTUALIZACION DE LA INFORMACION
	    nNroFil += 2
	    @nNroFil,nNroCol+00 SAY 'FECHA DE NACIMIENTO:';
				  GET dFecNac PICT "@!" ;
				  VALID HelpRead();
				  WHEN {||HelpRead('FECHA')}

	    @nNroFil,nNroCol+33 SAY 'ESTRATO:';
				GET cEstrat PICT "9";
	      WHEN {||HelpRead('INGRESE EL NUMERO DEL ESTRATO')}


	    IF nTipPer == 3
	       @ nNroFil,nNroCol+46 SAY 'SEXO:';
				    GET cSexFem;
				    VALID lValSexo(ROW(),COL()-1,;
					  @cSexFem,@lSexFem)
	    ENDIF


	    nNroFil++
	    @++nNroFil,nNroCol+00 SAY 'DIRECCION CASA:';
				  GET cDirecc PICT "@!40";
	      WHEN {||HelpRead('INGRESE LA DIRECCION DE LA CASA')}


	    @++nNroFil,nNroCol+00 SAY 'CIUDAD:';
				  GET cCiuDir PICT "@!S30";
	      WHEN {||HelpRead('INGRESE LA CIUDAD DE LA DIRECCION DE LA CASA')}

	    @nNroFil,nNroCol+50 SAY 'TEL CASA:';
				  GET cTelefn PICT "@!S14";
	      WHEN {||HelpRead('INGRESE EL TELEFONO DE LA CASA')}

	    nNroFil += 2
	    @nNroFil,nNroCol+00 SAY 'CIUDAD TRABAJO:';
				GET cCiuTra PICT "@!S30";
	      WHEN {||HelpRead('INGRESE LA CIUDAD DEL TRABAJO')}

	    @nNroFil,nNroCol+47 SAY 'TEL TRABAJO:';
				GET cTelTra PICT "@!S14";
				VALID HelpRead('<ESC> ABANDONA LA GRABACION');
	      WHEN {||HelpRead('INGRESE EL TELEFONO DEL TRABAJO')}

	    IF nTipPer == 3
	       nNroFil += 1
	       @++nNroFil,nNroCol+00 SAY 'DIRECCION CORRESPONDENCIA:';
				     GET cDirEnv PICT "@!S50";
			  WHEN {||HelpRead('INGRESE LA DIRECCION PARA '+;
					   'ENVIO DE CORRESPONDENCIA')}

	       @++nNroFil,nNroCol+00 SAY 'CIUDAD CORRESPONDECIA:';
				     GET cCiuEnv PICT "@!S30";
				     VALID HelpRead('<ESC> ABANDONA LA GRABACION');
			  WHEN {||HelpRead('INGRESE LA CIUDAD PARA EL '+;
					   'ENVIO DE CORRESPONDENCIA')}
	       ENDIF
	    READ
**********FIN ACTUALIZACION DE LA INFORMACION

**********PREGUNTA DE DECISION
	    DO CASE
	    CASE LASTKEY() # K_ESC
		 IF !lPregunta('DESEA GRABAR? Si No')
		    lGrabar := .F.
		    LOOP
		 ELSE
		    lGrabar := .T.
		 ENDIF

	    CASE LASTKEY() == K_ESC
		 lGrabar := .F.
		 IF !lPregunta('DESEA ABANDONAR? Si No')
		    LOOP
		 ENDIF
		 EXIT
	    ENDCASE
**********FIN PREGUNTA DE DECISION

**********GRABACION O ACTUALIZACION DEL REGISTRO
	    IF lGrabar

	       DO CASE
	       CASE nTipPer == 1 // Padre

*===================ACTUALIZACION DE LOS DATOS DEL PADRE
		      SELECT &cMaeAct
		      IF lRegLock(lShared,.F.)

			 REPL &(cMaeAct+'->cTipCo'+STR(nFirCon,1)+'Est') WITH cTipNit

			 REPL &cMaeAct->cPadLugEst WITH cLugNit

			 REPL &cMaeAct->lPadFotEst WITH lFotNit

			 REPL &cMaeAct->cNomPadEst WITH cNombre
			 REPL &cMaeAct->cApePadEst WITH cApelli

			 REPL &cMaeAct->dNacPadEst WITH dFecNac
			 REPL &cMaeAct->cDireccEst WITH cDirecc
			 REPL &cMaeAct->cCiudadEst WITH cCiuDir
			 REPL &cMaeAct->cTelefnEst WITH cTelefn
			 REPL &cMaeAct->cTelPadEst WITH cTelTra
			 REPL &cMaeAct->cCiuPadEst WITH cCiuTra
			 REPL &cMaeAct->nEstratEst WITH VAL(cEstrat)

		      ELSE
			  cError('NO SE GRABA EL REGISTRO')
		      ENDIF

		      DBCOMMIT()
		      IF lShared
			 DBUNLOCK()
		      ENDIF
*===================FIN ACTUALIZACION DE LOS DATOS DEL PADRE

	       CASE nTipPer == 2  // Madre

*===================ACTUALIZACION DE LOS DATOS DE LA MADRE
		      SELECT &cMaeAct
		      IF lRegLock(lShared,.F.)

			 REPL &(cMaeAct+'->cTipCo'+STR(nFirCon,1)+'Est') WITH cTipNit

			 REPL &cMaeAct->cMadLugEst WITH cLugNit

			 REPL &cMaeAct->lMadFotEst WITH lFotNit

			 REPL &cMaeAct->cNomMadEst WITH cNombre
			 REPL &cMaeAct->cApeMadEst WITH cApelli

			 REPL &cMaeAct->dNacMadEst WITH dFecNac

			 REPL &cMaeAct->cDireccEst WITH cDirecc
			 REPL &cMaeAct->cCiudadEst WITH cCiuDir
			 REPL &cMaeAct->cTelefnEst WITH cTelefn

			 REPL &cMaeAct->cTelMadEst WITH cTelTra
			 REPL &cMaeAct->cCiuPadEst WITH cCiuTra

			 REPL &cMaeAct->nEstratEst WITH VAL(cEstrat)

		      ELSE
			  cError('NO SE GRABA EL REGISTRO')
		      ENDIF

		      DBCOMMIT()
		      IF lShared
			 DBUNLOCK()
		      ENDIF
*===================FIN ACTUALIZACION DE LOS DATOS DE LA MADRE

	       CASE nTipPer == 3  // Otra Persona

*===================ACTUALIZACION DE LOS DATOS DE LA PERSONA
		      IF PER->(lRegLock(lShared,lInsReg))


			 REPL PER->nIdeCodPer WITH PER->(RECNO())
			 IF lInsReg
			    REPL PER->cDocNitPer WITH cDocNit
			    REPL PER->cTipNitPer WITH cTipNit
			 ENDIF
			 REPL PER->cLugNitPer WITH cLugNit
			 REPL PER->lFotNitPer WITH lFotNit

			 REPL PER->cApeUnoPer WITH cApeUno
			 REPL PER->cApeDosPer WITH cApeDos
			 REPL PER->cNomUnoPer WITH cNomUno
			 REPL PER->cNomDosPer WITH cNomDos

			 REPL PER->dFecNacPer WITH dFecNac

			 REPL PER->cDireccPer WITH cDirecc
			 REPL PER->cCiudadPer WITH cCiuDir
			 REPL PER->cTelefnPer WITH cTelefn

			 IF EMPTY(cDirEnv) .OR. EMPTY(cCiuEnv)
			    cDirEnv := cDirecc
			    cCiuEnv := cCiuDir
			 ENDIF

			 REPL PER->cDirEnvPer WITH cDirEnv
			 REPL PER->cBarEnvPer WITH cCiuEnv

			 REPL PER->cTelTraPer WITH cTelTra
			 REPL PER->cCiuTraPer WITH cCiuTra

			 REPL PER->cEstratPer WITH cEstrat
			 REPL PER->lSexFemPer WITH lSexFem

		      ENDIF

		      PER->(DBCOMMIT())
		      IF lShared
			 PER->(DBUNLOCK())
		      ENDIF
*===================FIN ACTUALIZACION DE LOS DATOS DE LA PERSONA

	       ENDCASE
	       EXIT
	    ENDIF
**********FIN GRABACION O ACTUALIZACION DEL REGISTRO

       ENDDO
       SET ESCAPE OFF
       RETURN NIL
*>>>>FIN LECTURA DE LOS DETALLES DEL CONTRATANTE

/*************************************************************************
* TITULO..: LOCALIZAR LOS CONTRATANTES                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 29/2008 VIE A
       Colombia, Bucaramanga        INICIO: 09:30 PM   AGO 29/2008 VIE

OBJETIVOS:

1- Permite localizar la informaci¢n de todos los contratantes del estudiante.

2- Retorna un vector con la informaci¢n de los contratantes

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aNroCnts(cMaeAct)

*>>>>DESCRIPCION DE PARAMETROS
/*     cMaeAct                              // Maestro Actual */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL aDocNit := {}                  // Documentos de los Contratantes
       LOCAL aNroCnt := {}                  // N£mero de Contratantes
       LOCAL aDetCnt := {}                  // Informaci¢n del Contratante

       LOCAL nTipPer := 0                   // Tipo de Persona
*>>>>FIN DECLARACION DE VARIABLES

*>>>>PRIMER CONTRATANTE
       IF EMPTY(&cMaeAct->cNitCo1Est)
	  AADD(aDocNit,{'',''})
       ELSE
	  AADD(aDocNit,{&cMaeAct->cNitCo1Est,;
			&cMaeAct->cTipCo1Est})
       ENDIF
*>>>>FIN PRIMER CONTRATANTE

*>>>>SEGUNDO CONTRATANTE
       IF EMPTY(&cMaeAct->cNitCo2Est)
	  AADD(aDocNit,{'',''})
       ELSE
	  AADD(aDocNit,{&cMaeAct->cNitCo2Est,;
			&cMaeAct->cTipCo2Est})
       ENDIF
*>>>>FIN SEGUNDO CONTRATANTE

*>>>>TERCER CONTRATANTE
       IF EMPTY(&cMaeAct->cNitCo3Est)
	  AADD(aDocNit,{'',''})
       ELSE
	  AADD(aDocNit,{&cMaeAct->cNitCo3Est,;
			&cMaeAct->cTipCo3Est})
       ENDIF
*>>>>FIN TERCER CONTRATANTE

*>>>>CUARTO CONTRATANTE
       IF EMPTY(&cMaeAct->cNitCo4Est)
	  AADD(aDocNit,{'',''})
       ELSE
	  AADD(aDocNit,{&cMaeAct->cNitCo4Est,;
			&cMaeAct->cTipCo4Est})
       ENDIF
*>>>>FIN CUARTO CONTRATANTE

*>>>>ANALISIS DEL CONTRATANTE
       aNroCnt := {}
       aDetCnt := {}
       FOR i := 1 TO LEN(aDocNit)

	   aDetCnt := {}

***********ANALISIS DE DECISION
	     IF EMPTY(aDocNit[i,1])

		AADD(aDetCnt,{'cApelli',''})
		AADD(aDetCnt,{'cNombrs',''})
		AADD(aDetCnt,{'cNombre',''})
		AADD(aDetCnt,{'lSiQepd',.F.})
		AADD(aDetCnt,{'dFecNac',CTOD('00/00/00')})
		AADD(aDetCnt,{'cLugNac',''})
		AADD(aDetCnt,{'cDocNit',''})
		AADD(aDetCnt,{'cLugNit',''})
		AADD(aDetCnt,{'cTipNit',''})
		AADD(aDetCnt,{'lFotNit',.F.})
		AADD(aDetCnt,{'cProfes',''})
		AADD(aDetCnt,{'cEmpTra',''})
		AADD(aDetCnt,{'cCarTra',''})
		AADD(aDetCnt,{'cDirecc',''})
		AADD(aDetCnt,{'cBarrio',''})
		AADD(aDetCnt,{'cCiudad',''})
		AADD(aDetCnt,{'cTelefn',''})
		AADD(aDetCnt,{'cTelCel',''})
		AADD(aDetCnt,{'cTelFax',''})
		AADD(aDetCnt,{'cBipper',''})
		AADD(aDetCnt,{'cCorreo',''})

		DO CASE
		CASE i == 1
		     AADD(aNroCnt,{'aCntUno',aDetCnt})
		CASE i == 2
		     AADD(aNroCnt,{'aCntDos',aDetCnt})
		CASE i == 3
		     AADD(aNroCnt,{'aCntTre',aDetCnt})
		CASE i == 4
		     AADD(aNroCnt,{'aCntCua',aDetCnt})
		ENDCASE

		LOOP
	     ENDIF
***********FIN ANALISIS DE DECISION

***********INFORMACION DEL CONTRATANTE
	     nTipPer := nTipPerMae(aDocNit[i,1],;
				   &cMaeAct->cPadNitEst,;
				   &cMaeAct->cMadNitEst)

	     DO CASE
	     CASE nTipPer == 1     // Padre

		  AADD(aDetCnt,{'cApelli',ALLTRIM(&cMaeAct->cApePadEst)})
		  AADD(aDetCnt,{'cNombrs',ALLTRIM(&cMaeAct->cNomPadEst)})
		  AADD(aDetCnt,{'cNombre',RTRIM(&cMaeAct->cApePadEst)+' '+;
					  RTRIM(&cMaeAct->cNomPadEst)})
		  AADD(aDetCnt,{'lSiQepd',&cMaeAct->lPadQepEst})
		  AADD(aDetCnt,{'dFecNac',&cMaeAct->dNacPadEst})
		  AADD(aDetCnt,{'cLugNac',ALLTRIM(&cMaeAct->cLugPadEst)})
		  AADD(aDetCnt,{'cDocNit',ALLTRIM(&cMaeAct->cPadNitEst)})
		  AADD(aDetCnt,{'cLugNit',ALLTRIM(&cMaeAct->cPadLugEst)})
		  AADD(aDetCnt,{'cTipNit',ALLTRIM(&cMaeAct->cPadTntEst)})
		  AADD(aDetCnt,{'lFotNit',&cMaeAct->lPadFotEst})
		  AADD(aDetCnt,{'cProfes',ALLTRIM(&cMaeAct->cProPadEst)})
		  AADD(aDetCnt,{'cEmpTra',ALLTRIM(&cMaeAct->cEmpPadEst)})
		  AADD(aDetCnt,{'cCarTra',ALLTRIM(&cMaeAct->cCarPadEst)})
		  AADD(aDetCnt,{'cDirecc',ALLTRIM(&cMaeAct->cDirPadEst)})
		  AADD(aDetCnt,{'cBarrio',ALLTRIM(&cMaeAct->cBarPadEst)})
		  AADD(aDetCnt,{'cCiudad',ALLTRIM(&cMaeAct->cCiuPadEst)})
		  AADD(aDetCnt,{'cTelefn',ALLTRIM(&cMaeAct->cTelPadEst)})
		  AADD(aDetCnt,{'cTelCel',ALLTRIM(&cMaeAct->cCelPadEst)})
		  AADD(aDetCnt,{'cTelFax',ALLTRIM(&cMaeAct->cFaxPadEst)})
		  AADD(aDetCnt,{'cBipper',ALLTRIM(&cMaeAct->cBipPadEst)})
		  AADD(aDetCnt,{'cCorreo',ALLTRIM(&cMaeAct->cMaiPadEst)})

	     CASE nTipPer == 2     // Madre

		  AADD(aDetCnt,{'cApelli',ALLTRIM(&cMaeAct->cApeMadEst)})
		  AADD(aDetCnt,{'cNombrs',ALLTRIM(&cMaeAct->cNomMadEst)})
		  AADD(aDetCnt,{'cNombre',RTRIM(&cMaeAct->cApeMadEst)+' '+;
					  RTRIM(&cMaeAct->cNomMadEst)})
		  AADD(aDetCnt,{'lSiQepd',&cMaeAct->lMadQepEst})
		  AADD(aDetCnt,{'dFecNac',&cMaeAct->dNacMadEst})
		  AADD(aDetCnt,{'cLugNac',ALLTRIM(&cMaeAct->cLugMadEst)})
		  AADD(aDetCnt,{'cDocNit',ALLTRIM(&cMaeAct->cMadNitEst)})
		  AADD(aDetCnt,{'cLugNit',ALLTRIM(&cMaeAct->cMadLugEst)})
		  AADD(aDetCnt,{'cTipNit',ALLTRIM(&cMaeAct->cMadTntEst)})
		  AADD(aDetCnt,{'lFotNit',&cMaeAct->lMadFotEst})
		  AADD(aDetCnt,{'cProfes',ALLTRIM(&cMaeAct->cProMadEst)})
		  AADD(aDetCnt,{'cEmpTra',ALLTRIM(&cMaeAct->cEmpMadEst)})
		  AADD(aDetCnt,{'cCarTra',ALLTRIM(&cMaeAct->cCarMadEst)})
		  AADD(aDetCnt,{'cDirecc',ALLTRIM(&cMaeAct->cDirMadEst)})
		  AADD(aDetCnt,{'cBarrio',ALLTRIM(&cMaeAct->cBarMadEst)})
		  AADD(aDetCnt,{'cCiudad',ALLTRIM(&cMaeAct->cCiuMadEst)})
		  AADD(aDetCnt,{'cTelefn',ALLTRIM(&cMaeAct->cTelMadEst)})
		  AADD(aDetCnt,{'cTelCel',ALLTRIM(&cMaeAct->cCelMadEst)})
		  AADD(aDetCnt,{'cTelFax',ALLTRIM(&cMaeAct->cFaxMadEst)})
		  AADD(aDetCnt,{'cBipper',ALLTRIM(&cMaeAct->cBipMadEst)})
		  AADD(aDetCnt,{'cCorreo',ALLTRIM(&cMaeAct->cMaiMadEst)})


	     CASE nTipPer == 3     // Otra Persona

		  IF lLocNitPer(aDocNit[i,1],aDocNit[i,2])

		     AADD(aDetCnt,{'cApelli',RTRIM(PER->cApeUnoPer)+' '+;
					     RTRIM(PER->cApeDosPer)})

		     AADD(aDetCnt,{'cNombrs',RTRIM(PER->cNomUnoPer)+' '+;
					     RTRIM(PER->cNomDosPer)})

		     AADD(aDetCnt,{'cNombre',RTRIM(PER->cApeUnoPer)+' '+;
					     RTRIM(PER->cApeDosPer)+' '+;
					     RTRIM(PER->cNomUnoPer)+' '+;
					     RTRIM(PER->cNomDosPer)})

		     AADD(aDetCnt,{'lSiQepd',PER->lSiQepdPer})
		     AADD(aDetCnt,{'dFecNac',PER->dFecNacPer})
		     AADD(aDetCnt,{'cLugNac',ALLTRIM(PER->cLugNacPer)})
		     AADD(aDetCnt,{'cDocNit',ALLTRIM(PER->cDocNitPer)})
		     AADD(aDetCnt,{'cLugNit',ALLTRIM(PER->cLugNitPer)})
		     AADD(aDetCnt,{'cTipNit',ALLTRIM(PER->cTipNitPer)})
		     AADD(aDetCnt,{'lFotNit',PER->lFotNitPer})
		     AADD(aDetCnt,{'cProfes',ALLTRIM(PER->cProfesPer)})
		     AADD(aDetCnt,{'cEmpTra',ALLTRIM(PER->cEmpTraPer)})
		     AADD(aDetCnt,{'cCarTra',ALLTRIM(PER->cCarTraPer)})
		     AADD(aDetCnt,{'cDirecc',ALLTRIM(PER->cDireccPer)})
		     AADD(aDetCnt,{'cBarrio',ALLTRIM(PER->cBarrioPer)})
		     AADD(aDetCnt,{'cCiudad',ALLTRIM(PER->cCiudadPer)})
		     AADD(aDetCnt,{'cTelefn',ALLTRIM(PER->cTelefnPer)})
		     AADD(aDetCnt,{'cTelCel',ALLTRIM(PER->cTelCelPer)})
		     AADD(aDetCnt,{'cTelFax',ALLTRIM(PER->cTelFaxPer)})
		     AADD(aDetCnt,{'cBipper',ALLTRIM(PER->cBipperPer)})
		     AADD(aDetCnt,{'cCorreo',ALLTRIM(PER->cMaiUnoPer)})

		  ELSE

		     AADD(aDetCnt,{'cApelli',''})
		     AADD(aDetCnt,{'cNombrs',''})
		     AADD(aDetCnt,{'cNombre',''})
		     AADD(aDetCnt,{'lSiQepd',.F.})
		     AADD(aDetCnt,{'dFecNac',CTOD('00/00/00')})
		     AADD(aDetCnt,{'cLugNac',''})
		     AADD(aDetCnt,{'cDocNit',aDocNit[i,1]})
		     AADD(aDetCnt,{'cLugNit',''})
		     AADD(aDetCnt,{'cTipNit',aDocNit[i,2]})
		     AADD(aDetCnt,{'lFotNit',.F.})
		     AADD(aDetCnt,{'cProfes',''})
		     AADD(aDetCnt,{'cEmpTra',''})
		     AADD(aDetCnt,{'cCarTra',''})
		     AADD(aDetCnt,{'cDirecc',''})
		     AADD(aDetCnt,{'cBarrio',''})
		     AADD(aDetCnt,{'cCiudad',''})
		     AADD(aDetCnt,{'cTelefn',''})
		     AADD(aDetCnt,{'cTelCel',''})
		     AADD(aDetCnt,{'cTelFax',''})
		     AADD(aDetCnt,{'cBipper',''})
		     AADD(aDetCnt,{'cCorreo',''})

		  ENDIF

	     ENDCASE
***********FIN INFORMACION DEL CONTRATANTE

***********ANALISIS DE DECISION
	     DO CASE
	     CASE i == 1
		  AADD(aNroCnt,{'aCntUno',aDetCnt})
	     CASE i == 2
		  AADD(aNroCnt,{'aCntDos',aDetCnt})
	     CASE i == 3
		  AADD(aNroCnt,{'aCntTre',aDetCnt})
	     CASE i == 4
		  AADD(aNroCnt,{'aCntCua',aDetCnt})
	     ENDCASE
***********FIN ANALISIS DE DECISION

       NEXT
       RETURN aNroCnt
*>>>>FIN ANALISIS DEL CONTRATANTE

/*************************************************************************
* TITULO..: BROWSE DE LOS ESTUDIANTES                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 14/2009 VIE A
       Colombia, Bucaramanga        INICIO: 11:00 AM   MAY 14/2009 VIE

OBJETIVOS:

1- Permite consultar el maestro de estudiantes.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION BrowseAlu(lShared,cMaeAct)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos
       cMaeAct                              // Maestro Habilidado */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cTitSup := ''                  // T¡tulo Superior del Browse
       LOCAL aCampos := NIL                 // Definici¢n de Campos
       LOCAL cTitInf := ''                  // T¡tulo Inferior del Browse
       LOCAL oBrowse := NIL                 // Browse de Alumnos
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DEFINICION DEL BROWSE
       SELECT &cMaeAct
       cTitSup := '<< CONSULTA DE ESTUDIANTE DE '+cMaeAct+;
		  ' .TOTAL ='+STR(RECCOUNT(),4)+' >>'
      *ÀT¡tulo Superior del Browse

       aCampos := {{{"CODIGO","cCodigoEst"},{NIL}},;
		   {{"GRUPO","cCodigoGru"},{NIL}},;
		   {{"APELLIDOS;DEL ESTUDIANTE","cApelliEst"},{NIL}},;
		   {{"NOMBRES;DEL ESTUDIANTE","cNombreEst"},{NIL}},;
		   {{"FECHA MATRICULA","dFecMatEst"},{NIL}},;
		   {{"HORA","cHorMatEst"},{NIL}},;
		   {{"RETIRADO","lRetiroEst"},{NIL}},;
		   {{"FECHA","dFecRetEst"},{NIL}},;
		   {{"GRUPO ANTERIOR","cGruAntGru"},{NIL}},;
		   {{"MES PARA EL;ULTIMO RECIBO","nUltRecEst"},;
		    {{'MODI',.T.},{'ALIAS',cMaeAct},;
		     {'FIELD','nUltRecEst'},{'PICTURE','99'}}},;
		   {{"NOMBRE PARA;EL RECIBO","nNomFacEst"},;
		    {{'MODI',.T.},{'ALIAS',cMaeAct},;
		     {'FIELD','nNomFacEst'},{'PICTURE','9'}}},;
		   {{"CLASIFICACION;DEL ESTUDIANTE","nMorosoEst"},{NIL}},;
		   {{"CONCEPTOS","cConcepEst"},{NIL}},;
		   {{"RUTAS","cCodigoRut"},{NIL}},;
		   {{"PAZ Y SALVO","cPazSdoEst"},;
		    {{'MODI',.F.},{'ALIAS',cMaeAct},;
		     {'FIELD','cPazSdoEst'},{'PICTURE','@!'}}},;
		   {{"ESTRATO","nEstratEst"},;
		    {{'MODI',.T.},{'ALIAS',cMaeAct},;
		     {'FIELD','nEstratEst'},{'PICTURE','99'}}},;
		   {{"TOTAL FACTURADO","nTotFacEst"},{NIL}},;
		   {{"TOTAL PAGADO","nTotPagEst"},{NIL}},;
		   {{"CONTRATANTE No. 1","cNitCo1Est"},;
		    {{'MODI',.F.},{'ALIAS',cMaeAct},;
		     {'FIELD','cNitCo1Est'},{'PICTURE','@9'}}},;
		   {{"NO REPORTAR No. 1","lNoRCo1Est"},;
		    {{'MODI',.F.},{'ALIAS',cMaeAct},;
		     {'FIELD','lNoRCo1Est'},{'PICTURE','@!'}}},;
		   {{"CONTRATANTE No. 2","cNitCo2Est"},;
		    {{'MODI',.F.},{'ALIAS',cMaeAct},;
		     {'FIELD','cNitCo2Est'},{'PICTURE','@9'}}},;
		   {{"NO REPORTAR No. 2","lNoRCo2Est"},;
		    {{'MODI',.F.},{'ALIAS',cMaeAct},;
		     {'FIELD','lNoRCo2Est'},{'PICTURE','@!'}}},;
		   {{"CONTRATANTE No. 3","cNitCo3Est"},;
		    {{'MODI',.F.},{'ALIAS',cMaeAct},;
		     {'FIELD','cNitCo3Est'},{'PICTURE','@9'}}},;
		   {{"NO REPORTAR No. 3","lNoRCo3Est"},;
		    {{'MODI',.F.},{'ALIAS',cMaeAct},;
		     {'FIELD','lNoRCo3Est'},{'PICTURE','@!'}}},;
		   {{"CONTRATANTE No. 4","cNitCo4Est"},;
		    {{'MODI',.F.},{'ALIAS',cMaeAct},;
		     {'FIELD','cNitCo4Est'},{'PICTURE','@9'}}},;
		   {{"NO REPORTAR No. 4","lNoRCo4Est"},;
		    {{'MODI',.F.},{'ALIAS',cMaeAct},;
		     {'FIELD','lNoRCo4Est'},{'PICTURE','@!'}}},;
		   {{"No;LISTA","nNroLisEst"},{NIL}}}
     *ÀDefinici¢n de Campos


       cTitInf := '<F2>Personal <F3>Pagos <F4>Descuentos '+;
		  '<F5>Buscar <F6>Recibos <ESC>Abandona'
      *ÀT¡tulo Inferior del Browse

       oBrowse := oBrowse(03,00,22,79,cTitSup,cTitInf,aCampos)
     *Creaci¢n del Browse
*>>>>FIN DEFINICION DEL BROWSE

*>>>>BROWSE DE CLIENTES
       SELECT &cMaeAct

       DO CASE
       CASE cMaeAct == 'JAR'
	    JAR->(CtrlBrw(lShared,oBrowse))

       CASE cMaeAct == 'PRI'
	    PRI->(CtrlBrw(lShared,oBrowse))

       CASE cMaeAct == 'BTO'
	    BTO->(CtrlBrw(lShared,oBrowse))

       ENDCASE
       RETURN NIL
*>>>>FIN BROWSE DE CLIENTES

/*************************************************************************
* TITULO..: CREACION DEL CODIGO                                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 24/2009 JUE A
       Colombia, Bucaramanga        INICIO: 10:00 AM   MAY 24/2009 JUE

OBJETIVOS:

1- Permite crear la estructura del codigo.

2- Retorna el codigo creado.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cNewCodigo(cAnoUsr,nNroSec,nLenCod,nTipCod)

*>>>>DESCRIPCION DE PARAMETROS
/*     cAnoUsr				    // A¤o del Sistema
       nNroSec                              // Numero Secuencial
       nLenCod                              // Longitud del C¢digo
       nTipCod                              // Tipo de C¢digo
					       1=C¢digo con A¤o
					       2=C¢digo secuencial */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema

       LOCAL cCodAno := ''                  // C¢digo del A¤o
       LOCAL cCodSec := ''                  // C¢digo Secuencial
       LOCAL nLenSec := ''                  // Longitud del n£mero secuencial
       LOCAL cCodigo := ''                  // C¢digo creado
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CODIGO DEL A¥O
       nTipCod := IF(nTipCod==NIL,1,nTipCod)
       nLenCod := IF(nLenCod==NIL .OR. nLenCod==0,6,nLenCod)

       DO CASE
       CASE nTipCod == 1  // C¢digo con A¤o

	    IF VAL(cAnoUsr) >= 2000
	       cCodAno := SUBS(cAnoUsr,1,1)+cAnoSis
	    ELSE
	       cCodAno := cAnoSis
	    ENDIF

	    IF nLenCod > 7
	       cCodAno := cAnoUsr
	    ENDIF

       CASE nTipCod == 2  // C¢digo secuencial
	    cCodAno := ''
       ENDCASE
*>>>>FIN CODIGO DEL A¥O

*>>>>SECUENCIAL DEL CODIGO
       nLenSec := nLenCod - LEN(cCodAno)
       cCodSec := STR(nNroSec,nLenSec)
       lCorrecion(@cCodSec)
*>>>>FIN SECUENCIAL DEL CODIGO

*>>>>CREACION DEL CODIGO
       DO CASE
       CASE nTipCod == 1  // C¢digo con A¤o

	    IF nLenCod > 5
	       cCodigo := cCodAno+cCodSec
	    ELSE
	       cCodigo := cCodSec
	    ENDIF

       CASE nTipCod == 2  // C¢digo secuencial
	    cCodigo := cCodSec
       ENDCASE
       RETURN cCodigo
*>>>>FIN CREACION DEL CODIGO

/*************************************************************************
* TITULO..: CODIGO DEL ESTUDIANTE                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 07/2009 MIE A
       Colombia, Bucaramanga        INICIO: 09:30 AM   OCT 07/2009 MIE

OBJETIVOS:

1- Asigna espacios a la derecha del c¢digo del estudiante de acuerdo
   a la longitud que se necesite para almacenar,hacer busquedas,etc.

2- Retorna el c¢digo del estudiante.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cCodEstSpc(cCodEst,nLenCod)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodEst                              // C¢digo del Estudiante
       nLenCod                              // Longitud del Codigo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>ASIGNACION DEL CODIGO
       nLenCod := IF(EMPTY(nLenCod),6,nLenCod)
       RETURN SUBS(cCodEst+SPACE(nLenCod),1,nLenCod)
*>>>>FIN ASIGNACION DEL CODIGO

/*************************************************************************
* TITULO..: NOMBRE PARA LA FACTURA                                       *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAR 27/2001 JUE A
       Colombia, Bucaramanga        INICIO: 08:30 PM   MAR 27/2001 JUE

OBJETIVOS:

1- Escoge el nombre de la factura

2- Retorna el nombre

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cNomFacMae(cMaeAct,nNomFac,cApelli,cNombre,cTipNom)

*>>>>DESCRIPCION DE PARAMETROS
/*     cMaeAct                              // Maestro Actual
       nNomFac                              // Nombre de la Factura
       cApelli                              // @Apellido de la Factura
       cNombre                              // @Nombre de la Factura
       cTipNom                              // @Tipo de Nombre de la Factura*/
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cNomFac := ''                  // Nombre para el Recibo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>SELECCION DEL NOMBRE PARA EL RECIBO
       cApelli := ''
       cNombre := ''

       IF &cMaeAct->nNomFacEst == 0

**********NOMBRE SEGUN CONFIGURACION GENERAL
	    DO CASE
	    CASE nNomFac == 1 .OR. nNomFac == 4            // Padre
		 cApelli := ALLTRIM(&cMaeAct->cApePadEst)
		 cNombre := ALLTRIM(&cMaeAct->cNomPadEst)
		 cTipNom := 'Padre'

	    CASE nNomFac == 2 .OR. nNomFac == 5	           // Madre
		 cApelli := ALLTRIM(&cMaeAct->cApeMadEst)
		 cNombre := ALLTRIM(&cMaeAct->cNomMadEst)
		 cTipNom := 'Madre'

	    CASE nNomFac == 3 .OR. nNomFac == 6	           // Acudiente
		 cApelli := ALLTRIM(&cMaeAct->cApeAcuEst)
		 cNombre := ALLTRIM(&cMaeAct->cNomAcuEst)
		 cTipNom := 'Acudiente'

	    ENDCASE
**********FIN NOMBRE SEGUN CONFIGURACION GENERAL

       ELSE

**********NOMBRE SEGUN CONFIGURACION INDIVIDUAL
	    DO CASE
	    CASE &cMaeAct->nNomFacEst == 1                 // Padre
		 cApelli := ALLTRIM(&cMaeAct->cApePadEst)
		 cNombre := ALLTRIM(&cMaeAct->cNomPadEst)
		 cTipNom := 'Padre'

	    CASE &cMaeAct->nNomFacEst == 2                 // Madre
		 cApelli := ALLTRIM(&cMaeAct->cApeMadEst)
		 cNombre := ALLTRIM(&cMaeAct->cNomMadEst)
		 cTipNom := 'Madre'

	    CASE &cMaeAct->nNomFacEst == 3                 // Acudiente
		 cApelli := ALLTRIM(&cMaeAct->cApeAcuEst)
		 cNombre := ALLTRIM(&cMaeAct->cNomAcuEst)
		 cTipNom := 'Acudiente'

	    ENDCASE
**********FIN NOMBRE SEGUN CONFIGURACION INDIVIDUAL

       ENDIF
       cNomFac := cNombre+' '+cApelli
       RETURN cNomFac
*>>>>FIN SELECCION DEL NOMBRE PARA EL RECIBO

/*************************************************************************
* TITULO..: DOCUMENTO NIT DE LA FACTURA                                  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 31/2010 LUN A
       Colombia, Bucaramanga        INICIO: 09:00 AM   MAY 31/2010 LUN

OBJETIVOS:

1- Escoge el n£mero de identificaci¢n de la persona que paga la factura

2- Retorna el documento de identidad


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cNitFacMae(cMaeAct,nNomFac,cApelli,cNombre,cTipNom)

*>>>>DESCRIPCION DE PARAMETROS
/*     cMaeAct                              // Maestro Actual
       nNomFac                              // Nombre de la Factura
       cApelli                              // @Apellido de la Factura
       cNombre                              // @Nombre de la Factura
       cTipNom                              // @Tipo de Nombre de la Factura*/
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cDocNit := ''                  // Nombre para el Recibo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>SELECCION DEL NOMBRE PARA EL RECIBO
       cApelli := ''
       cNombre := ''

       IF &cMaeAct->nNomFacEst == 0

**********NOMBRE SEGUN CONFIGURACION GENERAL
	    DO CASE
	    CASE nNomFac == 1 .OR. nNomFac == 4            // Padre
		 cApelli := ALLTRIM(&cMaeAct->cApePadEst)
		 cNombre := ALLTRIM(&cMaeAct->cNomPadEst)
		 cTipNom := 'Padre'
		 cDocNit := ALLTRIM(&cMaeAct->cPadNitEst)


	    CASE nNomFac == 2 .OR. nNomFac == 5	           // Madre
		 cApelli := ALLTRIM(&cMaeAct->cApeMadEst)
		 cNombre := ALLTRIM(&cMaeAct->cNomMadEst)
		 cTipNom := 'Madre'
		 cDocNit := ALLTRIM(&cMaeAct->cMadNitEst)

	    CASE nNomFac == 3 .OR. nNomFac == 6	           // Acudiente
		 cApelli := ALLTRIM(&cMaeAct->cApeAcuEst)
		 cNombre := ALLTRIM(&cMaeAct->cNomAcuEst)
		 cTipNom := 'Acudiente'
		 cDocNit := ALLTRIM(&cMaeAct->cAcuNitEst)

	    ENDCASE
**********FIN NOMBRE SEGUN CONFIGURACION GENERAL

       ELSE

**********NOMBRE SEGUN CONFIGURACION INDIVIDUAL
	    DO CASE
	    CASE &cMaeAct->nNomFacEst == 1                 // Padre
		 cApelli := ALLTRIM(&cMaeAct->cApePadEst)
		 cNombre := ALLTRIM(&cMaeAct->cNomPadEst)
		 cTipNom := 'Padre'
		 cDocNit := ALLTRIM(&cMaeAct->cPadNitEst)

	    CASE &cMaeAct->nNomFacEst == 2                 // Madre
		 cApelli := ALLTRIM(&cMaeAct->cApeMadEst)
		 cNombre := ALLTRIM(&cMaeAct->cNomMadEst)
		 cTipNom := 'Madre'
		 cDocNit := ALLTRIM(&cMaeAct->cMadNitEst)

	    CASE &cMaeAct->nNomFacEst == 3                 // Acudiente
		 cApelli := ALLTRIM(&cMaeAct->cApeAcuEst)
		 cNombre := ALLTRIM(&cMaeAct->cNomAcuEst)
		 cTipNom := 'Acudiente'
		 cDocNit := ALLTRIM(&cMaeAct->cAcuNitEst)

	    ENDCASE
**********FIN NOMBRE SEGUN CONFIGURACION INDIVIDUAL

       ENDIF
       RETURN cDocNit
*>>>>FIN SELECCION DEL NOMBRE PARA EL RECIBO