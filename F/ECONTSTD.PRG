/*************************************************************************
* TITULO..: MANTENIMIENTO DEL ARCHIVO                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAR 27/2007 MAR A
       Colombia, Bucaramanga        INICIO: 10:22 AM   MAR 27/2007 MAR

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenStd(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		   cPatSis,cMaeAct)

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
       cPatSis                              // Path del Sistema
       cMaeAct                              // Maestro Actual */
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
*>>>>FIN DECLARACION DE VARIABLES

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
       IF !lUseDbfs(aUseDbf)
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
       lModReg := IF(lModReg .AND. STD->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfStd(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
                             lModReg,lDelReg,lInsReg,lHaySql)

       SETKEY(K_F2,{||lManRegStd(lShared,cNomUsr,3,oBrowse)})
     *ÀConsulta

       IF lModReg
          SETKEY(K_F4,{||lManRegStd(lShared,cNomUsr,2,oBrowse,;
                                    STD->cCodigoGru)})
       ENDIF
     *ÀActualizar

       SETKEY(K_F5,{||BuscarStd(oBrowse)})

       SETKEY(K_F9,{||MenuOtrStd(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
                                 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
                                 aArchvo,lPrnArc,cOpcPrn,nCodPrn,lModReg,;
				 lDelReg,lInsReg,lHaySql,oBrowse,;
				 cPatSis,cMaeAct)})

       STD->(CtrlBrw(lShared,oBrowse))

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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 18/2005 MAR A
       Colombia, Bucaramanga        INICIO: 10:13 AM   OCT 18/2005 MAR

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrStd(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                    cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                    cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		    oBrowse,cPatSis,cMaeAct)

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
       oBrowse                              // Browse del Archivo
       cPatSis                              // Path del Sistema
       cMaeAct                              // Maestro Actual */
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
       AADD(aMenus,'1<POR CURSOS  >')
/*
       AADD(aMenus,'2<POR GRADOS  >')
       AADD(aMenus,'3<POR NIVEL   >')
       AADD(aMenus,'4<POR COLEGIO >')
       AADD(aMenus,'5<POR MATERIA >')
       AADD(aMenus,'6<POR PROFESOR>')
*/

       aAyuda := {}
       AADD(aAyuda,'Imprime las Estadisticas por Cursos')
/*
       AADD(aAyuda,'Imprime las Estadisticas por Grados')
       AADD(aAyuda,'Imprime las Estadisticas por Nivel Jar,Pri,Bto')
       AADD(aAyuda,'Imprime las Estadisticas por Colegio')
       AADD(aAyuda,'Imprime las Estadisticas por Materia')
       AADD(aAyuda,'Imprime las Estadisticas por Profesor')
*/

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
	    OtrStd011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		      oBrowse,nNroOpc,cPatSis,cMaeAct)
	   *Estadisticas por cursos

       CASE nNroOpc == 2

	    OtrStd012(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		      oBrowse,nNroOpc,cPatSis,cMaeAct)
	   *Estadisticas por grados


       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE OPCION ESCOGIDA

/*************************************************************************
* TITULO..: CONVERSION DE UN CAMPO A CARACTERES                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ABR 02/2007 MAR A
       Colombia, Bucaramanga        INICIO: 04:00 PM   ABR 02/2007 MAR

OBJETIVOS:

1- Convierte cualquier campo a caracters

2- Retorna el STRING del campo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cCampoPrn(aStrCam,lMoneda)

*>>>>DESCRIPCION DE PARAMETROS
/*     aStrCam                              // Estructura del Campo
       lMoneda                              // .T. Campo equivalente a dinero */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL xConCam := ''                  // Contenido del Campo
       LOCAL cTipCam := ''                  // Tipo del Campo
       LOCAL nLenCam := ''                  // Longitud del Campo
       LOCAL nNroDec := ''                  // Numero de Decimales

       LOCAL cCamPrn := ''                  // Campo de Impresi¢n
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ESTRUCTURA DEL CAMPO
       xConCam := aStrCam[1]
       cTipCam := aStrCam[2]
       nLenCam := aStrCam[3]
       nNroDec := aStrCam[4]
