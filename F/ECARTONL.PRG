/*************************************************************************
* TITULO..: MENU DE OTROS PARA EL ARCHIVO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: jun 4/2008 DIA A
       Colombia, Bucaramanga        INICIO:  11:43 AM  jun 4/2008 DIA

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrOnl(aP1,aP2,aP3,;
		    aArchvo,cOpcPrn,nCodPrn,lModReg,;
		    lDelReg,lInsReg,lHaySql,oBrowse)

*>>>>DESCRIPCION DE PARAMETROS
/*     aP1                                  // Parametros Generales
       aP2                                  // Parametros Generales
       aP3                                  // Parametros Generales
       aArchvo                              // Archivo en Uso
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
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL aMenus  := {}                  // Vector de declaracion de men£
       LOCAL aAyuda  := {}                  // Vector de ayudas para el men£
       LOCAL nNroOpc := 1                   // Numero de la opcion

       LOCAL GetList := {}                  // Variable del Sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION PARAMETROS GENERALES
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
*>>>>FIN DECLARACION PARAMETROS GENERALES

*>>>>DECLARCION Y EJECUCION DEL MENU
       aMenus := {}
       AADD(aMenus,'1<PAGOS EN LINEA     >')
       AADD(aMenus,'2<CREAR ARCHIVO PLANO>')

       aAyuda := {}
       AADD(aAyuda,'Imprime los Detalles del Archivo')
       AADD(aAyuda,'Creaci¢n del archivo plano')

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

	    SCA_20900(aP1,aP2,aP3,;
		      aArchvo,cOpcPrn,nCodPrn,lModReg,;
		      lDelReg,lInsReg,lHaySql,oBrowse)
	   *Impresi¢n de los campos del Archivo

       CASE nNroOpc == 2

	    OtrOnl002(aP1,aP2,aP3,oBrowse)
	   *Creaci¢n del Archivo plano

       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE OPCION ESCOGIDA

/*************************************************************************
* TITULO..: CREACION DEL ARCHIVO PLANO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 05/2008 JUE A
       Colombia, Bucaramanga        INICIO:  12:30 AM  JUN 05/2008 JUE

OBJETIVOS:

1- Crea el archivo plano.

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrOnl002(aP1,aP2,aP3,oBrowse)

*>>>>DESCRIPCION DE PARAMETROS
/*     aP1                                  // Parametros Generales
       aP2                                  // Parametros Generales
       aP3                                  // Parametros Generales
       oBrowse                              // Browse del Archivo */
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
       LOCAL cMaeAct := xPrm(aP1,'cMaeAct') // Maestro Activo
       LOCAL cJorTxt := xPrm(aP1,'cJorTxt') // Jornada escogida
     *ÀDetalles Acad‚micos

       LOCAL nMesIni := xPrm(aP2,'nMesIni') // Mes Inicial
       LOCAL nPagOnl := xPrm(aP2,'nPagOnl') // Formato para pagos en lineas.
*>>>>FIN DECLARACION PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "ARC-CART.PRG"      // Archivos del Sistema

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL cMesIni := ''                  // Mes Inicial

       LOCAL nNroArc := 0                   // N£mero del Archivo
       LOCAL cRegTxt := ''                  // Texto del registro
       LOCAL nByeWri := 0                   // Bytes Escritos
       LOCAL lGraReg := .F.                 // Grabar el Registro


       LOCAL cPagOnl := ''                  // Formato Pago en Linea

       LOCAL nArcUsr := 0                   // N£mero del Archivo
       LOCAL cRegUsr := ''                  // Texto del registro
       LOCAL FileUsr := ''                  // Archivo de Usuarios

       LOCAL Getlist := {}                  // Variable del sistema
     *ÀVariables espec¡ficas
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       lHayErr := .T.
       DO CASE
       CASE ONL->(RECCOUNT()) == 0
	    cError('NO SE HAN CREADO LOS REGISTROS')

       OTHERWISE
	    lHayErr :=.F.
       ENDCASE
       IF lHayErr
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>ANALISIS DE DECISION
       IF !lPregunta('DESEA CONTINUAR? Si No')
	  cError('SE ABANDONA EL PROCESO')
	  RETURN NIL
       ENDIF
*>>>>FIN ANALISIS DE DECISION

