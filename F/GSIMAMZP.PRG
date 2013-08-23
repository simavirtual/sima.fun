/*************************************************************************
* TITULO..: RECUPERACION DE LA ESTRUCTURA                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  2/2011 MIE A
       Colombia, Bucaramanga        INICIO: 10:27 AM   NOV  2/2011 MIE

OBJETIVOS:

1- Recupera la estructura del archivo

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RecuDbfMzp(lShared,nModCry,PathArc,fArchvo)

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
       CreaDbfMzp(lShared,nModCry,PathArc,fArchvo)
       RESTORE SCREEN
       RETURN NIL
*>>>>FIN RECUPERA LA ESTRUCTURA DEL ARCHIVO

/*************************************************************************
* TITULO..: ACTUALIZACION DE LA ESTRUCTURA                               *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  2/2011 MIE A
       Colombia, Bucaramanga        INICIO: 10:27 AM   NOV  2/2011 MIE

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

FUNCTION nActStrMzp(lShared,nModCry,PathArc,cNomArc)

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
       CreaDbfMzp(lShared,nModCry,PathArc,cNomArc,@aStrNew)
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
                         {||CreaDbfMzp(lShared,nModCry,PathArc,FileTem)})
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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  2/2011 MIE A
       Colombia, Bucaramanga        INICIO: 10:27 AM   NOV  2/2011 MIE

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenMzp(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       lModReg := IF(lModReg .AND. MZP->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfMzp(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
                             lModReg,lDelReg,lInsReg,lHaySql)

       SETKEY(K_F2,{||lManRegMzp(lShared,cNomUsr,3,oBrowse)})
     *ÀConsulta

       IF lModReg
          SETKEY(K_F4,{||lManRegMzp(lShared,cNomUsr,2,oBrowse,;
                                    MZP->nRecNroMzp)})
       ENDIF
     *ÀActualizar

       SETKEY(K_F5,{||BuscarMzp(oBrowse)})

       SETKEY(K_F9,{||MenuOtrMzp(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
                                 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
                                 aArchvo,lPrnArc,cOpcPrn,nCodPrn,lModReg,;
                                 lDelReg,lInsReg,lHaySql,oBrowse)})

       MZP->(CtrlBrw(lShared,oBrowse))

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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  2/2011 MIE A
       Colombia, Bucaramanga        INICIO: 10:27 AM   NOV  2/2011 MIE

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfMzp(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
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

       cTitSup := '<< CONFIGURACION RECIBO: COL,FIL EN CMS >>'
       cTitInf := '<F2>Consultar <F5>Buscar'+;
                   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
                   IF(lDelReg,' <DEL>Borrar','')+;
                   IF(lInsReg,' <INS>Incluir','')

       IF lInsReg
          oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegMzp(lShared,cNomUsr)}}
       ELSE
          oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT MZP
       oColumn := TBCOLUMNNEW('NUMERO;RECIBO',{||MZP->nRecNroMzp})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','MZP'},;
			 {'FIELD','nRecNroMzp'},{'PICTURE','99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CAMPO',{||MZP->cCamposMzp})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','MZP'},;
			 {'FIELD','cCamposMzp'},{'PICTURE','XXXXXX'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('PARTE1',{||MZP->cParte1Mzp})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MZP'},;
			 {'FIELD','cParte1Mzp'},{'PICTURE','XXXXXX'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('PARTE2',{||MZP->cParte2Mzp})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MZP'},;
			 {'FIELD','cParte2Mzp'},{'PICTURE','XXXXXX'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('PARTE3',{||MZP->cParte3Mzp})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MZP'},;
			 {'FIELD','cParte3Mzp'},{'PICTURE','XXXXXX'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('PARTE4',{||MZP->cParte4Mzp})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MZP'},;
			 {'FIELD','cParte4Mzp'},{'PICTURE','XXXXXX'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('PARTE5',{||MZP->cParte5Mzp})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MZP'},;
			 {'FIELD','cParte5Mzp'},{'PICTURE','XXXXXX'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('PARTE6',{||MZP->cParte6Mzp})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','MZP'},;
			 {'FIELD','cParte6Mzp'},{'PICTURE','XXXXXX'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||MZP->cNomUsrMzp})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				    {||cFecha(MZP->dFecUsrMzp)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				    {||cHoraSys(MZP->cHorUsrMzp)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CODIGO',{||MZP->nIdeCodMzp})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('No.',{||MZP->(RECNO())})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL REGISTRO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  2/2011 MIE A
       Colombia, Bucaramanga        INICIO: 10:27 AM   NOV  2/2011 MIE

OBJETIVOS:

1- Permite inclusi¢n,modificaci¢n y consulta del registro

2- Puede invocarse en la lectura a trav‚s de la clausula VALID

2- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lManRegMzp(lShared,cNomUsr,nTipMod,oBrowse,nRecNro,nNroOpc)

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

       LOCAL cCamposTmz := ''               // Campo                                                       
       LOCAL cParte1Tmz := ''               // Parte1                                                      
       LOCAL cParte2Tmz := ''               // Parte2                                                      
       LOCAL cParte3Tmz := ''               // Parte3                                                      
       LOCAL cParte4Tmz := ''               // Parte4                                                      
       LOCAL cParte5Tmz := ''               // Parte5                                                      
       LOCAL cParte6Tmz := ''               // Parte6                                                      

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
            cTxtTem := 'CONFIGURACION RECIBO .INCLUIR. '+aMenus[nNroOpc]
            MZP->(DBGOBOTTOM())
            MZP->(DBSKIP())
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 2
            cTxtTem := 'CONFIGURACION RECIBO .ACTUALIZAR. '+aMenus[nNroOpc]
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 3
            cTxtTem := 'CONFIGURACION RECIBO. CONSUTA. '+aMenus[nNroOpc]
       ENDCASE
       nFilIni := nMarco(03,cTxtTem,22,'°')
*>>>>FIN MARCO DEL MANTENIMIENTO

*>>>>MANTENIMIENTO DEL REGISTRO
       SELECT MZP
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
            IF lGrabar

               IF EMPTY(nRecNro)
                  nRecNro := MZP->nRecNroMzp
               ENDIF

               cCamposTmz := MZP->cCamposMzp
               cParte1Tmz := MZP->cParte1Mzp
               cParte2Tmz := MZP->cParte2Mzp
               cParte3Tmz := MZP->cParte3Mzp
               cParte4Tmz := MZP->cParte4Mzp
               cParte5Tmz := MZP->cParte5Mzp
               cParte6Tmz := MZP->cParte6Mzp
            ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil := nFilIni
               cTxtTem := 'RECIBO                :'

               IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(nRecNro)
                  @ nNroFil,nNroCol SAY cTxtTem
                  @ nNroFil,nNroCol+LEN(cTxtTem)+1 SAY nRecNro COLOR('I')
               ELSE
                  @ nNroFil,nNroCol SAY cTxtTem;
                                    GET nRecNro PICT '99';
                                    VALID !EMPTY(nRecNro) .AND.;
                                          !lValCodMzp(nRecNro)
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CAMPO :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCamposTmz COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCamposTmz PICT 'XXXXXX';
                                    WHEN {||HelpRead('FAVOR INGRESE EL CAMPO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PARTE1:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cParte1Tmz COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cParte1Tmz PICT 'XXXXXX';
                                    WHEN {||HelpRead('FAVOR INGRESE EL PARTE1')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PARTE2:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cParte2Tmz COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cParte2Tmz PICT 'XXXXXX';
                                    WHEN {||HelpRead('FAVOR INGRESE EL PARTE2')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PARTE3:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cParte3Tmz COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cParte3Tmz PICT 'XXXXXX';
                                    WHEN {||HelpRead('FAVOR INGRESE EL PARTE3')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PARTE4:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cParte4Tmz COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cParte4Tmz PICT 'XXXXXX';
                                    WHEN {||HelpRead('FAVOR INGRESE EL PARTE4')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PARTE5:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cParte5Tmz COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cParte5Tmz PICT 'XXXXXX';
                                    WHEN {||HelpRead('FAVOR INGRESE EL PARTE5')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PARTE6:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cParte6Tmz COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cParte6Tmz PICT 'XXXXXX';
                                    WHEN {||HelpRead('FAVOR INGRESE EL PARTE6')}
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
       SELECT MZP
       IF nTipMod # 3 .AND. lGrabar

          lInsReg := IF(nTipMod == 1,.T.,.F.)
          IF MZP->(lRegLock(lShared,lInsReg))

             IF lInsReg
                REPL MZP->nIdeCodMzp WITH MZP->(RECNO())
                REPL MZP->nRecNroMzp WITH nRecNro
             ENDIF

             REPL MZP->cCamposMzp WITH cCamposTmz
             REPL MZP->cParte1Mzp WITH cParte1Tmz
             REPL MZP->cParte2Mzp WITH cParte2Tmz
             REPL MZP->cParte3Mzp WITH cParte3Tmz
             REPL MZP->cParte4Mzp WITH cParte4Tmz
             REPL MZP->cParte5Mzp WITH cParte5Tmz
             REPL MZP->cParte6Mzp WITH cParte6Tmz

             REPL MZP->cNomUsrMzp WITH cNomUsr
             REPL MZP->dFecUsrMzp WITH DATE()
             REPL MZP->cHorUsrMzp WITH TIME()
             MZP->(DBCOMMIT())
          ENDIF

          IF lShared
             MZP->(DBUNLOCK())
          ENDIF

       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SETCURSOR(nTipCur)
*>>>>FIN GRABACION DEL REGISTRO

*>>>>REFRESCAR EL BROWSE
       IF nTipMod == 2
          nNroReg := MZP->(RECNO())
          MZP->(DBGOTOP())
          oBrowse:GOTOP()
          MZP->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ENDIF
       RETURN .T.
*>>>>FIN REFRESCAR EL BROWSE

/*************************************************************************
* TITULO..: VALIDACION DE EXISTENCIA DEL CODIGO                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  2/2011 MIE A
       Colombia, Bucaramanga        INICIO: 10:27 AM   NOV  2/2011 MIE

OBJETIVOS:

1- Debe estar en uso el archivo.

2- Realiza la validaci¢n de existencia del C¢digo.

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCodMzp(cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF cCodigo # cSpaces('MZP','nRecNroMzp')
          IF lLocCodigo('nRecNroMzp','MZP',cCodigo)
             cError('ESTE CODIGO YA EXISTE')
             lHayErr := .T.
          ENDIF
       ENDIF
       RETURN lHayErr
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: BUSQUEDA DEL CODIGO                                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  2/2011 MIE A
       Colombia, Bucaramanga        INICIO: 10:27 AM   NOV  2/2011 MIE

OBJETIVOS:

1- Permite localizar un c¢digo dentro del archivo.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION BuscarMzp(oBrowse)

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
       cCodigo := cSpaces('MZP','nRecNroMzp')
       TitBuscar(LEN(cCodigo),@nNroFil,@nNroCol)
       @ nNroFil,nNroCol GET cCodigo PICT '@!';
			 VALID lValMzp(ROW(),COL()-3,@cCodigo)
       READ
*>>>>FIN CAPTURA DEL CODIGO

*>>>>VALIDACION DEL CODIGO
       IF cCodigo == cSpaces('MZP','nRecNroMzp')
          cError('PATRON DE BUSQUEDA NO ESPECIFICADO',;
                 'ADVERTENCIA')
          lBuscar := .F.
       ENDIF
*>>>>FIN VALIDACION DEL CODIGO

*>>>>BUSQUEDA DEL CODIGO
       SELECT MZP
       IF lBuscar .AND. lLocCodigo('nRecNroMzp','MZP',cCodigo)
          nNroReg := MZP->(RECNO())
          MZP->(DBGOTOP())
          oBrowse:GOTOP()
          MZP->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ELSE
          oBrowse:GOTOP()
       ENDIF
       RETURN NIL
*>>>>FIN BUSQUEDA DEL CODIGO

/*************************************************************************
* TITULO..: VALIDACION DEL CODIGO                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  2/2011 MIE A
       Colombia, Bucaramanga        INICIO: 10:27 AM   NOV  2/2011 MIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Realiza la validaci¢n del c¢digo

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValMzp(nNroFil,nNroCol,cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroReg := 0                   // N£mero del Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF !lLocCodigo('nRecNroMzp','MZP',cCodigo)
          nNroReg := nSelMzp(nNroFil,nNroCol)
          IF nNroReg == 0
             cCodigo := cSpaces('MZP','nRecNroMzp')
          ELSE
             MZP->(DBGOTO(nNroReg))
             cCodigo := MZP->nRecNroMzp
          ENDIF
       ENDIF
       RETURN .T.
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: SELECCION DEL CODIGO                                         *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  2/2011 MIE A
       Colombia, Bucaramanga        INICIO: 10:27 AM   NOV  2/2011 MIE

OBJETIVOS:

1- Debe estar en uso el archivo

2- Permite escoger el registro de acuerdo al c¢digo o descripci¢n

3- Retorna el n£mero del registro escogido

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nSelMzp(nNroFil,nNroCol)

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
       IF MZP->(RECCOUNT()) == 0
          cError('NO EXISTEN REGISTROS GRABADOS')
          RETURN 0
       ENDIF
*>>>>FIN VALIDACION DE CONTENIDOS DE ARCHIVOS

*>>>>INICIALIZACION DE LAS COORDENADAS
       SELECT MZP
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
       MZP->(DBGOTOP())
       cSavPan := SAVESCREEN(0,0,24,79)
       @ nFilSup-1,nColSup-1 TO nFilInf,nColInf+1 DOUBLE
       nNroReg := nBrowseDbf(nFilSup,nColSup,nFilInf-1,nColInf,;
			     {||MZP->nRecNroMzp})
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN nNroReg
*>>>>FIN SELECCION DEL CODIGO

/*************************************************************************
* TITULO..: MENU DE OTROS PARA EL ARCHIVO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: NOV  2/2011 MIE A
       Colombia, Bucaramanga        INICIO: 10:27 AM   NOV  2/2011 MIE

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrMzp(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       AADD(aMenus,'1<CONFIGURACION RECIBO>')

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
            OtrMzp011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
                      oBrowse)
           *Impresi¢n de los campos del Archivo

       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE OPCION ESCOGIDA