*>>>>FIN ESTRUCTURA DEL CAMPO

*>>>>CONVERSION DE CAMPO A STRING
       DO CASE
       CASE UPPER(SUBS(cTipCam,1,1)) == 'C'
	    cCamPrn := SUBS(xConCam+SPACE(nLenCam),1,nLenCam)

       CASE UPPER(SUBS(cTipCam,1,1)) == 'D'
	    cCamPrn := cFecha(xConCam)

       CASE UPPER(SUBS(cTipCam,1,1)) == 'L'
	    xConCam := IF(xConCam,'SI','NO')

       CASE UPPER(SUBS(cTipCam,1,1)) == 'N'
	    lMoneda := IF(EMPTY(lMoneda),.F.,lMoneda)
	    IF lMoneda
	       xConCam := TRANS(xConCam,"#####,###,###.99")
	    ELSE
	       xConCam := STR(xConCam,nLenCam,nNroDec)
	    ENDIF
       ENDCASE
       RETURN xConCam
*>>>>FIN CONVERSION DE CAMPO A STRING

/*************************************************************************
* TITULO..: RESGISTRO DE IMPRESION DE LAS ESTADISTICAS                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ABR 09/2007 MAR A
       Colombia, Bucaramanga        INICIO: 03:00 PM   ABR 09/2007 MAR

OBJETIVOS:

1- Arma el registro de impresi¢n de las estadisticas

2- Retorna array aRegPrn de impresi¢n

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aRegPrnStd(aArrStd,lPorcen,lPrnMat,cNomMat)

*>>>>DESCRIPCION DE PARAMETROS
/*     aArrStd                              // Array de estadisticas
       lPorcen                              // Calcular Porcentaje
       lPrnMat                              // .T. Imprimir detalles de materias
       cNomMat                              // Nombre de la Materia */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       k := 0                   // Contador
       LOCAL cCampo  := ''                  // Contenido del Campo
       LOCAL nNroEst := 0                   // N£mero de Estudiantes
       LOCAL nTotJvf := 0                   // Total de Jvf
       LOCAL aRegPrn := {}                  // Registro de Impresi¢n
*>>>>FIN DECLARACION DE VARIABLES

*>>>>NUMERO DE ESTUDIANTES
       k := ASCAN(aArrStd,{|aArray|aArray[1] == 'EST'})
       IF k # 0
	  nNroEst := aArrStd[k,2]
       ENDIF
*>>>>FIN NUMERO DE ESTUDIANTES

*>>>>TOTAL DE JUICIOS VALORATIVOS FINALES
       k := ASCAN(aArrStd,{|aArray|aArray[1] == 'JVF SI'})
       IF k # 0
	  nTotJvf += aArrStd[k,2]
       ENDIF

       k := ASCAN(aArrStd,{|aArray|aArray[1] == 'JVF NO'})
       IF k # 0
	  nTotJvf += aArrStd[k,2]
       ENDIF
*>>>>FIN TOTAL DE JUICIOS VALORATIVOS FINALES

*>>>>REGISTRO DE IMPRESION DE ESTADISTICAS
       k := ASCAN(aArrStd,{|aArray|aArray[1] == 'GRUPO'})
       IF k # 0
	  cCampo := aArrStd[k,2]
	  cCampo := cCampoPrn({cCampo,'C',6,0})
	  AADD(aRegPrn,cCampo)
       ELSE
	  AADD(aRegPrn,SPACE(01))
       ENDIF

       IF lPrnMat
	  cNomMat := IF(EMPTY(cNomMat),'',cNomMat)
	  AADD(aRegPrn,cNomMat)

/*
	  k := ASCAN(aArrStd,{|aArray|aArray[1] == 'PROFESOR'})
	  IF k # 0
	     cCampo := aArrStd[k,2]
	     cCampo := cCampoPrn({cCampo,'C',8,0})
	     AADD(aRegPrn,cCampo)
	  ELSE
	     AADD(aRegPrn,SPACE(01))
	  ENDIF
*/
       ENDIF

