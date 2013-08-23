/*                   SIMA. SISTEMA INTEGRADO MULTIUSUARIO
		BIBLIOTECA DE FUNCIONES PARA EL ARCHIVO DE EMPRESAS

/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 31/2004 MAR A
       Colombia, Bucaramanga        INICIO: 10:30 PM   AGO 31/2004 MAR

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfEmp(lShared,nModCry,PathArc,fArchvo,aStrDbf)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       PathArc				    // Path del Archivo
       fArchvo				    // Nombre del Archivo
       aStrDbf                              // Estructura del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL PathAct := ''                  // Path Actual

       LOCAL aDbfStr := {}                  // Estructura del Archivo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DE LA ESTRUCTURA
       AADD(aDbfStr,{"nCodigoEmp","Numeric"  ,16,0}) // C¢digo de la Empresa
     *ÀLlave principal

       AADD(aDbfStr,{"cDocNitEmp","Character",16,0}) // Nit de la Empresa
       AADD(aDbfStr,{"cTipNitEmp","Character",01,0}) // Tipo de Documento. 2=>Nits Empresariales, 3=>Nits de Extranjeria
       AADD(aDbfStr,{"lFotNitEmp","Logical"  ,01,0}) // .T. Fotocopia del Documneto
       AADD(aDbfStr,{"cNombreEmp","Character",60,0}) // Nombre de la Empresa
       AADD(aDbfStr,{"cTipEmpEmp","Character",01,0}) // Tipo de Empresa. 1 =>Ltda 2=>Personal 3=>Unipersonal
     *ÀIdentificaci¢n

       AADD(aDbfStr,{"lHayIvaEmp","Logical"  ,01,0}) // .T. Responsable del Iva
       AADD(aDbfStr,{"lHayRtfEmp","Logical"  ,01,0}) // .T. Retefuente .F. Autoretenedor
     *ÀImpuestos

       AADD(aDbfStr,{"cDireccEmp","Character",60,0}) // Direccion
       AADD(aDbfStr,{"cBarrioEmp","Character",30,0}) // Barrio de la direcci¢n
       AADD(aDbfStr,{"cCiudadEmp","Character",30,0}) // Ciudad
     *ÀDireccion de Domicilio

       AADD(aDbfStr,{"cTelefnEmp","Character",14,0}) // Telefonos
       AADD(aDbfStr,{"cTelFaxEmp","Character",14,0}) // Fax
       AADD(aDbfStr,{"cTelOtrEmp","Character",30,0}) // Otros Telefonos de la Empresa
     *ÀTelefonos

       AADD(aDbfStr,{"cUrlWwwEmp","Character",40,0}) // Sitio de la Empresa
       AADD(aDbfStr,{"cMaiUnoEmp","Character",40,0}) // E-MAIL No. 1
       AADD(aDbfStr,{"cMaiDosEmp","Character",40,0}) // E-MAIL No. 2
       AADD(aDbfStr,{"cMaiTreEmp","Character",40,0}) // E-MAIL No. 3
     *ÀContactos en Internet

       AADD(aDbfStr,{"cNomUsrEmp","Character",10,0}) // Nombre del Usuario
       AADD(aDbfStr,{"dFecUsrEmp","Date"     ,08,0}) // Fecha del Usuario
       AADD(aDbfStr,{"cHorUsrEmp","Character",10,0}) // Hora del Usuario
*>>>>DECLARACION DE LA ESTRUCTURA

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
	    DBCREATE(fArchvo,aDbfStr,"DBFNTX")

       CASE DIRCHANGE(PathArc) == -3
	    cError('NO EXISTE EL DIRECTORIO: '+PathArc)

       CASE DIRCHANGE(PathArc) == -5
	    cError('NO TIENE DERECHOS EN: '+PathArc)
       ENDCASE
       nCd(PathAct)
       RETURN NIL
*>>>>FIN CREACION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: RECUPERACION DE LA ESTRUCTURA                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 31/2004 MAR A
       Colombia, Bucaramanga        INICIO: 10:35 PM   AGO 31/2004 MAR

OBJETIVOS:

1- Recupera la estructura del archivo

2- Retorna NIL


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RecuDbfEmp(lShared,nModCry,PathArc,fArchvo)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                        // .T. Sistema Compartido
       nModCry                        // Modo de Protecci¢n
       PathArc			      // Path del Archivo
       fArchvo			      // Nombre del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>RECUPERA LA ESTRUCTURA DEL ARCHIVO
       SAVE SCREEN
       cError("SE BORRO EL ARCHIVO "+PathArc+'\'+fArchvo,;
	      "Error Grave. TOME NOTA",;
	      "Al Presionar Cualquier tecla se crea el archivo")
       Termometro(0,"CREANDO LA ESTRUCTURA")
       Termometro(100)
       CreaDbfEmp(lShared,nModCry,PathArc,fArchvo)
       RESTORE SCREEN
       RETURN NIL
*>>>>FIN RECUPERA LA ESTRUCTURA DEL ARCHIVO

/*************************************************************************
* TITULO..: ACTUALIZACION DE LA ESTRUCTURA                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 31/2004 MAR A
       Colombia, Bucaramanga        INICIO: 10:40 PM   AGO 31/2004 MAR

OBJETIVOS:

1- Actualiza la Estructura del Archivo

2- Retorna el N£mero de Error:
   0 => No hay Error
	Estructura Actualizada
	Estructura Sin problemas
   1 => Estructura No Actualizada

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nActStrEmp(lShared,nModCry,PathArc,cNomArc)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       PathArc				    // Path del Archivo
       cNomArc				    // Nombre del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

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
       IF !lUseDbf(.T.,PathArc+'\'+cNomArc,'ACT',NIL,lShared,nModCry)
	  cError('ABRIENDO EL ARCHIVO')
	  CloseDbf('ACT')
	  RETURN nNroErr := 1
       ENDIF
       aStrOld := ACT->(DBSTRUCT())
       CloseDbf('ACT')
       CreaDbfEmp(lShared,nModCry,PathArc,cNomArc,@aStrNew)
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
	  cError('El Archivo '+cNomArc+' su Estructura Esta DesActualizada.',;
		 'ATENCION',;
		 'Para Actualizarla NO Debe Haber Ning£n Usuario en la Red.')
	  lCambio := lPregunta('DESEA ACTUALIZAR LA ESTRUCTURA? No Si')
	  IF !lCambio
	     nNroErr := 1
	  ENDIF
       ENDIF
*>>>>FIN CONFIRMACION DE LA ACTUALIZACION

*>>>>ACTUALIZACION DE LA ESTRUCTURA
       IF lCambio
	  FileTem := SUBS(cNomArc,1,AT('.',cNomArc))+'STR'
	  cSavPan := SAVESCREEN(0,0,24,79)
	  IF !lStrucFile(lShared,;
			 PathArc+'\'+cNomArc,;
			 PathArc+'\'+FileTem,;
			 {||CreaDbfEmp(lShared,nModCry,PathArc,FileTem)})
	     cError('NO SE ACTUALIZO LA ESTRUCTURA DEL ARCHIVO')
	     nNroErr := 1
	  ENDIF
	  RESTSCREEN(0,0,24,79,cSavPan)
       ENDIF
       RETURN nNroErr
*>>>>FIN ACTUALIZACION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL ARCHIVO                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 31/2004 MAR A
       Colombia, Bucaramanga        INICIO: 10:45 PM   AGO 31/2004 MAR

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenEmp(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,PathArc,fArchvo,;
		   aArcNtx,lPrnArc,cOpcPrn,lModReg,lDelReg,lInsReg,;
		   lHaySql)

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
       fArchvo				    // Archivo de Usuarios
       aArcNtx			            // Archivos Indice
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
       lModReg                              // .T. Modificar el Registro
       lDelReg                              // .T. Borrar Registros
       lInsReg                              // .T. Insertar Registro
       lHaySql                              // .T. Exportar a Sql */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "inkey.ch"                   // Declaraci¢n de teclas
       #INCLUDE "FILES.PRG"           // Archivos Compartidos

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL fNtxArc := ''                  // Archivo Indice
       LOCAL oBrowse := NIL                 // Browse