*>>>>CREACION DEL ARCHIVO
       cCodEmp := xPrm(aP2,'cCodEmp')

       cMesIni := STR(nMesIni,2)
       lCorrecion(@cMesIni)

       cPagOnl := STR(ONL->nPagOnlCar,2,0)
       lCorrecion(@cPagOnl)

       IF nMesIni == 13
	  PathOnl := cPatSis+'\online\13'
       ELSE
	  PathOnl := cPatSis+'\online\'+cMes(nMesIni,3)
       ENDIF


       DO CASE
       CASE EMPTY(ONL->cForPagOnl)
	    FileOnl := cPagOnl+;
		       ALLTRIM(cCodEmp)+cMesIni+'.txt'


       CASE ONL->cForPagOnl == '1'
	    FileOnl := 'O'+cPagOnl+;
		       ALLTRIM(cCodEmp)+cMesIni+'.txt'

       CASE ONL->cForPagOnl == '2'
	    FileOnl := 'E'+cPagOnl+;
		       ALLTRIM(cCodEmp)+cMesIni+'.txt'

       ENDCASE

       nNroArc := FCREATE(PathOnl+'\'+FileOnl,0)
       IF nNroArc == -1
	  cError('NO SE PUEDE CREAR EL ARCHIVO '+FileOnl)
	  RETURN NIL
       ENDIF

       SELECT ONL
       ONL->(DBGOTO(10))
       IF !EMPTY(ALLTRIM(ONL->cRegUsrTxt))
	  FileUsr := 'usr'+ALLTRIM(cCodEmp)+cMesIni+'.txt'
	  nArcUsr := FCREATE(PathOnl+'\'+FileUsr,0)
	  IF nArcUsr == -1
	     cError('NO SE PUEDE CREAR EL ARCHIVO '+FileUsr)
	     RETURN NIL
	  ENDIF
       ENDIF
*>>>>FIN CREACION DEL ARCHIVO

*>>>>RECORRIDO DE LOS REGISTROS
       cSavPan := SAVESCREEN(0,0,24,79)

       SELECT ONL
       ONL->(DBGOTOP())
       DO WHILE .NOT. ONL->(EOF())

**********LINEA DE ESTADO
	    LineaEstado('REGISTRO: '+STR(ONL->(RECNO()),4)+'/'+;
				     STR(ONL->(RECCOUNT()),4),cNomSis)
**********FIN LINEA DE ESTADO

**********GRABACION DE LA CABECERA DEL ARCHIVO
	    cRegUsr := ''
	    DO CASE
	    CASE nPagOnl == 1       // Asobancaria 2001
		 cRegTxt := SUBS(ONL->cRegistTxt,1,220)+CHR(13)+CHR(10)

	    CASE nPagOnl == 2       // Asobancaria 2001. Place to Play
		 cRegTxt := SUBS(ONL->cRegistTxt,1,219)+CHR(13)+CHR(10)

	    CASE nPagOnl == 5       // Avisor
		 cRegTxt := SUBS(ONL->cRegistTxt,1,562)+CHR(13)+CHR(10)
		 cRegUsr := SUBS(ONL->cRegUsrTxt,1,531)+CHR(13)+CHR(10)

	    OTHERWISE
		 cRegTxt := SUBS(ONL->cRegistTxt,1,219)+CHR(13)+CHR(10)
	    ENDCASE

	    nByeWri := FWRITE(nNroArc,cRegTxt,LEN(cRegTxt))
	    IF nByeWri # LEN(cRegTxt)
		cError('GRABACION DEL REGISTRO')
		EXIT
	    ENDIF

	    IF !EMPTY(cRegUsr)  
	       nByeWri := FWRITE(nArcUsr,cRegUsr,LEN(cRegUsr))
	       IF nByeWri # LEN(cRegUsr)
		   cError('GRABACION DEL REGISTRO DE USUARIOS')
		   EXIT
	       ENDIF
	    ENDIF
**********FIN GRABACION DE LA CABECERA DEL ARCHIVO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT ONL
	    ONL->(DBSKIP())
**********FIN AVANCE DEL SIGUIENTE REGISTRO

       ENDDO
       cError(FileOnl+' EN '+PathOnl,'SE CREO EL ARCHIVO:')
       RESTSCREEN(0,0,24,79,cSavPan)

       SELECT ONL
       ONL->(DBGOTOP())
       oBrowse:GOTOP()
       oBrowse:FORCESTABLE()
       RETURN NIL
*>>>>FIN RECORRIDO DE LOS REGISTROS