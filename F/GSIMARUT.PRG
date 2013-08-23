/*************************************************************************
* TITULO..: CREACION DE LA ESTRUCTURA                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC  9/2004 JUE A
       Colombia, Bucaramanga        INICIO: 11:15 AM   DIC  9/2004 JUE

OBJETIVOS:

1- Crea la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaDbfRut(lShared,nModCry,PathArc,fArchvo,aStrDbf)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       PathArc                              // Path del Archivo
       fArchvo                              // Nombre del Archivo
       aStrDbf                              // Estructura del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL PathAct := ''                  // Path Actual

       LOCAL aDbfStr := {}                  // Estructura del Archivo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DE LA ESTRUCTURA
       AADD(aDbfStr,{'cCodigoRut','Character',2,0}) // C¢digo de la Ruta
       AADD(aDbfStr,{'cNombreRut','Character',40,0}) // Nombre de la Ruta
       AADD(aDbfStr,{'cConcepRut','Character',40,0}) // Conceptos de la Ruta
       AADD(aDbfStr,{'cNitChfRut','Character',16,0}) // Documento del Conductor
       AADD(aDbfStr,{'cTipChfRut','Character',1,0}) // Tipo del Documento del Conductor
       AADD(aDbfStr,{'cNitAuxRut','Character',16,0}) // Documento del Conductor
       AADD(aDbfStr,{'cTipAuxRut','Character',1,0}) // Tipo del Documento del Auxiliar

       AADD(aDbfStr,{'nCodigoRut','Numeric'  ,16,0}) // C¢digo del Registro
       AADD(aDbfStr,{'cNomUsrRut','Character',10,0}) // Nombre del Usuario
       AADD(aDbfStr,{'dFecUsrRut','Date'     ,08,0}) // Fecha del Usuario
       AADD(aDbfStr,{'cHorUsrRut','Character',10,0}) // Hora del Usuario
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
       RETURN NIL
*>>>>FIN CREACION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: RECUPERACION DE LA ESTRUCTURA                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC  9/2004 JUE A
       Colombia, Bucaramanga        INICIO: 11:15 AM   DIC  9/2004 JUE

OBJETIVOS:

1- Recupera la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RecuDbfRut(lShared,nModCry,PathArc,fArchvo)

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
       CreaDbfRut(lShared,nModCry,PathArc,fArchvo)
       RESTORE SCREEN
       RETURN NIL
*>>>>FIN RECUPERA LA ESTRUCTURA DEL ARCHIVO

/*************************************************************************
* TITULO..: ACTUALIZACION DE LA ESTRUCTURA                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC  9/2004 JUE A
       Colombia, Bucaramanga        INICIO: 11:15 AM   DIC  9/2004 JUE

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

FUNCTION nActStrRut(lShared,nModCry,PathArc,cNomArc)

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
       CreaDbfRut(lShared,nModCry,PathArc,cNomArc,@aStrNew)
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
                         {||CreaDbfRut(lShared,nModCry,PathArc,FileTem)})
             cError('NO SE ACTUALIZO LA ESTRUCTURA DEL ARCHIVO')
             nNroErr := 1
          ENDIF
          RESTSCREEN(0,0,24,79,cSavPan)
       ENDIF
       RETURN nNroErr
*>>>>FIN ACTUALIZACION DE LA ESTRUCTURA

/*************************************************************************
* TITULO..: DEFINICION DEL OBJETO BROWSE                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC  9/2004 JUE A
       Colombia, Bucaramanga        INICIO: 11:15 AM   DIC  9/2004 JUE

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfRut(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
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

       cTitSup := '<< RUTAS >>'
       cTitInf := '<F2>Consultar <F5>Buscar'+;
                   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
                   IF(lDelReg,' <DEL>Borrar','')+;
                   IF(lInsReg,' <INS>Incluir','')

       IF lInsReg
          oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegRut(lShared,cNomUsr)}}
       ELSE
          oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT RUT
       oColumn := TBCOLUMNNEW('CODIGO;RUTA',{||RUT->cCodigoRut})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','RUT'},;
			 {'FIELD','cCodigoRut'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NOMBRE DE;LA RUTA',{||RUT->cNombreRut})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RUT'},;
			 {'FIELD','cNombreRut'},{'PICTURE','@X'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CONCEPTOS;DE LA RUTA',{||RUT->cConcepRut})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','RUT'},;
			 {'FIELD','cConcepRut'},{'PICTURE','@X'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('DOCUMENTO;CONDUCTOR',{||RUT->cNitChfRut})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','RUT'},;
			 {'FIELD','cNitChfRut'},{'PICTURE','9999999999999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('TIPO DOCUMENTO;CONDUCTOR',{||RUT->cTipChfRut})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','RUT'},;
			 {'FIELD','cTipChfRut'},{'PICTURE','9'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('DOCUMENTO;AUXILIAR',{||RUT->cNitAuxRut})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','RUT'},;
			 {'FIELD','cNitAuxRut'},{'PICTURE','9999999999999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('TIPO DOCUMENTO;AUXILIAR',{||RUT->cTipAuxRut})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','RUT'},;
			 {'FIELD','cTipAuxRut'},{'PICTURE','9'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||RUT->cNomUsrRut})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				    {||cFecha(RUT->dFecUsrRut)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				    {||cHoraSys(RUT->cHorUsrRut)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CODIGO',{||RUT->nCodigoRut})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('No.',{||RUT->(RECNO())})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL REGISTRO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC  9/2004 JUE A
       Colombia, Bucaramanga        INICIO: 11:15 AM   DIC  9/2004 JUE

OBJETIVOS:

1- Permite inclusi¢n,modificaci¢n y consulta del registro

2- Puede invocarse en la lectura a trav‚s de la clausula VALID

2- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lManRegRut(lShared,cNomUsr,nTipMod,oBrowse,cCodigo,nNroOpc)

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
       #INCLUDE 'inkey.ch'                  // Declaraci¢n de teclas

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

       LOCAL cNombreTru := ''               // Nombre de la Ruta                                           
       LOCAL cConcepTru := ''               // Conceptos de la Ruta                                        
       LOCAL cNitChfTru := ''               // Documento del Conductor                                     
       LOCAL cTipChfTru := ''               // Tipo del Documento del Conductor                            
       LOCAL cNitAuxTru := ''               // Documento del Conductor                                     
       LOCAL cTipAuxTru := ''               // Tipo del Documento del Auxiliar                             

       LOCAL GetList := {}                 // Variable del sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DEL MENU
       nTipMod := IF(nTipMod==NIL,1,nTipMod)

       cSavPan := SAVESCREEN(0,0,24,79)
       nNroOpc := 1
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
            cTxtTem := 'RUTAS .POR FAVOR INGRESE LOS DATOS'
            RUT->(DBGOBOTTOM())
            RUT->(DBSKIP())
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 2
            cTxtTem := 'RUTAS .POR FAVOR ACTUALICE LOS DATOS'
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 3
            cTxtTem := 'CONSULTA. RUTAS'
       ENDCASE
       nFilIni := nMarco(03,cTxtTem,22,'°')
*>>>>FIN MARCO DEL MANTENIMIENTO

*>>>>MANTENIMIENTO DEL REGISTRO
       SELECT RUT
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
            IF lGrabar

               IF EMPTY(cCodigo)
                  cCodigo := RUT->cCodigoRut
               ENDIF

               cNombreTru := RUT->cNombreRut
               cConcepTru := RUT->cConcepRut
               cNitChfTru := RUT->cNitChfRut
               cTipChfTru := RUT->cTipChfRut
               cNitAuxTru := RUT->cNitAuxRut
               cTipAuxTru := RUT->cTipAuxRut
            ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DE CAMPO
            nNroFil := nFilIni
            cTxtTem := 'CODIGO DE LA RUTA       :'

            IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(cCodigo)
               @ nNroFil,nNroCol SAY cTxtTem
               @ nNroFil,nNroCol+LEN(cTxtTem)+1 SAY cCodigo COLOR('I')
            ELSE
               @ nNroFil,nNroCol SAY cTxtTem;
                                 GET cCodigo PICT '@!';
                                 VALID !EMPTY(cCodigo) .AND.;
                                       !lValCodRut(cCodigo)
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'NOMBRE DE LA RUTA       :'

            IF nTipMod == 3
               @ nNroFil+1,nColTem SAY cTxtTem
               @ nNroFil+1,nColTem+LEN(cTxtTem)+1 SAY cNombreTru COLOR('I')
            ELSE
               @ nNroFil+1,nColTem SAY cTxtTem;
                                   GET cNombreTru PICT '@X';
                                   VALID !EMPTY(cNombreTru);
                                   WHEN {||HelpRead('FAVOR INGRESE EL NOMBRE DE LA RUTA')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'CONCEPTOS DE LA RUTA    :'

            IF nTipMod == 3
               @ nNroFil+2,nColTem SAY cTxtTem
               @ nNroFil+2,nColTem+LEN(cTxtTem)+1 SAY cConcepTru COLOR('I')
            ELSE
               @ nNroFil+2,nColTem SAY cTxtTem;
                                   GET cConcepTru PICT '@X';
                                   VALID !EMPTY(cConcepTru);
                                   WHEN {||HelpRead('POR FAVOR INGRESE LOS CONCEPTOS DE LA RUTA')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'DOCUMENTO DEL CONDUCTOR :'

            IF nTipMod == 3
               @ nNroFil+3,nColTem SAY cTxtTem
               @ nNroFil+3,nColTem+LEN(cTxtTem)+1 SAY cNitChfTru COLOR('I')
            ELSE
               @ nNroFil+3,nColTem SAY cTxtTem;
                                   GET cNitChfTru PICT '9999999999999999';
                                   VALID !EMPTY(cNitChfTru);
                                   WHEN {||HelpRead('FAVOR INGRESE EL DOCUMENTO DEL CONDUCTOR')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'TIPO DOCUMENTO CONDUCTOR:'

            IF nTipMod == 3
               @ nNroFil+4,nColTem SAY cTxtTem
               @ nNroFil+4,nColTem+LEN(cTxtTem)+1 SAY cTipChfTru COLOR('I')
            ELSE
               @ nNroFil+4,nColTem SAY cTxtTem;
                                   GET cTipChfTru PICT '9';
                                   VALID !EMPTY(cTipChfTru);
                                   WHEN {||HelpRead('FAVOR INGRESE EL TIPO DEL DOCUMENTO DEL CONDUCTOR')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'DOCUMENTO DEL AUXILIAR  :'

            IF nTipMod == 3
               @ nNroFil+5,nColTem SAY cTxtTem
               @ nNroFil+5,nColTem+LEN(cTxtTem)+1 SAY cNitAuxTru COLOR('I')
            ELSE
               @ nNroFil+5,nColTem SAY cTxtTem;
                                   GET cNitAuxTru PICT '9999999999999999';
                                   VALID !EMPTY(cNitAuxTru);
                                   WHEN {||HelpRead('FAVOR INGRESE EL DOCUMENTO DEL AUXILIAR')}
            ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            nColTem := nNroCol
            cTxtTem := 'TIPO DOCUMENTO AUXILIAR :'

            IF nTipMod == 3
               @ nNroFil+6,nColTem SAY cTxtTem
               @ nNroFil+6,nColTem+LEN(cTxtTem)+1 SAY cTipAuxTru COLOR('I')
            ELSE
               @ nNroFil+6,nColTem SAY cTxtTem;
                                   GET cTipAuxTru PICT '9';
                                   VALID !EMPTY(cTipAuxTru);
                                   WHEN {||HelpRead('FAVOR INGRESE EL TIPO DEL DOCUMENTO DEL AUXILIAR')}
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
       SELECT RUT
       IF nTipMod # 3 .AND. lGrabar

          lInsReg := IF(nTipMod == 1,.T.,.F.)
          IF RUT->(lRegLock(lShared,lInsReg))

             IF lInsReg
                REPL RUT->nCodigoRut WITH RUT->(RECNO())
                REPL RUT->cCodigoRut WITH cCodigo
             ENDIF

             REPL RUT->cNombreRut WITH cNombreTru
             REPL RUT->cConcepRut WITH cConcepTru
             REPL RUT->cNitChfRut WITH cNitChfTru
             REPL RUT->cTipChfRut WITH cTipChfTru
             REPL RUT->cNitAuxRut WITH cNitAuxTru
             REPL RUT->cTipAuxRut WITH cTipAuxTru

             REPL RUT->cNomUsrRut WITH cNomUsr
             REPL RUT->dFecUsrRut WITH DATE()
             REPL RUT->cHorUsrRut WITH TIME()
             RUT->(DBCOMMIT())
          ENDIF

          IF lShared
             RUT->(DBUNLOCK())
          ENDIF

       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SETCURSOR(nTipCur)
*>>>>FIN GRABACION DEL CAMPO

*>>>>REFRESCAR EL BROWSE
       IF nTipMod == 2
          nNroReg := RUT->(RECNO())
          RUT->(DBGOTOP())
          oBrowse:GOTOP()
          RUT->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ENDIF
       RETURN .T.
*>>>>FIN REFRESCAR EL BROWSE

/*************************************************************************
* TITULO..: VALIDACION DE EXISTENCIA DEL CODIGO                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC  9/2004 JUE A
       Colombia, Bucaramanga        INICIO: 11:15 AM   DIC  9/2004 JUE

OBJETIVOS:

1- Debe estar en uso el archivo.

2- Realiza la validaci¢n de existencia del C¢digo.

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCodRut(cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF cCodigo # cSpaces('RUT','cCodigoRut')
          IF lLocCodigo('cCodigoRut','RUT',cCodigo)
             cError('ESTE CODIGO YA EXISTE')
             lHayErr := .T.
          ENDIF
       ENDIF
       RETURN lHayErr
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: BUSQUEDA DEL CODIGO                                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC  9/2004 JUE A
       Colombia, Bucaramanga        INICIO: 11:15 AM   DIC  9/2004 JUE

OBJETIVOS:

1- Permite localizar un c¢digo dentro del archivo.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION BuscarRut(oBrowse)

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
       cCodigo := cSpaces('RUT','cCodigoRut')
       TitBuscar(LEN(cCodigo),@nNroFil,@nNroCol)
       @ nNroFil,nNroCol GET cCodigo PICT '@!';
			 VALID lValRut(ROW(),COL()-3,@cCodigo)
       READ
*>>>>FIN CAPTURA DEL CODIGO

*>>>>VALIDACION DEL CODIGO
       IF cCodigo == cSpaces('RUT','cCodigoRut')
          cError('PATRON DE BUSQUEDA NO ESPECIFICADO',;
                 'ADVERTENCIA')
          lBuscar := .F.
       ENDIF
*>>>>FIN VALIDACION DEL CODIGO

*>>>>BUSQUEDA DEL CODIGO
       SELECT RUT
       IF lBuscar .AND. lLocCodigo('cCodigoRut','RUT',cCodigo)
          nNroReg := RUT->(RECNO())
          RUT->(DBGOTOP())
          oBrowse:GOTOP()
          RUT->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ELSE
          oBrowse:GOTOP()
       ENDIF
       RETURN NIL
*>>>>FIN BUSQUEDA DEL CODIGO

/*************************************************************************
* TITULO..: VALIDACION DEL CODIGO                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC  9/2004 JUE A
       Colombia, Bucaramanga        INICIO: 11:15 AM   DIC  9/2004 JUE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Realiza la validaci¢n del c¢digo

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValRut(nNroFil,nNroCol,cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroReg := 0                   // N£mero del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF !lLocCodigo('cCodigoRut','RUT',cCodigo)
          nNroReg := nSelRut(nNroFil,nNroCol)
          IF nNroReg == 0
             cCodigo := cSpaces('RUT','cCodigoRut')
          ELSE
             RUT->(DBGOTO(nNroReg))
             cCodigo := RUT->cCodigoRut
          ENDIF
       ENDIF
       RETURN .T.
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: SELECCION DEL CODIGO                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC  9/2004 JUE A
       Colombia, Bucaramanga        INICIO: 11:15 AM   DIC  9/2004 JUE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Permite escoger el registro de acuerdo al c¢digo o descripci¢n

3- Retorna el n£mero del registro escogido

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSelRut(nNroFil,nNroCol)

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
       IF RUT->(RECCOUNT()) == 0
          cError('NO EXISTEN REGISTROS GRABADOS')
          RETURN 0
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>INICIALIZACION DE LAS COORDENADAS
       SELECT RUT
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
       RUT->(DBGOTOP())
       cSavPan := SAVESCREEN(0,0,24,79)
       @ nFilSup-1,nColSup-1 TO nFilInf,nColInf+1 DOUBLE
       nNroReg := nBrowseDbf(nFilSup,nColSup,nFilInf-1,nColInf,;
			     {||RUT->cCodigoRut})
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN nNroReg
*>>>>FIN SELECCION DEL CODIGO

/*************************************************************************
* TITULO..: IMPRESION CAMPOS DEL MANTENIMIENTO                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC  9/2004 JUE A
       Colombia, Bucaramanga        INICIO: 11:15 AM   DIC  9/2004 JUE

OBJETIVOS:

1- Imprime los campos del archivo de mantenimiento

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrRut011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       fArchvo                              // Archivo de Usuarios
       aArcNtx                              // Archivos Indice
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
     *ÀVariables generales

       LOCAL FilePrn := ''                  // Archivo de impresion
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

*>>>>DEFINCION DEL ENCABEZADO
       nNroPag := 0
       lTamAnc := .F.

       nTotReg := 0

       aCabPrn := {cNomEmp,cNomSis,;
                   'RUTAS',;
                   '',;
                   ''}

       aCabeza := {aCabPrn[1],aCabPrn[2],aCabPrn[3],aCabPrn[4],aCabPrn[5],;
                   nNroPag++,;
                   cTotPagina(nTotReg),lTamAnc}

       cCodIni := PCL({'DraftOn','Elite','CondenOn'})
       cCodFin := PCL({'NegraOf','DobGolOf'})
*>>>>FIN DEFINCION DEL ENCABEZADO

*>>>>ENCABEZADOS DE COLUMNA
       aNroCol := {}
       aTitPrn := {}

       AADD(aNroCol,4)
       AADD(aTitPrn,'RUTA')

       AADD(aNroCol,40)
       AADD(aTitPrn,'DESCRIPCION')

       AADD(aNroCol,40)
       AADD(aTitPrn,'CONCEPTOS')

       AADD(aNroCol,16)
       AADD(aTitPrn,'CONDUCTOR')

       AADD(aNroCol,4)
       AADD(aTitPrn,'TIPO')

       AADD(aNroCol,16)
       AADD(aTitPrn,'AUXILIAR')

       AADD(aNroCol,4)
       AADD(aTitPrn,'TIPO')

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
          FilePrn := 'Rut'
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

       SELECT RUT
       RUT->(DBGOTOP())
       DO WHILE .NOT. RUT->(EOF())

**********VISUALIZACION DE AVANCE
            nAvance := INT(( RUT->(RECNO()) / RUT->(RECCOUNT()) )*100)

            IF STR(nAvance,3) $ '25 50 75100'
               SET DEVICE TO SCREEN
               Termometro(nAvance)
               SET DEVICE TO PRINT
            ENDIF
**********FIN VISUALIZACION DE AVANCE

**********IMPRESION DEL REGISTRO
            aRegPrn := {}
            AADD(aRegPrn,RUT->cCodigoRut)
            AADD(aRegPrn,RUT->cNombreRut)
            AADD(aRegPrn,RUT->cConcepRut)
            AADD(aRegPrn,RUT->cNitChfRut)
            AADD(aRegPrn,RUT->cTipChfRut)
            AADD(aRegPrn,RUT->cNitAuxRut)
            AADD(aRegPrn,RUT->cTipAuxRut)

            lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
                    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
**********FIN IMPRESION DEL REGISTRO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT RUT
	    RUT->(DBSKIP())
	    IF RUT->(EOF())
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