*>>>>FIN DECLARACION DE VARIABLES

*>>>>AREAS DE TRABAJO
       fNtxArc := IF(aArcNtx==NIL,NIL,PathArc+'\'+aArcNtx[1])

       aUseDbf := {}
       AADD(aUseDbf,{.T.,PathArc+'\'+fArchvo,'EMP',fNtxArc,lShared,nModCry})
*>>>>FIN AREAS DE TRABAJO

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbfs(aUseDbf)
	  cError('ABRIENDO EL ARCHIVO FIADORES')
	  CloseDbf('EMP')
	  RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>PARAMETROS POR DEFECTO
       lModReg := IF(EMPTY(lModReg),.F.,lModReg)
       lModReg := IF(lModReg .AND. EMP->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfEmp(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
			     lModReg,lDelReg,lInsReg,lHaySql)

       SETKEY(K_F2,{||lManRegEmp(lShared,cNomUsr,3)})
     *ÀConsulta

       IF lModReg
	  SETKEY(K_F4,{||lManRegEmp(lShared,cNomUsr,2,oBrowse)})
       ENDIF
     *ÀActualizar

       SETKEY(K_F5,{||BuscarEmp(oBrowse)})

       SETKEY(K_F9,{||MenuOtrEmp(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
				 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
				 PathArc,fArchvo,aArcNtx,lPrnArc,cOpcPrn,;
				 lModReg,lDelReg,lInsReg,lHaySql,oBrowse)})

       EMP->(CtrlBrw(lShared,oBrowse))

       SETKEY(K_F2,NIL)
       SETKEY(K_F4,NIL)
       SETKEY(K_F5,NIL)
       SETKEY(K_F9,NIL)
       CloseDbf('EMP')
       RETURN NIL
*>>>>FIN MANTENIMIENTO DEL ARCHIVO

/*************************************************************************
* TITULO..: DEFINICION DEL OBJETO BROWSE                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 31/2004 MAR A
       Colombia, Bucaramanga        INICIO: 10:50 PM   AGO 31/2004 MAR

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfEmp(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
		    lModReg,lDelReg,lInsReg,lHaySql)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos
       cNomUsr                              // Nombre del Usuario
       cAnoUsr                              // A¤o del Usuario
       nFilSup	                            // Fila Superior
       nColSup	                            // Columna Superior
       nFilInf	                            // Fila Inferior
       nColInf	                            // Columna Inferior
       lModReg                              // .T. Modificar el Registro
       lDelReg                              // .T. Borrar Registros
       lInsReg                              // .T. Insertar Registros
       lHaySql                              // .T. Exportar a Sql */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL oColumn := NIL                 // Objeto Columna
       LOCAL oBrowse := NIL	            // Browse del Archivo

       LOCAL cTitSup := ''                  // T¡tulo Superior del Browse
       LOCAL cTitInf := ''                  // T¡tulo Inferior del Browse
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DEFINICION DEL OBJETO BROWSE
       oBrowse := TBROWSEDB(nFilSup+1,nColSup+1,nFilInf-1,nColInf-1)
      *Definici¢n de Objeto y asignaci¢n de las coordenadas

       oBrowse:ColSep    := '³'
       oBrowse:HeadSep   := 'Ä'

       cTitSup := '<< INFORMACION DE LAS EMPRESAS >>'
       cTitInf := '<F2>Consultar <F5>Buscar'+;
		   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
		   IF(lDelReg,' <DEL>Borrar','')+;
		   IF(lInsReg,' <INS>Incluir','')

       IF lInsReg
	  oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegEmp(lShared,cNomUsr)}}
       ELSE
	  oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT EMP
       oColumn	:= TBCOLUMNNEW('NIT DE LA;EMPRESA',{||EMP->cDocNitEmp})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','EMP'},;
			 {'FIELD','cDocNitEmp'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('TIPO DE NIT',{||EMP->cTipNitEmp})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','EMP'},;
			 {'FIELD','cTipNitEmp'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	:= TBCOLUMNNEW('RAZON SOCIAL DE LA EMPRESA',{||EMP->cNombreEmp})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','EMP'},;
			 {'FIELD','cNombreEmp'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	:= TBCOLUMNNEW('FOTOCOPIA;DEL NIT',{||EMP->lFotNitEmp})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','EMP'},;
			 {'FIELD','lFotNitEmp'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||EMP->cNomUsrEmp})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				    {||cFecha(EMP->dFecUsrEmp)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				    {||cHoraSys(EMP->cHorUsrEmp)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CODIGO',{||EMP->nCodigoEmp})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('No.',{||EMP->(RECNO())})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL REGISTRO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 31/2004 MAR A
       Colombia, Bucaramanga        INICIO: 10:55 PM   AGO 31/2004 MAR

OBJETIVOS:

1- Permite inclusi¢n,modificaci¢n y consulta del registro

2- Puede invocarse en la lectura a trav‚s de la clausula VALID

2- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lManRegEmp(lShared,cNomUsr,nTipMod,oBrowse,cDocNit,cTipNit,nNroOpc)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos
       cNomUsr                              // Nombre del Usuario
       nTipMod			            // Tipo de Modificaci¢n. 1 =>Insertar, 2=>Modificar 3=>Consultar
       cDocNit                              // N£mero del Documento
       cTipNit                              // Tipo de Documento
       nNroOpc                              // N£mero de Opci¢n
       oBrowse                              // Browse del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla

       LOCAL aMenus  := {}                  // Vector de declaracion de men£
       LOCAL aAyuda  := {}                  // Vector de ayudas para el men£

       LOCAL nTipCur := 1                   // Tipo de Cursor
       LOCAL nNroFil := 0                   // N£mero de la fila
       LOCAL nNroCol := 1                   // N£mero de la Columna
       LOCAL nColTem := 0                   // Columna Temporal
       LOCAL nFilIni := 0                   // Fila Inicial

       LOCAL nNroReg := 0                   // N£mero del Registro
       LOCAL lGrabar := .T.                 // .T. Grabar el registro
       LOCAL lInsReg := .F.                 // .T. Insertar el Registro

       LOCAL cTxtTem := ''                  // Texto temporal
       LOCAL cTxtHlp := ''                  // Texto de Ayuda

       LOCAL lFotNit := .F.                 // .T. Fotocopia del Documneto
       LOCAL cFotNit := ''                  // .T. Fotocopia del Documneto
       LOCAL cNombre := ''                  // Nombre de la Empresa
       LOCAL cTipEmp := ''                  // Tipo de Empresa. 1 =>Ltda 2=>Personal 3=>Unipersonal
     *ÀIdentificaci¢n

       LOCAL lHayIva := .F.                 // .T. Responsable del Iva
       LOCAL cHayIva := ''                  // .T. Responsable del Iva
       LOCAL lHayRtf := .F.                 // .T. Retefuente .F. Autoretenedor
       LOCAL cHayRtf := ''                  // .T. Retefuente .F. Autoretenedor
     *ÀImpuestos

       LOCAL cDirecc := ''                 // Direccion
       LOCAL cBarrio := ''                 // Barrio de la direcci¢n
       LOCAL cCiudad := ''                 // Ciudad
     *ÀDireccion de Domicilio

       LOCAL cTelefn := ''                 // Telefonos
       LOCAL cTelFax := ''                 // Fax
       LOCAL cTelOtr := ''                 // Otros Telefonos de la Empresa
     *ÀTelefonos

       LOCAL cUrlWww := ''                 // Sitio de la Empresa
       LOCAL cMaiUno := ''                 // E-MAIL No. 1
       LOCAL cMaiDos := ''                 // E-MAIL No. 2
       LOCAL cMaiTre := ''                 // E-MAIL No. 3
     *ÀContactos en Internet.

       LOCAL GetList := {}                 // Variable del sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DEL MENU
       nTipMod := IF(nTipMod==NIL,1,nTipMod)

       cSavPan := SAVESCREEN(0,0,24,79)
       IF EMPTY(nNroOpc)

	  AADD(aMenus,'1<INFORMACION BASICA>')

	  AADD(aAyuda,IF(nTipMod==3,'Consulta','Actualiza')+' '+;
		      'la Informaci¢n B sica de la Empresa')

	  cSavPan := SAVESCREEN(0,0,24,79)
	  nNroOpc := 1
	  nNroOpc := nMenu(aMenus,aAyuda,10,25,;
			   IF(nTipMod==3,'CONSULTAR','ACTUALIZAR'),NIL,1,.F.)
	  RESTSCREEN(0,0,24,79,cSavPan)
	  IF nNroOpc == 0
	     RETURN NIL
	  ENDIF
       ENDIF
*>>>>FIN DECLARACION DEL MENU

*>>>>VALIDACION DE LA INFORMACION BASICA
       IF nNroOpc # 1
	  IF EMPTY(cNombre)
	     cError('PRIMERO DEBE ESTAR ACTUALIZADA LA INFORMACION BASICA')
	     RETURN NIL
	  ENDIF
       ENDIF
*>>>>FIN VALIDACION DE LA INFORMACION BASICA

*>>>>MARCO DEL MANTENIMIENTO
       nTipCur := SETCURSOR()
       DO CASE
       CASE nTipMod == 1
	    cTxtTem := 'POR FAVOR INGRESE LOS DATOS DE LA EMPRESA'
	    EMP->(DBGOBOTTOM())
	    EMP->(DBSKIP())
	    nTipCur := SETCURSOR(1)

       CASE nTipMod == 2
	    cTxtTem := 'POR FAVOR ACTUALICE LOS DATOS DE LA EMPRESA'
	    nTipCur := SETCURSOR(1)

       CASE nTipMod == 3
	    cTxtTem := 'CONSULTA DE LOS DETALLES DE LA EMPRESA'
       ENDCASE
       nFilIni := nMarco(03,cTxtTem,22,'°')
*>>>>FIN MARCO DEL MANTENIMIENTO

*>>>>MANTENIMIENTO DEL REGISTRO
       SELECT EMP
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
	    IF lGrabar

	       IF EMPTY(cDocNit)
		  cDocNit := EMP->cDocNitEmp
	       ENDIF

	       IF EMPTY(cTipNit)
		  cTipNit := EMP->cTipNitEmp
	       ENDIF

	       lFotNit := EMP->lFotNitEmp
	       cFotNit := IF(lFotNit,'S','N')

	       cNombre := EMP->cNombreEmp
	       cTipEmp := EMP->cTipEmpEmp
	     *ÀIdentificaci¢n

	       lHayIva := EMP->lHayIvaEmp
	       cHayIva := IF(lHayIva,'S','N')

	       lHayRtf := EMP->lHayRtfEmp
	       cHayRtf := IF(lHayRtf,'S','N')
	     *ÀImpuestos

	       cDirecc := EMP->cDireccEmp
	       cBarrio := EMP->cBarrioEmp
	       cCiudad := EMP->cCiudadEmp
	     *ÀDireccion de Domicilio

	       cTelefn := EMP->cTelefnEmp
	       cTelFax := EMP->cTelFaxEmp
	       cTelOtr := EMP->cTelOtrEmp
	     *ÀTelefonos

	       cUrlWww := EMP->cUrlWwwEmp
	       cMaiUno := EMP->cMaiUnoEmp
	       cMaiDos := EMP->cMaiDosEmp
	       cMaiTre := EMP->cMaiTreEmp
	     *ÀContactos en Internet

	    ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********NIT DE LA EMPRESA
	    nNroFil := nFilIni

	    cTxtTem := 'NIT DE LA EMPRESA   :'
	    IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(cDocNit)
	       @ nNroFil,nNroCol SAY cTxtTem
	       @ nNroFil,nNroCol+LEN(cTxtTem)+1 SAY cDocNit COLOR('I')
	    ELSE
	       @ nNroFil,nNroCol SAY cTxtTem;
				 GET cDocNit PICT '9999999999999999';
				 VALID !EMPTY(cDocNit) .AND.;
				       !lValCodEmp(cDocNit)
	    ENDIF
**********FIN NIT DE LA EMPRESA

**********TIPO DE NIT
	    nColTem := nNroCol+LEN(cTxtTem)+18
	    cTxtTem := 'TIPO DE NIT:'

	    IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(cTipNit)
	       @ nNroFil,nColTem SAY cTxtTem
	       @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cTipNit COLOR('I')
	    ELSE
	       @ nNroFil,nColTem SAY cTxtTem;
				 GET cTipNit PICT "@!";
				 VALID lValTipDoc(ROW(),COL()-1,;
						  @cTipNit,'23') .AND.;
				       !EMPTY(cTipNit);
			    WHEN {||HelpRead('DIGITE EL TIPO DE NIT')}
	    ENDIF
**********FIN TIPO DE NIT

**********FOTOTOCOPIA DEL DOCUMENTO
	    nColTem := nColTem+LEN(cTxtTem)+3
	    cTxtTem := 'FOTOCOPIA?:'
	    IF nTipMod == 3
	       @ nNroFil,nColTem SAY cTxtTem
	       @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cFotNit COLOR('I')
	    ELSE
	       @ nNroFil,nColTem SAY cTxtTem;
				 GET cFotNit;
				 VALID lValSiNo(ROW(),COL()-1,;
						@cFotNit,@lFotNit)
	    ENDIF
**********FIN FOTOTOCOPIA DEL DOCUMENTO

**********NOMBRE DE LA EMPRESA
	    cTxtTem := 'NOMBRE DE LA EMPRESA:'
	    IF nTipMod == 3
	       @ nNroFil+01,nNroCol SAY cTxtTem
	       @ nNroFil+01,nNroCol+LEN(cTxtTem)+1 SAY cNombre COLOR('I');
						   PICT '@!S55'
	    ELSE
	       @ nNroFil+01,nNroCol SAY cTxtTem;
				    GET cNombre PICT '@!S55';
				    VALID !EMPTY(cNombre)
	    ENDIF
**********FIN NOMBRE DE LA EMPRESA

**********TIPO DE EMPRESA
	    cTxtTem := 'TIPO DE EMPRESA     :'
	    IF nTipMod == 3
	       @ nNroFil+03,nNroCol SAY cTxtTem
	       @ nNroFil+03,nNroCol+LEN(cTxtTem)+1 SAY cTipEmp COLOR('I')
	    ELSE
	       cTxtHlp := 'POR FAVOR DIGITE EL TIPO DE EMPRESA'
	       @ nNroFil+03,nNroCol SAY cTxtTem;
				    GET cTipEmp PICT '9';
				    VALID lValTipEmp(ROW(),COL(),;
					  @cTipEmp)  .AND.;
					  !EMPTY(cTipEmp) .AND.;
					  HelpRead();
				    WHEN {||HelpRead(cTxtHlp)}
	    ENDIF
**********FIN TIPO DE EMPRESA

**********RESPONABLE DEL IVA
	    nColTem := nNroCol+LEN(cTxtTem)+5
	    cTxtTem := 'RESPONSABLES DEL IVA:'
	    IF nTipMod == 3
	       @ nNroFil+03,nColTem SAY cTxtTem
	       @ nNroFil+03,nColTem+LEN(cTxtTem)+1 SAY cHayIva COLOR('I')
	    ELSE
	       @ nNroFil+03,nColTem SAY cTxtTem;
				 GET cHayIva;
				 VALID lValSiNo(ROW(),COL()-1,;
						@cHayIva,@lHayIva)
	    ENDIF
**********FIN RESPONABLE DEL IVA

**********APLICAR LA RETENCION
	    nColTem := nColTem+LEN(cTxtTem)+5
	    cTxtTem := 'APLICAR RETENCION:'
	    IF nTipMod == 3
	       @ nNroFil+03,nColTem SAY cTxtTem
	       @ nNroFil+03,nColTem+LEN(cTxtTem)+1 SAY cHayRtf COLOR('I')
	    ELSE
	       @ nNroFil+03,nColTem SAY cTxtTem;
				    GET cHayRtf;
				    VALID lValSiNo(ROW(),COL()-1,;
						   @cHayRtf,@lHayRtf)
	    ENDIF
**********FIN APLICAR LA RETENCION

**********DIRECCION
	    cTxtTem := 'DIRECCION           :'
	    IF nTipMod == 3
	       @ nNroFil+05,nNroCol SAY cTxtTem
	       @ nNroFil+05,nNroCol+LEN(cTxtTem)+1 SAY cDirecc COLOR('I');
						   PICT '@S55!'
	    ELSE
	       @ nNroFil+05,nNroCol SAY cTxtTem;
				    GET cDirecc PICT '@S55!'
	    ENDIF
**********FIN DIRECCION

**********BARRIO
	    cTxtTem := 'BARRIO              :'
	    IF nTipMod == 3
	       @ nNroFil+06,nNroCol SAY cTxtTem
	       @ nNroFil+06,nNroCol+LEN(cTxtTem)+1 SAY cBarrio COLOR('I')
	    ELSE
	       @ nNroFil+06,nNroCol SAY cTxtTem;
				    GET cBarrio PICT '@!'
	    ENDIF
**********FIN BARRIO

**********CIUDAD
	    cTxtTem := 'CIUDAD              :'
	    IF nTipMod == 3
	       @ nNroFil+07,nNroCol SAY cTxtTem
	       @ nNroFil+07,nNroCol+LEN(cTxtTem)+1 SAY cCiudad COLOR('I')
	    ELSE
	       @ nNroFil+07,nNroCol SAY cTxtTem;
				    GET cCiudad PICT '@!'
	    ENDIF
**********FIN CIUDAD

**********TELEFONO
	    cTxtTem := 'TELEFONO            :'
	    IF nTipMod == 3
	       @ nNroFil+08,nNroCol SAY cTxtTem
	       @ nNroFil+08,nNroCol+LEN(cTxtTem)+1 SAY cTelefn COLOR('I')
	    ELSE
	       @ nNroFil+08,nNroCol SAY cTxtTem;
				    GET cTelefn PICT '99999999999999'
	    ENDIF
**********FIN TELEFONO

**********FAX
	    nColTem := nNroCol+LEN(cTxtTem)+18
	    cTxtTem := 'FAX:'
	    IF nTipMod == 3
	       @ nNroFil+08,nColTem SAY cTxtTem
	       @ nNroFil+08,nColTem+LEN(cTxtTem)+1 SAY cTelFax COLOR('I')
	    ELSE
	       @ nNroFil+08,nColTem SAY cTxtTem;
				    GET cTelFax PICT '99999999999999'
	    ENDIF
**********FIN FAX

**********OTROS TELEFONOS
	    cTxtTem := 'OTROS CONTACTOS     :'
	    IF nTipMod == 3
	       @ nNroFil+09,nNroCol SAY cTxtTem
	       @ nNroFil+09,nNroCol+LEN(cTxtTem)+1 SAY cTelOtr COLOR('I')
	    ELSE
	       @ nNroFil+09,nNroCol SAY cTxtTem;
				    GET cTelOtr PICT '@XS40'
	    ENDIF
**********FIN OTROS TELEFONOS

**********SITIO EN INTERNET
	    cTxtTem := 'SITIO INTERNET      :'
	    IF nTipMod == 3
	       @ nNroFil+11,nNroCol SAY cTxtTem
	       @ nNroFil+11,nNroCol+LEN(cTxtTem)+1 SAY cUrlWww COLOR('I')
	    ELSE
	       @ nNroFil+11,nNroCol SAY cTxtTem;
				    GET cUrlWww PICT '@XS40'
	    ENDIF
**********FIN SITIO EN INTERNET

**********E-MAIL No.1
	    cTxtTem := 'E-MAIL No.1         :'
	    IF nTipMod == 3
	       @ nNroFil+12,nNroCol SAY cTxtTem
	       @ nNroFil+12,nNroCol+LEN(cTxtTem)+1 SAY cMaiUno COLOR('I')
	    ELSE
	       @ nNroFil+12,nNroCol SAY cTxtTem;
				    GET cMaiUno PICT '@XS40'
	    ENDIF
**********FIN E-MAIL No.1

**********E-MAIL No.2
	    cTxtTem := 'E-MAIL No.2         :'
	    IF nTipMod == 3
	       @ nNroFil+13,nNroCol SAY cTxtTem
	       @ nNroFil+13,nNroCol+LEN(cTxtTem)+1 SAY cMaiDos COLOR('I')
	    ELSE
	       @ nNroFil+13,nNroCol SAY cTxtTem;
				    GET cMaiDos PICT '@XS40'
	    ENDIF
**********FIN E-MAIL No.2

**********E-MAIL No.3
	    cTxtTem := 'E-MAIL No.3         :'
	    IF nTipMod == 3
	       @ nNroFil+14,nNroCol SAY cTxtTem
	       @ nNroFil+14,nNroCol+LEN(cTxtTem)+1 SAY cMaiTre COLOR('I')
	    ELSE
	       @ nNroFil+14,nNroCol SAY cTxtTem;
				    GET cMaiTre PICT '@XS40'
	    ENDIF
**********FIN E-MAIL No.3

**********LECTURA DE LOS CAMPOS
	    IF nTipMod == 3
	       cPausa()
	       EXIT
	    ELSE
	       READ
	    ENDIF
**********FIN LECTURA DE LOS CAMPOS

**********PREGUNTA DE DECISION
	    DO CASE
	    CASE LASTKEY() # K_ESC .AND. nTipMod # 3
		 IF !lPregunta('DESEA GRABAR? Si No')
		    lGrabar := .F.
		    LOOP
		 ELSE
		    lGrabar := .T.
		    EXIT
		 ENDIF

	    CASE LASTKEY() == K_ESC
		 lGrabar := .F.
		 IF !lPregunta('DESEA ABANDONAR? Si No')
		    LOOP
		 ENDIF
		 EXIT
	    ENDCASE
**********FIN PREGUNTA DE DECISION

       ENDDO
*>>>>FIN MANTENIMIENTO DEL REGISTRO

*>>>>GRABACION DEL REGISTRO
       SELECT EMP
       IF nTipMod # 3 .AND. lGrabar

	  lInsReg := IF(nTipMod == 1,.T.,.F.)
	  IF EMP->(lRegLock(lShared,lInsReg))

	     IF lInsReg
		REPL EMP->nCodigoEmp WITH EMP->(RECNO())
		REPL EMP->cDocNitEmp WITH cDocNit
		REPL EMP->cTipNitEmp WITH cTipNit
	     ENDIF
	     REPL EMP->lFotNitEmp WITH lFotNit
	     REPL EMP->cNombreEmp WITH cNombre
	     REPL EMP->cTipEmpEmp WITH cTipEmp
	   *ÀIdentificaci¢n

	     REPL EMP->lHayIvaEmp WITH lHayIva
	     REPL EMP->lHayRtfEmp WITH lHayRtf
	   *ÀImpuestos

	     REPL EMP->cDireccEmp WITH cDirecc
	     REPL EMP->cBarrioEmp WITH cBarrio
	     REPL EMP->cCiudadEmp WITH cCiudad
	   *ÀDireccion de Domicilio

	     REPL EMP->cTelefnEmp WITH cTelefn
	     REPL EMP->cTelFaxEmp WITH cTelFax
	     REPL EMP->cTelOtrEmp WITH cTelOtr
	   *ÀTelefonos

	     REPL EMP->cUrlWwwEmp WITH cUrlWww
	     REPL EMP->cMaiUnoEmp WITH cMaiUno
	     REPL EMP->cMaiDosEmp WITH cMaiDos
	     REPL EMP->cMaiTreEmp WITH cMaiTre
	   *ÀContactos en Internet

	     REPL EMP->cNomUsrEmp WITH cNomUsr
	     REPL EMP->dFecUsrEmp WITH DATE()
	     REPL EMP->cHorUsrEmp WITH TIME()

	     EMP->(DBCOMMIT())
	  ENDIF

       IF lShared
	  EMP->(DBUNLOCK())
       ENDIF

       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SETCURSOR(nTipCur)
*>>>>FIN GRABACION DEL CAMPO

*>>>>REFRESCAR EL BROWSE
       IF nTipMod == 2
	  nNroReg := EMP->(RECNO())
	  EMP->(DBGOTOP())
	  oBrowse:GOTOP()
	  EMP->(DBGOTO(nNroReg))
	  oBrowse:FORCESTABLE()
       ENDIF
       RETURN .T.
*>>>>FIN REFRESCAR EL BROWSE

/*************************************************************************
* TITULO..: VALIDACION DE EXISTENCIA DEL CODIGO                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 31/2004 MAR A
       Colombia, Bucaramanga        INICIO: 11:15 PM   AGO 31/2004 MAR

OBJETIVOS:

1- Debe estar en uso el archivo.

2- Realiza la validaci¢n de existencia del C¢digo.

3- Retorna .T. si hay problemas

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCodEmp(cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodigo			            // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO DEL BANCO
       IF cCodigo # cSpaces('EMP','cDocNitEmp')
	  IF lLocCodigo('cDocNitEmp','EMP',cCodigo)
	     cError('ESTE CODIGO YA EXISTE')
	     lHayErr := .T.
	  ENDIF
       ENDIF
       RETURN lHayErr
*>>>>FIN VALIDACION DEL CODIGO DEL BANCO

/*************************************************************************
* TITULO..: BUSQUEDA DEL CODIGO                                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 31/2004 MAR A
       Colombia, Bucaramanga        INICIO: 11:00 PM   AGO 31/2004 MAR

OBJETIVOS:

1- Permite localizar un c¢digo dentro del archivo.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION BuscarEmp(oBrowse)

*>>>>DESCRIPCION DE PARAMETROS
/*     oBrowse			            // Browse del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroFil := 0                   // Fila de lectura
       LOCAL nNroCol := 0                   // Columna de lectura
       LOCAL nNroReg := 0                   // N£mero del Registro
       LOCAL lBuscar := .T.                 // .T. Realizar la b£squeda
       LOCAL GetList := {}                  // Variable del sistema

       LOCAL cCodigo := ''                  // C¢digo de b£squeda
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CAPTURA DEL CODIGO
       SET CURSOR ON
       cCodigo := cSpaces('EMP','cDocNitEmp')
       TitBuscar(LEN(cCodigo),@nNroFil,@nNroCol)
       @ nNroFil,nNroCol GET cCodigo PICT '@!';
			 VALID lValDocNit(ROW(),COL()-3,@cCodigo)
       READ
*>>>>FIN CAPTURA DEL CODIGO

*>>>>VALIDACION DEL CODIGO
       IF cCodigo == cSpaces('EMP','cDocNitEmp')
	  cError('PATRON DE BUSQUEDA NO ESPECIFICADO',;
		  'ADVERTENCIA')
	  lBuscar := .F.
       ENDIF
*>>>>FIN VALIDACION DEL CODIGO

*>>>>BUSQUEDA DEL CODIGO
       SELECT EMP
       IF lBuscar .AND. lLocCodigo('cDocNitEmp','EMP',cCodigo)
	  nNroReg := RECNO()
	  GO TOP
	  oBrowse:GOTOP()
	  GO nNroReg
	  oBrowse:FORCESTABLE()
       ELSE
	  oBrowse:GOTOP()
       ENDIF
       RETURN NIL
*>>>>FIN BUSQUEDA DEL CODIGO

/*************************************************************************
* TITULO..: VALIDACION DEL CODIGO                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 31/2004 MAR A
       Colombia, Bucaramanga        INICIO: 11:05 PM   AGO 31/2004 MAR

OBJETIVOS:

1- Debe estar en uso el archivo

2- Realiza la validaci¢n del c¢digo

3- Retorna .T. si hay problemas

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValDocNit(nNroFil,nNroCol,cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cCodigo			            // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroReg := 0                   // N£mero del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF !lLocCodigo('cDocNitEmp','EMP',cCodigo)
	  nNroReg := nSelDocNit(nNroFil,nNroCol)
	  IF nNroReg == 0
	     cCodigo := cSpaces('EMP','cDocNitEmp')
	  ELSE
	     GO nNroReg
	     cCodigo := EMP->cDocNitEmp
	  ENDIF
       ENDIF
       RETURN .T.
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: SELECCION DEL CODIGO                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 31/2004 MAR A
       Colombia, Bucaramanga        INICIO: 11:10 PM   AGO 31/2004 MAR

OBJETIVOS:

1- Debe estar en uso el archivo

2- Permite escoger el registro de acuerdo al c¢digo o descripci¢n

3- Retorna el n£mero del registro escogido

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSelDocNit(nNroFil,nNroCol)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // N£mero de la fila
       nNroCol                              // N£mero de la Columna */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL nFilSup := 0                   // Fila superior
       LOCAL nColSup := 0                   // Colunma superior
       LOCAL nFilInf := 0                   // Fila inferior
       LOCAL nColInf := 0                   // Columna inferior
       LOCAL nNroReg := 0		    // Registro del Banco
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       IF EMP->(RECCOUNT()) == 0
	  cError('NO EXISTEN FIADORES GRABADOS')
	  RETURN 0
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>INICIALIZACION DE LAS COORDENADAS
	SELECT EMP
	nFilSup := nNroFil+1
	nColSup := nNroCol+2
	IF nFilSup+RECCOUNT() > 22
	   nFilInf := 22
	ELSE
	   nFilInf := nFilSup + RECCOUNT()
	ENDIF
	nColInf := nColSup+18
*>>>>FIN INICIALIZACION DE LAS COORDENADAS

*>>>>SELECCION DEL CODIGO
       EMP->(DBGOTOP())
       cSavPan := SAVESCREEN(0,0,24,79)
       @ nFilSup-1,nColSup-1 TO nFilInf,nColInf+1 DOUBLE
       nNroReg := nBrowseDbf(nFilSup,nColSup,nFilInf-1,nColInf,;
			     {||EMP->cNombreEmp})
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN nNroReg
*>>>>FIN SELECCION DEL CODIGO



/*************************************************************************
* TITULO..: MENU DE OTROS PARA EL ARCHIVO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 31/2004 MAR A
       Colombia, Bucaramanga        INICIO: 11:20 PM   AGO 31/2004 MAR

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrEmp(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		    cNomEmp,cNomSec,cNomUsr,cAnoUsr,PathArc,fArchvo,;
		    aArcNtx,lPrnArc,cOpcPrn,lModReg,lDelReg,lInsReg,;
		    lHaySql,oBrowse)

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
       fArchvo				    // Archivo de Usuarios
       aArcNtx			            // Archivos Indice
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
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
       LOCAL cIntUno := ''                  // Path de integraci¢n uno
       LOCAL cIntDos := ''                  // Path de integraci¢n dos
       LOCAL cIntTre := ''                  // Path de integraci¢n tres
       LOCAL cIntCua := ''                  // Path de integraci¢n cuatro

       LOCAL aMenus  := {}                  // Vector de declaracion de men£
       LOCAL aAyuda  := {}                  // Vector de ayudas para el men£
       LOCAL nNroOpc := 1                   // Numero de la opcion

       LOCAL GetList := {}                  // Variable del Sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARCION Y EJECUCION DEL MENU
       aMenus := {'1<INFORME DE EMPRESAS>'}

       aAyuda := {'Imprime el listado de Empresas'}

       cSavPan := SAVESCREEN(0,0,24,79)
       nNroOpc := nMenu(aMenus,aAyuda,10,25,NIL,NIL,1,.F.)
       RESTSCREEN(0,0,24,79,cSavPan)
       IF nNroOpc == 0
	  RETURN NIL
       ENDIF
*>>>>FIN DECLARCION Y EJECUCION DEL MENU

*>>>>ANALISIS DE OPCION ESCOGIDA
       DO CASE
       CASE nNroOpc == 1
	    OtrEmp011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		     cNomEmp,cNomSec,cNomUsr,cAnoUsr,PathArc,fArchvo,;
		     aArcNtx,lPrnArc,cOpcPrn,lModReg,lDelReg,lInsReg,;
		     lHaySql,oBrowse)
	   *Impresi¢n del listado de Empresas

       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE OPCION ESCOGIDA

/*************************************************************************
* TITULO..: IMPRESION CAMPOS DEL MANTENIMIENTO                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 31/2004 MAR A
       Colombia, Bucaramanga        INICIO: 11:25 PM   AGO 31/2004 MAR

OBJETIVOS:

1- Imprime los campos del archivo de mantenimiento

2- Retorna NIL

SINTAXIS:


*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrEmp011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		    cNomEmp,cNomSec,cNomUsr,cAnoUsr,PathArc,fArchvo,;
		    aArcNtx,lPrnArc,cOpcPrn,lModReg,lDelReg,lInsReg,;
		    lHaySql,oBrowse)

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
       fArchvo				    // Archivo de Usuarios
       aArcNtx			            // Archivos Indice
       lPrnArc                              // .T. Imprimir a Archivo
       cOpcPrn                              // Opciones de Impresi¢n
       lModReg                              // .T. Modificar el Registro
       lDelReg                              // .T. Borrar Registros
       lInsReg                              // .T. Insertar Registro
       lHaySql                              // .T. Exportar a Sql
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

       LOCAL nAvance := 0                   // Avance de registros
       LOCAL Getlist := {}                  // Variable del sistema
     *ÀVariables espec¡ficas
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DEFINCION DEL ENCABEZADO
       nNroPag := 0
       lTamAnc := .F.

       nTotReg := 0

       aCabPrn := {cNomEmp,cNomSis,;
		   'LISTADO DE EMPRESAS',;
		   '',;
		   ''}

       aCabeza := {aCabPrn[1],aCabPrn[2],aCabPrn[3],aCabPrn[4],aCabPrn[5],;
		   nNroPag++,;
		   cTotPagina(nTotReg),lTamAnc}

       cCodIni := PCL({'DraftOn','Elite','CondenOn'})
       cCodFin := PCL({'NegraOf','DobGolOf'})
*>>>>FIN DEFINCION DEL ENCABEZADO

*>>>>ENCABEZADOS DE COLUMNA
       aNroCol := {16,40}
       aTitPrn := {'NIT','NOMBRE'}
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

*>>>>ACTIVACION DE LA IMPRESORA
       IF lPrnArc
	  SET DEVICE TO PRINT
       ELSE
	  FilePrn := 'empresas'
	  nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,cOpcPrn,.F.,.T.)
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

*>>>>RECORRIDO DE LOS REGISTROS
       cSavPan := SAVESCREEN(0,0,24,79)
       SET DEVICE TO SCREEN
       Termometro(0,'IMPRIMIENDO')
       SET DEVICE TO PRINT

       SELECT EMP
       GO TOP
       DO WHILE .NOT. EMP->(EOF())

**********VISUALIZACION DE AVANCE
	    nAvance := INT(( EMP->(RECNO()) / EMP->(RECCOUNT()) )*100)

	    IF STR(nAvance,3) $ '25 50 75100'
	       SET DEVICE TO SCREEN
	       Termometro(nAvance)
	       SET DEVICE TO PRINT
	    ENDIF
**********FIN VISUALIZACION DE AVANCE

**********IMPRESION DEL REGISTRO
	    aRegPrn := {EMP->cDocNitEmp,;
			EMP->cNombreEmp}

	    lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
		    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
**********FIN IMPRESION DEL REGISTRO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT EMP
	    EMP->(DBSKIP())
	    IF EMP->(EOF())
	       SET DEVICE TO SCREEN
	       Termometro(100)
	       SET DEVICE TO PRINT
	    ENDIF
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
* TITULO..: VALIDACION DEL TIPO DE EMPRESA                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 10/2004 DOM A
       Colombia, Bucaramanga        INICIO: 07:30 PM   OCT 10/2004 DOM

OBJETIVOS:

1- Realiza la validaci¢n del tipo de Empresa

2- Retorna .T. si hay problemas

3- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValTipEmp(nNroFil,nNroCol,cCodigo,cValDoc)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cCodigo			            // @Codigo a validar
       cValDoc                              // Validaci¢n del Documento */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL aMenus  := {}                  // Declaraci¢n de Men£s
       LOCAL aAyudas := {}                  // Declaraci¢n de Ayudas
       LOCAL nNroOpc := 1                   // N£mero de Opci¢n
*>>>>DECLARACION DE VARIABLES

*>>>>VALIDACION DEL TIPO
       cValDoc := IF(cValDoc == NIL,'123',cValDoc)
       IF cCodigo $ cValDoc
	  RETURN .T.
       ENDIF
*>>>>FIN VALIDACION DEL TIPO

*>>>>DEFINICION TIPOS DE EMPRESAS
       aMenus := {}
       aAyudas := {}

       IF '1' $ cValDoc
	  AADD(aMenus,'1<EMPRESA            >')
	  AADD(aAyudas,'Empresa')
       ENDIF

       IF '2' $ cValDoc
	  AADD(aMenus,'2<EMPRESA UNIPERSONAL>')
	  AADD(aAyudas,'Empresa UniPersonal')
       ENDIF

       IF '3' $ cValDoc
	  AADD(aMenus,'3<EMPRESA PERSONAL   >')
	  AADD(aAyudas,'Empresa Personal')
       ENDIF
*>>>>FIN DEFINICION TIPOS DE EMPRESAS

*>>>>SELECCION DEL TIPO DE EMPRESAS
       cCodigo := ALLTRIM(cCodigo)

       IF LEN(aMenus) # 0

	  cSavPan := SAVESCREEN(0,0,24,79)
	  nNroOpc := nMenu(aMenus,aAyudas,nNroFil,nNroCol,NIL,NIL,1,.F.)
	  RESTSCREEN(0,0,24,79,cSavPan)

	  IF nNroOpc == 0
	     cCodigo := SPACE(01)
	  ELSE
	     cCodigo := SUBS(aMenus[nNroOpc],1,1)
	  ENDIF

       ENDIF
       RETURN .T.
*>>>>FIN SELECCION DEL TIPO DE EMPRESAS
