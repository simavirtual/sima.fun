/*************************************************************************
* TITULO..: RECUPERACION DE LA ESTRUCTURA                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 18/2013 LUN A
       Colombia, Bucaramanga        INICIO: 10:33 AM   NOV 18/2013 LUN

OBJETIVOS:

1- Recupera la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RecuDbfCnc(lShared,nModCry,PathArc,fArchvo)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                        // .T. Sistema Compartido
       nModCry                        // Modo de Protecci¢n
       PathArc			      // Path del Archivo
       fArchvo			      // Nombre del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>RECUPERA LA ESTRUCTURA DEL ARCHIVO
       SAVE SCREEN
       cError('SE BORRO EL ARCHIVO '+PathArc+'\'+fArchvo,;
              'Error Grave. TOME NOTA',;
              'Al Presionar Cualquier tecla se crea el archivo')
       Termometro(0,'CREANDO LA ESTRUCTURA')
       Termometro(100)
       CreaDbfCnc(lShared,nModCry,PathArc,fArchvo)
       RESTORE SCREEN
       RETURN NIL
*>>>>FIN RECUPERA LA ESTRUCTURA DEL ARCHIVO

/*************************************************************************
* TITULO..: ACTUALIZACION DE LA ESTRUCTURA                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 18/2013 LUN A
       Colombia, Bucaramanga        INICIO: 10:33 AM   NOV 18/2013 LUN

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

FUNCTION nActStrCnc(lShared,nModCry,PathArc,cNomArc)

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
       CreaDbfCnc(lShared,nModCry,PathArc,cNomArc,@aStrNew)
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
                         {||CreaDbfCnc(lShared,nModCry,PathArc,FileTem)})
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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 18/2013 LUN A
       Colombia, Bucaramanga        INICIO: 10:33 AM   NOV 18/2013 LUN

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenCnc(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql)

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
       lHaySql                              // .T. Exportar a Sql */
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
       lModReg := IF(lModReg .AND. CNC->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfCnc(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
                             lModReg,lDelReg,lInsReg,lHaySql)

       SETKEY(K_F2,{||lManRegCnc(lShared,cNomUsr,3,oBrowse)})
     *ÀConsulta

       IF lModReg
          SETKEY(K_F4,{||lManRegCnc(lShared,cNomUsr,2,oBrowse,;
                                    CNC->nNroMesCnc)})
       ENDIF
     *ÀActualizar

       SETKEY(K_F5,{||BuscarCnc(oBrowse)})

       SETKEY(K_F9,{||MenuOtrCnc(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
                                 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
                                 aArchvo,lPrnArc,cOpcPrn,nCodPrn,lModReg,;
                                 lDelReg,lInsReg,lHaySql,oBrowse)})

       CNC->(CtrlBrw(lShared,oBrowse))

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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 18/2013 LUN A
       Colombia, Bucaramanga        INICIO: 10:33 AM   NOV 18/2013 LUN

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfCnc(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
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

       cTitSup := '<< CONCILIACIONES >>'
       cTitInf := '<F2>Consultar <F5>Buscar'+;
                   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
                   IF(lDelReg,' <DEL>Borrar','')+;
                   IF(lInsReg,' <INS>Incluir','')

       IF lInsReg
          oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegCnc(lShared,cNomUsr)}}
       ELSE
          oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT CNC
       oColumn := TBCOLUMNNEW('MES',{||CNC->nNroMesCnc})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CNC'},;
			 {'FIELD','nNroMesCnc'},{'PICTURE','99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CAUSACION',{||CNC->nTotCauCnc})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CNC'},;
			 {'FIELD','nTotCauCnc'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CAUSACION;VALIDADA',{||CNC->nCauValCnc})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CNC'},;
			 {'FIELD','nCauValCnc'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('PAGOS',{||CNC->nTotPagCnc})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CNC'},;
			 {'FIELD','nTotPagCnc'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('PAGOS;VALIDADOS',{||CNC->nPagValCnc})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CNC'},;
			 {'FIELD','nPagValCnc'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('REPORTE;CONTABILIDAD',{||CNC->lReportCnc})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CNC'},;
			 {'FIELD','lReportCnc'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||CNC->cNomUsrCnc})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				    {||cFecha(CNC->dFecUsrCnc)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				    {||cHoraSys(CNC->cHorUsrCnc)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CODIGO',{||CNC->nIdeCodCnc})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('No.',{||CNC->(RECNO())})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL REGISTRO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 18/2013 LUN A
       Colombia, Bucaramanga        INICIO: 10:33 AM   NOV 18/2013 LUN

OBJETIVOS:

1- Permite inclusi¢n,modificaci¢n y consulta del registro

2- Puede invocarse en la lectura a trav‚s de la clausula VALID

2- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lManRegCnc(lShared,cNomUsr,nTipMod,oBrowse,nNroMes,nNroOpc)

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

       LOCAL nTotCauTcn := 0                // CAUSACION                                                   
       LOCAL nCauValTcn := 0                // CAUSACION VALIDADA                                          
       LOCAL nTotPagTcn := 0                // PAGOS                                                       
       LOCAL nPagValTcn := 0                // PAGOS VALIDADOS                                             
       LOCAL lReportTcn := .F.              // Reporte a la Contabilidad                                   
       LOCAL cReportTcn := ''               // Reporte a la Contabilidad                                   

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
            cTxtTem := 'CONCILIACIONES .INCLUIR. '+aMenus[nNroOpc]
            CNC->(DBGOBOTTOM())
            CNC->(DBSKIP())
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 2
            cTxtTem := 'CONCILIACIONES .ACTUALIZAR. '+aMenus[nNroOpc]
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 3
            cTxtTem := 'CONCILIACIONES. CONSUTA. '+aMenus[nNroOpc]
       ENDCASE
       nFilIni := nMarco(03,cTxtTem,22,'°')
*>>>>FIN MARCO DEL MANTENIMIENTO

*>>>>MANTENIMIENTO DEL REGISTRO
       SELECT CNC
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
            IF lGrabar

               IF EMPTY(nNroMes)
                  nNroMes := CNC->nNroMesCnc
               ENDIF

               nTotCauTcn := CNC->nTotCauCnc
               nCauValTcn := CNC->nCauValCnc
               nTotPagTcn := CNC->nTotPagCnc
               nPagValTcn := CNC->nPagValCnc
               lReportTcn := CNC->lReportCnc
               cReportTcn := IF(lReportTcn,'S','N')
            ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil := nFilIni
               cTxtTem := 'MES                         :'

               IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(nNroMes)
                  @ nNroFil,nNroCol SAY cTxtTem
                  @ nNroFil,nNroCol+LEN(cTxtTem)+1 SAY nNroMes COLOR('I')
               ELSE
                  @ nNroFil,nNroCol SAY cTxtTem;
                                    GET nNroMes PICT '99';
                                    VALID !EMPTY(nNroMes) .AND.;
                                          !lValCodCnc(nNroMes)
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CAUSACION                   :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nTotCauTcn COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nTotCauTcn PICT '999999999.99';
                                    VALID !EMPTY(nTotCauTcn);
                                    WHEN {||HelpRead('FAVOR INGRESE EL TOTAL CAUSACION')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CAUSACION VALIDADA          :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nCauValTcn COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nCauValTcn PICT '999999999.99';
                                    VALID !EMPTY(nCauValTcn);
                                    WHEN {||HelpRead('FAVOR INGRESE LA CAUSACION VALIDADA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PAGOS                       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nTotPagTcn COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nTotPagTcn PICT '999999999.99';
                                    VALID !EMPTY(nTotPagTcn);
                                    WHEN {||HelpRead('FAVOR INGRESE EL TOTAL PAGOS')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PAGOS VALIDADOS             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nPagValTcn COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nPagValTcn PICT '999999999.99';
                                    VALID !EMPTY(nPagValTcn);
                                    WHEN {||HelpRead('FAVOR INGRESE LOS PAGOS VALIDADOS')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'REPORTE CONTABILI:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cReportTcn COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cReportTcn PICT '@!';
                                    VALID lValSiNo(ROW(),COL()-1,;
                                                     @cReportTcn,@lReportTcn);
                                    WHEN {||HelpRead('FAVOR INGRESE SI REPORTO A CONTABILIDAD')}
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
       SELECT CNC
       IF nTipMod # 3 .AND. lGrabar

          lInsReg := IF(nTipMod == 1,.T.,.F.)
          IF CNC->(lRegLock(lShared,lInsReg))

             IF lInsReg
                REPL CNC->nIdeCodCnc WITH CNC->(RECNO())
                REPL CNC->nNroMesCnc WITH nNroMes
             ENDIF

             REPL CNC->nTotCauCnc WITH nTotCauTcn
             REPL CNC->nCauValCnc WITH nCauValTcn
             REPL CNC->nTotPagCnc WITH nTotPagTcn
             REPL CNC->nPagValCnc WITH nPagValTcn
             REPL CNC->lReportCnc WITH lReportTcn

             REPL CNC->cNomUsrCnc WITH cNomUsr
             REPL CNC->dFecUsrCnc WITH DATE()
             REPL CNC->cHorUsrCnc WITH TIME()
             CNC->(DBCOMMIT())
          ENDIF

          IF lShared
             CNC->(DBUNLOCK())
          ENDIF

       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SETCURSOR(nTipCur)
*>>>>FIN GRABACION DEL REGISTRO

*>>>>REFRESCAR EL BROWSE
       IF nTipMod == 2
          nNroReg := CNC->(RECNO())
          CNC->(DBGOTOP())
          oBrowse:GOTOP()
          CNC->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ENDIF
       RETURN .T.
*>>>>FIN REFRESCAR EL BROWSE

/*************************************************************************
* TITULO..: VALIDACION DE EXISTENCIA DEL CODIGO                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 18/2013 LUN A
       Colombia, Bucaramanga        INICIO: 10:33 AM   NOV 18/2013 LUN

OBJETIVOS:

1- Debe estar en uso el archivo.

2- Realiza la validaci¢n de existencia del C¢digo.

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCodCnc(cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF cCodigo # cSpaces('CNC','nNroMesCnc')
          IF lLocCodigo('nNroMesCnc','CNC',cCodigo)
             cError('ESTE CODIGO YA EXISTE')
             lHayErr := .T.
          ENDIF
       ENDIF
       RETURN lHayErr
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: BUSQUEDA DEL CODIGO                                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 18/2013 LUN A
       Colombia, Bucaramanga        INICIO: 10:33 AM   NOV 18/2013 LUN

OBJETIVOS:

1- Permite localizar un c¢digo dentro del archivo.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION BuscarCnc(oBrowse)

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
       cCodigo := cSpaces('CNC','nNroMesCnc')
       TitBuscar(LEN(cCodigo),@nNroFil,@nNroCol)
       @ nNroFil,nNroCol GET cCodigo PICT '@!';
			 VALID lValCnc(ROW(),COL()-3,@cCodigo)
       READ
*>>>>FIN CAPTURA DEL CODIGO

*>>>>VALIDACION DEL CODIGO
       IF cCodigo == cSpaces('CNC','nNroMesCnc')
          cError('PATRON DE BUSQUEDA NO ESPECIFICADO',;
                 'ADVERTENCIA')
          lBuscar := .F.
       ENDIF
*>>>>FIN VALIDACION DEL CODIGO

*>>>>BUSQUEDA DEL CODIGO
       SELECT CNC
       IF lBuscar .AND. lLocCodigo('nNroMesCnc','CNC',cCodigo)
          nNroReg := CNC->(RECNO())
          CNC->(DBGOTOP())
          oBrowse:GOTOP()
          CNC->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ELSE
          oBrowse:GOTOP()
       ENDIF
       RETURN NIL
*>>>>FIN BUSQUEDA DEL CODIGO

/*************************************************************************
* TITULO..: VALIDACION DEL CODIGO                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 18/2013 LUN A
       Colombia, Bucaramanga        INICIO: 10:33 AM   NOV 18/2013 LUN

OBJETIVOS:

1- Debe estar en uso el archivo

2- Realiza la validaci¢n del c¢digo

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCnc(nNroFil,nNroCol,cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroReg := 0                   // N£mero del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF !lLocCodigo('nNroMesCnc','CNC',cCodigo)
          nNroReg := nSelCnc(nNroFil,nNroCol)
          IF nNroReg == 0
             cCodigo := cSpaces('CNC','nNroMesCnc')
          ELSE
             CNC->(DBGOTO(nNroReg))
             cCodigo := CNC->nNroMesCnc
          ENDIF
       ENDIF
       RETURN .T.
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: SELECCION DEL CODIGO                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 18/2013 LUN A
       Colombia, Bucaramanga        INICIO: 10:33 AM   NOV 18/2013 LUN

OBJETIVOS:

1- Debe estar en uso el archivo

2- Permite escoger el registro de acuerdo al c¢digo o descripci¢n

3- Retorna el n£mero del registro escogido

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSelCnc(nNroFil,nNroCol)

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
       IF CNC->(RECCOUNT()) == 0
          cError('NO EXISTEN REGISTROS GRABADOS')
          RETURN 0
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>INICIALIZACION DE LAS COORDENADAS
       SELECT CNC
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
       CNC->(DBGOTOP())
       cSavPan := SAVESCREEN(0,0,24,79)
       @ nFilSup-1,nColSup-1 TO nFilInf,nColInf+1 DOUBLE
       nNroReg := nBrowseDbf(nFilSup,nColSup,nFilInf-1,nColInf,;
			     {||CNC->nNroMesCnc})
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN nNroReg
*>>>>FIN SELECCION DEL CODIGO

/*************************************************************************
* TITULO..: MENU DE OTROS PARA EL ARCHIVO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 18/2013 LUN A
       Colombia, Bucaramanga        INICIO: 10:33 AM   NOV 18/2013 LUN

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrCnc(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       AADD(aMenus,'1<CONCILIACIONES>')

       aAyuda := {}
       AADD(aAyuda,'Imprime los Detalles del Archivo')

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
            OtrCnc011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
                      oBrowse)
           *Impresi¢n de los campos del Archivo

       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE OPCION ESCOGIDA

/*************************************************************************
* TITULO..: IMPRESION CAMPOS DEL MANTENIMIENTO                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV 18/2013 LUN A
       Colombia, Bucaramanga        INICIO: 10:33 AM   NOV 18/2013 LUN

OBJETIVOS:

1- Imprime los campos del archivo de mantenimiento

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrCnc011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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

       LOCAL nAvance := 0                   // Avance de registros
       LOCAL Getlist := {}                  // Variable del sistema
     *ÀVariables espec¡ficas
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ACTIVACION DE LA IMPRESORA
       nRegPrn := PRN->(RECNO())
       nLenPrn := PCL('n17Stan')

       IF lPrnArc
          SET DEVICE TO PRINT
       ELSE
          FilePrn := 'Cnc'
          nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,cOpcPrn,.F.,.T.)
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
                   'CONCILIACIONES',;
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

       AADD(aNroCol,4)
       AADD(aTitPrn,'MES')

       AADD(aNroCol,14)
       AADD(aTitPrn,'CAUSACION')

       AADD(aNroCol,14)
       AADD(aTitPrn,'CAUSA VAL')

       AADD(aNroCol,14)
       AADD(aTitPrn,'PAGOS')

       AADD(aNroCol,14)
       AADD(aTitPrn,'PAGOS VAL')

       AADD(aNroCol,8)
       AADD(aTitPrn,'REPORTE')

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

*>>>>RECORRIDO DE LOS REGISTROS
       cSavPan := SAVESCREEN(0,0,24,79)
       SET DEVICE TO SCREEN
       Termometro(0,'IMPRIMIENDO')
       SET DEVICE TO PRINT

       SELECT CNC
       CNC->(DBGOTOP())
       DO WHILE .NOT. CNC->(EOF())

**********VISUALIZACION DE AVANCE
            nAvance := INT(( CNC->(RECNO()) / CNC->(RECCOUNT()) )*100)

            IF STR(nAvance,3) $ '25 50 75100'
               SET DEVICE TO SCREEN
               Termometro(nAvance)
               SET DEVICE TO PRINT
            ENDIF
**********FIN VISUALIZACION DE AVANCE

**********IMPRESION DEL REGISTRO
            aRegPrn := {}
            AADD(aRegPrn,STR(CNC->nNroMesCnc,2,0))
            AADD(aRegPrn,TRANS(CNC->nTotCauCnc,'###,###,###.99'))
            AADD(aRegPrn,TRANS(CNC->nCauValCnc,'###,###,###.99'))
            AADD(aRegPrn,TRANS(CNC->nTotPagCnc,'###,###,###.99'))
            AADD(aRegPrn,TRANS(CNC->nPagValCnc,'###,###,###.99'))
            AADD(aRegPrn,IF(CNC->lReportCnc,'SI','NO'))

            lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
                    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
**********FIN IMPRESION DEL REGISTRO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT CNC
	    CNC->(DBSKIP())
	    IF CNC->(EOF())
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
       PRN->(DBGOTO(nRegPrn))

       SET DEVICE TO SCREEN
       RETURN NIL
*>>>>FIN IMPRESION DERECHOS