/*
       k := ASCAN(aArrStd,{|aArray|aArray[1] == 'PE'})
       IF k # 0
	  cCampo := aArrStd[k,2]
	  cCampo := cCampoPrn({cCampo,'N',2,0})
	  AADD(aRegPrn,cCampo)
       ELSE
	  AADD(aRegPrn,SPACE(01))
       ENDIF
*/

       SELECT JVF
       JVF->(DBGOTOP())
       DO WHILE .NOT. JVF->(EOF())

	  k := ASCAN(aArrStd,;
		    {|aArray|aArray[1] == ALLTRIM(JVF->cCodigoJvf)})
	  IF k # 0
	     cCampo := aArrStd[k,2]
	     IF lPorcen
		cCampo := STR((cCampo*100)/nTotJvf,6,2)+'%'
		cCampo := cCampoPrn({cCampo,'C',6,0})
	     ELSE
		cCampo := cCampoPrn({cCampo,'N',4,0})
	     ENDIF
	     AADD(aRegPrn,cCampo)
	  ELSE
	     AADD(aRegPrn,SPACE(01))
	  ENDIF

	  JVF->(DBSKIP())

       ENDDO

/*
       k := ASCAN(aArrStd,{|aArray|aArray[1] == 'SN'})
       IF k # 0
	  cCampo := aArrStd[k,2]
	  IF lPorcen
	     cCampo := STR((cCampo*100)/nNroEst,6,2)+'%'
	     cCampo := cCampoPrn({cCampo,'C',6,0})
	  ELSE
	     cCampo := cCampoPrn({cCampo,'N',4,0})
	  ENDIF
	  AADD(aRegPrn,cCampo)
       ELSE
	  AADD(aRegPrn,SPACE(01))
       ENDIF
     *ÀSin Notas
*/

       k := ASCAN(aArrStd,{|aArray|aArray[1] == 'JVF SI'})
       IF k # 0
	  cCampo := aArrStd[k,2]
	  IF lPorcen
	     cCampo := STR((cCampo*100)/nTotJvf,6,2)+'%'
	     cCampo := cCampoPrn({cCampo,'C',6,0})
	  ELSE
	     cCampo := cCampoPrn({cCampo,'N',4,0})
	  ENDIF
	  AADD(aRegPrn,cCampo)
       ELSE
	  AADD(aRegPrn,SPACE(01))
       ENDIF

       k := ASCAN(aArrStd,{|aArray|aArray[1] == 'JVF NO'})
       IF k # 0
	  cCampo := aArrStd[k,2]
	  IF lPorcen
	     cCampo := STR((cCampo*100)/nTotJvf,6,2)+'%'
	     cCampo := cCampoPrn({cCampo,'C',6,0})
	  ELSE
	     cCampo := cCampoPrn({cCampo,'N',4,0})
	  ENDIF
	  AADD(aRegPrn,cCampo)
       ELSE
	  AADD(aRegPrn,SPACE(01))
       ENDIF

/*
       k := ASCAN(aArrStd,{|aArray|aArray[1] == 'IND SI'})
       IF k # 0
	  cCampo := aArrStd[k,2]
	  IF lPorcen
	     cCampo := STR((cCampo*100)/nTotJvf,3)+'%'
	     cCampo := cCampoPrn({cCampo,'C',4,0})
	  ELSE
	     cCampo := cCampoPrn({cCampo,'N',4,0})
	  ENDIF
	  AADD(aRegPrn,cCampo)
       ELSE
	  AADD(aRegPrn,SPACE(01))
       ENDIF

       k := ASCAN(aArrStd,{|aArray|aArray[1] == 'IND NO'})
       IF k # 0
	  cCampo := aArrStd[k,2]
	  IF lPorcen
	     cCampo := STR((cCampo*100)/nTotJvf,3)+'%'
	     cCampo := cCampoPrn({cCampo,'C',4,0})
	  ELSE
	     cCampo := cCampoPrn({cCampo,'N',4,0})
	  ENDIF
	  AADD(aRegPrn,cCampo)
       ELSE
	  AADD(aRegPrn,SPACE(01))
       ENDIF

       k := ASCAN(aArrStd,{|aArray|aArray[1] == 'EST'})
       IF k # 0
	  cCampo := aArrStd[k,2]
	  cCampo := cCampoPrn({cCampo,'N',4,0})
	  AADD(aRegPrn,cCampo)
       ELSE
	  AADD(aRegPrn,SPACE(01))
       ENDIF
*/

       RETURN aRegPrn
