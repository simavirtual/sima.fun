/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO  9/2005 MAR A
       Colombia, Bucaramanga        INICIO:  7:38 AM   AGO  9/2005 MAR

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfFam(lShared,nModCry,PathArc,fArchvo,aStrDbf,;
		    cAnoUsr,cMaeAlu)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       PathArc                              // Path del Archivo
       fArchvo                              // Nombre del Archivo
       aStrDbf                              // Estructura del Archivo
       cAnoUsr                              // A¤o del Usuario
       cMaeAlu                              // Maestros Habilitados  */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL PathAct := ''                  // Path Actual

       LOCAL aDbfStr := {}                  // Estructura del Archivo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DE LA ESTRUCTURA
       AADD(aDbfStr,{'nIdeCodFam','Numeric'  ,16,0}) // Ide del Registro
      *Llave Principal

       AADD(aDbfStr,{'cNombreFam','Character',30,0}) // Nombre de la Familia
       AADD(aDbfStr,{'cCodEstFam','Character',60,0}) // C¢digos de Estudiante de la familia
       AADD(aDbfStr,{'cPadNitEst','Character',16,0}) // Documento del Padre
       AADD(aDbfStr,{'cApePadEst','Character',30,0}) // Apellido del Padre
       AADD(aDbfStr,{'cNomPadEst','Character',40,0}) // Nombre del Padre
       AADD(aDbfStr,{'cMadNitEst','Character',16,0}) // Documento de la Madre
       AADD(aDbfStr,{'cApeMadEst','Character',30,0}) // Apellido de la Madre
       AADD(aDbfStr,{'cNomMadEst','Character',40,0}) // Nombre de la Madre

       AADD(aDbfStr,{'cNomUsrFam','Character',10,0}) // Nombre del Usuario
       AADD(aDbfStr,{'dFecUsrFam','Date'     ,08,0}) // Fecha del Usuario
       AADD(aDbfStr,{'cHorUsrFam','Character',10,0}) // Hora del Usuario
*>>>>FIN CREACION DE LA ESTRUCTURA

*>>>>RETORNO DE LA ESTRUCTURA
       IF !EMPTY(aStrDbf)
          aStrDbf := aDbfStr
          RETURN NIL
       ENDIF
*>>>>FIN RETORNO DE LA ESTRUCTURA

*>>>>CREACION DE LA ESTRUCTURA
       PathAct := cPathAct()
       DO CASE
       CASE nCd(PathArc) == 0
            DBCREATE(fArchvo,aDbfStr,'DBFNTX')

       CASE nCd(PathArc) == -3
            cError('NO EXISTE EL DIRECTORIO: '+PathArc)

       CASE nCd(PathArc) == -5
            cError('NO TIENE DERECHOS EN: '+PathArc)
       ENDCASE
       nCd(PathAct)

       Familias(lShared,nModCry,cAnoUsr,PathArc,cMaeAlu)
       RETURN NIL
