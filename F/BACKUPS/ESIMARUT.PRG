/*************************************************************************
* TITULO..: MANTENIMIENTO DEL ARCHIVO                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC  6/2004 LUN A
       Colombia, Bucaramanga        INICIO:  9:22 AM   DIC  6/2004 LUN

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenRut(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,PathArc,fArchvo,;
		   aArcNtx,lPrnArc,cOpcPrn,lModReg,lDelReg,lInsReg,;
		   lHaySql,FilePrn,nCodPrn,cPatSis,cMaeAlu,cMaeAct,;
		   cJorTxt)

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
       PathArc                              // Path del Archivo
       fArchvo                              // Archivo de Usuarios
       aArcNtx                              // Archivos Indice
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
       lModReg                              // .T. Modificar el Registro
       lDelReg                              // .T. Borrar Registros
       lInsReg                              // .T. Insertar Registro
       lHaySql                              // .T. Exportar a Sql
       FilePrn                              // Archivo de Impresi¢n
       nCodPrn                              // C¢digo de Impresi¢n
       cPatSis                              // Path del sistema
       cMaeAlu                              // Maestros habilitados
       cMaeAct                              // Maestro Activo
       cJorTxt                              // Jornada escogida */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE 'inkey.ch'                  // Declaraci¢n de teclas

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL aUseDbf := {}                  // Archivos en Uso
       LOCAL fNtxArc := ''                  // Archivo Indice
       LOCAL oBrowse := NIL                 // Browse
*>>>>FIN DECLARACION DE VARIABLES

*>>>>AREAS DE TRABAJO
       fNtxArc := IF(aArcNtx==NIL,NIL,PathArc+'\'+aArcNtx[1])

       aUseDbf := {}
       AADD(aUseDbf,{.T.,PathArc+'\'+fArchvo,'RUT',fNtxArc,lShared,nModCry})
       AADD(aUseDbf,{.T.,FilePrn,'PRN',NIL,lShared,nModCry})
*>>>>FIN AREAS DE TRABAJO

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbfs(aUseDbf)
	  cError('ABRIENDO EL ARCHIVO')
	  CloseAll()
	  RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>LOCALIZACION DE LA IMPRESORA
       IF !lLocCodigo('nCodigoPrn','PRN',nCodPrn)
	  cError('NO EXISTE LA IMPRESORA QUE ESTA HABILITADA')
	  CloseAll()
	  RETURN NIL
       ENDIF
*>>>>FIN LOCALIZACION DE LA IMPRESORA

*>>>>PARAMETROS POR DEFECTO
       lModReg := IF(EMPTY(lModReg),.F.,lModReg)
       lModReg := IF(lModReg .AND. RUT->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfRut(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
                             lModReg,lDelReg,lInsReg,lHaySql)

       SETKEY(K_F2,{||lManRegRut(lShared,cNomUsr,3)})
     *ÀConsulta

       IF lModReg
          SETKEY(K_F4,{||lManRegRut(lShared,cNomUsr,2,oBrowse,;
                                    RUT->cCodigoRut)})
       ENDIF
     *ÀActualizar

       SETKEY(K_F5,{||BuscarRut(oBrowse)})

       SETKEY(K_F9,{||MenuOtrRut(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
                                 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
                                 PathArc,fArchvo,aArcNtx,lPrnArc,cOpcPrn,;
				 lModReg,lDelReg,lInsReg,lHaySql,oBrowse,;
				 cPatSis,cMaeAlu,cMaeAct,cJorTxt)})

       RUT->(CtrlBrw(lShared,oBrowse))

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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC  6/2004 LUN A
       Colombia, Bucaramanga        INICIO:  9:22 AM   DIC  6/2004 LUN

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrRut(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                    cNomEmp,cNomSec,cNomUsr,cAnoUsr,PathArc,fArchvo,;
                    aArcNtx,lPrnArc,cOpcPrn,lModReg,lDelReg,lInsReg,;
		    lHaySql,oBrowse,cPatSis,cMaeAlu,cMaeAct,cJorTxt)

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
       PathArc                              // Path del Archivo
       fArchvo                              // Archivo de Usuarios
       aArcNtx                              // Archivos Indice
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
       lModReg                              // .T. Modificar el Registro
       lDelReg                              // .T. Borrar Registros
       lInsReg                              // .T. Insertar Registro
       lHaySql                              // .T. Exportar a Sql
       oBrowse                              // Browse del Archivo
       cPatSis                              // Path del sistema
       cMaeAlu                              // Maestros habilitados
       cMaeAct                              // Maestro Activo
       cJorTxt                              // Jornada escogida */
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
       AADD(aMenus,'1<RUTAS DISPONIBLES    >')
       AADD(aMenus,'2<USUARIOS DE LAS RUTAS>')
       AADD(aMenus,'3<PAGOS DE LAS RUTAS   >')

       aAyuda := {}
       AADD(aAyuda,'Imprime las Rutas Disponibles')
       AADD(aAyuda,'Imprime los Usuarios de la Rutas')
       AADD(aAyuda,'Imprime las deudas y pagos de la rutas')

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
            OtrRut011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                      cNomEmp,cNomSec,cNomUsr,cAnoUsr,PathArc,fArchvo,;
                      aArcNtx,lPrnArc,cOpcPrn,lModReg,lDelReg,lInsReg,;
                      lHaySql,oBrowse)
	   *Impresi¢n de las Rutas Disponibles

       CASE nNroOpc == 2

	     OtrRut112(lShared,nModCry,cNomSis,cEmpPal,cNitEmp,;
		       cNomEmp,cNomSec,cNomUsr,cAnoUsr,cPatSis,;
		       oBrowse,cMaeAlu,cMaeAct,cJorTxt,lPrnArc,;
		       cOpcPrn)
	    *Usuarios de rutas

       CASE nNroOpc == 3

	     OtrRut113(lShared,nModCry,cNomSis,cEmpPal,cNitEmp,;
		       cNomEmp,cNomSec,cNomUsr,cAnoUsr,cPatSis,;
		       oBrowse,cMaeAlu,cMaeAct,cJorTxt,lPrnArc,;
		       cOpcPrn)
	   *Pagos de las rutas

       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE OPCION ESCOGIDA