*>>>>REGISTRO DE IMPRESION DE ESTADISTICAS

/*************************************************************************
* TITULO..: ESTADISTICAS POR CURSOS                                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 18/2005 MAR A
       Colombia, Bucaramanga        INICIO: 10:13 AM   OCT 18/2005 MAR

OBJETIVOS:

1- Imprime las estad¡sticas por Grupos

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrStd011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		   oBrowse,nNroOpc,cPatSis,cMaeAct)

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
       oBrowse                              // Browse del Archivo
       nNroOpc                              // N£mero de la Opci¢n
       cPatSis                              // Path del Sistema
       cMaeAct                              // Maestro Actual */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL lHayErr := .F.                 // .T. Hay Error
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
       LOCAL cColPrn := ''                  // Columna de Impresi¢n

       LOCAL PathPrn := 'PRINTER'           // Path para impresiones
       LOCAL aStrPrn := {}                  // Estructura del Archivo
     *ÀVariables de informe

       LOCAL   i,k,y := 0                   // Contador
       LOCAL nNroPer := 0                   // Total Periodos
       LOCAL nRegIni := 0                   // Registro inicial del grupo
       LOCAL nRegFin := 0                   // Registro Final del grupo
       LOCAL cGruIni := ''                  // C¢digo del grupo inicial
       LOCAL cGruFin := ''                  // C¢digo del grupo final
       LOCAL nNroFil := 0                   // Fila de lectura
       LOCAL nNroCol := 0                   // Columna de lectura
       LOCAL cCodAct := ''                  // C¢digo Actual
       LOCAL cCodAnt := ''                  // C¢digo Anterior
       LOCAL lRegUno := .T.                 // .T. Primer Registro
       LOCAL nJuiSAp := 0                   // Juicios Si Aprobados
       LOCAL nJuiNAp := 0                   // Juicios No Aprobados
       LOCAL aJvfMat := {}                  // Total Juicios Valorativos por materia
       LOCAL lPorcen := .F.                 // .T. Imprimir Porcentajes
       LOCAL lPrnMat := .F.                 // .T. Imprimir detalles de materias

       LOCAL aNotAre := {}                  // Detalles de las areas
       LOCAL aNotMat := {}                  // Detalles de las materias
       LOCAL aStdMat := {}                  // Estadistica de la materia
       LOCAL aStdGru := {}                  // Estadistica por Grupo
       LOCAL aTotStd := {}                  // Total de Estadisticas
       LOCAL aMatPrn := {}                  // Materias a Imprimir
       LOCAL cCampo  := ''                  // Contenido del Campo
       LOCAL nGruPrn := 0                   // N£mero de Grupos impresos

       LOCAL nAvance := 0                   // Avance de registros
       LOCAL Getlist := {}                  // Variable del sistema
     *ÀVariables espec¡ficas

       LOCAL cCodigoTma := ''               // C¢digo de la Materia
       LOCAL cNombreTma := ''               // Nombre de la Materia
       LOCAL cCodigoTpr := ''               // C¢digo del Profesor
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
       lPorcen := lPregunta('DESEA IMPRIMIR COMO PORCENTAJES? Si No')
       lPrnMat := lPregunta('DESEA IMPRIMIR LAS MATERIAS? Si No')
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
	  FilePrn := 'GrStd'+cMaeAct
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
		   'ESTADISTICAS POR CURSOS. A¥O:'+cAnoUsr,;
		   'Periodo No.'+STR(nNroPer),;
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
       aJvfMat := {}

       AADD(aNroCol,6)
       AADD(aTitPrn,'GRUPO')
       AADD(aStrPrn,{'GRUPO','Character',4,0})

       IF lPrnMat
	  AADD(aNroCol,40)
	  AADD(aTitPrn,'MATERIA')
	  AADD(aStrPrn,{'MATERIA','Character',40,0})