*>>>>FIN CREACION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL ARCHIVO                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO  9/2005 MAR A
       Colombia, Bucaramanga        INICIO:  7:38 AM   AGO  9/2005 MAR

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenFam(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		   nFilInf,nColInf,cPatSis,cMaeAlu,cJorTxt,cPatCon)

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
       nFilInf                              // Fila Inferior del SubMen£
       nColInf                              // Columna Inferior del SubMen£
       cPatSis                              // Path del Sistema
       cMaeAlu                              // Maestros Habilitados
       cJorTxt                              // Jornada escogida
       cPatCon                              // Path de la Contabilidad */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE 'inkey.ch'                  // Declaraci¢n de teclas

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL       i := 0                   // Contador
       LOCAL lHayPrn := .F.                 // .T. Hay Archivo de Impresi¢n
       LOCAL aUseDbf := {}                  // Archivos en Uso
       LOCAL fArchvo := ''                  // Nombre del Archivo
       LOCAL fNtxArc := ''                  // Archivo Indice
       LOCAL cNalias := ''                  // Alias del Archivo
       LOCAL oBrowse := NIL                 // Browse

       LOCAL nNroPos := 0                   // N£mero de la posici¢n
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CREACION DE LAS FAMILIAS
       cPatCon := IF(EMPTY(cPatCon),'',cPatCon+'\')
       IF lPregunta('DESEA GENERAR LAS FAMILIAS? No Si')

	  nNroPos := RAT('\',aArchvo[1,1])
	  fArchvo := SUBS(aArchvo[1,1],nNroPos+1,LEN(aArchvo[1,1]))

	  CreaDbfFam(lShared,nModCry,cPatCon+cPatSis,fArchvo,NIL,;
		     cAnoUsr,cMaeAlu)

       ENDIF
*>>>>FIN CREACION DE LAS FAMILIAS

*>>>>AREAS DE TRABAJO
       aUseDbf := {}
       FOR i := 1 TO LEN(aArchvo)
           fArchvo := aArchvo[i,1]
           fNtxArc := aArchvo[i,2]
           cNalias := aArchvo[i,3]
           AADD(aUseDbf,{.T.,fArchvo,cNalias,fNtxArc,lShared,nModCry})
           IF cNalias == 'PRN'
              lHayPrn := .T.
           ENDIF
       ENDFOR
*>>>>FIN AREAS DE TRABAJO

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbfs(aUseDbf) .OR.;
	  !lUseMae(lShared,cPatCon+cPatSis,cMaeAlu,cAnoSis)
	  cError('ABRIENDO EL ARCHIVO')
          CloseAll()
          RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>LOCALIZACION DE LA IMPRESORA
       IF lHayPrn
          IF !lLocCodigo('nCodigoPrn','PRN',nCodPrn)
             cError('NO EXISTE LA IMPRESORA QUE ESTA HABILITADA')
             CloseAll()
             RETURN NIL
          ENDIF
       ENDIF
*>>>>FIN LOCALIZACION DE LA IMPRESORA

*>>>>PARAMETROS POR DEFECTO
       lModReg := IF(EMPTY(lModReg),.F.,lModReg)
       lModReg := IF(lModReg .AND. FAM->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfFam(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
                             lModReg,lDelReg,lInsReg,lHaySql)

       SETKEY(K_F2,{||lManRegFam(lShared,cNomUsr,3,oBrowse)})
     *ÀConsulta

       IF lModReg
          SETKEY(K_F4,{||lManRegFam(lShared,cNomUsr,2,oBrowse,;
                                    FAM->cNombreFam)})
       ENDIF
     *ÀActualizar

       SETKEY(K_F5,{||BuscarFam(oBrowse)})

       SETKEY(K_F9,{||MenuOtrFam(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
				 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
				 aArchvo,lPrnArc,cOpcPrn,nCodPrn,;
				 lModReg,lDelReg,lInsReg,lHaySql,;
				 nFilInf,nColInf,cPatSis,cMaeAlu,;
				 cJorTxt,cPatCon,oBrowse)})

       FAM->(CtrlBrw(lShared,oBrowse))

       SETKEY(K_F2,NIL)
       SETKEY(K_F4,NIL)
       SETKEY(K_F5,NIL)
       SETKEY(K_F9,NIL)
       CloseAll()
       RETURN NIL
*>>>>FIN MANTENIMIENTO DEL ARCHIVO

/*************************************************************************
* TITULO..: MENU DE OTROS PARA EL ARCHIVO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO  9/2005 MAR A
       Colombia, Bucaramanga        INICIO:  7:38 AM   AGO  9/2005 MAR

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrFam(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		    cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		    cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		    nFilInf,nColInf,cPatSis,cMaeAlu,cJorTxt,cPatCon,;
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
       nFilInf                              // Fila Inferior del SubMen£
       nColInf                              // Columna Inferior del SubMen£
       cPatSis                              // Path del Sistema
       cMaeAlu                              // Maestros Habilitados
       cJorTxt                              // Jornada escogida
       cPatCon                              // Path de la Contabilidad
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
       AADD(aMenus,'1<FAMILIAS           >')
       AADD(aMenus,'2<FAMILIAS POR CURSO >')
       AADD(aMenus,'3<INFORME DE FAMILIAS>')
       AADD(aMenus,'4<PADRES DE FAMILIA  >')
       IF !EMPTY(cPatCon)
	  AADD(aMenus,'5<TOTAL PAGADO       >')
       ENDIF

       aAyuda := {}
       AADD(aAyuda,'Imprime los Detalles del Archivo')
       AADD(aAyuda,'Imprime Familias de acuerdo al curso')
       AADD(aAyuda,'Imprime Familias con mas de un Hijo')
       AADD(aAyuda,'Imprime los Detalles de los Padres de Familia')
       IF !EMPTY(cPatCon)
	  AADD(aAyuda,'Imprime el total pagado por la Familia')
       ENDIF

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
            OtrFam011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
                      oBrowse)
	   *Impresi¢n de los campos del Archivo

       CASE nNroOpc == 2

	    PrnFamGru(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		      nFilInf,nColInf,cPatSis,cMaeAlu,cJorTxt,cPatCon,;
		      oBrowse)

	   *Familias por Curso

       CASE nNroOpc == 3

	    PrnFamilia(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		      nFilInf,nColInf,cPatSis,cMaeAlu,cJorTxt,cPatCon,;
		      oBrowse)

	   *Informe de familias

       CASE nNroOpc == 4

	    PrnPadres(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		      nFilInf,nColInf,cPatSis,cMaeAlu,cJorTxt,cPatCon,;
		      oBrowse)

	   *Padres de familia

       CASE nNroOpc == 5

	    PrnTotPag(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		      nFilInf,nColInf,cPatSis,cMaeAlu,cJorTxt,cPatCon,;
		      oBrowse)
	   *Total pagado por familia

       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE OPCION ESCOGIDA

/*************************************************************************
* TITULO..: IMPRESION DE LAS FAMILIAS                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 05/2003 LUN A
       Colombia, Bucaramanga        INICIO: 12:00 AM   MAY 05/2003 LUN

OBJETIVOS:

1- Imprime el listado de las Familias

2- Debe estar en uso el archivo de los profesores

3- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION PrnFamilia(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		    cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		    cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		    nFilInf,nColInf,cPatSis,cMaeAlu,cJorTxt,cPatCon,;
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
       nFilInf                              // Fila Inferior del SubMen£
       nColInf                              // Columna Inferior del SubMen£
       cPatSis                              // Path del Sistema
       cMaeAlu                              // Maestros Habilitados
       cJorTxt                              // Jornada escogida
       cPatCon                              // Path de la Contabilidad
       oBrowse                              // Browse del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"           // Archivos Compartidos

       LOCAL cSavPan := ''                  // Salvar Pantalla
     *ÀVariables generales

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

       LOCAL nTipPrn := 0                   // Tipo de Impresi¢n

       LOCAL     i,k := 0                   // Contadores
       LOCAL nAvance := 0                   // Avance de registros
       LOCAL cMaeAct := ''                  // Maestro Actual
     *ÀVariables espec¡ficas

       LOCAL cCodigoTes := ''               // C¢digo del Estudiante
       LOCAL cNombreTes := ''               // Nombre del Estudiante
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CONTENIDO
       IF FAM->(RECCOUNT()) == 0
	  cError('NO EXISTEN FAMILIAS GRABADAS')
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DEL CONTENIDO

*>>>>LECTURA DEL TIPO DE IMPRESION
       nTipPrn := nLeeOpcion('ENTRE EL TIPO DE IMPRESION: '+;
		 '1<TODAS> 2<SOLO HERMANOS> 3<ABANDONAR>?',3,'0')

       IF nTipPrn == 3
	  RETURN NIL
       ENDIF
*>>>>FIN LECTURA DEL TIPO DE IMPRESION

*>>>>DEFINCION DEL ENCABEZADO
       nNroPag := 0
       lTamAnc := .F.

       nTotReg := FAM->(RECCOUNT())+nLinTot

       aCabPrn := {cNomEmp,cNomSis,;
		   'FAMILIAS DEL COLEGIO A¥O:'+cAnoUsr+' JORNADA: '+cJorTxt,;
		   '',;
		   ''}

       aCabeza := {aCabPrn[1],aCabPrn[2],aCabPrn[3],aCabPrn[4],aCabPrn[5],;
		   nNroPag++,;
		   cTotPagina(nTotReg),lTamAnc}

       cCodIni := PCL({'DraftOn','Pica','CondenOn'})
       cCodFin := PCL({'NegraOf','DobGolOf'})
*>>>>FIN DEFINCION DEL ENCABEZADO

*>>>>ENCABEZADOS DE COLUMNA
       aNroCol := {04,30,06,06,80}
       aTitPrn := {'No.','FAMILIA','CODIGO','GRUPO','ESTUDIANTES'}
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
			       nColCab,cCodFin,aCabSec)}
       bDerAut := {||DerechosPrn(cNomSis,cNomEmp,nLenPrn)}
*>>>>FIN ANALISIS PARA CENTRAR EL INFORME

*>>>>ACTIVACION DE LA IMPRESORA
       IF lPrnArc
	  SET DEVICE TO PRINT
       ELSE
	  FilePrn := 'famdoble'
	  nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,cOpcPrn,.F.,.T.,,PathDoc)
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

       nHanXml := CreaFrmPrn(lNoRed,FilePrn,aNroCol,nOpcPrn,aCabPrn,aTitPrn)
*>>>>FIN ACTIVACION DE LA IMPRESORA

*>>>>IMPRESION DEL PLAN ACADEMICO
       cSavPan := SAVESCREEN(0,0,24,79)
       SET DEVICE TO SCREEN
       Termometro(0,'IMPRIMIENDO')
       SET DEVICE TO PRINT

       SELECT FAM
       GO TOP
       DO WHILE .NOT. FAM->(EOF())

**********VISUALIZACION DE AVANCE
	    nAvance := INT(( FAM->(RECNO()) / FAM->(RECCOUNT()) )*100)

	    IF STR(nAvance,3) $ '25 50 75100'
	       SET DEVICE TO SCREEN
	       Termometro(nAvance)
	       SET DEVICE TO PRINT
	    ENDIF
**********FIN VISUALIZACION DE AVANCE

**********ANALISIS DE DECISION
	    IF nTipPrn == 2 .AND.;
	       LEN(ALLTRIM(FAM->cCodEstFam)) == 6

	       FAM->(DBSKIP())
	       IF FAM->(EOF())
		  SET DEVICE TO SCREEN
		  Termometro(100)
		  SET DEVICE TO PRINT
	       ENDIF
	       LOOP

	    ENDIF
**********FIN ANALISIS DE DECISION

**********IMPRESION DE LOS ESTUDIANTES
	    k++
	    FOR i := 1 TO 10

*---------------LECTURA DEL CODIGO
		cCodigoTes := SUBS(FAM->cCodEstFam,i*6-5,6)
		IF EMPTY(cCodigoTes)
		   LOOP
		ENDIF
*---------------FIN LECTURA DEL CODIGO

*---------------BUSQUEDA DEL ESTUDIANTE
		  cNombreTes := 'Estudiante No Existe'
		  IF lSekCodMae(cCodigoTes,cMaeAlu,@cMaeAct)
		     cNombreTes = RTRIM(&cMaeAct->cApelliEst)+' '+;
				  RTRIM(&cMaeAct->cNombreEst)
		     cNombreTes := SUBS(cNombreTes+SPACE(80),1,80)
		  ENDIF
*---------------FIN BUSQUEDA DEL ESTUDIANTE

*---------------IMPRESION DEL REGISTRO
		  aRegPrn := {IF(i==1,STR(k,4),''),;
			      IF(i==1,FAM->cNombreFam,''),;
			      &cMaeAct->cCodigoEst,;
			      &cMaeAct->cCodigoGru,;
			      cNombreTes}
		  lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
			  aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
*---------------FIN IMPRESION DEL REGISTRO

	    ENDFOR
**********FIN IMPRESION DE LOS ESTUDIANTES

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT FAM
	    FAM->(DBSKIP())
	    IF FAM->(EOF())
	       SET DEVICE TO SCREEN
	       Termometro(100)
	       SET DEVICE TO PRINT
	    ENDIF
**********FIN AVANCE DEL SIGUIENTE REGISTRO

       ENDDO
       RESTSCREEN(0,0,24,79,cSavPan)
*>>>>FIN IMPRESION DEL PLAN ACADEMICO

*>>>>IMPRESION DERECHOS
       EVAL(bDerAut)
      *Derechos de Autor

       VerPrn(nOpcPrn,FilePrn,nHanXml)
       SET DEVICE TO SCREEN
       RETURN NIL
*>>>>FIN IMPRESION DERECHOS

/*************************************************************************
* TITULO..: IMPRESION DE LOS PADRES                                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 08/2005 LUN A
       Colombia, Bucaramanga        INICIO: 04:00 AM   AGO 08/2005 LUN

OBJETIVOS:

1- Imprime el listado con los detalles de los padres de familia

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION PrnPadres(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		   nFilInf,nColInf,cPatSis,cMaeAlu,cJorTxt,cPatCon,;
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
       nFilInf                              // Fila Inferior del SubMen£
       nColInf                              // Columna Inferior del SubMen£
       cPatSis                              // Path del Sistema
       cMaeAlu                              // Maestros Habilitados
       cJorTxt                              // Jornada escogida
       cPatCon                              // Path de la Contabilidad
       oBrowse                              // Browse del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"           // Archivos Compartidos

       LOCAL cSavPan := ''                  // Salvar Pantalla
     *ÀVariables generales

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

       LOCAL cMaeAct := ''                  // Maestro Actual
     *ÀVariables espec¡ficas

       LOCAL cNomPad := ''                  // Nombre del Padre
       LOCAL cPadNit := ''                  // Docomento del Padre
       LOCAL cDirPad := ''                  // Direccion del Padre
       LOCAL cTelPad := ''                  // Telefono del Padre

       LOCAL cNomMad := ''                  // Nombre de la Madre
       LOCAL cMadNit := ''                  // Docomento de la Madre
       LOCAL cDirMad := ''                  // Direccion de la Madre
       LOCAL cTelMad := ''                  // Telefono de la Madre

       LOCAL cCodigoTes := ''               // C¢digo del Estudiante
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CONTENIDO
       IF FAM->(RECCOUNT()) == 0
	  cError('NO EXISTEN FAMILIAS GRABADAS')
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DEL CONTENIDO

*>>>>DEFINCION DEL ENCABEZADO
       nNroPag := 0
       lTamAnc := .F.

       nTotReg := FAM->(RECCOUNT())+nLinTot

       aCabPrn := {cNomEmp,cNomSis,;
		   'FAMILIAS DEL COLEGIO A¥O:'+cAnoUsr+' JORNADA: '+cJorTxt,;
		   '',;
		   ''}

       aCabeza := {aCabPrn[1],aCabPrn[2],aCabPrn[3],aCabPrn[4],aCabPrn[5],;
		   nNroPag++,;
		   cTotPagina(nTotReg),lTamAnc}

       cCodIni := PCL({'DraftOn','Pica','CondenOn'})
       cCodFin := PCL({'NegraOf','DobGolOf'})
*>>>>FIN DEFINCION DEL ENCABEZADO

*>>>>ENCABEZADOS DE COLUMNA
       aNroCol := {40,16,06,60,14}
       aTitPrn := {'PADRES','DOCUMENTO','HIJOS','DIRECCION','TELEFONO'}
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
			       nColCab,cCodFin,aCabSec)}
       bDerAut := {||DerechosPrn(cNomSis,cNomEmp,nLenPrn)}
*>>>>FIN ANALISIS PARA CENTRAR EL INFORME

*>>>>ACTIVACION DE LA IMPRESORA
       IF lPrnArc
	  SET DEVICE TO PRINT
       ELSE
	  FilePrn := 'padres'
	  nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,cOpcPrn,.F.,.T.,,PathDoc)
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

       nHanXml := CreaFrmPrn(lNoRed,FilePrn,aNroCol,nOpcPrn,aCabPrn,aTitPrn)
*>>>>FIN ACTIVACION DE LA IMPRESORA

*>>>>IMPRESION DEL PLAN ACADEMICO
       cSavPan := SAVESCREEN(0,0,24,79)
       SELECT FAM
       FAM->(DBGOTOP())
       DO WHILE .NOT. FAM->(EOF())

**********IMPRESION DE LA LINEA DE ESTADO
	    SET DEVICE TO SCREEN
	    LineaEstado('REGISTRO:'+STR(FAM->(RECNO()),4)+'/'+;
				    STR(FAM->(RECCOUNT()),4),cNomSis)
	    SET DEVICE TO PRINT
**********FIN IMPRESION DE LA LINEA DE ESTADO

**********LECTURA DEL CODIGO
	    cCodigoTes := SUBS(FAM->cCodEstFam,1,6)
	    IF EMPTY(cCodigoTes)
	       LOOP
	    ENDIF
**********FIN LECTURA DEL CODIGO

**********BUSQUEDA DEL ESTUDIANTE
	    cNomPad := ''
	    cPadNit := ''
	    cDirPad := ''
	    cTelPad := ''

	    cNomMad := ''
	    cMadNit := ''
	    cDirMad := ''
	    cTelMad := ''

	    IF lSekCodMae(cCodigoTes,cMaeAlu,@cMaeAct)

***************DETALLES DEL PADRE
		 IF !&cMaeAct->lPadQepEst

		    cNomPad := RTRIM(&cMaeAct->cApePadEst)+' '+;
			       RTRIM(&cMaeAct->cNomPadEst)
		    cNomPad := SUBS(cNomPad+SPACE(40),1,40)

		    cPadNit := &cMaeAct->cPadNitEst

		    cDirPad := ALLTRIM(&cMaeAct->cDirPadEst)+' '+;
			       ALLTRIM(&cMaeAct->cBarPadEst)+' '+;
			       ALLTRIM(&cMaeAct->cCiuPadEst)
		    cDirPad := SUBS(cDirPad+SPACE(60),1,60)

		    cTelPad := &cMaeAct->cTelPadEst

		    aRegPrn := {}
		    AADD(aRegPrn,cNomPad)
		    AADD(aRegPrn,cPadNit)
		    AADD(aRegPrn,STR(LEN(ALLTRIM(FAM->cCodEstFam))/6,2))
		    AADD(aRegPrn,cDirPad)
		    AADD(aRegPrn,cTelPad)

		    lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
			    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)

		 ENDIF
***************FIN DETALLES DEL PADRE

***************DETALLES DE LA MADRE
		 IF !&cMaeAct->lMadQepEst

		    cNomMad := RTRIM(&cMaeAct->cApeMadEst)+' '+;
			       RTRIM(&cMaeAct->cNomMadEst)
		    cNomMad := SUBS(cNomMad+SPACE(40),1,40)

		    cMadNit := &cMaeAct->cMadNitEst

		    cDirMad := ALLTRIM(&cMaeAct->cDirMadEst)+' '+;
			       ALLTRIM(&cMaeAct->cBarMadEst)+' '+;
			       ALLTRIM(&cMaeAct->cCiuMadEst)
		    cDirMad := SUBS(cDirMad+SPACE(60),1,60)

		    cTelMad := &cMaeAct->cTelMadEst

		    aRegPrn := {}
		    AADD(aRegPrn,cNomMad)
		    AADD(aRegPrn,cMadNit)
		    AADD(aRegPrn,STR(LEN(ALLTRIM(FAM->cCodEstFam))/6,2))
		    AADD(aRegPrn,cDirMad)
		    AADD(aRegPrn,cTelMad)

		    lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
			    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)

		 ENDIF
***************FIN DETALLES DE LA MADRE

	    ENDIF
**********FIN BUSQUEDA DEL ESTUDIANTE

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT FAM
	    FAM->(DBSKIP())
**********FIN AVANCE DEL SIGUIENTE REGISTRO

       ENDDO
       RESTSCREEN(0,0,24,79,cSavPan)
*>>>>FIN IMPRESION DEL PLAN ACADEMICO

*>>>>IMPRESION DERECHOS
       EVAL(bDerAut)
      *Derechos de Autor

       VerPrn(nOpcPrn,FilePrn,nHanXml)
       SET DEVICE TO SCREEN
       RETURN NIL
*>>>>FIN IMPRESION DERECHOS

/*************************************************************************
* TITULO..: IMPRESION DE LAS FAMILIAS POR GRUPOS                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 05/2003 LUN A
       Colombia, Bucaramanga        INICIO: 12:00 AM   MAY 05/2003 LUN

OBJETIVOS:

1- Imprime el listado de las Familias

2- Debe estar en uso el archivo de los profesores

3- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION PrnFamGru(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		   nFilInf,nColInf,cPatSis,cMaeAlu,cJorTxt,cPatCon,;
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
       nFilInf                              // Fila Inferior del SubMen£
       nColInf                              // Columna Inferior del SubMen£
       cPatSis                              // Path del Sistema
       cMaeAlu                              // Maestros Habilitados
       cJorTxt                              // Jornada escogida
       cPatCon                              // Path de la Contabilidad
       oBrowse                              // Browse del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"           // Archivos Compartidos

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL lHayErr := .F.                 // .T. Hay Error
       LOCAL cIntUno := ''                  // Path de integraci¢n uno
       LOCAL cIntDos := ''                  // Path de integraci¢n dos
       LOCAL cIntTre := ''                  // Path de integraci¢n tres
       LOCAL cIntCua := ''                  // Path de integraci¢n cuatro

       LOCAL cMaeAct := ''                  // Maestro Actual
       LOCAL nOpcPrn := 0                   // Opci¢n de Impresi¢n
       LOCAL nNroFil := 0                   // N£mero de la Fila
       LOCAL nRegIni := 0                   // Registro inicial
       LOCAL nRegFin := 0                   // Registro Final
       LOCAL nGruIni := 0                   // Grupo Inicial
       LOCAL cGruFin := ''                  // C¢digo del grupo final

       FIELD cCodigoGru
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CONTENIDO
       IF FAM->(RECCOUNT()) == 0
	  cError('NO EXISTEN FAMILIAS GRABADAS')
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DEL CONTENIDO

*>>>>GRABACION DE LOS FAMILIARES
       cSavPan := SAVESCREEN(0,0,24,79)
       GraHnoFam(lShared,nModCry,cAnoUsr,cPatSis,cMaeAlu)
       RESTSCREEN(0,0,24,79,cSavPan)
*>>>>FIN GRABACION DE LOS FAMILIARES

*>>>>CAPTURA DE LOS GRUPOS POR INTERVALO
       cSavPan := SAVESCREEN(0,0,24,79)
       nNroFil := nMarco(06,'POR FAVOR SELECIONE EL NIVEL',;
			 22,NIL,NIL,20,60)
       cMaeAct := cNivelEst(nNroFil,21,cMaeAlu)
       RESTSCREEN(0,0,24,79,cSavPan)
*>>>>FIN CAPTURA DE LOS GRUPOS POR INTERVALO

*>>>>AREAS DE TRABAJO
       aUseDbf := {}
       AADD(aUseDbf,{.T.,cPatCon+cPatSis+'\'+cMaeAct+'\'+;
			 FileGru+cMaeAct+cAnoSis+ExtFile,'GRU',;
			 NIL,lShared,nModCry})
*>>>>FIN AREAS DE TRABAJO

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbfs(aUseDbf)
	  cError('ABRIENDO ARCHIVOS')
	  CloseDbf('GRU')
	  RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       lHayErr := .T.
       DO CASE
       CASE GRU->(RECCOUNT()) == 0
	    cError('NO EXISTEN GRUPOS GRABADOS')

       OTHERWISE
	    lHayErr :=.F.
       ENDCASE

       IF lHayErr
	  CloseDbf('GRU')
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>CAPTURA DE LOS GRUPOS POR INTERVALO
       cSavPan := SAVESCREEN(0,0,24,79)
       nNroFil := nMarco(06,'POR FAVOR SELECIONES LOS GRUPOS',;
			 22,NIL,NIL,20,60)
       IF !lIntervGru(nNroFil,21,@nRegIni,@nRegFin)
	  CloseAll(aUseDbf,.F.)
	  RETURN NIL
       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
*>>>>FIN CAPTURA DE LOS GRUPOS POR INTERVALO

*>>>>ACTIVACION DE LA IMPRESORA
       IF lPrnArc
	  SET DEVICE TO PRINT
       ELSE
	  FilePrn := 'famgru'
	  nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,cOpcPrn,.F.,.F.,,PathDoc)
	  IF EMPTY(nOpcPrn)
	     CloseDbf('GRU')
	     RETURN NIL
	  ENDIF
       ENDIF
       SendCodes(PCL('Reset'))
*>>>>FIN ACTIVACION DE LA IMPRESORA

*>>>>IMPRESION POR GRUPOS
       SELECT GRU
       GO nRegFin
       cGruFin = GRU->cCodigoGru

       GO nRegIni
       DO WHILE GRU->(RECNO()) <= nRegFin

**********IMPRESION DE LA LINEA DE ESTADO
	    SET DEVICE TO SCREEN
	    LineaEstado('IMPRIMIENDO EL GRUPO: '+GRU->cCodigoGru+'/'+;
			cGruFin+'ºFAVOR ESPERAR ...',cNomSis)
	    SET DEVICE TO PRINT
**********FIN IMPRESION DE LA LINEA DE ESTADO

**********IMPRESION DE LA LISTA DE CLASE
	    PrnEstFam(lShared,GRU->cCodigoGru,cNomEmp,cNomSis,cAnoUsr,;
		      cMaeAlu,cMaeAct,cJorTxt,nOpcPrn,FilePrn,nHanXml)
**********FIN IMPRESION DE LA LISTA DE CLASE

	  SELECT GRU
	  GRU->(DBSKIP())

       ENDDO
       VerPrn(nOpcPrn,FilePrn,nHanXml)
       RETURN NIL
*>>>>FIN IMPRESION POR GRUPOS

/*************************************************************************
* TITULO..: GRABACION DE LOS FAMILIARES                                  *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 18/2004 MIE A
       Colombia, Bucaramanga        INICIO: 02:00 PM   MAY 18/2004 MIE

OBJETIVOS:

1- Graba para cada estudiante sus parientes

2- Debe estar en uso el archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION GraHnoFam(lShared,nModCry,cAnoUsr,cPatSis,cMaeAlu)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       cAnoUsr				    // A¤o del Sistema
       cMaeAlu                              // Maestros Habilitado */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"           // Archivos Compartidos

       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema

       LOCAL       i := 0                   // Contador
       LOCAL cMaeAct := ''                  // Maestro Actual
       LOCAL nNroFil := 0                   // N£mero de la Fila

       LOCAL cCodigoTes := ''               // C¢digo del Estudiante
       LOCAL cNombreTes := ''               // Nombre del Estudiante
*>>>>FIN DECLARACION DE VARIABLES

*>>>>RECORRIDO DE LAS FAMILIAS
       nNroFil := nMarco(03,'GRABACION DE LOS FAMILIARES')
       SELECT FAM
       FAM->(DBGOTOP())
       DO WHILE .NOT. FAM->(EOF())

**********GRABACION DE LOS FAMILIARES
	    FOR i := 1 TO LEN(ALLTRIM(FAM->cCodEstFam))/6

		cCodigoTes := SUBS(ALLTRIM(FAM->cCodEstFam),i*6-5,6)

*---------------BUSQUEDA DEL ESTUDIANTE
		  cNombreTes := 'Estudiante No Existe'
		  IF !lSekCodMae(cCodigoTes,cMaeAlu,@cMaeAct)
		     LOOP
		  ENDIF
		  cNombreTes = RTRIM(&cMaeAct->cApelliEst)+' '+;
			       RTRIM(&cMaeAct->cNombreEst)
		  cNombreTes := SUBS(cNombreTes+SPACE(40),1,40)
*---------------FIN BUSQUEDA DEL ESTUDIANTE

*--------------IMPRESION DE LA LINEA DE ESTADO
		 LineaEstado('ºFAMILIA:'+SUBS(FAM->cNombreFam,1,20)+;
			     'ºREGISTRO:'+STR(FAM->(RECNO()),4)+'\'+;
					  STR(FAM->(RECCOUNT()),4)+;
			     'ºCODIGO:'+cCodigoTest+;
			     'ºGRUPO:'+&cMaeAct->cCodigoGru,'')
*--------------FIN IMPRESION DE LA LINEA DE ESTADO

*---------------GRABACION DE LOS FAMILIARES
		  SELECT &cMaeAct
		  IF lRegLock(lShared,.F.)
		     REPL &cMaeAct->cCodFamEst WITH FAM->cCodEstFam
		     DBCOMMIT()
		  ELSE
		     cError('NO SE GRABA EL REGISTRO INICIAL DE LA TABLA')
		  ENDIF
		  IF lShared
		     DBUNLOCK()
		  ENDIF
*---------------FIN GRABACION DE LOS FAMILIARES

*---------------VISUALIZACION
		  @ nNroFil,01 SAY FAM->cNombreFam+' '+;
				   ALLTRIM(FAM->cCodEstFam)

		  nNroFil++
		  IF nNroFil == 21
		     nNroFil := nMarco(03,'GRABACION DE LOS FAMILIARES')
		  ENDIF
*---------------FIN VISUALIZACION

	    NEXT
**********FIN GRABACION DE LOS FAMILIARES

	  FAM->(DBSKIP())

       ENDDO
       RETURN NIL
*>>>>FIN RECORRIDO DE LAS FAMILIAS


/*************************************************************************
* TITULO DE LA FUNCION..: IMPRESION DE LA LISTA DE CLASE                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC 06/94 MAR A
						       DIC 06/94 MAR
OBJETIVOS:

1- Imprime imprime una lista de clase para el grupo determinado

2)- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION PrnEstFam(lShared,cCodGru,cNomEmp,cNomSis,cAnoUsr,;
		   cMaeAlu,cMaeAct,cJorTxt,nOpcPrn,FilePrn,nHanXml)

*>>>>PARAMATROS DE LA FUNCION
/*     cCodGru                              // C¢digo del grupo
       cNomEmp                              // Nombre de la Empresa
       cNomSis                              // Nombre del sistema
       cAnoSys                              // A¤o del usuario
       cMaeAlu                              // Maestros Habilitados
       cMaeAct                              // Maestro Actual
       cJorTxt                              // Jornada Escogida
       nOpcPrn                              // Opci¢n de Impresi¢n
       FilePrn                              // Archivo de Impresi¢n
       nHanXml                              // Manejador de Archivo */
*>>>>FIN PARAMATROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
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
     *ÀVariables de informe

       LOCAL       i := 0                   // Contador
       LOCAL nNroPos := 0                   // N£mero de Posici¢n
       LOCAL nLenTxt := 0                   // Longitud del Texto
       LOCAL nNroAlu := 0                   // N£mero de Alumnos
       LOCAL cCodFam := ''                  // C¢digos de Familia
       LOCAL nNroReg := 0                   // N£mero del Registro
       LOCAL cNalias := ''                  // Alias del Archivo
     *ÀVariables espec¡ficas

       LOCAL cCodigoTes := ''               // C¢digo del Estudiante
       LOCAL cNombreTes := ''               // Nombre del Estudiante
       LOCAL cCodigoTgr := ''               // C¢digo del Grupo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DEFINCION DEL ENCABEZADO
       nNroPag := 0
       lTamAnc := .F.

       nTotReg := 0

       aCabPrn := {cNomEmp,cNomSis,;
		   'A¥O: '+cAnoUsr+' JORNADA: '+cJorTxt,;
		   'FAMILIAS POR CURSO',;
		   'CURSO:'+cCodGru}

       aCabeza := {aCabPrn[1],aCabPrn[2],aCabPrn[3],aCabPrn[4],aCabPrn[5],;
		   nNroPag++,;
		   cTotPagina(nTotReg),lTamAnc}

       cCodIni := PCL({'DraftOn','Elite','CondenOn'})
       cCodFin := PCL({'NegraOf','DobGolOf'})
*>>>>FIN DEFINCION DEL ENCABEZADO

*>>>>ENCABEZADOS DE COLUMNA
       aNroCol := {04,06,40,40,06,06}
       aTitPrn := {'No.','CODIGO','ESTUDIANTE','HERMANOS','CODIGO','GRUPO'}
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

*>>>>IMPRESION DEL ENCABEZADO
       SET DEVICE TO PRINT
       SendCodes(PCL('Reset'))

       EVAL(bCabeza)
      *Impresi¢n del Encabezado

       AADD(aCabPrn,cFecPrn)
       AADD(aCabPrn,cHorPrn)
       AADD(aCabPrn,cDiaPrn)
*>>>>FIN IMPRESION DEL ENCABEZADO

*>>>>RECORRIDO DE LOS REGISTROS
       SELECT &cMaeAct
       DBGOTOP()
       DO WHILE .NOT. EOF()

**********ANALISIS DEL GRUPO
	    SELECT &cMaeAct
	    IF &cMaeAct->cCodigoGru # cCodGru

	       SELECT &cMaeAct
	       DBSKIP()
	       LOOP

	    ENDIF
	    nNroReg := RECNO()
**********FIN ANALISIS DEL GRUPO

**********IMPRESION DEL REGISTRO
	    nNroAlu++
	    aRegPrn := {}
	    AADD(aRegPrn,STR(nNroAlu,2))
	    AADD(aRegPrn,&cMaeAct->cCodigoEst)

	    cNombreTes := RTRIM(&cMaeAct->cApelliEst)+' '+;
			  RTRIM(&cMaeAct->cNombreEst)+SPACE(40)
	    cNombreTes := SUBS(cNombreTes,1,40)
	    AADD(aRegPrn,cNombreTes)

	    cCodFam := ALLTRIM(&cMaeAct->cCodFamEst)
	    nNroPos := AT(&cMaeAct->cCodigoEst,cCodFam)
	    nLenTxt := LEN(cCodFam)
	    IF nNroPos == 1
	       cCodFam := SUBS(cCodFam,7,nLenTxt)
	    ELSE
	       cCodFam := SUBS(cCodFam,1,nNroPos-1)+;
			  SUBS(cCodFam,nNroPos+6,nLenTxt)
	    ENDIF

	    IF EMPTY(cCodFam)
	       AADD(aRegPrn,'')
	       AADD(aRegPrn,'')
	       AADD(aRegPrn,'')

	       lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
		       aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
	    ENDIF

	    IF .NOT. EMPTY(cCodFam)

	       FOR i := 1 TO LEN(cCodFam)/6

		   cCodigoTes := SUBS(cCodFam,i*6-5,6)
		   cNombreTes := 'Estudiante No Existe'
		   cCodigoTgr := ''

		   IF lSekCodMae(cCodigoTes,cMaeAlu,@cNalias)
		      cNombreTes = RTRIM(&cNalias->cApelliEst)+' '+;
				   RTRIM(&cNalias->cNombreEst)
		      cNombreTes := SUBS(cNombreTes+SPACE(40),1,40)
		      cCodigoTgr := &cNalias->cCodigoGru
		   ENDIF

		   IF i == 1
		      AADD(aRegPrn,cNombreTes)
		      AADD(aRegPrn,cCodigoTes)
		      AADD(aRegPrn,cCodigoTgr)
		   ELSE
		      aRegPrn := {}
		      AADD(aRegPrn,'')
		      AADD(aRegPrn,'')
		      AADD(aRegPrn,'')
		      AADD(aRegPrn,cNombreTes)
		      AADD(aRegPrn,cCodigoTes)
		      AADD(aRegPrn,cCodigoTgr)
		   ENDIF
		   lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
			   aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)

	       NEXT
	    ENDIF
**********FIN IMPRESION DEL REGISTRO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT &cMaeAct
	    DBGOTO(nNroReg)
	    DBSKIP()
**********FIN AVANCE DEL SIGUIENTE REGISTRO

       ENDDO
*>>>>FIN RECORRIDO DE LOS REGISTROS

*>>>>IMPRESION DERECHOS
       EVAL(bDerAut)
      *Derechos de Autor
       EJECT

       SET DEVICE TO SCREEN
       RETURN NIL
*>>>>FIN IMPRESION DERECHOS

/*************************************************************************
* TITULO..: IMPRESION DEL TOTAL PAGADO POR LA FAMILIA                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 05/2003 LUN A
       Colombia, Bucaramanga        INICIO: 12:00 AM   MAY 05/2003 LUN

OBJETIVOS:

1- Imprime el listado de las Familias

2- Debe estar en uso el archivo de los profesores

3- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION PrnTotPag(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		   nFilInf,nColInf,cPatSis,cMaeAlu,cJorTxt,cPatCon,;
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
       nFilInf                              // Fila Inferior del SubMen£
       nColInf                              // Columna Inferior del SubMen£
       cPatSis                              // Path del Sistema
       cMaeAlu                              // Maestros Habilitados
       cJorTxt                              // Jornada escogida
       cPatCon                              // Path de la Contabilidad
       oBrowse                              // Browse del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"           // Archivos Compartidos

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL lHayErr := .F.                 // .T. Hay Error
       LOCAL cIntUno := ''                  // Path de integraci¢n uno
       LOCAL cIntDos := ''                  // Path de integraci¢n dos
       LOCAL cIntTre := ''                  // Path de integraci¢n tres
       LOCAL cIntCua := ''                  // Path de integraci¢n cuatro

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

       LOCAL       i := 0                   // Total Pagado
       LOCAL nTotFac := 0                   // Total Facturado
       LOCAL nTotPag := 0                   // Total Pagado
       LOCAL nNroFam := 0                   // N£mero de Estudiantes

       LOCAL cCodEst := ''                  // C¢digo del Estudiante
       LOCAL cDocPad := ''                  // N£mero del Documento
       LOCAL cAp1Pad := ''                  // Primer apellido
       LOCAL cAp2Pad := ''                  // Segundo apellido
       LOCAL cNo1Pad := ''                  // Primer Nombre
       LOCAL cNo2Pad := ''                  // Segundo Nombre
       LOCAL cDirPad := ''                  // Direccion del Padre
       LOCAL cCiuPad := ''                  // Ciudad del Padre
       LOCAL cDepPad := ''                  // Departamento del Padre

       LOCAL cDocMad := ''                  // N£mero del Documento
       LOCAL cAp1Mad := ''                  // Primer apellido
       LOCAL cAp2Mad := ''                  // Segundo apellido
       LOCAL cNo1Mad := ''                  // Primer Nombre
       LOCAL cNo2Mad := ''                  // Segundo Nombre
       LOCAL cDirMad := ''                  // Direccion de la Madre
       LOCAL cCiuMad := ''                  // Ciudad de la Madre
       LOCAL cDepMad := ''                  // Departamento de la Madre

       LOCAL cDocNit := ''                  // Documento de Identidad
       LOCAL cApeUno := ''                  // Primer Apellido
       LOCAL cApeDos := ''                  // Segundo Apellido
       LOCAL cNomUno := ''                  // Primer Nombre
       LOCAL cNomDos := ''                  // Segundo Nombre
       LOCAL cDirecc := ''                  // Direccion de la Casa
       LOCAL cCiudad := ''                  // Ciudad de la Direcci¢n
       LOCAL cDepart := ''                  // Departamento de la Direcci¢n

       LOCAL cMaeAct := ''                  // Maestro Actual
       LOCAL Getlist := {}                  // Variable del sistema

       LOCAL cCodigoTes := ''               // C¢digo del Estudiante
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CONTENIDO
       IF FAM->(RECCOUNT()) == 0
	  cError('NO EXISTEN FAMILIAS GRABADAS')
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DEL CONTENIDO

*>>>>INDEXACION DEL ARCHIVO
       fNtxFam := cPatCon+cPatSis+'\'+fNtxFam
       SELECT FAM
       INDEX ON FAM->cNombreFam TO &fNtxFam
*>>>>FIN INDEXACION DEL ARCHIVO

*>>>>ACTIVACION DE LA IMPRESORA
       IF lPrnArc
	  SET DEVICE TO PRINT
       ELSE
	  FilePrn := 'PagosFam'
	  nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,cOpcPrn,.F.,.T.,,PathDoc)
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
		   'TOTAL PAGOS POR FAMILIA',;
		   '',;
		   ''}

       aCabeza := {aCabPrn[1],aCabPrn[2],aCabPrn[3],aCabPrn[4],aCabPrn[5],;
                   nNroPag++,;
                   cTotPagina(nTotReg),lTamAnc}

       cCodIni := PCL({'DraftOn','Elite','CondenOn'})
       cCodFin := PCL({'NegraOf','DobGolOf'})
*>>>>FIN DEFINICION DEL ENCABEZADO

*>>>>ENCABEZADOS DE COLUMNA
       aNroCol := {}
       aTitPrn := {}

       IF nOpcPrn == 7 .OR. nOpcPrn == 8

	  AADD(aNroCol,60)
	  AADD(aTitPrn,'HERMANOS')

	  AADD(aNroCol,16)
	  AADD(aTitPrn,'CC PADRE')

	  AADD(aNroCol,20)
	  AADD(aTitPrn,'APELLIDO1 PADRE')

	  AADD(aNroCol,20)
	  AADD(aTitPrn,'APELLIDO2 PADRE')

	  AADD(aNroCol,20)
	  AADD(aTitPrn,'NOMBRE1 PADRE')

	  AADD(aNroCol,20)
	  AADD(aTitPrn,'NOMBRE2 PADRE')

	  AADD(aNroCol,100)
	  AADD(aTitPrn,'DIRECCION PADRE')

	  AADD(aNroCol,40)
	  AADD(aTitPrn,'CIUDAD PADRE')
	*ÀInformaci¢n del padre

	  AADD(aNroCol,16)
	  AADD(aTitPrn,'CC MADRE')

	  AADD(aNroCol,20)
	  AADD(aTitPrn,'APELLIDO1 MADRE')

	  AADD(aNroCol,20)
	  AADD(aTitPrn,'APELLIDO2 MADRE')

	  AADD(aNroCol,20)
	  AADD(aTitPrn,'NOMBRE1 MADRE')

	  AADD(aNroCol,20)
	  AADD(aTitPrn,'NOMBRE2 MADRE')

	  AADD(aNroCol,100)
	  AADD(aTitPrn,'DIRECCION MADRE')

	  AADD(aNroCol,40)
	  AADD(aTitPrn,'CIUDAD MADRE')
	*ÀInformaci¢n de la madre

	  AADD(aNroCol,16)
	  AADD(aTitPrn,'CC CONTRATANTE')

	  AADD(aNroCol,20)
	  AADD(aTitPrn,'APELLIDO1 CONTRATANTE')

	  AADD(aNroCol,20)
	  AADD(aTitPrn,'APELLIDO2 CONTRATANTE')

	  AADD(aNroCol,20)
	  AADD(aTitPrn,'NOMBRE1 CONTRATANTE')

	  AADD(aNroCol,20)
	  AADD(aTitPrn,'NOMBRE2 CONTRATANTE')

	  AADD(aNroCol,100)
	  AADD(aTitPrn,'DIRECCION CONTRATANTE')

	  AADD(aNroCol,40)
	  AADD(aTitPrn,'CIUDAD CONTRATANTE')
	*ÀInformaci¢n del contratante

	  AADD(aNroCol,12)
	  AADD(aTitPrn,'FACTURADO')

	  AADD(aNroCol,12)
	  AADD(aTitPrn,'PAGADO')

       ELSE

	  AADD(aNroCol,6)
	  AADD(aTitPrn,'No.')

	  AADD(aNroCol,30)
	  AADD(aTitPrn,'FAMILIA')

	  AADD(aNroCol,60)
	  AADD(aTitPrn,'HERMANOS')

	  AADD(aNroCol,12)
	  AADD(aTitPrn,'VALOR')

       ENDIF
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

*>>>>IMPRESION DEL ENCABEZADO
       SendCodes(PCL('Reset'))

       EVAL(bCabeza)
      *Impresi¢n del Encabezado

       AADD(aCabPrn,cFecPrn)
       AADD(aCabPrn,cHorPrn)
       AADD(aCabPrn,cDiaPrn)

       nHanXml := CreaFrmPrn(lShared,FilePrn,aNroCol,nOpcPrn,aCabPrn,aTitPrn)
*>>>>FIN IMPRESION DEL ENCABEZADO

*>>>>RECORRIDO DE LOS REGISTROS
       cSavPan := SAVESCREEN(0,0,24,79)

       SELECT FAM
       FAM->(DBGOTOP())
       DO WHILE .NOT. FAM->(EOF())

**********LINEA DE ESTADO
	    SET DEVICE TO SCREEN
	    LineaEstado('No. '+STR(FAM->(RECNO()),4)+'/'+;
			       STR(FAM->(RECCOUNT()),4),cNomSis)
	    SET DEVICE TO PRINT
**********FIN LINEA DE ESTADO

**********RECORRIDO POR HERMANOS
	    nTotFac := 0
	    nTotPag := 0
	    FOR i := 1 TO LEN(ALLTRIM(FAM->cCodEstFam))/6

*---------------BUSQUEDA DEL ESTUDIANTE
		  cCodigoTes := SUBS(ALLTRIM(FAM->cCodEstFam),i*6-5,6)
		  IF i == 1
		     cCodEst := cCodigoTes
		  ENDIF
		  IF lSekCodMae(cCodigoTes,cMaeAlu,@cMaeAct)
		     nTotFac += &cMaeAct->nTotFacEst
		     nTotPag += &cMaeAct->nTotPagEst
		  ENDIF
*---------------FIN BUSQUEDA DEL ESTUDIANTE

	    NEXT
**********FIN RECORRIDO POR HERMANOS

**********BUSQUEDA DEL PRIMER ESTUDIANTE
	    cDocPad := ''
	    cAp1Pad := ''
	    cAp2Pad := ''
	    cNo1Pad := ''
	    cNo2Pad := ''
	    cDirPad := ''
	    cCiuPad := ''
	  *ÀInformaci¢n del padre

	    cDocMad := ''
	    cAp1Mad := ''
	    cAp2Mad := ''
	    cNo1Mad := ''
	    cNo2Mad := ''
	    cDirMad := ''
	    cCiuMad := ''
	  *ÀInformaci¢n de la Madre

	    IF lSekCodMae(cCodEst,cMaeAlu,@cMaeAct)

	       cDocPad := ALLTRIM(&cMaeAct->cPadNitEst)

	       SepararNom(ALLTRIM(&cMaeAct->cApePadEst),;
			  @cAp1Pad,@cAp2Pad)              // Apellidos

	       SepararNom(ALLTRIM(&cMaeAct->cNomPadEst),;
			  @cNo1Pad,@cNo2Pad)              // Nombres

	       cDirPad := ALLTRIM(&cMaeAct->cDirPadEst)+' '+;
			  ALLTRIM(&cMaeAct->cBarPadEst)
	       cCiuPad := &cMaeAct->cCiuPadEst
	     *ÀInformaci¢n del padre


	       cDocMad := ALLTRIM(&cMaeAct->cMadNitEst)

	       SepararNom(ALLTRIM(&cMaeAct->cApeMadEst),;
			  @cAp1Mad,@cAp2Mad)              // Apellidos

	       SepararNom(ALLTRIM(&cMaeAct->cNomMadEst),;
			  @cNo1Mad,@cNo2Mad)              // Nombres

	       cDirMad := ALLTRIM(&cMaeAct->cDirMadEst)+' '+;
			  ALLTRIM(&cMaeAct->cBarMadEst)
	       cCiuMad := &cMaeAct->cCiuMadEst
	     *ÀInformaci¢n de la Madre

	    ENDIF
**********FIN BUSQUEDA DEL PRIMER ESTUDIANTE

**********LOCALIZACION DE PRIMER CONTRATANTE
	    cDocNit := ''
	    cApeUno := ''
	    cApeDos := ''
	    cNomUno := ''
	    cNomDos := ''
	    cDirecc := ''
	    cCiudad := ''

	    IF lLocNitPer(&cMaeAct->cNitCo1Est,;
			  &cMaeAct->cTipCo1Est)

	       cDocNit := PER->cDocNitPer
	       cApeUno := PER->cApeUnoPer
	       cApeDos := PER->cApeDosPer
	       cNomUno := PER->cNomUnoPer
	       cNomDos := PER->cNomDosPer
	       cDirecc := ALLTRIM(PER->cDireccPer)+' '+;
			  ALLTRIM(PER->cBarrioPer)
	       cCiudad := PER->cCiudadPer

	    ENDIF
**********FIN LOCALIZACION DE PRIMER CONTRATANTE

**********IMPRESION DEL REGISTRO
	    nNroFam++
	    aRegPrn := {}

	    IF nOpcPrn == 7 .OR. nOpcPrn == 8

	       AADD(aRegPrn,FAM->cCodEstFam)

	       AADD(aRegPrn,cDocPad)
	       AADD(aRegPrn,cAp1Pad)
	       AADD(aRegPrn,cAp2Pad)
	       AADD(aRegPrn,cNo1Pad)
	       AADD(aRegPrn,cNo2Pad)
	       AADD(aRegPrn,cDirPad)
	       AADD(aRegPrn,cCiuPad)
	     *ÀInformaci¢n del padre

	       AADD(aRegPrn,cDocMad)
	       AADD(aRegPrn,cAp1Mad)
	       AADD(aRegPrn,cAp2Mad)
	       AADD(aRegPrn,cNo1Mad)
	       AADD(aRegPrn,cNo2Mad)
	       AADD(aRegPrn,cDirMad)
	       AADD(aRegPrn,cCiuMad)
	     *ÀInformaci¢n de la madre

	       AADD(aRegPrn,cDocNit)
	       AADD(aRegPrn,cApeUno)
	       AADD(aRegPrn,cApeDos)
	       AADD(aRegPrn,cNomUno)
	       AADD(aRegPrn,cNomDos)
	       AADD(aRegPrn,cDirecc)
	       AADD(aRegPrn,cCiudad)
	     *ÀInformaci¢n primer contratante

	       AADD(aRegPrn,TRANS(nTotFac,"##########"))
	       AADD(aRegPrn,TRANS(nTotPag,"##########"))

	    ELSE

	       AADD(aRegPrn,STR(nNroFam,6))
	       AADD(aRegPrn,FAM->cNombreFam)
	       AADD(aRegPrn,FAM->cCodEstFam)
	       AADD(aRegPrn,TRANS(nTotPag,"####,###,###"))

	    ENDIF

	    SET DEVICE TO PRINT
	    lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
		    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,;
		    bCabeza)
	    SET DEVICE TO SCREEN
**********FIN IMPRESION DEL REGISTRO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT FAM
	    FAM->(DBSKIP())
**********FIN AVANCE DEL SIGUIENTE REGISTRO

       ENDDO
       RESTSCREEN(0,0,24,79,cSavPan)
*>>>>FIN RECORRIDO DE LOS REGISTROS

*>>>>IMPRESION DERECHOS
       EVAL(bDerAut)
      *Derechos de Autor

       VerPrn(nOpcPrn,FilePrn,nHanXml)
       SET DEVICE TO SCREEN
       RETURN NIL
*>>>>FIN IMPRESION DERECHOS

/*************************************************************************
* TITULO..: LOCALIZAR EL ESTUDIANTE EN LA FAMILIA                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 15/2004 SAB A
       Colombia, Bucaramanga        INICIO: 11:30 AM   MAY 15/2004 SAB

OBJETIVOS:

1- Localiza el c¢digo del estudiante en el c¢digo de familia

2- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lLocCodFam(cPadNit,cApePad,cMadNit,cApeMad,cParNit,cNomFam)

*>>>>DESCRIPCION DE PARAMETROS
/*     cPadNit			      // Documento del Padre
       cApePad                        // Apellido del Padre
       cMadNit			      // Documento de la Madre
       cApeMad                        // Apellido de la Madre
       cParNit                        // Documento del Pariente
       cNomFam                        // @Nombre de la Familia del Pariente */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lExiste := .T.                 // .T. Existe el c¢digo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DEL CODIGO
       SELECT FAM
       FAM->(DBGOTOP())
       LOCATE FOR (FAM->cPadNitEst == cPadNit  .AND.;
		   FAM->cApePadEst == cApePad) .OR.;
		  (FAM->cMadNitEst == cMadNit  .AND.;
		   FAM->cApeMadEst == cApeMad)

       IF .NOT. FOUND()

	  lExiste := .F.
	  IF !EMPTY(cParNit)

	     SELECT FAM
	     FAM->(DBGOTOP())
	     LOCATE FOR FAM->cPadNitEst == cParNit .OR.;
			FAM->cMadNitEst == cParNit
	     IF FOUND()
		lExiste := .T.
		cNomFam := FAM->cNombreFam
	     ENDIF

	  ENDIF
       ENDIF
       RETURN lExiste
*>>>>FIN LOCALIZACION DEL CODIGO

/*************************************************************************
* TITULO..: LOCALIZAR LA FAMILIA                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 15/2004 SAB A
       Colombia, Bucaramanga        INICIO: 11:30 AM   MAY 15/2004 SAB

OBJETIVOS:

1- Localiza el c¢digo del estudiante en el c¢digo de familia

2- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lLocEstFam(cCodFam,cCodEst)

*>>>>DECLARACION DE FAMILIAS
       LOCAL i := 0                         // Contador
       LOCAL lHayCod := .F.                 // .T. Existe el C¢digo

       LOCAL cCodigoEst := ''               // C¢digo del Estudiante
*>>>>FIN DECLARACION DE FAMILIAS

*>>>>LOCALIZACION DEL CODIGO
       FOR i := 1 TO 10
	   cCodigoEst := SUBS(cCodFam,i*6-5,6)
	   IF cCodEst == cCodigoEst
	      lHayCod := .T.
	   ENDIF
       ENDFOR
       RETURN lHayCod
*>>>>FIN LOCALIZACION DEL CODIGO

/*************************************************************************
* TITULO..: CALCULO DE LAS FAMILIAS                                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 15/2004 SAB A
       Colombia, Bucaramanga        INICIO: 11:35 AM   MAY 15/2004 SAB

OBJETIVOS:

1- Calcula las familias de acuerdo al maestro de estudiantes.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION Familias(lShared,nModCry,cAnoUsr,cPatSis,cMaeAlu)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       cAnoUsr				    // A¤o del Sistema
       cMaeAlu                              // Maestros Habilitado */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"           // Archivos Compartidos

       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema

       LOCAL       i := 0                   // Contador
       LOCAL cMaeAct := ''                  // Maestro Actual
       LOCAL nNroFil := 0                   // N£mero de la Fila

       LOCAL cNombreTfa := ''               // Nombre de la familia
       LOCAL cCodEstTfa := ''               // Codigos de estudiantes de la familia
*>>>>FIN DECLARACION DE VARIABLES

*>>>>FAMILIAS DE LOS MAESTROS HABILITADOS
       FOR i := 1 TO LEN(cMaeAlu)/3

***********AREAS DE TRABAJO
	     cMaeAct := SUBS(cMaeAlu,i*3-2,3)
	     aUseDbf := {}
	     AADD(aUseDbf,{.T.,cPatSis+'\'+;
			       FileFam,'FAM',NIL,lShared,nModCry})

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

***********GRABACION DE LAS FAMILIAS
	     nNroFil := nMarco(03,'FAMILIAS DE: '+cMaeAct)

	     SELECT &cMaeAct
	     DO WHILE .NOT. EOF()

*--------------IMPRESION DE LA LINEA DE ESTADO
		 LineaEstado('NIVEL '+cMaeAct+;
			     'ºGRUPO:'+&cMaeAct->cCodigoGru+;
			     'ºREGISTRO:'+;
			      STR(RECNO(),4)+'/'+;
			      STR(RECCOUNT(),4),'')
*--------------FIN IMPRESION DE LA LINEA DE ESTADO

*---------------LOCALIZACION DE LA FAMILIA
		  cNombreTfa := &cMaeAct->cApelliEst

		  IF !lLocCodFam(&cMaeAct->cPadNitEst,&cMaeAct->cApePadEst,;
				 &cMaeAct->cMadNitEst,&cMaeAct->cApeMadEst,;
				 &cMaeAct->cParNitEst,@cNombreTfa)

*....................GRABACION DE LA FAMILIA
		       IF !lLocEstFam(FAM->cCodEstFam,;
				      &cMaeAct->cCodigoEst,;
				      &cMaeAct->cPadNitEst,;
				      &cMaeAct->cMadNitEst)

			  cCodEstTfa := ALLTRIM(FAM->cCodEstFam)+;
					&cMaeAct->cCodigoEst

			  IF FAM->(lRegLock(lShared,.T.))
			     REPL FAM->cNombreFam WITH cNombreTfa
			     REPL FAM->cCodEstFam WITH cCodEstTfa
			     REPL FAM->cPadNitEst WITH &cMaeAct->cPadNitEst
			     REPL FAM->cApePadEst WITH &cMaeAct->cApePadEst
			     REPL FAM->cNomPadEst WITH &cMaeAct->cNomPadEst
			     REPL FAM->cMadNitEst WITH &cMaeAct->cMadNitEst
			     REPL FAM->cApeMadEst WITH &cMaeAct->cApeMadEst
			     REPL FAM->cNomMadEst WITH &cMaeAct->cNomMadEst

			     FAM->(DBCOMMIT())
			  ELSE
			     cError('NO SE GRABA EL REGISTRO INICIAL DE LA TABLA')
			  ENDIF
			  IF lShared
			     FAM->(DBUNLOCK())
			  ENDIF
		       ENDIF
*....................FIN GRABACION DE LA FAMILIA

		  ELSE

*....................GRABACION DE LA FAMILIA
		       IF !lLocEstFam(FAM->cCodEstFam,&cMaeAct->cCodigoEst)

			  cCodEstTfa := ALLTRIM(FAM->cCodEstFam)+;
					&cMaeAct->cCodigoEst

			  IF FAM->(lRegLock(lShared,.F.))
			     REPL FAM->cCodEstFam WITH cCodEstTfa

			     FAM->(DBCOMMIT())
			  ELSE
			     cError('NO SE GRABA EL REGISTRO INICIAL DE LA TABLA')
			  ENDIF
			  IF lShared
			     FAM->(DBUNLOCK())
			  ENDIF
		       ENDIF
*....................FIN GRABACION DE LA FAMILIA

		  ENDIF
*---------------FIN LOCALIZACION DE LA FAMILIA

*---------------VISUALIZACION DE LA CARGA
		  @ nNroFil,01 SAY 'FAMILIA '+FAM->cNombreFam+;
				    ALLTRIM(FAM->cCodEstFam)

		  nNroFil++
		  IF nNroFil == 21
		     nNroFil := nMarco(03,'FAMILIAS DE: '+cMaeAct)
		  ENDIF
*---------------FIN VISUALIZACION DE LA CARGA

		SELECT &cMaeAct
		DBSKIP()

	     ENDDO
***********FIN GRABACION DE LAS FAMILIAS

       ENDFOR
*>>>>FIN FAMILIAS DE LOS MAESTROS HABILITADOS

*>>>>CREACION DEL INDICE
       SELECT FAM
       fNtxFam := cPatSis+'\'+fNtxFam
       INDEX ON FAM->cNombreFam TO &fNtxFam
       DBSETINDEX(fNtxFam)
       CloseAll(aUseDbf)
       IF !lOrdFile(lShared,cPatSis+'\'+FileFam,'cNombreFam')
	  cError('NO SE ORDENO EL MAESTRO')
       ENDIF
       RETURN NIL
*>>>>FIN CREACION DEL INDICE

/*************************************************************************
* TITULO..: SEPARACION DE NONMBRES                                       *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: FEB 26/2009 JUE A
       Colombia, Bucaramanga        INICIO: 10:00 AM   FEB 26/2009 JUE

OBJETIVOS:

1- Permite separar los nombres o apellidos en primer y segundo nombres o
   apellidos.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION SepararNom(cNombre,cNomUno,cNomDos)

*>>>>DESCRIPCION DE PARAMETROS
/*     cNombre                              // Nombres
       cNomUno                              // @Nombre Uno
       cNomDos                              // @Nombre Dos */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroPos := 0                   // N£mero de la posici¢n
*>>>>FIN DECLARACION DE VARIABLES

*>>>>SEPARACION DE LOS NOMBRES
       cNombre := ALLTRIM(cNombre)
       nNroPos := AT(SPACE(01),cNombre)
       IF nNroPos # 0
	  cNomUno := SUBS(cNombre,1,nNroPos-1)
	  cNomDos := SUBS(cNombre,nNroPos+1,LEN(cNombre))
       ELSE
	  cNomUno := cNombre
	  cNomDos := ''
       ENDIF
       RETURN NIL
*>>>>FIN SEPARACION DE LOS NOMBRES