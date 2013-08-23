/*************************************************************************
* TITULO..: MENU DE OTROS PARA EL ARCHIVO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 23/2007 JUE A
       Colombia, Bucaramanga        INICIO:  4:07 PM   AGO 23/2007 JUE

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrStI(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                    cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                    cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
                    oBrowse)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       cNomSis                              // Nombre del Sistema
       cCodEmp                              // C¢digo de la Empresa
       cNitEmp                              // Nit de la Empresa
       cEmpPal                              // Nombre de la Empresa principal
       cNomEmp                              // Nombre de la Empresa
       cNomSec                              // Nombre de la Empresa Secundario
       cNomUsr                              // Nombre del Usuario
       cAnoUsr                              // A¤o del usuario
       aArchvo                              // Archivo en Uso
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
       nCodPrn                              // C¢digo de Impresi¢n
       lModReg                              // .T. Modificar el Registro
       lDelReg                              // .T. Borrar Registros
       lInsReg                              // .T. Insertar Registro
       lHaySql                              // .T. Exportar a Sql
       oBrowse                              // Browse del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL aMenus  := {}                  // Vector de declaracion de men£
       LOCAL aAyuda  := {}                  // Vector de ayudas para el men£
       LOCAL nNroOpc := 1                   // Numero de la opcion

       LOCAL GetList := {}                  // Variable del Sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARCION Y EJECUCION DEL MENU
       aMenus := {}
       AADD(aMenus,'1<POR GRUPOS     >')
       AADD(aMenus,'2<POR MATERIAS   >')
       AADD(aMenus,'3<POR INDICADORES>')

       aAyuda := {}
       AADD(aAyuda,'Imprime las Estad¡sticas por Grupos')
       AADD(aAyuda,'Imprime las Estad¡sticas por Materias')
       AADD(aAyuda,'Imprime las Estad¡sticas por Indicadores')

       cSavPan := SAVESCREEN(0,0,24,79)
       nNroOpc := nMenu(aMenus,aAyuda,10,25,'MENU OTROS',NIL,1,.F.)
       RESTSCREEN(0,0,24,79,cSavPan)
       IF nNroOpc == 0
          RETURN NIL
       ENDIF
*>>>>FIN DECLARCION Y EJECUCION DEL MENU

*>>>>ANALISIS DE OPCION ESCOGIDA
       DO CASE
       CASE nNroOpc == 1
            OtrStI011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
                      oBrowse)
	   *Por Grupos

       CASE nNroOpc == 2
	    OtrStI012(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		      oBrowse)
	   *Por Materias

       CASE nNroOpc == 3
	    OtrStI013(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		      oBrowse)
	   *Por Indicadores

       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE OPCION ESCOGIDA

/*************************************************************************
* TITULO..: ESTADISTICA POR GRUPOS                                       *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 26/2007 MIE A
       Colombia, Bucaramanga        INICIO: 04:32 PM   SEP 26/2007 MIE

OBJETIVOS:

1- Imprime los campos del archivo de mantenimiento

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrStI011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		   oBrowse)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       cNomSis                              // Nombre del Sistema
       cCodEmp                              // C¢digo de la Empresa
       cNitEmp                              // Nit de la Empresa
       cEmpPal                              // Nombre de la Empresa principal
       cNomEmp                              // Nombre de la Empresa
       cNomSec                              // Nombre de la Empresa Secundario
       cNomUsr                              // Nombre del Usuario
       cAnoUsr                              // A¤o del usuario
       aArchvo                              // Archivos en Uso
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
       nCodPrn                              // C¢digo de Impresi¢n
       lModReg                              // .T. Modificar el Registro
       lDelReg                              // .T. Borrar Registros
       lInsReg                              // .T. Insertar Registro
       lHaySql                              // .T. Exportar a Sql
       oBrowse                              // Browse del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL CodGru := 1
       LOCAL CodMat := 2
       LOCAL NotDef := 3
       LOCAL CodInd := 4
       LOCAL EstuSI := 5
       LOCAL EstuNo := 6
       LOCAL EstNoR := 7
       LOCAL CodPro := 8
       LOCAL NroEst := 9
     *ÀIndices

       LOCAL cSavPan := ''                  // Salvar Pantalla
     *ÀVariables generales

       LOCAL FilePrn := ''                  // Archivo de impresion
       LOCAL nRegPrn := 0                   // Registro de Impresi¢n
       LOCAL nHanXml := 0                   // Manejador del Archivo
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

       LOCAL nNroFil := 0                   // Fila de lectura
       LOCAL nNroCol := 0                   // Columna de lectura
       LOCAL nNroPer := 0                   // Total Periodos
       LOCAL nRegIni := 0                   // Registro inicial del grupo
       LOCAL nRegFin := 0                   // Registro Final del grupo
       LOCAL cGruIni := ''                  // C¢digo del grupo inicial
       LOCAL cGruFin := ''                  // C¢digo del grupo final

       LOCAL     i,j := 0                   // Contador
       LOCAL aCodGru := {}                  // C¢digos de Grupos
       LOCAL aCodMat := {}                  // C¢digo de la materia

       LOCAL aNotMat := {}                  // Nota de la materia
       LOCAL aNotPrn := {}                  // Notas a imprimir

       LOCAL aIndMat := {}                  // Indicadores de la materia
       LOCAL aIndPrn := {}                  // Indicadores a imprimir

       LOCAL cCodMat := ''                  // C¢digo de la materia
       LOCAL cCodPro := ''                  // C¢digo del Profesor
       LOCAL cNotDef := ''                  // Nota definitiva
       LOCAL cCodInd := ''                  // C¢digo del indicador
       LOCAL nEstuSi := 0                   // Estudiantes indicador aprobado
       LOCAL nEstuNo := 0                   // Estudiantes indicador no aprobado
       LOCAL nEstNoR := 0                   // Estudiantes indicador recuperado
       LOCAL nNroEst := 0                   // N£mero de Estudiantes
       LOCAL nTotEst := 0                   // Total Estudiantes

       LOCAL nTotGru := 0                   // Total del Grupo
       LOCAL nGrupSi := 0                   // Grupo indicador aprobado
       LOCAL nGrupNo := 0                   // Grupo indicador no aprobado

       LOCAL nTotal  := 0                   // Total del Indicadores
       LOCAL nTotaSi := 0                   // Total indicador aprobado
       LOCAL nTotaNo := 0                   // Total indicador no aprobado
       LOCAL lSiorNo := .F.                 // Variable de decision

       LOCAL cCodigoTgr := ''               // C¢digo del grupo
       LOCAL cCodigoTni := ''               // C¢digo del Nivel
       LOCAL cCodigoTma := ''               // C¢digo de la Materia
       LOCAL cNombreTma := ''               // Nombre de la Materia

       LOCAL cCodigoTpr := ''               // C¢digo del profesor
       LOCAL cNombreTpr := ''               // Nombre del profesor

       LOCAL cNombreTjv := ''               // Nombre del juicio valorativo
       LOCAL cCodigoTju := ''               // C¢digo del indicador
       LOCAL cNombreTju := ''               // Nombre del Indicador
       LOCAL cExtra1Tju := ''               // Indicador extra

       LOCAL Getlist := {}                  // Variable del sistema
     *ÀVariables espec¡ficas
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LECTURA DEL PERIODO
       cSavPan := SAVESCREEN(0,0,24,79)
       SETCURSOR(1)
       TitBuscar(20,@nNroFil,@nNroCol,'INGRESE EL PERIODO:','PERIODO',13)

       nNroPer := nLeeNroPer(nNroFil,nNroCol,3,TCO->nTotPerTbl)

       SETCURSOR(0)
       RESTSCREEN(0,0,24,79,cSavPan)
       IF nNroPer == 0
	  RETURN NIL
       ENDIF
*>>>>FIN LECTURA DEL PERIODO

*>>>>CAPTURA DE LOS GRUPOS POR INTERVALO
       cSavPan := SAVESCREEN(0,0,24,79)
       SETCURSOR(1)
       TitBuscar(20,@nNroFil,@nNroCol,'INGRESE LOS GRUPOS:','GRUPOS',22)

       IF !lIntervGru(nNroFil+1,nNroCol,@nRegIni,@nRegFin)
	  SETCURSOR(0)
	  RESTSCREEN(0,0,24,79,cSavPan)
	  RETURN NIL
       ENDIF

       IF !lPregunta('DESEA CONTINUAR? Si No')
	  SETCURSOR(0)
	  RESTSCREEN(0,0,24,79,cSavPan)
	  RETURN NIL
       ENDIF
       SETCURSOR(0)
       RESTSCREEN(0,0,24,79,cSavPan)
       lSiorNo := lPregunta('DESEA ORDENAR LOS GRUPOS? Si No')
*>>>>FIN CAPTURA DE LOS GRUPOS POR INTERVALO

*>>>>ACTIVACION DE LA IMPRESORA
       nRegPrn := PRN->(RECNO())
       nLenPrn := PCL('n17Stan')

       IF lPrnArc
          SET DEVICE TO PRINT
       ELSE
	  FilePrn := STR(nNroPer,1)+'StIG'+;
		     cMaeActNiv(SUBS(GRU->cCodigoGru,1,2))
	  nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,cOpcPrn,.F.,2)
          IF EMPTY(nOpcPrn)
             RETURN NIL
          ENDIF
       ENDIF
*>>>>FIN ACTIVACION DE LA IMPRESORA

*>>>>DEFINICION DEL ENCABEZADO
       nNroPag := 0
       lTamAnc := .F.

       nTotReg := 0

       aCabPrn := {cNomEmp,cNomSis,;
		   'ESTADISTICAS POR GRUPOS',;
		   '',;
		   'PERIODO No. '+STR(nNroPer,2)}

       aCabeza := {aCabPrn[1],aCabPrn[2],aCabPrn[3],aCabPrn[4],aCabPrn[5],;
                   nNroPag++,;
                   cTotPagina(nTotReg),lTamAnc}

       cCodIni := PCL({'DraftOn','Elite','CondenOn'})
       cCodFin := PCL({'NegraOf','DobGolOf'})
*>>>>FIN DEFINICION DEL ENCABEZADO

*>>>>ENCABEZADOS DE COLUMNA
       aNroCol := {}
       aTitPrn := {}

       AADD(aNroCol,06)
       AADD(aTitPrn,'GRUPO')

       AADD(aNroCol,06)
       AADD(aTitPrn,'ESTU')

       AADD(aNroCol,10)
       AADD(aTitPrn,'APROBADOS')

       AADD(aNroCol,12)
       AADD(aTitPrn,'NO APROBADOS')

       cCabCol := cRegPrint(aTitPrn,aNroCol)
*>>>>FIN ENCABEZADOS DE COLUMNA

*>>>>ANALISIS PARA CENTRAR EL INFORME
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

*>>>>IMPRESION DEL ENCABEZADO
       SendCodes(PCL('Reset'))

       EVAL(bCabeza)
      *Impresi¢n del Encabezado

       AADD(aCabPrn,cFecPrn)
       AADD(aCabPrn,cHorPrn)
       AADD(aCabPrn,cDiaPrn)

       nHanXml := CreaFrmPrn(lShared,FilePrn,aNroCol,nOpcPrn,aCabPrn,aTitPrn)
*>>>>FIN IMPRESION DEL ENCABEZADO

*>>>>RECORRIDO POR GRUPOS
       cSavPan := SAVESCREEN(0,0,24,79)

       SELECT GRU
       GO nRegFin
       cGruFin := GRU->cCodigoGru

       GO nRegIni
       DO WHILE GRU->(RECNO()) <= nRegFin

**********FILTRACION DEL ARCHIVO
	    SELECT STI
	    SET FILTER TO STI->cCodigoGru == GRU->cCodigoGru .AND.;
			  STI->nNroPerStI == nNroPer

	    STI->(DBGOTOP())
	    IF STI->(EOF())
	       SET FILTER TO
	       SELECT GRU
	       GRU->(DBSKIP())
	       LOOP
	    ENDIF
**********FIN FILTRACION DEL ARCHIVO

**********RECORRIDO DE REGISTROS
	    aCodMat := {}
	    aNotMat := {}
	    aIndMat := {}

	    nTotGru := 0
	    nGrupSi := 0
	    nGrupNo := 0

	    SELECT STI
	    STI->(DBGOTOP())
	    DO WHILE .NOT. STI->(EOF())

*===============IMPRESION DE LA LINEA DE ESTADO
		  SET DEVICE TO SCREEN
		  LineaEstado('PERIODO: '+STR(nNroPer,2)+'º'+;
			      'GRUPO: '+GRU->cCodigoGru+'º'+;
			      'No.'+ALLTRIM(STR(STI->(RECNO()),9))+'/'+;
				    ALLTRIM(STR(STI->(RECCOUNT()),9)),cNomSis)
		  SET DEVICE TO PRINT
*===============FIN IMPRESION DE LA LINEA DE ESTADO

*==============MATERIAS DEL GRUPO
		 IF !EMPTY(STI->cNotDefStI) .AND. EMPTY(STI->cCodIndStI)

		    cCodigoTgr := STI->cCodigoGru
		    cCodigoTma := STI->cCodigoMat
		    cCodigoTpr := STI->cCodigoPro

		       cNotDef := STI->cNotDefStI
		       cCodInd := STI->cCodIndStI

		       nEstuSi := STI->nEstuSiStI
		       nEstuNo := STI->nEstuNoStI
		       nEstNoR := STI->nEstNoRStI
		       nNroEst := STI->nTotEstStI

		    PrnStI(cCodigoTgr,cCodigoTma,cCodigoTpr,cNotDef,;
			   cCodInd,nEstuSI,nEstuNo,nEstNoR,nNroEst,;
			   aCodMat,STI->(RECNO()),'aCodMat')

		 ENDIF
*==============FIN MATERIAS DEL GRUPO

*==============NOTAS DE LAS MATERIAS
		 IF !EMPTY(STI->cNotDefStI)  .AND. EMPTY(STI->cCodIndStI)

		    cCodigoTgr := STI->cCodigoGru
		    cCodigoTma := STI->cCodigoMat
		    cCodigoTpr := STI->cCodigoPro

		       cNotDef := STI->cNotDefStI
		       cCodInd := STI->cCodIndStI

		       nEstuSi := STI->nEstuSiStI
		       nEstuNo := STI->nEstuNoStI
		       nEstNoR := STI->nEstNoRStI
		       nNroEst := STI->nTotEstStI

		    PrnStI(cCodigoTgr,cCodigoTma,cCodigoTpr,cNotDef,;
			   cCodInd,nEstuSI,nEstuNo,nEstNoR,nNroEst,;
			   aNotMat,STI->(RECNO()),'aNotMat')
		 ENDIF
*==============FIN NOTAS DE LAS MATERIAS

*==============INDICADORES DE LAS MATERIAS
		 IF !EMPTY(STI->cCodIndStI)

		    cCodigoTgr := STI->cCodigoGru
		    cCodigoTma := STI->cCodigoMat
		    cCodigoTpr := STI->cCodigoPro

		    cNotDef := STI->cNotDefStI
		    cCodInd := STI->cCodIndStI

		    nEstuSi := STI->nEstuSiStI
		    nEstuNo := STI->nEstuNoStI
		    nEstNoR := STI->nEstNoRStI
		    nNroEst := STI->nTotEstStI

		    PrnStI(cCodigoTgr,cCodigoTma,cCodigoTpr,cNotDef,;
			   cCodInd,nEstuSI,nEstuNo,nEstNoR,nNroEst,;
			   aIndMat,STI->(RECNO()),'aIndMat')

		 ENDIF
*==============FIN INDICADORES DE LAS MATERIAS

	       SELECT STI
	       STI->(DBSKIP())

	    ENDDO
**********FIN RECORRIDO DE REGISTROS

**********RECORRIDO POR MATERIAS
	    aCodMat := ASORT(aCodMat,,,{|x,y| x[5] < y[5]})
	    FOR i := 1 TO LEN(aCodMat)

		nNroEst := aCodMat[i,NroEst]
		nTotGru += nNroEst
		 nTotal += nNroEst

		nEstuSi := aCodMat[i,EstuSi]
		nGrupSi += nEstuSi
		nTotaSi += nEstuSi

		nEstuNo := aCodMat[i,EstuNo]
		nGrupNo += nEstuNo
		nTotaNo += nEstuNo

	    ENDFOR
**********FIN RECORRIDO POR MATERIAS

**********ESTADISTICAS DEL GRUPO
	    AADD(aCodGru,{aCodMat[1,CodGru],; // 1. cCodGru
			  nNroEst,;           // 2. Estudiantes
			  nGrupSi,;           // 3. Aprobados
			  nGrupNo,;           // 4. No Aprobados
			  nTotGru})           // 5. Total del Grupo
**********FIN ESTADISTICAS DEL GRUPO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT GRU
	    GRU->(DBSKIP())
	    SET FILTER TO
**********FIN AVANCE DEL SIGUIENTE REGISTRO

       ENDDO
       RESTSCREEN(0,0,24,79,cSavPan)
*>>>>FIN RECORRIDO POR GRUPOS

*>>>>IMPRESION DE LOS GRUPOS
       nTotEst := 0
       IF lSiorNo
	  aCodGru := ASORT(aCodGru,,,{|x,y| x[3] < y[3]})
       ENDIF
       FOR i := 1 TO LEN(aCodGru)

***********IMPRESION DEL REGISTRO
	     aRegPrn := {}
	     AADD(aRegPrn,aCodGru[i,1])

	     nNroEst := aCodGru[i,2]
	     nTotEst += nNroEst

	     AADD(aRegPrn,STR(nNroEst,2,0))

	     nTotGru := aCodGru[i,5]

	     nEstuSi := aCodGru[i,3]
	     AADD(aRegPrn,IF(EMPTY(nEstuSi),'0',cPorcen(nTotGru,nEstuSi)))

	     nEstuNo := aCodGru[i,4]
	     AADD(aRegPrn,IF(EMPTY(nEstuNo),'0',cPorcen(nTotGru,nEstuNo)))

	    lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
		    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
***********FIN IMPRESION DEL REGISTRO

       ENDFOR
*>>>>FIN IMPRESION DE LOS GRUPOS

*>>>>IMPRESION DATOS TOTALES
       aRegPrn := {}
       AADD(aRegPrn,'TOTAL')
       AADD(aRegPrn,STR(nTotEst,4,0))

       nEstuSi := nTotaSi
       AADD(aRegPrn,IF(EMPTY(nEstuSi),'0',cPorcen(nTotal,nEstuSi)))

       nEstuNo := nTotaNo
       AADD(aRegPrn,IF(EMPTY(nEstuNo),'0',cPorcen(nTotal,nEstuNo)))

       lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
	       aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
*>>>>FIN IMPRESION DATOS TOTALES

*>>>>IMPRESION DERECHOS
       EVAL(bDerAut)
      *Derechos de Autor

       VerPrn(nOpcPrn,FilePrn,nHanXml)
       PRN->(DBGOTO(nRegPrn))

       SET DEVICE TO SCREEN
       RETURN NIL
*>>>>FIN IMPRESION DERECHOS

/*************************************************************************
* TITULO..: ESTADISTICA POR MATERIAS                                     *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 23/2007 JUE A
       Colombia, Bucaramanga        INICIO:  4:07 PM   AGO 23/2007 JUE

OBJETIVOS:

1- Imprime los campos del archivo de mantenimiento

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrStI012(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		   oBrowse)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       cNomSis                              // Nombre del Sistema
       cCodEmp                              // C¢digo de la Empresa
       cNitEmp                              // Nit de la Empresa
       cEmpPal                              // Nombre de la Empresa principal
       cNomEmp                              // Nombre de la Empresa
       cNomSec                              // Nombre de la Empresa Secundario
       cNomUsr                              // Nombre del Usuario
       cAnoUsr                              // A¤o del usuario
       aArchvo                              // Archivos en Uso
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
       nCodPrn                              // C¢digo de Impresi¢n
       lModReg                              // .T. Modificar el Registro
       lDelReg                              // .T. Borrar Registros
       lInsReg                              // .T. Insertar Registro
       lHaySql                              // .T. Exportar a Sql
       oBrowse                              // Browse del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL CodGru := 1
       LOCAL CodMat := 2
       LOCAL NotDef := 3
       LOCAL CodInd := 4
       LOCAL EstuSI := 5
       LOCAL EstuNo := 6
       LOCAL EstNoR := 7
       LOCAL CodPro := 8
       LOCAL NroEst := 9
     *ÀIndices

       LOCAL cSavPan := ''                  // Salvar Pantalla
     *ÀVariables generales

       LOCAL FilePrn := ''                  // Archivo de impresion
       LOCAL nRegPrn := 0                   // Registro de Impresi¢n
       LOCAL nHanXml := 0                   // Manejador del Archivo
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

       LOCAL nNroFil := 0                   // Fila de lectura
       LOCAL nNroCol := 0                   // Columna de lectura
       LOCAL nNroPer := 0                   // Total Periodos
       LOCAL nRegIni := 0                   // Registro inicial del grupo
       LOCAL nRegFin := 0                   // Registro Final del grupo
       LOCAL cGruIni := ''                  // C¢digo del grupo inicial
       LOCAL cGruFin := ''                  // C¢digo del grupo final

       LOCAL     i,j := 0                   // Contador
       LOCAL aCodMat := {}                  // C¢digo de la materia

       LOCAL aNotMat := {}                  // Nota de la materia
       LOCAL aNotPrn := {}                  // Notas a imprimir

       LOCAL aIndMat := {}                  // Indicadores de la materia
       LOCAL aIndPrn := {}                  // Indicadores a imprimir

       LOCAL cCodMat := ''                  // C¢digo de la materia
       LOCAL cCodPro := ''                  // C¢digo del Profesor
       LOCAL cNotDef := ''                  // Nota definitiva
       LOCAL cCodInd := ''                  // C¢digo del indicador
       LOCAL nEstuSi := 0                   // Estudiantes indicador aprobado
       LOCAL nEstuNo := 0                   // Estudiantes indicador no aprobado
       LOCAL nEstNoR := 0                   // Estudiantes indicador recuperado
       LOCAL nNroEst := 0                   // N£mero de Estudiantes
       LOCAL lHayNot := .F.                 // .T. Visualizar las notas

       LOCAL nTotGru := 0                   // Total del Grupo
       LOCAL nGrupSi := 0                   // Grupo indicador aprobado
       LOCAL nGrupNo := 0                   // Grupo indicador no aprobado

       LOCAL nTotal  := 0                   // Total del Indicadores
       LOCAL nTotaSi := 0                   // Total indicador aprobado
       LOCAL nTotaNo := 0                   // Total indicador no aprobado

       LOCAL cCodigoTgr := ''               // C¢digo del grupo
       LOCAL cCodigoTni := ''               // C¢digo del Nivel
       LOCAL cCodigoTma := ''               // C¢digo de la Materia
       LOCAL cNombreTma := ''               // Nombre de la Materia

       LOCAL cCodigoTpr := ''               // C¢digo del profesor
       LOCAL cNombreTpr := ''               // Nombre del profesor

       LOCAL cNombreTjv := ''               // Nombre del juicio valorativo
       LOCAL cCodigoTju := ''               // C¢digo del indicador
       LOCAL cNombreTju := ''               // Nombre del Indicador
       LOCAL cExtra1Tju := ''               // Indicador extra

       LOCAL Getlist := {}                  // Variable del sistema
     *ÀVariables espec¡ficas
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LECTURA DEL PERIODO
       cSavPan := SAVESCREEN(0,0,24,79)
       SETCURSOR(1)
       TitBuscar(20,@nNroFil,@nNroCol,'INGRESE EL PERIODO:','PERIODO',13)

       nNroPer := nLeeNroPer(nNroFil,nNroCol,3,TCO->nTotPerTbl)

       SETCURSOR(0)
       RESTSCREEN(0,0,24,79,cSavPan)
       IF nNroPer == 0
	  RETURN NIL
       ENDIF
*>>>>FIN LECTURA DEL PERIODO

*>>>>CAPTURA DE LOS GRUPOS POR INTERVALO
       cSavPan := SAVESCREEN(0,0,24,79)
       SETCURSOR(1)
       TitBuscar(20,@nNroFil,@nNroCol,'INGRESE LOS GRUPOS:','GRUPOS',22)

       IF !lIntervGru(nNroFil+1,nNroCol,@nRegIni,@nRegFin)
	  SETCURSOR(0)
	  RESTSCREEN(0,0,24,79,cSavPan)
	  RETURN NIL
       ENDIF

       IF !lPregunta('DESEA CONTINUAR? Si No')
	  SETCURSOR(0)
	  RESTSCREEN(0,0,24,79,cSavPan)
	  RETURN NIL
       ENDIF
       SETCURSOR(0)
       RESTSCREEN(0,0,24,79,cSavPan)
       lHayNot := lPregunta('DESEA IMPRIMIR LAS NOTAS DE LAS MATERIAS? No Si')
*>>>>FIN CAPTURA DE LOS GRUPOS POR INTERVALO

*>>>>ACTIVACION DE LA IMPRESORA
       nRegPrn := PRN->(RECNO())
       nLenPrn := PCL('n17Stan')

       IF lPrnArc
          SET DEVICE TO PRINT
       ELSE
	  FilePrn := STR(nNroPer,1)+'StIM'+;
		     cMaeActNiv(SUBS(GRU->cCodigoGru,1,2))
	  nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,cOpcPrn,.F.,2)
          IF EMPTY(nOpcPrn)
             RETURN NIL
          ENDIF
       ENDIF
*>>>>FIN ACTIVACION DE LA IMPRESORA

*>>>>DEFINICION DEL ENCABEZADO
       nNroPag := 0
       lTamAnc := .F.

       nTotReg := 0

       aCabPrn := {cNomEmp,cNomSis,;
		   'ESTADISTICAS POR MATERIAS',;
		   '',;
		   'PERIODO No. '+STR(nNroPer,2)}

       aCabeza := {aCabPrn[1],aCabPrn[2],aCabPrn[3],aCabPrn[4],aCabPrn[5],;
                   nNroPag++,;
                   cTotPagina(nTotReg),lTamAnc}

       cCodIni := PCL({'DraftOn','Elite','CondenOn'})
       cCodFin := PCL({'NegraOf','DobGolOf'})
*>>>>FIN DEFINICION DEL ENCABEZADO

*>>>>ENCABEZADOS DE COLUMNA
       aNroCol := {}
       aTitPrn := {}

       AADD(aNroCol,08)
       AADD(aTitPrn,'GRUPO')

       AADD(aNroCol,40)
       AADD(aTitPrn,'DETALLE')

       AADD(aNroCol,10)
       AADD(aTitPrn,'APROBADOS')

       AADD(aNroCol,12)
       AADD(aTitPrn,'NO APROBADOS')

       cCabCol := cRegPrint(aTitPrn,aNroCol)
*>>>>FIN ENCABEZADOS DE COLUMNA

*>>>>ANALISIS PARA CENTRAR EL INFORME
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

*>>>>IMPRESION DEL ENCABEZADO
       SendCodes(PCL('Reset'))

       EVAL(bCabeza)
      *Impresi¢n del Encabezado

       AADD(aCabPrn,cFecPrn)
       AADD(aCabPrn,cHorPrn)
       AADD(aCabPrn,cDiaPrn)

       nHanXml := CreaFrmPrn(lShared,FilePrn,aNroCol,nOpcPrn,aCabPrn,aTitPrn)
*>>>>FIN IMPRESION DEL ENCABEZADO

*>>>>RECORRIDO POR GRUPOS
       cSavPan := SAVESCREEN(0,0,24,79)

       SELECT GRU
       GO nRegFin
       cGruFin := GRU->cCodigoGru

       GO nRegIni
       DO WHILE GRU->(RECNO()) <= nRegFin

**********FILTRACION DEL ARCHIVO
	    SELECT STI
	    SET FILTER TO STI->cCodigoGru == GRU->cCodigoGru .AND.;
			  STI->nNroPerStI == nNroPer

	    STI->(DBGOTOP())
	    IF STI->(EOF())
	       SET FILTER TO
	       SELECT GRU
	       GRU->(DBSKIP())
	       LOOP
	    ENDIF
**********FIN FILTRACION DEL ARCHIVO

**********RECORRIDO DE REGISTROS
	    aCodMat := {}
	    aNotMat := {}
	    aIndMat := {}

	    nTotGru := 0
	    nGrupSi := 0
	    nGrupNo := 0

	    SELECT STI
	    STI->(DBGOTOP())
	    DO WHILE .NOT. STI->(EOF())

*===============IMPRESION DE LA LINEA DE ESTADO
		  SET DEVICE TO SCREEN
		  LineaEstado('PERIODO: '+STR(nNroPer,2)+'º'+;
			      'GRUPO: '+GRU->cCodigoGru+'º'+;
			      'No.'+ALLTRIM(STR(STI->(RECNO()),9))+'/'+;
				    ALLTRIM(STR(STI->(RECCOUNT()),9)),cNomSis)
		  SET DEVICE TO PRINT
*===============FIN IMPRESION DE LA LINEA DE ESTADO

*==============MATERIAS DEL GRUPO
		 IF !EMPTY(STI->cNotDefStI) .AND. EMPTY(STI->cCodIndStI)

		    cCodigoTgr := STI->cCodigoGru
		    cCodigoTma := STI->cCodigoMat
		    cCodigoTpr := STI->cCodigoPro

		       cNotDef := STI->cNotDefStI
		       cCodInd := STI->cCodIndStI

		       nEstuSi := STI->nEstuSiStI
		       nEstuNo := STI->nEstuNoStI
		       nEstNoR := STI->nEstNoRStI
		       nNroEst := STI->nTotEstStI

		    PrnStI(cCodigoTgr,cCodigoTma,cCodigoTpr,cNotDef,;
			   cCodInd,nEstuSI,nEstuNo,nEstNoR,nNroEst,;
			   aCodMat,STI->(RECNO()),'aCodMat')

		 ENDIF
*==============FIN MATERIAS DEL GRUPO

*==============NOTAS DE LAS MATERIAS
		 IF !EMPTY(STI->cNotDefStI) .AND. EMPTY(STI->cCodIndStI)

		    cCodigoTgr := STI->cCodigoGru
		    cCodigoTma := STI->cCodigoMat
		    cCodigoTpr := STI->cCodigoPro

		       cNotDef := STI->cNotDefStI
		       cCodInd := STI->cCodIndStI

		       nEstuSi := STI->nEstuSiStI
		       nEstuNo := STI->nEstuNoStI
		       nEstNoR := STI->nEstNoRStI
		       nNroEst := STI->nTotEstStI

		    PrnStI(cCodigoTgr,cCodigoTma,cCodigoTpr,cNotDef,;
			   cCodInd,nEstuSI,nEstuNo,nEstNoR,nNroEst,;
			   aNotMat,STI->(RECNO()),'aNotMat')
		 ENDIF
*==============FIN NOTAS DE LAS MATERIAS

*==============INDICADORES DE LAS MATERIAS
		 IF !EMPTY(STI->cCodIndStI)

		    cCodigoTgr := STI->cCodigoGru
		    cCodigoTma := STI->cCodigoMat
		    cCodigoTpr := STI->cCodigoPro

		    cNotDef := STI->cNotDefStI
		    cCodInd := STI->cCodIndStI

		    nEstuSi := STI->nEstuSiStI
		    nEstuNo := STI->nEstuNoStI
		    nEstNoR := STI->nEstNoRStI
		    nNroEst := STI->nTotEstStI

		    PrnStI(cCodigoTgr,cCodigoTma,cCodigoTpr,cNotDef,;
			   cCodInd,nEstuSI,nEstuNo,nEstNoR,nNroEst,;
			   aIndMat,STI->(RECNO()),'aIndMat')

		 ENDIF
*==============FIN INDICADORES DE LAS MATERIAS

	       SELECT STI
	       STI->(DBSKIP())

	    ENDDO
**********FIN RECORRIDO DE REGISTROS

**********RECORRIDO POR MATERIAS
	    aCodMat := ASORT(aCodMat,,,{|x,y| x[5] < y[5]})
	    FOR i := 1 TO LEN(aCodMat)

		nNroEst := aCodMat[i,NroEst]
		nTotGru += nNroEst
		 nTotal += nNroEst

*===============LOCALIZACION DE LA MATERIA
		  IF !lLocCodigo('cCodigoMat','MAT',aCodMat[i,CodMat])
		     LOOP
		  ENDIF
		  cNombreTma := MAT->cNombreMat
		  cNombreTma := SUBS(cNombreTma+SPACE(40),1,40)
*===============FIN LOCALIZACION DE LA MATERIA

*===============IMPRESION DEL REGISTRO
		  aRegPrn := {}
		  AADD(aRegPrn,aCodMat[i,CodGru])
		  AADD(aRegPrn,cNombreTma)

		  nEstuSi := aCodMat[i,EstuSi]
		  nGrupSi += nEstuSi
		  nTotaSi += nEstuSi

		  AADD(aRegPrn,cPorcen(nNroEst,nEstuSi)+;
			       IF(nEstuSi==0,'','=')+;
			       ALLTRIM(STR(nEstuSi,4,0)))

		  nEstuNo := aCodMat[i,EstuNo]
		  nGrupNo += nEstuNo
		  nTotaNo += nEstuNo

		  AADD(aRegPrn,cPorcen(nNroEst,nEstuNo)+;
			       IF(nEstuNo==0,'','=')+;
			       ALLTRIM(STR(nEstuNo,4,0)))

		  lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
			  aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
*===============FIN IMPRESION DEL REGISTRO

*===============NOTAS A IMPRIMIR
		  aNotPrn := {}
		  FOR j := 1 TO LEN(aNotMat)

*::::::::::::::::::::ANALISIS DE DECISION
		       IF aCodMat[i,CodMat] # aNotMat[j,CodMat]
			  LOOP
		       ENDIF
*::::::::::::::::::::FIN ANALISIS DE DECISION

*::::::::::::::::::::REGISTRO A IMPRIMIR
		       AADD(aNotPrn,{aNotMat[j,NotDef],;
				     aNotMat[j,EstuSi],;
				     aNotMat[j,EstuNo]})
*::::::::::::::::::::FIN REGISTRO A IMPRIMIR

		  ENDFOR
		  aNotPrn := ASORT(aNotPrn,,,{|x,y| x[3] > y[3]})
*===============FIN NOTAS A IMPRIMIR

*===============RECORRIDO POR NOTAS
		  IF !lHayNot
		     aNotPrn := {}
		  ENDIF
		  FOR j := 1 TO LEN(aNotPrn)

*::::::::::::::::::::LOCALIZACION DEL JUICIO VALORATIVO
		       IF aNotPrn[j,1] # 'SN'
			  IF !lLocCodigo('cCodigoJvf','JVF',aNotPrn[j,1])
			     LOOP
			  ENDIF
			  cNombreTjv := JVF->cNombreJvf
		       ELSE
			  cNombreTjv := 'SIN NOTA'
		       ENDIF
		       cNombreTjv := SUBS(cNombreTjv+SPACE(38),1,38)
*::::::::::::::::::::FIN LOCALIZACION DEL JUICIO VALORATIVO

*::::::::::::::::::::IMPRESION DEL JUICIO VALORATIVO
		       aRegPrn := {}
		       AADD(aRegPrn,IF(j==1,'ALU='+;
					    ALLTRIM(STR(nNroEst,4,0)),''))
		       AADD(aRegPrn,+SPACE(02)+cNombreTjv)

		       nEstuSi := aNotPrn[j,2]
		       AADD(aRegPrn,cPorcen(nNroEst,nEstuSi)+;
				    IF(nEstuSi==0,'','=')+;
				    ALLTRIM(STR(nEstuSi,4,0)))

		       nEstuNo := aNotPrn[j,3]
		       AADD(aRegPrn,cPorcen(nNroEst,nEstuNo)+;
				    IF(nEstuNo==0,'','=')+;
				    ALLTRIM(STR(nEstuNo,4,0)))

		       lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
			       aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
*::::::::::::::::::::FIN IMPRESION DEL JUICIO VALORATIVO

		  ENDFOR
*===============FIN RECORRIDO POR NOTAS

	    ENDFOR
	    RESTSCREEN(0,0,24,79,cSavPan)
**********FIN RECORRIDO POR MATERIAS

**********IMPRESION DATOS DEL GRUPO
	    aRegPrn := {}
	    AADD(aRegPrn,aCodMat[1,CodGru])
	    AADD(aRegPrn,SUBS('ESTUDIANTES='+;
			      STR(nNroEst,2,0)+SPACE(40),1,40))

	    nEstuSi := nGrupSi
	    AADD(aRegPrn,IF(EMPTY(nEstuSi),'0',cPorcen(nTotGru,nEstuSi)))

	    nEstuNo := nGrupNo
	    AADD(aRegPrn,IF(EMPTY(nEstuNo),'0',cPorcen(nTotGru,nEstuNo)))

	    lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
		    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
**********FIN IMPRESION DATOS DEL GRUPO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT GRU
	    GRU->(DBSKIP())
	    SET FILTER TO
**********FIN AVANCE DEL SIGUIENTE REGISTRO

       ENDDO
       RESTSCREEN(0,0,24,79,cSavPan)
*>>>>FIN RECORRIDO POR GRUPOS

*>>>>IMPRESION DATOS TOTALES
       aRegPrn := {}
       AADD(aRegPrn,'')
       AADD(aRegPrn,'TOTALES')

       nEstuSi := nTotaSi
       AADD(aRegPrn,IF(EMPTY(nEstuSi),'0',cPorcen(nTotal,nEstuSi)))

       nEstuNo := nTotaNo
       AADD(aRegPrn,IF(EMPTY(nEstuNo),'0',cPorcen(nTotal,nEstuNo)))

       lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
	       aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
*>>>>FIN IMPRESION DATOS TOTALES

*>>>>IMPRESION DERECHOS
       EVAL(bDerAut)
      *Derechos de Autor

       VerPrn(nOpcPrn,FilePrn,nHanXml)
       PRN->(DBGOTO(nRegPrn))

       SET DEVICE TO SCREEN
       RETURN NIL
*>>>>FIN IMPRESION DERECHOS



/*************************************************************************
* TITULO..: ESTADISTICA POR INDICADORES                                  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 23/2007 JUE A
       Colombia, Bucaramanga        INICIO:  4:07 PM   AGO 23/2007 JUE

OBJETIVOS:

1- Imprime los campos del archivo de mantenimiento

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrStI013(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		   oBrowse)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       cNomSis                              // Nombre del Sistema
       cCodEmp                              // C¢digo de la Empresa
       cNitEmp                              // Nit de la Empresa
       cEmpPal                              // Nombre de la Empresa principal
       cNomEmp                              // Nombre de la Empresa
       cNomSec                              // Nombre de la Empresa Secundario
       cNomUsr                              // Nombre del Usuario
       cAnoUsr                              // A¤o del usuario
       aArchvo                              // Archivos en Uso
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
       nCodPrn                              // C¢digo de Impresi¢n
       lModReg                              // .T. Modificar el Registro
       lDelReg                              // .T. Borrar Registros
       lInsReg                              // .T. Insertar Registro
       lHaySql                              // .T. Exportar a Sql
       oBrowse                              // Browse del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL CodGru := 1
       LOCAL CodMat := 2
       LOCAL NotDef := 3
       LOCAL CodInd := 4
       LOCAL EstuSI := 5
       LOCAL EstuNo := 6
       LOCAL EstNoR := 7
       LOCAL CodPro := 8
       LOCAL NroEst := 9
     *ÀIndices

       LOCAL cSavPan := ''                  // Salvar Pantalla
     *ÀVariables generales

       LOCAL FilePrn := ''                  // Archivo de impresion
       LOCAL nRegPrn := 0                   // Registro de Impresi¢n
       LOCAL nHanXml := 0                   // Manejador del Archivo
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

       LOCAL nNroFil := 0                   // Fila de lectura
       LOCAL nNroCol := 0                   // Columna de lectura
       LOCAL nNroPer := 0                   // Total Periodos
       LOCAL nRegIni := 0                   // Registro inicial del grupo
       LOCAL nRegFin := 0                   // Registro Final del grupo
       LOCAL cGruIni := ''                  // C¢digo del grupo inicial
       LOCAL cGruFin := ''                  // C¢digo del grupo final

       LOCAL     i,j := 0                   // Contador
       LOCAL aCodMat := {}                  // C¢digo de la materia

       LOCAL aNotMat := {}                  // Nota de la materia
       LOCAL aNotPrn := {}                  // Notas a imprimir

       LOCAL aIndMat := {}                  // Indicadores de la materia
       LOCAL aIndPrn := {}                  // Indicadores a imprimir

       LOCAL cCodMat := ''                  // C¢digo de la materia
       LOCAL cCodPro := ''                  // C¢digo del Profesor
       LOCAL cNotDef := ''                  // Nota definitiva
       LOCAL cCodInd := ''                  // C¢digo del indicador

       LOCAL nEstuSi := 0                   // Estudiantes indicador aprobado
       LOCAL nEstuNo := 0                   // Estudiantes indicador no aprobado
       LOCAL nEstNoR := 0                   // Estudiantes indicador recuperado
       LOCAL nNroEst := 0                   // N£mero de Estudiantes

       LOCAL cCodigoTgr := ''               // C¢digo del grupo
       LOCAL cCodigoTni := ''               // C¢digo del Nivel
       LOCAL cCodigoTma := ''               // C¢digo de la Materia
       LOCAL cNombreTma := ''               // Nombre de la Materia

       LOCAL cCodigoTpr := ''               // C¢digo del profesor
       LOCAL cNombreTpr := ''               // Nombre del profesor

       LOCAL cNombreTjv := ''               // Nombre del juicio valorativo
       LOCAL cCodigoTju := ''               // C¢digo del indicador
       LOCAL cNombreTju := ''               // Nombre del Indicador
       LOCAL cExtra1Tju := ''               // Indicador extra

       LOCAL Getlist := {}                  // Variable del sistema
     *ÀVariables espec¡ficas
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LECTURA DEL PERIODO
       cSavPan := SAVESCREEN(0,0,24,79)
       SETCURSOR(1)
       TitBuscar(20,@nNroFil,@nNroCol,'INGRESE EL PERIODO:','PERIODO',13)

       nNroPer := nLeeNroPer(nNroFil,nNroCol,3,TCO->nTotPerTbl)

       SETCURSOR(0)
       RESTSCREEN(0,0,24,79,cSavPan)
       IF nNroPer == 0
	  RETURN NIL
       ENDIF
*>>>>FIN LECTURA DEL PERIODO

*>>>>CAPTURA DE LOS GRUPOS POR INTERVALO
       cSavPan := SAVESCREEN(0,0,24,79)
       SETCURSOR(1)
       TitBuscar(20,@nNroFil,@nNroCol,'INGRESE LOS GRUPOS:','GRUPOS',22)

       IF !lIntervGru(nNroFil+1,nNroCol,@nRegIni,@nRegFin)
	  SETCURSOR(0)
	  RESTSCREEN(0,0,24,79,cSavPan)
	  RETURN NIL
       ENDIF

       IF !lPregunta('DESEA CONTINUAR? Si No')
	  SETCURSOR(0)
	  RESTSCREEN(0,0,24,79,cSavPan)
	  RETURN NIL
       ENDIF
       SETCURSOR(0)
       RESTSCREEN(0,0,24,79,cSavPan)
*>>>>FIN CAPTURA DE LOS GRUPOS POR INTERVALO

*>>>>ACTIVACION DE LA IMPRESORA
       nRegPrn := PRN->(RECNO())
       nLenPrn := PCL('n17Stan')

       IF lPrnArc
          SET DEVICE TO PRINT
       ELSE
	  FilePrn := STR(nNroPer,1)+'StII'+;
		     cMaeActNiv(SUBS(GRU->cCodigoGru,1,2))
	  nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,cOpcPrn,.F.,2)
          IF EMPTY(nOpcPrn)
             RETURN NIL
          ENDIF
       ENDIF
*>>>>FIN ACTIVACION DE LA IMPRESORA

*>>>>DEFINICION DEL ENCABEZADO
       nNroPag := 0
       lTamAnc := .F.

       nTotReg := 0

       aCabPrn := {cNomEmp,cNomSis,;
		   'ESTADISTICAS POR INDICADORES',;
		   '',;
		   'PERIODO No. '+STR(nNroPer,2)}

       aCabeza := {aCabPrn[1],aCabPrn[2],aCabPrn[3],aCabPrn[4],aCabPrn[5],;
                   nNroPag++,;
                   cTotPagina(nTotReg),lTamAnc}

       cCodIni := PCL({'DraftOn','Elite','CondenOn'})
       cCodFin := PCL({'NegraOf','DobGolOf'})
*>>>>FIN DEFINICION DEL ENCABEZADO

*>>>>ENCABEZADOS DE COLUMNA
       aNroCol := {}
       aTitPrn := {}

       AADD(aNroCol,08)
       AADD(aTitPrn,'GRUPO')

       IF nOpcPrn == 6   // A Excel
	  AADD(aNroCol,40)
       ELSE
	  AADD(aNroCol,112)
       ENDIF
       AADD(aTitPrn,'DETALLE')

       AADD(aNroCol,10)
       AADD(aTitPrn,'APROBADOS')

       AADD(aNroCol,12)
       AADD(aTitPrn,'NO APROBADOS')

       AADD(aNroCol,14)
       AADD(aTitPrn,'RECUPERACIONES')

       cCabCol := cRegPrint(aTitPrn,aNroCol)
*>>>>FIN ENCABEZADOS DE COLUMNA

*>>>>ANALISIS PARA CENTRAR EL INFORME
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

*>>>>IMPRESION DEL ENCABEZADO
       SendCodes(PCL('Reset'))

       EVAL(bCabeza)
      *Impresi¢n del Encabezado

       AADD(aCabPrn,cFecPrn)
       AADD(aCabPrn,cHorPrn)
       AADD(aCabPrn,cDiaPrn)

       nHanXml := CreaFrmPrn(lShared,FilePrn,aNroCol,nOpcPrn,aCabPrn,aTitPrn)
*>>>>FIN IMPRESION DEL ENCABEZADO

*>>>>RECORRIDO POR GRUPOS
       cSavPan := SAVESCREEN(0,0,24,79)

       SELECT GRU
       GO nRegFin
       cGruFin := GRU->cCodigoGru

       GO nRegIni
       DO WHILE GRU->(RECNO()) <= nRegFin

**********FILTRACION DEL ARCHIVO
	    SELECT STI
	    SET FILTER TO STI->cCodigoGru == GRU->cCodigoGru .AND.;
			  STI->nNroPerStI == nNroPer

	    STI->(DBGOTOP())
	    IF STI->(EOF())
	       SET FILTER TO
	       SELECT GRU
	       GRU->(DBSKIP())
	       LOOP
	    ENDIF
**********FIN FILTRACION DEL ARCHIVO

**********RECORRIDO DE REGISTROS
	    aCodMat := {}
	    aNotMat := {}
	    aIndMat := {}

	    SELECT STI
	    STI->(DBGOTOP())
	    DO WHILE .NOT. STI->(EOF())

*===============IMPRESION DE LA LINEA DE ESTADO
		  SET DEVICE TO SCREEN
		  LineaEstado('PERIODO: '+STR(nNroPer,2)+'º'+;
			      'GRUPO: '+GRU->cCodigoGru+'º'+;
			      'No.'+ALLTRIM(STR(STI->(RECNO()),9))+'/'+;
				    ALLTRIM(STR(STI->(RECCOUNT()),9)),cNomSis)
		  SET DEVICE TO PRINT
*===============FIN IMPRESION DE LA LINEA DE ESTADO

*==============MATERIAS DEL GRUPO
		 IF !EMPTY(STI->cNotDefStI) .AND. EMPTY(STI->cCodIndStI)

		    cCodigoTgr := STI->cCodigoGru
		    cCodigoTma := STI->cCodigoMat
		    cCodigoTpr := STI->cCodigoPro

		       cNotDef := STI->cNotDefStI
		       cCodInd := STI->cCodIndStI

		       nEstuSi := STI->nEstuSiStI
		       nEstuNo := STI->nEstuNoStI
		       nEstNoR := STI->nEstNoRStI
		       nNroEst := STI->nTotEstStI

		    PrnStI(cCodigoTgr,cCodigoTma,cCodigoTpr,cNotDef,;
			   cCodInd,nEstuSI,nEstuNo,nEstNoR,nNroEst,;
			   aCodMat,STI->(RECNO()),'aCodMat')

		 ENDIF
*==============FIN MATERIAS DEL GRUPO

*==============NOTAS DE LAS MATERIAS
		 IF !EMPTY(STI->cNotDefStI) .AND. EMPTY(STI->cCodIndStI)

		    cCodigoTgr := STI->cCodigoGru
		    cCodigoTma := STI->cCodigoMat
		    cCodigoTpr := STI->cCodigoPro

		       cNotDef := STI->cNotDefStI
		       cCodInd := STI->cCodIndStI

		       nEstuSi := STI->nEstuSiStI
		       nEstuNo := STI->nEstuNoStI
		       nEstNoR := STI->nEstNoRStI
		       nNroEst := STI->nTotEstStI

		    PrnStI(cCodigoTgr,cCodigoTma,cCodigoTpr,cNotDef,;
			   cCodInd,nEstuSI,nEstuNo,nEstNoR,nNroEst,;
			   aNotMat,STI->(RECNO()),'aNotMat')

		 ENDIF
*==============FIN NOTAS DE LAS MATERIAS

*==============INDICADORES DE LAS MATERIAS
		 IF !EMPTY(STI->cCodIndStI)

		    cCodigoTgr := STI->cCodigoGru
		    cCodigoTma := STI->cCodigoMat
		    cCodigoTpr := STI->cCodigoPro

		    cNotDef := STI->cNotDefStI
		    cCodInd := STI->cCodIndStI

		    nEstuSi := STI->nEstuSiStI
		    nEstuNo := STI->nEstuNoStI
		    nEstNoR := STI->nEstNoRStI
		    nNroEst := STI->nTotEstStI

		    PrnStI(cCodigoTgr,cCodigoTma,cCodigoTpr,cNotDef,;
			   cCodInd,nEstuSi,nEstuNo,nEstNoR,nNroEst,;
			   aIndMat,STI->(RECNO()),'aIndMat')

		 ENDIF
*==============FIN INDICADORES DE LAS MATERIAS

	       SELECT STI
	       STI->(DBSKIP())

	    ENDDO
**********FIN RECORRIDO DE REGISTROS

**********RECORRIDO POR MATERIAS
	    aCodMat := ASORT(aCodMat,,,{|x,y| x[5] < y[5]})
	    FOR i := 1 TO LEN(aCodMat)

		nNroEst := aCodMat[i,NroEst]

*===============LOCALIZACION DE LA MATERIA
		  IF !lLocCodigo('cCodigoMat','MAT',aCodMat[i,CodMat])
		     LOOP
		  ENDIF
		  cNombreTma := MAT->cNombreMat
		  cNombreTma := SUBS(cNombreTma+SPACE(112),1,112)
*===============FIN LOCALIZACION DE LA MATERIA

*===============IMPRESION DEL REGISTRO
		  aRegPrn := {}
		  AADD(aRegPrn,aCodMat[i,CodGru])
		  AADD(aRegPrn,cNombreTma)

		  nEstuSi := aCodMat[i,EstuSi]
		  AADD(aRegPrn,cPorcen(nNroEst,nEstuSi)+;
			       IF(nEstuSi==0,'','=')+;
			       ALLTRIM(STR(nEstuSi,4,0)))

		  nEstuNo := aCodMat[i,EstuNo]
		  AADD(aRegPrn,cPorcen(nNroEst,nEstuNo)+;
			       IF(nEstuNo==0,'','=')+;
			       ALLTRIM(STR(nEstuNo,4,0)))

		  AADD(aRegPrn,'')

		  lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
			  aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
*===============FIN IMPRESION DEL REGISTRO

*===============NOTAS A IMPRIMIR
		  aNotPrn := {}
		  FOR j := 1 TO LEN(aNotMat)

*::::::::::::::::::::ANALISIS DE DECISION
		       IF aCodMat[i,CodMat] # aNotMat[j,CodMat]
			  LOOP
		       ENDIF
*::::::::::::::::::::FIN ANALISIS DE DECISION

*::::::::::::::::::::REGISTRO A IMPRIMIR
		       AADD(aNotPrn,{aNotMat[j,NotDef],;
				     aNotMat[j,EstuSi],;
				     aNotMat[j,EstuNo],;
				     aNotMat[j,EstNoR]})
*::::::::::::::::::::FIN REGISTRO A IMPRIMIR

		  ENDFOR
		  aNotPrn := ASORT(aNotPrn,,,{|x,y| x[3] > y[3]})
*===============FIN NOTAS A IMPRIMIR

*===============RECORRIDO POR NOTAS
		  FOR j := 1 TO LEN(aNotPrn)

*::::::::::::::::::::LOCALIZACION DEL JUICIO VALORATIVO
		       IF aNotPrn[j,1] # 'SN'
			  IF !lLocCodigo('cCodigoJvf','JVF',aNotPrn[j,1])
			     LOOP
			  ENDIF
			  cNombreTjv := JVF->cNombreJvf
		       ELSE
			  cNombreTjv := 'SIN NOTA'
		       ENDIF
		       cNombreTjv := SUBS(cNombreTjv+SPACE(110),1,110)
*::::::::::::::::::::FIN LOCALIZACION DEL JUICIO VALORATIVO

*::::::::::::::::::::IMPRESION DEL JUICIO VALORATIVO
		       aRegPrn := {}
		       AADD(aRegPrn,IF(j==1,'ALU='+;
					    ALLTRIM(STR(nNroEst,4,0)),''))
		       AADD(aRegPrn,+SPACE(02)+cNombreTjv)

		       nEstuSi := aNotPrn[j,2]
		       AADD(aRegPrn,cPorcen(nNroEst,nEstuSi)+;
				    IF(nEstuSi==0,'','=')+;
				    ALLTRIM(STR(nEstuSi,4,0)))

		       nEstuNo := aNotPrn[j,3]
		       AADD(aRegPrn,cPorcen(nNroEst,nEstuNo)+;
				    IF(nEstuNo==0,'','=')+;
				    ALLTRIM(STR(nEstuNo,4,0)))

		       nEstNoR := aNotPrn[j,4]
		       AADD(aRegPrn,cPorcen(nEstuNo,nEstNoR)+;
				    IF(nEstNoR==0,'','=')+;
				    ALLTRIM(STR(nEstNoR,4,0)))

		       lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
			       aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
*::::::::::::::::::::FIN IMPRESION DEL JUICIO VALORATIVO

		  ENDFOR
*===============FIN RECORRIDO POR NOTAS

*===============INDICADORES A IMPRIMIR
		  aIndPrn := {}
		  FOR j := 1 TO LEN(aIndMat)

*::::::::::::::::::::ANALISIS DE DECISION
		       IF aCodMat[i,CodMat] # aIndMat[j,CodMat] .OR.;
			  EMPTY(aIndMat[j,CodInd])
			  LOOP
		       ENDIF
*::::::::::::::::::::FIN ANALISIS DE DECISION

*::::::::::::::::::::REGISTRO A IMPRIMIR
		       AADD(aIndPrn,{aIndMat[j,CodInd],;
				     aIndMat[j,EstuSI],;
				     aIndMat[j,EstuNo],;
				     aIndMat[j,EstNoR],;
				     aIndMat[j,NotDef]})
*::::::::::::::::::::FIN REGISTRO A IMPRIMIR

		  ENDFOR
		  aIndPrn := ASORT(aIndPrn,,,{|x,y| x[1] < y[1]})
*===============FIN INDICADORES A IMPRIMIR

*===============RECORRIDO POR INDICADORES
		  FOR j := 1 TO LEN(aIndPrn)

*::::::::::::::::::::BUSQUEDA DEL INDICADOR
		       cCodInd := aIndPrn[j,1]

		       IF lLocCodigo('cCodigoCla','CLA',SUBS(cCodInd,1,1))

			  IF EMPTY(CLA->cCodigoMat)
			     cCodigoTni := SUBS(aCodMat[i,CodGru],1,2)
			     cCodigoTma := aCodMat[i,CodMat]
			  ELSE
			     cCodigoTni := SPACE(02)
			     cCodigoTma := CLA->cCodigoMat
			  ENDIF

		       ENDIF

		       cCodigoTju := cCodigoTni+cCodigoTma+cCodInd
		       cNombreTju := 'NO EXISTE EL CODIGO '+cCodInd
		       cNombreTju := SUBS(cNombreTju+SPACE(106),1,106)
		       cExtra1Tju := ''

		       IF lSekCodigo(cCodigoTju,'IND')
			  cNombreTju := IND->cNombreJui
			  cExtra1Tju := IND->cExtra1Jui
			  cExtra1Tju := SUBS(cExtra1Tju+SPACE(106),1,106)
		       ENDIF
*::::::::::::::::::::FIN BUSQUEDA DEL INDICADOR

*::::::::::::::::::::IMPRESION DEL INDICADOR
		       aRegPrn := {}
		       AADD(aRegPrn,'')
		       AADD(aRegPrn,'-'+aIndPrn[j,5]+':'+;
					aIndPrn[j,1]+':'+;
					cNombreTju)

		       nEstuSi := aIndPrn[j,2]
		       AADD(aRegPrn,cPorcen(nNroEst,nEstuSi)+;
				    IF(nEstuSi==0,'','=')+;
				    ALLTRIM(STR(nEstuSi,4,0)))

		       nEstuNo := aIndPrn[j,3]
		       AADD(aRegPrn,cPorcen(nNroEst,nEstuNo)+;
				    IF(nEstuNo==0,'','=')+;
				    ALLTRIM(STR(nEstuNo,4,0)))

		       nEstNoR := aIndPrn[j,4]
		       AADD(aRegPrn,cPorcen(nEstuNo,nEstNoR)+;
				    IF(nEstNoR==0,'','=')+;
				    ALLTRIM(STR(nEstNoR,4,0)))

		       lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
			       aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)

		       IF !EMPTY(cExtra1Tju)

			  aRegPrn := {}
			  AADD(aRegPrn,STI->cCodigoGru)
			  AADD(aRegPrn,cExtra1Tju)
			  AADD(aRegPrn,'')
			  AADD(aRegPrn,'')
			  AADD(aRegPrn,'')
			  lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
				  aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)

		       ENDIF
*::::::::::::::::::::FIN IMPRESION DEL INDICADOR

		  ENDFOR
*===============FIN RECORRIDO POR INDICADORES

	    ENDFOR
	    RESTSCREEN(0,0,24,79,cSavPan)
**********FIN RECORRIDO POR MATERIAS

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT GRU
	    GRU->(DBSKIP())
	    SET FILTER TO
**********FIN AVANCE DEL SIGUIENTE REGISTRO

       ENDDO
       RESTSCREEN(0,0,24,79,cSavPan)
*>>>>FIN RECORRIDO POR GRUPOS

*>>>>IMPRESION DERECHOS
       EVAL(bDerAut)
      *Derechos de Autor

       VerPrn(nOpcPrn,FilePrn,nHanXml)
       PRN->(DBGOTO(nRegPrn))

       SET DEVICE TO SCREEN
       RETURN NIL
*>>>>FIN IMPRESION DERECHOS



FUNCTION PrnStI(cCodGru,cCodMat,cCodPro,cNotDef,cCodInd,;
		nEstuSI,nEstuNo,nEstNoR,nNroEst,aEstadi,;
		nNroReg,cTipStd)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodGru                              // C¢digo del Grupo
       cCodMat                              // C¢digo de la materia
       cCodPro                              // C¢digo del Profesor
       cNotDef                              // Nota definitiva
       cCodInd			            // C¢digo del indicador
       nEstuSi                              // Estudiantes indicador aprobado
       nEstuNo                              // Estudiantes indicador no aprobado
       nEstNoR                              // Estudiantes indicador recuperado
       nNroEst			            // Total de Estudiantes
       aEstadi                              // @Estadistica
       nNroReg                              // N£mero del Registro
       cTipStd                              // Tipo de Estadistica  */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL CodGru := 1
       LOCAL CodMat := 2
       LOCAL NotDef := 3
       LOCAL CodInd := 4
       LOCAL EstuSI := 5
       LOCAL EstuNo := 6
       LOCAL EstNoR := 7
       LOCAL CodPro := 8
       LOCAL NroEst := 9
     *ÀIndices

       LOCAL      k := 0                         // Contador
