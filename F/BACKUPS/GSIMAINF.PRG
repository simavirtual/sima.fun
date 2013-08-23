/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: feb 13/2008 DIA A
       Colombia, Bucaramanga        INICIO:  07:29 PM  feb 13/2008 DIA

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfInf(lShared,nModCry,PathArc,fArchvo,aStrDbf,bInsReg)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       PathArc                              // Path del Archivo
       fArchvo                              // Nombre del Archivo
       aStrDbf                              // Estructura del Archivo
       bInsReg                              // Insertar Registros */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL PathAct := ''                  // Path Actual

       LOCAL aDbfStr := {}                  // Estructura del Archivo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DE LA ESTRUCTURA
       AADD(aDbfStr,{'nIdeCodInf','Numeric'  ,16,0}) // Ide del Registro
      *Llave Principal

       AADD(aDbfStr,{'cCodigoInf','Character',08,0}) // C¢digo del Informe. XXX=>Id del Sistema 9=>Menu principal 99=>SubMenu 99=>Versi¢n del Sistema
       AADD(aDbfStr,{'cTituloInf','Character',255,0}) // T¡tulo por defecto del Informe
       AADD(aDbfStr,{'cObservInf','Character',255,0}) // Observaci¢n del informe
       AADD(aDbfStr,{'nNumeroInf','Numeric',08,0}) // N£mero del Informe
       AADD(aDbfStr,{'lInfVarInf','Logical',01,0}) // Informe variable
       AADD(aDbfStr,{'cCodSuiInf','Character',04,0}) // C¢digo del Sistema
       AADD(aDbfStr,{'nNroOrdInf','Numeric',04,0}) // N£mero de orden

       AADD(aDbfStr,{'cNomUsrInf','Character',10,0}) // Nombre del Usuario
       AADD(aDbfStr,{'dFecUsrInf','Date'     ,08,0}) // Fecha del Usuario
       AADD(aDbfStr,{'cHorUsrInf','Character',10,0}) // Hora del Usuario
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
*>>>>FIN CREACION DE LA ESTRUCTURA

*>>>>ANALISIS DE DECISION
       IF EMPTY(bInsReg)
	  RETURN NIL
       ENDIF
*>>>>FIN ANALISIS DE DECISION