/*
	  AADD(aNroCol,08)
	  AADD(aTitPrn,'PROFESOR')
*/
       ENDIF

/*
       AADD(aNroCol,02)
       AADD(aTitPrn,'PE')
*/

       SELECT JVF
       JVF->(DBGOTOP())
       DO WHILE .NOT. JVF->(EOF())

	  AADD(aNroCol,8)
	  AADD(aTitPrn,JVF->cCodigoJvf)
	  AADD(aJvfMat,{JVF->cCodigoJvf,0})
	  AADD(aStrPrn,{JVF->cCodigoJvf,'Numeric',4,0})
	  JVF->(DBSKIP())

       ENDDO

/*
       AADD(aNroCol,8)
       AADD(aTitPrn,'SN')
       AADD(aJvfMat,{'SN',0})
       AADD(aStrPrn,{'SN','Numeric',4,0})
*/

       AADD(aNroCol,8)
       AADD(aTitPrn,'JVF SI')
       AADD(aStrPrn,{'JVF_SI','Numeric',4,0})

       AADD(aNroCol,8)
       AADD(aTitPrn,'JVF NO')
       AADD(aStrPrn,{'JVF_NO','Numeric',4,0})

/*
       AADD(aNroCol,06)
       AADD(aTitPrn,'IND SI')

       AADD(aNroCol,06)
       AADD(aTitPrn,'IND NO')

       AADD(aNroCol,06)
       AADD(aTitPrn,'EST')

*/

       cCabCol := cRegPrint(aTitPrn,aNroCol)
*>>>>FIN FIN ENCABEZADOS DE COLUMNA

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
       SET DEVICE TO SCREEN
       Termometro(0,'IMPRIMIENDO')
       SET DEVICE TO PRINT

       SELECT GRU
       GO nRegFin
       cGruFin := GRU->cCodigoGru

       GO nRegIni
       DO WHILE GRU->(RECNO()) <= nRegFin

**********VISUALIZACION DE AVANCE
            nAvance := INT(( STD->(RECNO()) / STD->(RECCOUNT()) )*100)

            IF STR(nAvance,3) $ '25 50 75100'
               SET DEVICE TO SCREEN
               Termometro(nAvance)
               SET DEVICE TO PRINT
            ENDIF
**********FIN VISUALIZACION DE AVANCE

**********FILTRACION DEL ARCHIVO
	    SELECT STD
	    SET FILTER TO STD->cCodigoGru == GRU->cCodigoGru .AND.;
			  STD->nNroPerStd == nNroPer

	    STD->(DBGOTOP())
	    IF STD->(EOF())
	       SET FILTER TO
	       SELECT GRU
	       GRU->(DBSKIP())
	       LOOP
	    ENDIF
**********FIN FILTRACION DEL ARCHIVO

**********RECORRIDO POR MATERIAS A IMPRIMIR
	    nGruPrn++
	    aStdGru := {}
	    aMatPrn := aMatPrnPer(lShared,cAnoUsr,cPatSis,cMaeAct,;
				  GRU->cCodigoGru,nNroPer)

	    FOR i := 1 TO LEN(aMatPrn)

*===============IMPRESION DE LA LINEA DE ESTADO
		  SET DEVICE TO SCREEN
		  LineaEstado('PERIODO: '+STR(nNroPer,2)+'º'+;
			      'GRUPO: '+GRU->cCodigoGru+'º'+;
			      'No.'+ALLTRIM(STR(i,9))+'/'+;
				    ALLTRIM(STR(LEN(aMatPrn),9)),cNomSis)
		  SET DEVICE TO PRINT