*>>>>DECLARACION DE VARIABLES

*>>>>LOCALIZACION DEL INDICADOR
       cNotDef := UPPER(ALLTRIM(cNotDef))
       IF EMPTY(aEstadi)

	  AADD(aEstadi,{cCodGru,;           // 1. cCodGru
			cCodMat,;           // 2. cCodMat
			cNotDef,;           // 3. Nota Definitiva
			SUBS(cCodInd,1,4),; // 4. cCodInd
			0,;                 // 5. nEstuSi
			0,;                 // 6. nEstuNo
			0,;                 // 7. nEstNoR
			cCodPro,;           // 8. cCodPro
			nNroEst})           // 9. N£mero de Estudiantes

	  k := LEN(aEstadi)

       ELSE

	  DO CASE
	  CASE cTipStd == 'aCodMat'
	       k := ASCAN(aEstadi,{|aArr|aArr[CodMat] == cCodMat})

	  CASE cTipStd == 'aNotMat'
	       k := ASCAN(aEstadi,{|aArr|aArr[CodMat] == cCodMat .AND.;
					 aArr[NotDef] == cNotDef})

	  CASE cTipStd == 'aIndMat'
	       k := ASCAN(aEstadi,{|aArr|aArr[CodMat] == cCodMat .AND.;
					 aArr[NotDef] == cNotDef .AND.;
					 aArr[CodInd] == SUBS(cCodInd,1,4)})
	  OTHERWISE
	       k := -1

	  ENDCASE

	  IF k == 0

	     AADD(aEstadi,{cCodGru,;           // 1. cCodGru
			   cCodMat,;           // 2. cCodMat
			   cNotDef,;           // 3. Nota Definitiva
			   SUBS(cCodInd,1,4),; // 4. cCodInd
			   0,;                 // 5. nEstuSi
			   0,;                 // 6. nEstuNo
			   0,;                 // 7. nEstNoR
			   cCodPro,;           // 8. cCodPro
			   nNroEst})           // 9. N£mero de Estudiantes

	     k := LEN(aEstadi)

	  ENDIF

       ENDIF
*>>>>FIN LOCALIZACION DEL INDICADOR

*>>>>CONTEO DE LOS INDICADORES
       IF k > 0

	  DO CASE
	  CASE cTipStd == 'aCodMat'

	       IF aEstadi[k,CodMat] == cCodMat

		  aEstadi[k,EstuSi] += nEstuSi
		  aEstadi[k,EstuNo] += nEstuNo
		  aEstadi[k,EstNoR] += nEstNoR

	       ENDIF

	  CASE cTipStd == 'aNotMat'

	       IF aEstadi[k,EstuSi] == 0
		  aEstadi[k,EstuSi] += nEstuSi
	       ENDIF

	       IF aEstadi[k,EstuNo] == 0
		  aEstadi[k,EstuNo] += nEstuNo
	       ENDIF

	       IF aEstadi[k,EstNoR] == 0
		  aEstadi[k,EstNoR] += nEstNoR
	       ENDIF

	  CASE cTipStd == 'aIndMat'

	       aEstadi[k,EstuSi] += nEstuSi
	       aEstadi[k,EstuNo] += nEstuNo
	       aEstadi[k,EstNoR] += nEstNoR

	  ENDCASE

       ENDIF
       RETURN NIL
*>>>>FIN CONTEO DE LOS INDICADORES