/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ago 14/2008 DIA A
       Colombia, Bucaramanga        INICIO:  02:57 PM  ago 14/2008 DIA

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfIso(lShared,nModCry,PathArc,fArchvo,aStrDbf,bInsReg)

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
       AADD(aDbfStr,{'nIdeCodIso','Numeric'  ,16,0}) // Ide del Registro
      *Llave Principal

       AADD(aDbfStr,{'nNumeroIso','Numeric',08,0}) // N£mero Iso del Informe
       AADD(aDbfStr,{'cTituloIso','Character',60,0}) // T¡tulo por defecto del Documento
       AADD(aDbfStr,{'cCodigoIso','Character',60,0}) // C¢digo Iso del Documento
       AADD(aDbfStr,{'cNroVerIso','Character',08,0}) // Versi¢n del Documento
       AADD(aDbfStr,{'dFecAprIso','Date',08,0}) // Fecha de Aprobaci¢n del Iso
       AADD(aDbfStr,{'cFecAprIso','Character',12,0}) // Fecha de Aprobaci¢n del Iso
       AADD(aDbfStr,{'cOpcSysIso','Character',60,0}) // Opci¢n del Sistema del Informe
       AADD(aDbfStr,{'cTitUnoIso','Character',60,0}) // T¡tulo Uno Iso del Documento
       AADD(aDbfStr,{'cTitDosIso','Character',60,0}) // T¡tulo Dos Iso del Documento
       AADD(aDbfStr,{'cTitTreIso','Character',60,0}) // T¡tulo Tres Iso del Documento
       AADD(aDbfStr,{'cPieUnoIso','Character',256,0}) // Pie de P gina Uno del Documento
       AADD(aDbfStr,{'cPieDosIso','Character',256,0}) // Pie de P gina Dos del Documento
       AADD(aDbfStr,{'cPieTreIso','Character',256,0}) // Pie de P gina Tres del Documento
       AADD(aDbfStr,{'cObsUnoIso','Character',256,0}) // Observaci¢n Uno
       AADD(aDbfStr,{'cObsDosIso','Character',256,0}) // Observaci¢n Dos
       AADD(aDbfStr,{'cObsTreIso','Character',256,0}) // Observaci¢n Tres
       AADD(aDbfStr,{'nCabPrnIso','Numeric',02,0}) // N£mero del Encabezado
       AADD(aDbfStr,{'nCodPrnIso','Numeric',04,0}) // C¢digo de la Impresora
       AADD(aDbfStr,{'nMargSIIso','Numeric',03,0}) // Margen Superior Izquierdo
       AADD(aDbfStr,{'nMargSDIso','Numeric',03,0}) // Margen Superior Derecho
       AADD(aDbfStr,{'nMargIIIso','Numeric',03,0}) // Margen Inferior Izquierdo
       AADD(aDbfStr,{'nMargIDIso','Numeric',03,0}) // Margen Inferior Derecho
       AADD(aDbfStr,{'nMarg1IIso','Numeric',03,0}) // Margen Uno Izquierdo
       AADD(aDbfStr,{'nMarg1DIso','Numeric',03,0}) // Margen Uno Derecho
       AADD(aDbfStr,{'nMarg2IIso','Numeric',03,0}) // Margen Dos Izquierdo
       AADD(aDbfStr,{'nMarg2DIso','Numeric',03,0}) // Margen Dos Derecho
       AADD(aDbfStr,{'nNroDocIso','Numeric',02,0}) // N£mero del Documento
       AADD(aDbfStr,{'cCodInfIso','Character',08,0}) // C¢digo del Informe
       AADD(aDbfStr,{'cCodSuiIso','Character',04,0}) // C¢digo del Sistema
       AADD(aDbfStr,{'nNroOrdIso','Numeric',04,0}) // N£mero de orden

       AADD(aDbfStr,{'cNomUsrIso','Character',10,0}) // Nombre del Usuario
       AADD(aDbfStr,{'dFecUsrIso','Date'     ,08,0}) // Fecha del Usuario
       AADD(aDbfStr,{'cHorUsrIso','Character',10,0}) // Hora del Usuario
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
       IF !lUseDbf(.T.,PathArc+'\'+fArchvo,'ISO',NIL,lShared,nModCry)
	  WAIT 'ABRIENDO EL ARCHIVO.INFORMES CONTROLADOS'
	  CloseDbf('ISO',PathArc+'\'+fArchvo,nModCry)
	  RETURN NIL
       ENDIF
*>>>>FIN SELECCION DE LAS AREAS DE TRABAJO

*>>>>REGISTROS POR DEFECTO
       EVAL(bInsReg)
       CloseDbf('ISO',PathArc+'\'+fArchvo,nModCry)
       RETURN NIL
*>>>>FIN REGISTROS POR DEFECTO

/*************************************************************************
* TITULO..: RECUPERACION DE LA ESTRUCTURA                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ago 14/2008 DIA A
       Colombia, Bucaramanga        INICIO:  02:57 PM  ago 14/2008 DIA

OBJETIVOS:

1- Recupera la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RecuDbfIso(lShared,nModCry,PathArc,fArchvo,bInsReg)

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
       CreaDbfIso(lShared,nModCry,PathArc,fArchvo,,bInsReg)
       RESTORE SCREEN
       RETURN NIL
*>>>>FIN RECUPERA LA ESTRUCTURA DEL ARCHIVO

/*************************************************************************
* TITULO..: ACTUALIZACION DE LA ESTRUCTURA                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ago 14/2008 DIA A
       Colombia, Bucaramanga        INICIO:  02:57 PM  ago 14/2008 DIA

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

FUNCTION nActStrIso(lShared,nModCry,PathArc,cNomArc)

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
       CreaDbfIso(lShared,nModCry,PathArc,cNomArc,@aStrNew)
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
			 {||CreaDbfIso(lShared,nModCry,PathArc,FileTem)})
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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ago 14/2008 DIA A
       Colombia, Bucaramanga        INICIO:  02:57 PM  ago 14/2008 DIA

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenIso(aP1,aP2,aP3,aArchvo,cOpcPrn,nCodPrn,;
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
       lModReg := IF(lModReg .AND. ISO->(RECCOUNT())==0,.F.,lModReg)

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
       oBrowse := oBrwDbfIso(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
                             lModReg,lDelReg,lInsReg,lHaySql)

       SETKEY(K_F2,{||lManRegIso(lShared,cNomUsr,3,oBrowse)})
     *ÀConsulta

       IF lModReg
	  SETKEY(K_F4,{||lManRegIso(lShared,cNomUsr,2,oBrowse,;
				    ISO->nNumeroIso)})
       ENDIF
     *ÀActualizar

       SETKEY(K_F5,{||BuscarIso(oBrowse)})

       SETKEY(K_F9,{||MenuOtrIso(aP1,aP2,aP3,;
				 aArchvo,cOpcPrn,nCodPrn,lModReg,;
                                 lDelReg,lInsReg,lHaySql,oBrowse)})

       ISO->(CtrlBrw(lShared,oBrowse))

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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ago 14/2008 DIA A
       Colombia, Bucaramanga        INICIO:  02:57 PM  ago 14/2008 DIA

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfIso(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
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

       cTitSup := '<< INFORMES CONTROLADOS >>'
       cTitInf := '<F2>Consultar <F5>Buscar'+;
                   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
                   IF(lDelReg,' <DEL>Borrar','')+;
                   IF(lInsReg,' <INS>Incluir','')

       IF lInsReg
	  oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegIso(lShared,cNomUsr)}}
       ELSE
          oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT ISO
       oColumn := TBCOLUMNNEW('NUMERO',{||ISO->nNumeroIso})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','ISO'},;
			 {'FIELD','nNumeroIso'},{'PICTURE','99999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('TITULO;POR DEFECTO',{||ISO->cTituloIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','cTituloIso'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CODIGO;DE LA ISO',{||ISO->cCodigoIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','cCodigoIso'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VERSION',{||ISO->cNroVerIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','cNroVerIso'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('FECHA;APROBACION',{||ISO->dFecAprIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','dFecAprIso'},{'PICTURE','@!D'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('FECHA;APROBACION',{||ISO->cFecAprIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','cFecAprIso'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('OPCION DEL SISTEMA',{||ISO->cOpcSysIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','cOpcSysIso'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('TITULO UNO',{||ISO->cTitUnoIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','cTitUnoIso'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('TITULO DOS',{||ISO->cTitDosIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','cTitDosIso'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('TITULO TRES',{||ISO->cTitTreIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','cTitTreIso'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('PIE DE PAGINA UNO',{||ISO->cPieUnoIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','cPieUnoIso'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('PIE DE PAGINA DOS',{||ISO->cPieDosIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','cPieDosIso'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('PIE DE PAGINA TRES',{||ISO->cPieTreIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','cPieTreIso'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('OBSERVACION UNO',{||ISO->cObsUnoIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','cObsUnoIso'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('OBSERVACION DOS',{||ISO->cObsDosIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','cObsDosIso'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('OBSERVACION TRES',{||ISO->cObsTreIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','cObsTreIso'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('ENCABEZADO;DEL INFORME',{||ISO->nCabPrnIso})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','ISO'},;
			 {'FIELD','nCabPrnIso'},{'PICTURE','99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CODIGO;IMPRESORA',{||ISO->nCodPrnIso})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','ISO'},;
			 {'FIELD','nCodPrnIso'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MARGEN SUPERIOR;IZQUIERDO',{||ISO->nMargSIIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','nMargSIIso'},{'PICTURE','999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MARGEN SUPERIOR;DERECHO',{||ISO->nMargSDIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','nMargSDIso'},{'PICTURE','999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MARGEN INFERIOR;IZQUIERDO',{||ISO->nMargIIIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','nMargIIIso'},{'PICTURE','999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MARGEN INFERIOR;DERECHO',{||ISO->nMargIDIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','nMargIDIso'},{'PICTURE','999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MARGEN UNO;IZQUIERDO',{||ISO->nMarg1IIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','nMarg1IIso'},{'PICTURE','999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MARGEN UNO;DERECHO',{||ISO->nMarg1DIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','nMarg1DIso'},{'PICTURE','999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MARGEN DOS;IZQUIERDO',{||ISO->nMarg2IIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','nMarg2IIso'},{'PICTURE','999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MARGEN DOS;DERECHO',{||ISO->nMarg2DIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','nMarg2DIso'},{'PICTURE','999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NUMERO;DOCUMENTO',{||ISO->nNroDocIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','nNroDocIso'},{'PICTURE','99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CODIGO;INFORME',{||ISO->cCodInfIso})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','ISO'},;
			 {'FIELD','cCodInfIso'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CODIGO;SISTEMA',{||ISO->cCodSuiIso})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','ISO'},;
			 {'FIELD','cCodSuiIso'},{'PICTURE','@!S76'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('ORDEN',{||ISO->nNroOrdIso})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','ISO'},;
			 {'FIELD','nNroOrdIso'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna


       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||ISO->cNomUsrIso})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				    {||cFecha(ISO->dFecUsrIso)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				    {||cHoraSys(ISO->cHorUsrIso)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CODIGO',{||ISO->nIdeCodIso})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('No.',{||ISO->(RECNO())})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: VALIDACION DE EXISTENCIA DEL CODIGO                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ago 14/2008 DIA A
       Colombia, Bucaramanga        INICIO:  02:57 PM  ago 14/2008 DIA

OBJETIVOS:

1- Debe estar en uso el archivo.

2- Realiza la validaci¢n de existencia del C¢digo.

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCodIso(cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF cCodigo # 0
	  IF lLocCodigo('nNumeroIso','ISO',cCodigo)
	     cError('ESTE CODIGO YA EXISTE')
	     lHayErr := .T.
	  ENDIF
       ENDIF
       RETURN lHayErr
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: BUSQUEDA DEL CODIGO                                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ago 14/2008 DIA A
       Colombia, Bucaramanga        INICIO:  02:57 PM  ago 14/2008 DIA

OBJETIVOS:

1- Permite localizar un c¢digo dentro del archivo.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION BuscarIso(oBrowse)

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
       cCodigo := cSpaces('ISO','nNumeroIso')
       TitBuscar(LEN(cCodigo),@nNroFil,@nNroCol)
       @ nNroFil,nNroCol GET cCodigo PICT '@!';
			 VALID lValIso(ROW(),COL()-3,@cCodigo)
       READ
*>>>>FIN CAPTURA DEL CODIGO

*>>>>VALIDACION DEL CODIGO
       IF cCodigo == 0
	  cError('PATRON DE BUSQUEDA NO ESPECIFICADO',;
		 'ADVERTENCIA')
	  lBuscar := .F.
       ENDIF
*>>>>FIN VALIDACION DEL CODIGO

*>>>>BUSQUEDA DEL CODIGO
       SELECT ISO
       IF lBuscar .AND. lLocCodigo('nNumeroIso','ISO',cCodigo)
	  nNroReg := ISO->(RECNO())
	  ISO->(DBGOTOP())
	  oBrowse:GOTOP()
	  ISO->(DBGOTO(nNroReg))
	  oBrowse:FORCESTABLE()
       ELSE
          oBrowse:GOTOP()
       ENDIF
       RETURN NIL
*>>>>FIN BUSQUEDA DEL CODIGO

/*************************************************************************
* TITULO..: VALIDACION DEL CODIGO                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ago 14/2008 DIA A
       Colombia, Bucaramanga        INICIO:  02:57 PM  ago 14/2008 DIA

OBJETIVOS:

1- Debe estar en uso el archivo

2- Realiza la validaci¢n del c¢digo

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValIso(nNroFil,nNroCol,cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroReg := 0                   // N£mero del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF !lLocCodigo('nNumeroIso','ISO',cCodigo)
	  nNroReg := nSelIso(nNroFil,nNroCol)
          IF nNroReg == 0
	     cCodigo := 0
	  ELSE
	     ISO->(DBGOTO(nNroReg))
	     cCodigo := ISO->nNumeroIso
          ENDIF
       ENDIF
       RETURN .T.
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: SELECCION DEL CODIGO                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ago 14/2008 DIA A
       Colombia, Bucaramanga        INICIO:  02:57 PM  ago 14/2008 DIA

OBJETIVOS:

1- Debe estar en uso el archivo

2- Permite escoger el registro de acuerdo al c¢digo o descripci¢n

3- Retorna el n£mero del registro escogido

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSelIso(nNroFil,nNroCol)

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
       IF ISO->(RECCOUNT()) == 0
          cError('NO EXISTEN REGISTROS GRABADOS')
          RETURN 0
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>INICIALIZACION DE LAS COORDENADAS
       SELECT ISO
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
       ISO->(DBGOTOP())
       cSavPan := SAVESCREEN(0,0,24,79)
       @ nFilSup-1,nColSup-1 TO nFilInf,nColInf+1 DOUBLE
       nNroReg := nBrowseDbf(nFilSup,nColSup,nFilInf-1,nColInf,;
			     {||ISO->nNumeroIso})
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN nNroReg
*>>>>FIN SELECCION DEL CODIGO