*>>>>SELECCION DE LAS AREAS DE TRABAJO
       IF !lUseDbf(.T.,PathArc+'\'+fArchvo,'INF',NIL,lShared,nModCry)
	  WAIT 'ABRIENDO EL ARCHIVO.INFORMES DEL SISTEMA'
	  CloseDbf('INF',PathArc+'\'+fArchvo,nModCry)
	  RETURN NIL
       ENDIF
*>>>>FIN SELECCION DE LAS AREAS DE TRABAJO

*>>>>REGISTROS POR DEFECTO
       EVAL(bInsReg)
       CloseDbf('INF',PathArc+'\'+fArchvo,nModCry)
       RETURN NIL
*>>>>FIN REGISTROS POR DEFECTO

/*************************************************************************
* TITULO..: RECUPERACION DE LA ESTRUCTURA                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: feb 13/2008 DIA A
       Colombia, Bucaramanga        INICIO:  07:29 PM  feb 13/2008 DIA

OBJETIVOS:

1- Recupera la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RecuDbfInf(lShared,nModCry,PathArc,fArchvo,bInsReg)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                        // .T. Sistema Compartido
       nModCry                        // Modo de Protecci¢n
       PathArc			      // Path del Archivo
       fArchvo			      // Nombre del Archivo
       bInsReg                        // Insertar Registros */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>RECUPERA LA ESTRUCTURA DEL ARCHIVO
       SAVE SCREEN
       cError('SE BORRO EL ARCHIVO '+PathArc+'\'+fArchvo,;
              'Error Grave. TOME NOTA',;
              'Al Presionar Cualquier tecla se crea el archivo')
       Termometro(0,'CREANDO LA ESTRUCTURA')
       Termometro(100)
       CreaDbfInf(lShared,nModCry,PathArc,fArchvo,,bInsReg)
       RESTORE SCREEN
       RETURN NIL
*>>>>FIN RECUPERA LA ESTRUCTURA DEL ARCHIVO

/*************************************************************************
* TITULO..: ACTUALIZACION DE LA ESTRUCTURA                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: feb 13/2008 DIA A
       Colombia, Bucaramanga        INICIO:  07:29 PM  feb 13/2008 DIA

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

FUNCTION nActStrInf(lShared,nModCry,PathArc,cNomArc)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       PathArc                              // Path del Archivo
       cNomArc                              // Nombre del Archivo */
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
       CreaDbfInf(lShared,nModCry,PathArc,cNomArc,@aStrNew)
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
*>>>>FIN VALIDACION DE LA ESTRUCTURA

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
			 {||CreaDbfInf(lShared,nModCry,PathArc,FileTem)})
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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: feb 13/2008 DIA A
       Colombia, Bucaramanga        INICIO:  07:29 PM  feb 13/2008 DIA

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenInf(aP1,aP2,aP3,aArchvo,cOpcPrn,nCodPrn,;
		   lModReg,lDelReg,lInsReg,lHaySql,bInsReg)

*>>>>DESCRIPCION DE PARAMETROS
/*     aP1                                  // Parametros Generales
       aP2                                  // Parametros Generales
       aP3                                  // Parametros Generales
       aArchvo                              // Archivos en Uso
       cOpcPrn                              // Opciones de Impresi¢n
       nCodPrn                              // C¢digo de Impresi¢n 
       lModReg                              // .T. Modificar el Registro
       lDelReg                              // .T. Borrar Registros
       lInsReg                              // .T. Insertar Registro
       lHaySql                              // .T. Exportar a Sql
       bInsReg                              // Insertar Registros */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE 'inkey.ch'                  // Declaraci¢n de teclas

       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL       i := 0                   // Contador
       LOCAL lHayPrn := .F.                 // .T. Hay Archivo de Impresi¢n
       LOCAL aUseDbf := {}                  // Archivos en Uso
       LOCAL fArchvo := ''                  // Nombre del Archivo
       LOCAL fNtxArc := ''                  // Archivo Indice
       LOCAL cNalias := ''                  // Alias del Archivo
       LOCAL oBrowse := NIL                 // Browse
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
       lModReg := IF(lModReg .AND. INF->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>INSERCION DE REGISTROS
       IF !EMPTY(bInsReg)
	  EVAL(bInsReg)
       ENDIF
*>>>>FIN INSERCION DE REGISTROS

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfInf(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
                             lModReg,lDelReg,lInsReg,lHaySql)

       SETKEY(K_F2,{||lManRegInf(lShared,cNomUsr,3,oBrowse)})
     *ÀConsulta

       IF lModReg
	  SETKEY(K_F4,{||lManRegInf(lShared,cNomUsr,2,oBrowse,;
				    INF->cCodigoInf)})
       ENDIF
     *ÀActualizar

       SETKEY(K_F5,{||BuscarInf(oBrowse)})

       SETKEY(K_F9,{||MenuOtrInf(aP1,aP2,aP3,;
				 aArchvo,cOpcPrn,nCodPrn,lModReg,;
				 lDelReg,lInsReg,lHaySql,oBrowse)})

       INF->(CtrlBrw(lShared,oBrowse))

       SETKEY(K_F2,NIL)
       SETKEY(K_F4,NIL)
       SETKEY(K_F5,NIL)
       SETKEY(K_F9,NIL)
       CloseAll()
       RETURN NIL
*>>>>FIN MANTENIMIENTO DEL ARCHIVO

/*************************************************************************
* TITULO..: DEFINICION DEL OBJETO BROWSE                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: feb 13/2008 DIA A
       Colombia, Bucaramanga        INICIO:  07:29 PM  feb 13/2008 DIA

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfInf(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
                    lModReg,lDelReg,lInsReg,lHaySql)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos
       cNomUsr                              // Nombre del Usuario
       cAnoUsr                              // A¤o del Usuario
       nFilSup                              // Fila Superior
       nColSup                              // Columna Superior
       nFilInf                              // Fila Inferior
       nColInf                              // Columna Inferior
       lModReg                              // .T. Modificar el Registro
       lDelReg                              // .T. Borrar Registros
       lInsReg                              // .T. Insertar Registros
       lHaySql                              // .T. Exportar a Sql */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL oColumn := NIL                 // Objeto Columna
       LOCAL oBrowse := NIL                 // Browse del Archivo

       LOCAL cTitSup := ''                  // T¡tulo Superior del Browse
       LOCAL cTitInf := ''                  // T¡tulo Inferior del Browse
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DEFINICION DEL OBJETO BROWSE
       oBrowse := TBROWSEDB(nFilSup+1,nColSup+1,nFilInf-1,nColInf-1)
      *Definici¢n de Objeto y asignaci¢n de las coordenadas

       oBrowse:ColSep    := '³'
       oBrowse:HeadSep   := 'Ä'

       cTitSup := '<< INFORMES DEL SISTEMA >>'
       cTitInf := '<F2>Consultar <F5>Buscar'+;
                   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
                   IF(lDelReg,' <DEL>Borrar','')+;
                   IF(lInsReg,' <INS>Incluir','')

       IF lInsReg
	  oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegInf(lShared,cNomUsr)}}
       ELSE
          oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT INF
       oColumn := TBCOLUMNNEW('CODIGO;INFORME',{||INF->cCodigoInf})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','INF'},;
			 {'FIELD','cCodigoInf'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('TITULO;POR DEFECTO',{||INF->cTituloInf})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','INF'},;
			 {'FIELD','cTituloInf'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('OBSERVACION',{||INF->cObservInf})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','INF'},;
			 {'FIELD','cObservInf'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NUMERO',{||INF->nNumeroInf})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','INF'},;
			 {'FIELD','nNumeroInf'},{'PICTURE','99999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('INFORME;VARIABLE',{||INF->lInfVarInf})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','INF'},;
			 {'FIELD','lInfVarInf'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CODIGO;SISTEMA',{||INF->cCodSuiInf})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','INF'},;
			 {'FIELD','cCodSuiInf'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('ORDEN',{||INF->nNroOrdInf})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','INF'},;
			 {'FIELD','nNroOrdInf'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna


       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||INF->cNomUsrInf})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				    {||cFecha(INF->dFecUsrInf)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				    {||cHoraSys(INF->cHorUsrInf)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CODIGO',{||INF->nIdeCodInf})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('No.',{||INF->(RECNO())})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL REGISTRO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: feb 13/2008 DIA A
       Colombia, Bucaramanga        INICIO:  07:29 PM  feb 13/2008 DIA

OBJETIVOS:

1- Permite inclusi¢n,modificaci¢n y consulta del registro

2- Puede invocarse en la lectura a trav‚s de la clausula VALID

3- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lManRegInf(lShared,cNomUsr,nTipMod,oBrowse,cCodigo,nNroOpc)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos
       cNomUsr                              // Nombre del Usuario
       nTipMod                              // Tipo de Modificaci¢n. 1 =>Insertar, 2=>Modificar 3=>Consultar
       xCodigo                              // C¢digo a Ingresar, Actualizar
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

       LOCAL cCodigoTin := ''
       LOCAL cTituloTin := ''
       LOCAL cObservTin := ''
       LOCAL nNumeroTin := 0
       LOCAL lInfVarTin := .F.
       LOCAL lInfVar := ''
       LOCAL cCodSuiTin := ''
       LOCAL nNroOrdTin := 0

       LOCAL GetList := {}                 // Variable del sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DEL MENU
       nTipMod := IF(nTipMod==NIL,1,nTipMod)

       AADD(aMenus,'1<INFORMACION BASICA>')

       AADD(aAyuda,IF(nTipMod==3,'Consulta','Actualiza')+' '+;
                   'la Informaci¢n B sica.')

       cSavPan := SAVESCREEN(0,0,24,79)
       nNroOpc := IF(nNroOpc==NIL,1,nNroOpc)
       IF EMPTY(nNroOpc)

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
          IF EMPTY(nNroOpc) // Ojo
             cError('PRIMERO DEBE ESTAR ACTUALIZADA LA INFORMACION BASICA')
             RETURN NIL
          ENDIF
       ENDIF
*>>>>FIN VALIDACION DE LA INFORMACION BASICA

*>>>>MARCO DEL MANTENIMIENTO
       nTipCur := SETCURSOR()
       DO CASE
       CASE nTipMod == 1
	    cTxtTem := 'INFORMES DEL SISTEMA .INCLUIR. '+aMenus[nNroOpc]
	    INF->(DBGOBOTTOM())
	    INF->(DBSKIP())
	    nTipCur := SETCURSOR(1)

       CASE nTipMod == 2
	    cTxtTem := 'INFORMES DEL SISTEMA .ACTUALIZAR. '+aMenus[nNroOpc]
	    nTipCur := SETCURSOR(1)

       CASE nTipMod == 3
	    cTxtTem := 'INFORMES DEL SISTEMA. CONSULTA. '+aMenus[nNroOpc]
       ENDCASE
       nFilIni := nMarco(03,cTxtTem,22,'°')
*>>>>FIN MARCO DEL MANTENIMIENTO

*>>>>MANTENIMIENTO DEL REGISTRO
       SELECT INF
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
	    IF lGrabar

	       IF EMPTY(cCodigo)
		  cCodigo := INF->cCodigoInf
	       ENDIF

	       cTituloTin := INF->cTituloInf
	       cObservTin := INF->cObservInf
	       nNumeroTin := INF->nNumeroInf
	       lInfVarTin := INF->lInfVarInf
	       lInfVar := IF(lInfVarTin,'S','N')
	       cCodSuiTin := INF->cCodSuiInf
	       nNroOrdTin := INF->nNroOrdInf
	    ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DE CAMPO
	    IF nNroOpc == 1

               nNroFil := nFilIni
	       cTxtTem := SUBS('CODIGO INFORME'+SPACE(18),1,18)+':'

               IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(cCodigo)
                  @ nNroFil,nNroCol SAY cTxtTem
                  @ nNroFil,nNroCol+LEN(cTxtTem)+1 SAY cCodigo COLOR('I')
               ELSE
                  @ nNroFil,nNroCol SAY cTxtTem;
				    GET cCodigo PICT 'XXXXXXXX';
                                    VALID !EMPTY(cCodigo) .AND.;
					  !lValCodInf(cCodigo)
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
	       cTxtTem := SUBS('TITULO POR DEFECTO'+SPACE(18),1,18)+':'

	       IF nTipMod == 3
		  @ nNroFil,nColTem SAY cTxtTem
		  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cTituloTin COLOR('I')
	       ELSE
		  @ nNroFil,nColTem SAY cTxtTem;
				    GET cTituloTin PICT '@!S40';
				    VALID !EMPTY(cTituloTin);
				    WHEN {||HelpRead('FAVOR INGRESE EL TITULO POR DEFECTO')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
	       cTxtTem := SUBS('OBSERVACION'+SPACE(18),1,18)+':'

	       IF nTipMod == 3
		  @ nNroFil,nColTem SAY cTxtTem
		  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cObservTin COLOR('I')
	       ELSE
		  @ nNroFil,nColTem SAY cTxtTem;
				    GET cObservTin PICT '@!S40';
				    WHEN {||HelpRead('FAVOR INGRESE LA OBSERVACION')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
	       cTxtTem := SUBS('NUMERO DEL INFORME'+SPACE(18),1,18)+':'

	       IF nTipMod == 3
		  @ nNroFil,nColTem SAY cTxtTem
		  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nNumeroTin COLOR('I')
	       ELSE
		  @ nNroFil,nColTem SAY cTxtTem;
				    GET nNumeroTin PICT '99999999';
				    VALID !EMPTY(nNumeroTin);
				    WHEN {||HelpRead('FAVOR INGRESE EL NUMERO DEL INFORME')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
	       nColTem := nNroCol
	       cTxtTem := SUBS('INFORME VARIABLE'+SPACE(18),1,18)+':'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
		  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY lInfVar COLOR('I')
	       ELSE
		  @ nNroFil,nColTem SAY cTxtTem;
				    GET lInfVar PICT '@!';
                                    VALID lValSiNo(ROW(),COL()-1,;
						     @lInfVar,@lInfVarTin);
				    WHEN {||HelpRead('FAVOR INGRESE SI EL INFORME ES VARIABLE')}
	       ENDIF
	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
	       cTxtTem := SUBS('CODIGO SISTEMA'+SPACE(18),1,18)+':'

	       IF nTipMod == 3
		  @ nNroFil,nColTem SAY cTxtTem
		  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodSuiTin COLOR('I')
	       ELSE
		  @ nNroFil,nColTem SAY cTxtTem;
				    GET cCodSuiTin PICT '9999';
				    VALID !EMPTY(cCodSuiTin);
				    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO SISTEMA')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
	       cTxtTem := SUBS('NUMERO DE ORDEN'+SPACE(18),1,18)+':'

	       IF nTipMod == 3
		  @ nNroFil,nColTem SAY cTxtTem
		  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nNroOrdTin COLOR('I')
	       ELSE
		  @ nNroFil,nColTem SAY cTxtTem;
				    GET nNroOrdTin PICT '9999';
				    WHEN {||HelpRead('FAVOR INGRESE EL NUMERO DE ORDEN')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

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
       SELECT INF
       IF nTipMod # 3 .AND. lGrabar

          lInsReg := IF(nTipMod == 1,.T.,.F.)
	  IF INF->(lRegLock(lShared,lInsReg))

             IF lInsReg
		REPL INF->nIdeCodInf WITH INF->(RECNO())
		REPL INF->cCodigoInf WITH cCodigo
	     ENDIF

	     REPL INF->cTituloInf WITH cTituloTin
	     REPL INF->cObservInf WITH cObservTin
	     REPL INF->nNumeroInf WITH nNumeroTin
	     REPL INF->lInfVarInf WITH lInfVarTin
	     REPL INF->cCodSuiInf WITH cCodSuiTin
	     REPL INF->nNroOrdInf WITH nNroOrdTin

	     REPL INF->cNomUsrINF WITH cNomUsr
	     REPL INF->dFecUsrINF WITH DATE()
	     REPL INF->cHorUsrINF WITH TIME()
	     INF->(DBCOMMIT())
          ENDIF

          IF lShared
	     INF->(DBUNLOCK())
          ENDIF

       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SETCURSOR(nTipCur)
*>>>>FIN GRABACION DEL REGISTRO

*>>>>REFRESCAR EL BROWSE
       IF nTipMod == 2
	  nNroReg := INF->(RECNO())
	  INF->(DBGOTOP())
          oBrowse:GOTOP()
	  INF->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ENDIF
       RETURN .T.
*>>>>FIN REFRESCAR EL BROWSE

/*************************************************************************
* TITULO..: VALIDACION DE EXISTENCIA DEL CODIGO                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: feb 13/2008 DIA A
       Colombia, Bucaramanga        INICIO:  07:29 PM  feb 13/2008 DIA

OBJETIVOS:

1- Debe estar en uso el archivo.

2- Realiza la validaci¢n de existencia del C¢digo.

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCodInf(cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF cCodigo # cSpaces('INF','cCodigoInf')
	  IF lLocCodigo('cCodigoInf','INF',cCodigo)
	     cError('ESTE CODIGO YA EXISTE')
	     lHayErr := .T.
	  ENDIF
       ENDIF
       RETURN lHayErr
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: BUSQUEDA DEL CODIGO                                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: feb 13/2008 DIA A
       Colombia, Bucaramanga        INICIO:  07:29 PM  feb 13/2008 DIA

OBJETIVOS:

1- Permite localizar un c¢digo dentro del archivo.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION BuscarInf(oBrowse)

*>>>>DESCRIPCION DE PARAMETROS
/*     oBrowse                              // Browse del Archivo */
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
       cCodigo := cSpaces('INF','cCodigoInf')
       TitBuscar(LEN(cCodigo),@nNroFil,@nNroCol)
       @ nNroFil,nNroCol GET cCodigo PICT '@!';
			 VALID lValInf(ROW(),COL()-3,@cCodigo)
       READ
*>>>>FIN CAPTURA DEL CODIGO

*>>>>VALIDACION DEL CODIGO
       IF cCodigo == cSpaces('INF','cCodigoInf')
	  cError('PATRON DE BUSQUEDA NO ESPECIFICADO',;
		 'ADVERTENCIA')
	  lBuscar := .F.
       ENDIF
*>>>>FIN VALIDACION DEL CODIGO

*>>>>BUSQUEDA DEL CODIGO
       SELECT INF
       IF lBuscar .AND. lLocCodigo('cCodigoInf','INF',cCodigo)
	  nNroReg := INF->(RECNO())
	  INF->(DBGOTOP())
	  oBrowse:GOTOP()
	  INF->(DBGOTO(nNroReg))
	  oBrowse:FORCESTABLE()
       ELSE
          oBrowse:GOTOP()
       ENDIF
       RETURN NIL
*>>>>FIN BUSQUEDA DEL CODIGO

/*************************************************************************
* TITULO..: VALIDACION DEL CODIGO                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: feb 13/2008 DIA A
       Colombia, Bucaramanga        INICIO:  07:29 PM  feb 13/2008 DIA

OBJETIVOS:

1- Debe estar en uso el archivo

2- Realiza la validaci¢n del c¢digo

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValInf(nNroFil,nNroCol,cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroReg := 0                   // N£mero del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF !lLocCodigo('cCodigoInf','INF',cCodigo)
	  nNroReg := nSelInf(nNroFil,nNroCol)
          IF nNroReg == 0
	     cCodigo := cSpaces('INF','cCodigoInf')
          ELSE
	     INF->(DBGOTO(nNroReg))
	     cCodigo := INF->cCodigoInf
	  ENDIF
       ENDIF
       RETURN .T.
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: SELECCION DEL CODIGO                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: feb 13/2008 DIA A
       Colombia, Bucaramanga        INICIO:  07:29 PM  feb 13/2008 DIA

OBJETIVOS:

1- Debe estar en uso el archivo

2- Permite escoger el registro de acuerdo al c¢digo o descripci¢n

3- Retorna el n£mero del registro escogido

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSelInf(nNroFil,nNroCol)

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
       LOCAL nNroReg := 0                   // N£mero del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DE CONTENIDOS DE ARCHIVOS
       IF INF->(RECCOUNT()) == 0
          cError('NO EXISTEN REGISTROS GRABADOS')
          RETURN 0
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>INICIALIZACION DE LAS COORDENADAS
       SELECT INF
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
       INF->(DBGOTOP())
       cSavPan := SAVESCREEN(0,0,24,79)
       @ nFilSup-1,nColSup-1 TO nFilInf,nColInf+1 DOUBLE
       nNroReg := nBrowseDbf(nFilSup,nColSup,nFilInf-1,nColInf,;
			     {||INF->cCodigoInf})
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN nNroReg
*>>>>FIN SELECCION DEL CODIGO