*===============FIN IMPRESION DE LA LINEA DE ESTADO

*===============LOCALIZACION DE LA MATERIA
		  cCodigoTma := aMatPrn[i,1]
		  cNombreTma := cCodigoTma+' NO EXISTE'
		  cCodigoTpr := aMatPrn[i,2]
		  IF lLocCodigo('cCodigoMat','MAT',cCodigoTma)
		     cNombreTma := MAT->cNombreMat
		     IF !EMPTY(cCodigoTpr)
			cNombreTma := '..'+cNombreTma
		     ENDIF
		  ENDIF
		  cNombreTma := SUBS(cNombreTma+SPACE(40),1,40)
*===============FIN LOCALIZACION DE LA MATERIA

*===============IMPRESION DEL REGISTRO
		  aStdMat := aStdMatPer(GRU->cCodigoGru,;
					nNroPer,cCodigoTma,;
					cCodigoTpr)
		  IF EMPTY(aStdMat)
		     LOOP
		  ENDIF

		  IF EMPTY(cCodigoTpr)
		     aStdGru := aSumStdMat(aStdMat,aStdGru)
		  ENDIF

		  IF lPrnMat
		     aRegPrn := aRegPrnStd(aStdMat,lPorcen,lPrnMat,cNombreTma)
		     lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
			     aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,;
			     bCabeza)
		  ENDIF
*===============FIN IMPRESION DEL REGISTRO

	    ENDFOR
**********FIN RECORRIDO POR MATERIAS A IMPRIMIR

**********IMPRESION DE LAS ESTADISTICAS DEL GRUPO
	    aRegPrn := aRegPrnStd(aStdGru,lPorcen,lPrnMat)
	    lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
		    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,;
		    bCabeza)
	    aTotStd := aSumStdMat(aStdGru,aTotStd)
**********IMPRESION DE LAS ESTADISTICAS DEL GRUPO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT GRU
	    GRU->(DBSKIP())
	    IF GRU->(EOF())
	       SET DEVICE TO SCREEN
	       Termometro(100)
	       SET DEVICE TO PRINT
	    ENDIF
	    SET FILTER TO
**********FIN AVANCE DEL SIGUIENTE REGISTRO

       ENDDO
       RESTSCREEN(0,0,24,79,cSavPan)
*>>>>FIN RECORRIDO POR GRUPOS

*>>>>IMPRESION DE LAS ESTADISTICAS DEL GRUPO
       IF nGruPrn > 1

	  aRegPrn := aRegPrnStd(aTotStd,lPorcen,lPrnMat)
	  aRegPrn[1] := '' // Grupo

	  lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
		  aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,;
		  bCabeza)
       ENDIF
*>>>>FIN IMPRESION DE LAS ESTADISTICAS DEL GRUPO

*>>>>IMPRESION DERECHOS
       EVAL(bDerAut)
      *Derechos de Autor

       VerPrn(nOpcPrn,FilePrn,nHanXml)
       PRN->(DBGOTO(nRegPrn))

       SET DEVICE TO SCREEN
       RETURN NIL
*>>>>FIN IMPRESION DERECHOS

/*************************************************************************
* TITULO..: ESTADISTICAS POR GRADOS                                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ABR 09/2005 MAR A
       Colombia, Bucaramanga        INICIO: 11:00 AM   ABR 09/2005 MAR

OBJETIVOS:

1- Imprime las estad¡sticas por Grados

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrStd012(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		   oBrowse,nNroOpc,cPatSis,cMaeAct)

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
       oBrowse                              // Browse del Archivo
       nNroOpc                              // N£mero de la Opci¢n
       cPatSis                              // Path del Sistema
       cMaeAct                              // Maestro Actual */
*>>>>FIN DESCRIPCION DE PARAMETROS

cError('PENDIENTE')

       RETURN NIL


