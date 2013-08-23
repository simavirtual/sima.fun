/*************************************************************************
* TITULO..: MANTENIMIENTO DEL ARCHIVO                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN  8/2007 VIE A
       Colombia, Bucaramanga        INICIO:  7:22 PM   JUN  8/2007 VIE

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenPnl(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       lModReg := IF(lModReg .AND. PNL->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfPnl(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
			     lModReg,lDelReg,lInsReg,lHaySql)

       SETKEY(K_F3,{||VerAusPnl(lShared,cNomUsr,cAnoUsr,lModReg,;
				lDelReg,lInsReg,lHaySql)})

       SETKEY(K_F2,{||lManRegPnl(lShared,cNomUsr,cAnoUsr,3,oBrowse)})
     *ÀConsulta

       IF lModReg
	  SETKEY(K_F4,{||lManRegPnl(lShared,cNomUsr,cAnoUsr,2,oBrowse,;
                                    PNL->cCodigoPnl)})
       ENDIF
     *ÀActualizar

       SETKEY(K_F5,{||BuscarPnl(oBrowse)})

       SETKEY(K_F9,{||MenuOtrPnl(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
                                 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
                                 aArchvo,lPrnArc,cOpcPrn,nCodPrn,lModReg,;
                                 lDelReg,lInsReg,lHaySql,oBrowse)})

       PNL->(CtrlBrw(lShared,oBrowse))

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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN  8/2007 VIE A
       Colombia, Bucaramanga        INICIO:  7:22 PM   JUN  8/2007 VIE

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfPnl(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
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

       cTitSup := '<< PERSONAL >>'
       cTitInf := '<F2>Consultar <F3>Asitencia <F5>Buscar'+;
                   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
                   IF(lDelReg,' <DEL>Borrar','')+;
                   IF(lInsReg,' <INS>Incluir','')

       IF lInsReg
	  oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegPnl(lShared,cNomUsr,;
							  cAnoUsr)}}
       ELSE
          oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT PNL
       oColumn := TBCOLUMNNEW('CODIGO',{||PNL->cCodigoPnl})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','PNL'},;
			 {'FIELD','cCodigoPnl'},{'PICTURE','9999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NOMBRES Y APELLIDOS',;
			      {||cLocNomPer(PNL->nIdePerPnl,'PNL')})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('TIPO',{||PNL->cTipPerPnl})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PNL'},;
			 {'FIELD','cTipPerPnl'},{'PICTURE','99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('TIPO',{||cLocTipPer(PNL->cTipPerPnl,'PNL')})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('RETIRO',{||PNL->lRetiroPnl})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PNL'},;
			 {'FIELD','lRetiroPnl'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('FECHA;RETIRO',{||PNL->dFecRetPnl})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PNL'},;
			 {'FIELD','dFecRetPnl'},{'PICTURE','@!D'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('PERSONA',{||PNL->nIdePerPnl})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','PNL'},;
			 {'FIELD','nIdePerPnl'},{'PICTURE','9999999999999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CLAVE',{||PNL->cPasWorPnl})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','PNL'},;
			 {'FIELD','cPasWorPnl'},{'PICTURE','XXXXXXXXXX'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||PNL->cNomUsrPnl})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				    {||cFecha(PNL->dFecUsrPnl)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				    {||cHoraSys(PNL->cHorUsrPnl)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CODIGO',{||PNL->nIdeCodPnl})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('No.',{||PNL->(RECNO())})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL REGISTRO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN  8/2007 VIE A
       Colombia, Bucaramanga        INICIO:  7:22 PM   JUN  8/2007 VIE

OBJETIVOS:

1- Permite inclusi¢n,modificaci¢n y consulta del registro

2- Puede invocarse en la lectura a trav‚s de la clausula VALID

2- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lManRegPnl(lShared,cNomUsr,cAnoUsr,nTipMod,oBrowse,cCodigo,nNroOpc)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos
       cNomUsr                              // Nombre del Usuario
       cAnoUsr                              // A¤o del Usuario
       nTipMod                              // Tipo de Modificaci¢n. 1 =>Insertar, 2=>Modificar 3=>Consultar
       xCodigo                              // C¢digo a Ingresar, Actualizar
       cTipNit                              // Tipo de Documento
       nNroOpc                              // N£mero de Opci¢n
       oBrowse                              // Browse del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema

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

       LOCAL cCodigoTpn := ''               // C¢digo del Personal
       LOCAL cTipPerTpn := ''               // Tipo de persona                                             
       LOCAL cPasWorTpn := ''               // Clave de la Personal                                        
       LOCAL lRetiroTpn := .F.              // Retiro del Personal                                         
       LOCAL cRetiroTpn := ''               // Retiro del Personal                                         
       LOCAL dFecRetTpn := CTOD('00/00/00')   // Fecha de retiro                                             
       LOCAL nIdePerTpn := 0                // Ide del Registro de Personas                                

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

*>>>>LOCALIZACION DE LA PERSONA
       IF nTipMod # 1
	  IF !lLocCodigo('nIdeCodPer','PER',PNL->nIdePerPnl)
	     cError('NO EXISTE LA PERSONA CON ID:'+;
		    ALLTRIM(STR(PNL->nIdePerPnl)))
	     RETURN NIL
	  ENDIF
       ENDIF
*>>>>FIN LOCALIZACION DE LA PERSONA

*>>>>MARCO DEL MANTENIMIENTO
       nTipCur := SETCURSOR()
       DO CASE
       CASE nTipMod == 1

	    lManRegPer(lShared,cNomUsr,NIL,NIL,NIL,NIL,@nIdePerTpn)
	  *ÀIngreso de los datos de la persona

	    IF EMPTY(PER->cApeUnoPer) .OR. EMPTY(PER->cNomUnoPer)
	       RETURN NIL
	    ENDIF

            cTxtTem := 'PERSONAL .INCLUIR. '+aMenus[nNroOpc]
            PNL->(DBGOBOTTOM())
            PNL->(DBSKIP())
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 2
            cTxtTem := 'PERSONAL .ACTUALIZAR. '+aMenus[nNroOpc]
	    nTipCur := SETCURSOR(1)

	    lManRegPer(lShared,cNomUsr,2,NIL,PER->cDocNitPer)

       CASE nTipMod == 3
	    cTxtTem := 'PERSONAL. CONSULTA. '+aMenus[nNroOpc]

	    lManRegPer(lShared,cNomUsr,3)

       ENDCASE
       nFilIni := nMarco(03,cTxtTem,22,'°')
*>>>>FIN MARCO DEL MANTENIMIENTO

*>>>>MANTENIMIENTO DEL REGISTRO
       SELECT PNL
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
            IF lGrabar

               IF EMPTY(cCodigo)
                  cCodigo := PNL->cCodigoPnl
               ENDIF

	       cCodigoTpn := PNL->cCodigoPnl
               cTipPerTpn := PNL->cTipPerPnl
               cPasWorTpn := PNL->cPasWorPnl
               lRetiroTpn := PNL->lRetiroPnl
               cRetiroTpn := IF(lRetiroTpn,'S','N')
               dFecRetTpn := PNL->dFecRetPnl
	    ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DE CAMPO
	    IF nNroOpc == 1 .AND. ASA->lHayCodAsa

	       nNroFil := nFilIni
               nColTem := nNroCol
	       cTxtTem := 'CODIGO      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
		  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodigoTpn COLOR('I')
	       ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
				    GET cCodigoTpn PICT '999999';
				    VALID !lValCodPnl(cCodigoTpn) .AND.;
					  !EMPTY(cCodigoTpn);
				    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DEL PERSONAL')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

	       nNroFil := IF(ASA->lHayCodAsa,nNroFil+1,nFilIni)
               nColTem := nNroCol
               cTxtTem := 'TIPO        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cTipPerTpn COLOR('I')
	       ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cTipPerTpn PICT '99';
				    VALID lValTpe(ROW(),COL()-3,@cTipPerTpn);
				    WHEN {||HelpRead('FAVOR INGRESE EL TIPO DE PERSONAL')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CLAVE       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cPasWorTpn COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cPasWorTpn PICT 'XXXXXXXXXX';
                                    WHEN {||HelpRead('FAVOR INGRESE LA CLAVE DEL PERSONAL')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'RETIRO      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cRetiroTpn COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cRetiroTpn PICT '@!';
                                    VALID lValSiNo(ROW(),COL()-1,;
                                                     @cRetiroTpn,@lRetiroTpn);
                                    WHEN {||HelpRead('FAVOR INGRESE SI SE RETIRO EL PERSONAL')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'FECHA RETIRO:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY dFecRetTpn COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET dFecRetTpn PICT '@!D';
                                    WHEN {||HelpRead('FAVOR INGRESE LA FECHA DE RETIRO')}
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

*>>>>ASIGNACION DEL CODIGO DEL PERSONAL
       IF nTipMod == 1 .AND. lGrabar .AND. !ASA->lHayCodAsa

	  IF ASA->(lRegLock(lShared,.F.))

	     cCodigo := STR(ASA->nNroPerAsa+1,4)
	    *Lectura del C¢digo del Personal

	     REPL ASA->nNroPerAsa WITH ASA->nNroPerAsa+1
	     ASA->(DBCOMMIT())
	     IF lShared
		ASA->(DBUNLOCK())
	     ENDIF
	   *ÀGrabaci¢n de C¢digo asignado
	  ENDIF
       ENDIF
*>>>>FIN ASIGNACION DEL CODIGO DEL PERSONAL

*>>>>ASIGNACION DEL CODIGO DEL PERSONAL
       IF nTipMod == 1 .AND. lGrabar .AND. !ASA->lHayCodAsa
	  lCorrecion(@cCodigo)
	  IF VAL(cAnoUsr) >= 2000
	     cCodigo := SUBS(cAnoUsr,1,1)+cAnoSis+;
			   SUBS(cCodigo,2,3)
	  ELSE
	     cCodigo := cAnoSis+cCodigo
	  ENDIF
       ENDIF
*>>>>FIN ASIGNACION DEL CODIGO DEL PERSONAL

*>>>>ASIGNACION DEL CODIGO
       IF ASA->lHayCodAsa
	  cCodigo := cCodigoTpn
       ENDIF
*>>>>FIN ASIGNACION DEL CODIGO

*>>>>GRABACION DEL REGISTRO
       SELECT PNL
       IF nTipMod # 3 .AND. lGrabar

          lInsReg := IF(nTipMod == 1,.T.,.F.)
          IF PNL->(lRegLock(lShared,lInsReg))

             IF lInsReg
                REPL PNL->nIdeCodPnl WITH PNL->(RECNO())
                REPL PNL->cCodigoPnl WITH cCodigo
             ENDIF

             REPL PNL->cTipPerPnl WITH cTipPerTpn
             REPL PNL->cPasWorPnl WITH cPasWorTpn
             REPL PNL->lRetiroPnl WITH lRetiroTpn
	     REPL PNL->dFecRetPnl WITH dFecRetTpn

	     IF nTipMod == 1
		REPL PNL->nIdePerPnl WITH nIdePerTpn
	     ENDIF

             REPL PNL->cNomUsrPnl WITH cNomUsr
             REPL PNL->dFecUsrPnl WITH DATE()
             REPL PNL->cHorUsrPnl WITH TIME()
             PNL->(DBCOMMIT())
          ENDIF

          IF lShared
             PNL->(DBUNLOCK())
          ENDIF

       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SETCURSOR(nTipCur)
*>>>>FIN GRABACION DEL REGISTRO

*>>>>REFRESCAR EL BROWSE
       IF nTipMod == 2
          nNroReg := PNL->(RECNO())
          PNL->(DBGOTOP())
          oBrowse:GOTOP()
          PNL->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ENDIF
       RETURN .T.
*>>>>FIN REFRESCAR EL BROWSE

/*************************************************************************
* TITULO..: MENU DE OTROS PARA EL ARCHIVO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN  8/2007 VIE A
       Colombia, Bucaramanga        INICIO:  7:22 PM   JUN  8/2007 VIE

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrPnl(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       AADD(aMenus,'1<PERSONAL  >')
       AADD(aMenus,'2<ASISTENCIA>')
       AADD(aMenus,'3<PRUEBAS   >')

       aAyuda := {}
       AADD(aAyuda,'Imprime la relaci¢n del personal')
       AADD(aAyuda,'Imprime el control de asistencia')
       AADD(aAyuda,'Pruebas')

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
            OtrPnl011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
                      oBrowse)
	   *Impresi¢n de los campos del Archivo

       CASE nNroOpc == 2
	    OtrPnl012(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		      oBrowse)
	   *Control de Asistencia del Personal

       CASE nNroOpc == 3
	    OtrPnl013(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		      oBrowse)
	   *Control de Asistencia del Personal

       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE OPCION ESCOGIDA

/*************************************************************************
* TITULO..: IMPRESION CAMPOS DEL MANTENIMIENTO                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN  8/2007 VIE A
       Colombia, Bucaramanga        INICIO:  7:22 PM   JUN  8/2007 VIE

OBJETIVOS:

1- Imprime los campos del archivo de mantenimiento

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrPnl011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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

       LOCAL cNombre := ''                  // Nombre del Personal
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
          FilePrn := 'Pnl'
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
                   'PERSONAL',;
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
       AADD(aTitPrn,'No.')

       AADD(aNroCol,6)
       AADD(aTitPrn,'CODIGO')

       AADD(aNroCol,40)
       AADD(aTitPrn,'NOMBRE')

       AADD(aNroCol,4)
       AADD(aTitPrn,'TIPO')

       AADD(aNroCol,6)
       AADD(aTitPrn,'RETIRO')

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

       SELECT PNL
       PNL->(DBGOTOP())
       DO WHILE .NOT. PNL->(EOF())

**********VISUALIZACION DE AVANCE
            nAvance := INT(( PNL->(RECNO()) / PNL->(RECCOUNT()) )*100)

            IF STR(nAvance,3) $ '25 50 75100'
               SET DEVICE TO SCREEN
               Termometro(nAvance)
               SET DEVICE TO PRINT
            ENDIF
**********FIN VISUALIZACION DE AVANCE

**********LOCALIZACION DEL PERSONAL
	    cNombre := cLocNomPer(PNL->nIdePerPnl,'PNL')
	    cNombre := SUBS(cNombre+SPACE(40),1,40)
**********FIN LOCALIZACION DEL PERSONAL

**********IMPRESION DEL REGISTRO
	    aRegPrn := {}
	    AADD(aRegPrn,STR(PNL->(RECNO()),4))
	    AADD(aRegPrn,PNL->cCodigoPnl)
	    AADD(aRegPrn,cNombre)
            AADD(aRegPrn,PNL->cTipPerPnl)
	    AADD(aRegPrn,IF(PNL->lRetiroPnl,'SI','NO'))

            lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
                    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
**********FIN IMPRESION DEL REGISTRO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT PNL
	    PNL->(DBSKIP())
	    IF PNL->(EOF())
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

/*************************************************************************
* TITULO..: IMPRESION CONTROL DE ASISTENCIA DEL PERSONAL                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: DIC 12/2007 MIE A
       Colombia, Bucaramanga        INICIO: 09:30 AM   DIC 12/2007 MIE

OBJETIVOS:

1- Imprime la relaci¢n para el control de asistencia.

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrPnl012(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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

       LOCAL nNroFil := 0                   // N£mero de la Fila
       LOCAL nNroCol := 0                   // N£mero de la Columna
       LOCAL nAvance := 0                   // Avance de registros
       LOCAL Getlist := {}                  // Variable del sistema
     *ÀVariables espec¡ficas

       LOCAL dFecIni := CTOD('00/00/00')    // Fecha Inicial
       LOCAL dFecFin := CTOD('00/00/00')    // Fecha Final
       LOCAL lSiPaso := .F.                 // Control de Flujo
       LOCAL lPrnAll := .T.                 // Imprimir Todos

       LOCAL cTipPerTpn := ''               // Tipo de personal
       LOCAL cNombreTpe := ''               // Nombre de la Persona
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LECTURA DEL TIPO DE PERSONAL
       lPrnAll := lPregunta('DESEA IMPRIMIR TODO EL PERSONAL? No Si')

       IF lPrnAll

	  cSavPan := SAVESCREEN(0,0,24,79)
	  SETCURSOR(1)
	  TitBuscar(20,@nNroFil,@nNroCol,'TIPO PERSONAL:')
	  cTipPerTpn := SPACE(02)
	  @ nNroFil,nNroCol GET cTipPerTpn PICT '99';
		  VALID lValTpe(ROW(),COL()-3,@cTipPerTpn);
		  WHEN {||HelpRead('FAVOR INGRESE EL TIPO DE PERSONAL')}
	  READ
	  RESTSCREEN(0,0,24,79,cSavPan)
	  SETCURSOR(0)
	  IF !lPregunta('DESEA CONTINUAR? Si No')
	     RETURN NIL
	  ENDIF

       ENDIF
*>>>>FIN LECTURA DEL TIPO DE PERSONAL

*>>>>LECTURA DEL INTERVALO DE FECHAS
       cSavPan := SAVESCREEN(0,0,24,79)
       SETCURSOR(1)

       dFecIni := CTOD('00/00/00')
       dFecFin := CTOD('00/00/00')

       TitBuscar(18,@nNroFil,@nNroCol,'FECHAS:','INTERVALO',14)

       @ nNroFil  ,nNroCol SAY 'INICIAL:' GET dFecIni PICT '@D';
	   WHEN {||HelpRead('FAVOR INGRESE LA FECHA INICIAL: MM/DD/AAAA')}
       @ nNroFil+1,nNroCol SAY 'FINAL  :' GET dFecFin PICT '@D';
	   WHEN {||HelpRead('FAVOR INGRESE LA FECHA FINAL: MM/DD/AAAA')}
       READ
       RESTSCREEN(0,0,24,79,cSavPan)

       IF EMPTY(dFecIni) .OR. EMPTY(dFecFin)
	  RETURN NIL
       ENDIF
       SETCURSOR(0)

       IF !lPregunta('DESEA CONTINUAR? Si No')
	  RETURN NIL
       ENDIF
*>>>>FIN LECTURA DEL INTERVALO DE FECHAS

*>>>>FILTRACION DEL ARCHIVO
       IF lPrnAll
	  SELECT NOV
	  SET FILTER TO NOV->cTipPerNov == cTipPerTpn
	  NOV->(DBGOTOP())

	  IF NOV->(EOF())
	     SET FILTER TO
	     RETURN NIL
	  ENDIF
       ENDIF
*>>>>FIN FILTRACION DEL ARCHIVO

*>>>>ACTIVACION DE LA IMPRESORA
       nRegPrn := PRN->(RECNO())
       nLenPrn := PCL('n17Stan')

       IF lPrnArc
          SET DEVICE TO PRINT
       ELSE
	  FilePrn := 'asiper'+TPE->cCodigoTpe
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
		   'CONTROL DE ASISTENCIA',;
		   ALLTRIM(TPE->cNombreTpe),;
		   'DEL '+cFecha(dFecIni)+' A '+cFecha(dFecFin)}

       aCabeza := {aCabPrn[1],aCabPrn[2],aCabPrn[3],aCabPrn[4],aCabPrn[5],;
                   nNroPag++,;
                   cTotPagina(nTotReg),lTamAnc}

       cCodIni := PCL({'DraftOn','Elite','CondenOn'})
       cCodFin := PCL({'NegraOf','DobGolOf'})
*>>>>FIN DEFINICION DEL ENCABEZADO

*>>>>ENCABEZADOS DE COLUMNA
       aNroCol := {}
       aTitPrn := {}

       AADD(aNroCol,6)
       AADD(aTitPrn,'CODIGO')

       AADD(aNroCol,4)
       AADD(aTitPrn,'TIPO')

       AADD(aNroCol,40)
       AADD(aTitPrn,'NOMBRES APELLIDOS')

       AADD(aNroCol,28)
       AADD(aTitPrn,'INGRESO')

       AADD(aNroCol,26)
       AADD(aTitPrn,'SALIDA')

       AADD(aNroCol,20)
       AADD(aTitPrn,'HORAS')

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

       SELECT PNL
       IF lPrnAll
	  PNL->(DBGOTOP())
       ENDIF
       DO WHILE .T.

**********ANALSISIS DE DECISION
	    IF lPrnAll
	       IF PNL->(EOF())
		  EXIT
	       ENDIF
	    ENDIF
**********FIN ANALSISIS DE DECISION

**********VISUALIZACION DE AVANCE
            nAvance := INT(( PNL->(RECNO()) / PNL->(RECCOUNT()) )*100)

            IF STR(nAvance,3) $ '25 50 75100'
               SET DEVICE TO SCREEN
               Termometro(nAvance)
               SET DEVICE TO PRINT
            ENDIF
**********FIN VISUALIZACION DE AVANCE

**********FILTRACION DEL ARCHIVO
	    SELECT NOV
	    IF lPrnAll
	       SET FILTER TO NOV->cCodPnlNov == PNL->cCodigoPnl .AND.;
			     NOV->cTipPerNov == PNL->cTipPerPnl .AND.;
			     dFecIni <= NOV->dFecIngNov         .AND.;
			     dFecFin >= NOV->dFecIngNov
	    ELSE
	       SET FILTER TO NOV->cCodPnlNov == PNL->cCodigoPnl .AND.;
			     dFecIni <= NOV->dFecIngNov         .AND.;
			     dFecFin >= NOV->dFecIngNov
	    ENDIF

	    NOV->(DBGOTOP())

	    IF NOV->(EOF())
	       SELECT PNL
	       PNL->(DBSKIP())
	       LOOP
	    ENDIF
**********FIN FILTRACION DEL ARCHIVO

**********RECORRIDO DE LAS NOVEDADES
	    cNombreTpe := SUBS(cLocNomPer(PNL->nIdePerPnl,'PNL')+SPACE(40),1,40)

            aRegPrn := {}
            AADD(aRegPrn,PNL->cCodigoPnl)
	    AADD(aRegPrn,PNL->cTipPerPnl)
	    AADD(aRegPrn,cNombreTpe)
	    lSiPaso := .F.

	    SELECT NOV
	    NOV->(DBGOTOP())
	    DO WHILE .NOT. NOV->(EOF())

*=============IMPRESION DEL REGISTRO
		IF !lSiPaso
		   AADD(aRegPrn,IF(dFecIngNov==NOV->dFecOutNov,'','*')+;
				cDia(DOW(NOV->dFecIngNov),3)+' '+;
				cFecha(NOV->dFecIngNov)+' '+;
				cHoraSys(NOV->cHorIngNov))

		   AADD(aRegPrn,cDia(DOW(NOV->dFecOutNov),3)+' '+;
				cFecha(NOV->dFecOutNov)+' '+;
				cHoraSys(NOV->cHorOutNov))

		   AADD(aRegPrn,cHoraSys(NOV->cHorIngNov)+' '+;
				cHoraSys(NOV->cHorOutNov))
		   lSiPaso := .T.
		ELSE
		   aRegPrn[1] := SPACE(01)
		   aRegPrn[2] := SPACE(01)
		   aRegPrn[3] := SPACE(01)

		   aRegPrn[4] := IF(dFecIngNov==NOV->dFecOutNov,'','*')+;
				 cDia(DOW(NOV->dFecIngNov),3)+' '+;
				 cFecha(NOV->dFecIngNov)+' '+;
				 cHoraSys(NOV->cHorIngNov)

		   aRegPrn[5] := cDia(DOW(NOV->dFecOutNov),3)+' '+;
				 cFecha(NOV->dFecOutNov)+' '+;
				 cHoraSys(NOV->cHorOutNov)

		   aRegPrn[6] := cHoraSys(NOV->cHorIngNov)+' '+;
				 cHoraSys(NOV->cHorOutNov)

		ENDIF

		lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
			aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
*=============FIN IMPRESION DEL REGISTRO

	       NOV->(DBSKIP())

	    ENDDO
**********FIN RECORRIDO DE LAS NOVEDADES

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT PNL
	    IF lPrnAll
	       PNL->(DBSKIP())
	       IF PNL->(EOF())
		  SET DEVICE TO SCREEN
		  Termometro(100)
		  SET DEVICE TO PRINT
	       ENDIF
	    ELSE
	       EXIT
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

/*************************************************************************
* TITULO..: REVISION DEL CONTROL DE ASISTENCIA                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 27/2009 JUE A
       Colombia, Bucaramanga        INICIO: 01:30 AM   AGO 27/2009 JUE

OBJETIVOS:

1- Revisa los registros del control de asistencia.

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrPnl013(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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

       LOCAL nNroFil := 0                   // N£mero de la Fila
       LOCAL nNroCol := 0                   // N£mero de la Columna
       LOCAL nAvance := 0                   // Avance de registros
       LOCAL Getlist := {}                  // Variable del sistema
     *ÀVariables espec¡ficas

       LOCAL dFecIni := CTOD('00/00/00')    // Fecha Inicial
       LOCAL dFecFin := CTOD('00/00/00')    // Fecha Final
       LOCAL lSiPaso := .F.                 // Control de Flujo
       LOCAL lPrnAll := .T.                 // Imprimir Todos

       LOCAL aUseDbf := {}                  // Vector para Apertura de Varias Dbfs
       LOCAL PathTem := ''                  // Path Temporal
       LOCAL FileTem := ''                  // Archivo Temporal
*>>>>FIN DECLARACION DE VARIABLES

       lPrnAll := lPregunta('DESEA IMPRIMIR TODO EL PERSONAL? No Si')

*>>>>LECTURA DEL TIPO DE PERSONAL

*>>>>AREAS DE TRABAJO
       PathTem := 'printer'
       FileTem := 'NOVEASIS.DBF'
       CreaDbfNov(lShared,nModCry,PathTem,FileTem)

       aUseDbf := {}
       AADD(aUseDbf,{.T.,PathTem+'\'+FileTem,'TEM',NIL,lShared,nModCry})
*>>>>FIN AREAS DE TRABAJO

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbfs(aUseDbf)
	  cError('ABRIENDO ARCHIVOS')
	  CloseDbf('TEM')
	  RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>RECORRIDO DE LOS REGISTROS
       cSavPan := SAVESCREEN(0,0,24,79)

       SELECT PNL
       IF lPrnAll
	  PNL->(DBGOTOP())
       ENDIF
       DO WHILE .T.

**********ANALSISIS DE DECISION
	    IF lPrnAll
	       IF PNL->(EOF())
		  EXIT
	       ENDIF
	    ENDIF
**********FIN ANALSISIS DE DECISION

**********FILTRACION DEL ARCHIVO
	    SELECT NOV
	    SET FILTER TO NOV->cCodPnlNov == PNL->cCodigoPnl
	    NOV->(DBGOTOP())

	    IF NOV->(EOF())
	       SELECT PNL
	       PNL->(DBSKIP())
	       LOOP
	    ENDIF
**********FIN FILTRACION DEL ARCHIVO

**********RECORRIDO DE LAS NOVEDADES
	    SELECT NOV
	    NOV->(DBGOTOP())

	    DO WHILE .NOT. NOV->(EOF())

*==============LINEA DE ESTADO
		 LineaEstados('CODIGO: '+PNL->cCodigoPnl+;
			      'ºNo. '+PNL->(STR(RECNO(),2))+'/'+;
			       PNL->(STR(RECCOUNT(),2))+;
			      'ºNovedad No. '+NOV->(STR(RECNO(),4))+'/'+;
			       NOV->(STR(RECCOUNT(),4)),cNomSis)
*==============FIN LINEA DE ESTADO

*==============GRABACION DE LA NOVEDAD DE ASISTENCIA
		  SaveNov(lShared,NOV->dFecIngNov,NOV->cHorIngNov)
		  SaveNov(lShared,NOV->dFecOutNov,NOV->cHorOutNov)
*==============FIN GRABACION DE LA NOVEDAD DE ASISTENCIA

	       NOV->(DBSKIP())

	    ENDDO
**********FIN RECORRIDO DE LAS NOVEDADES

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT PNL
	    IF lPrnAll
	       PNL->(DBSKIP())
	    ELSE
	       EXIT
	    ENDIF
**********FIN AVANCE DEL SIGUIENTE REGISTRO

       ENDDO
       RESTSCREEN(0,0,24,79,cSavPan)
       RETURN NIL
*>>>>FIN RECORRIDO DE LOS REGISTROS

/*************************************************************************
* TITULO..: GRABACION DE LA NOVEDAD                                      *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 27/2009 JUE A
       Colombia, Bucaramanga        INICIO: 04:10 PM   AGO 27/2009 JUE

OBJETIVOS:

1- Graba la novedad de asistencia.

2- Retorna NIL

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION SaveNov(lShared,dFecNov,cHorNov)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       dFecNov                              // Fecha de la novedad
       cHorNov                              // Hora de la novedad */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lInsReg := .F.                 // .T. Insertar Registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACIN DEL INGRESO
       SELECT TEM
       TEM->(DBGOTOP())

       lInsReg := .F.   // Personal Registrado
       LOCATE FOR TEM->nIdePerNov == NOV->nIdePerNov .AND.;
		  TEM->dFecIngNov == dFecNov .AND.;
		  TEM->dFecOutNov == CTOD('00/00/00')

       IF .NOT. FOUND()
	  lInsReg := .T.  // Persona no registrada no esta.
       ENDIF
*>>>>FIN LOCALIZACIN DEL INGRESO

*>>>>GRABACION DE LA NOVEDAD
       SELECT TEM
       IF TEM->(lRegLock(lShared,lInsReg))

	  IF lInsReg

	     REPL TEM->nIdeCodNov WITH NOV->(RECNO())

	     REPL TEM->cCodPnlNov WITH NOV->cCodPnlNov
	     REPL TEM->cTipPerNov WITH NOV->cTipPerNov
	     REPL TEM->nIdePerNov WITH NOV->nIdePerNov
	     REPL TEM->dFecIngNov WITH dFecNov
	     REPL TEM->cHorIngNov WITH cHorNov

	  ELSE

	     REPL TEM->dFecOutNov WITH dFecNov
	     REPL TEM->cHorOutNov WITH cHorNov

	  ENDIF

	  REPL TEM->cNomUsrNov WITH NOV->cNomUsrNov
	  REPL TEM->dFecUsrNov WITH NOV->dFecUsrNov
	  REPL TEM->cHorUsrNov WITH NOV->cHorUsrNov

	  TEM->(DBCOMMIT())
       ENDIF

       IF lShared
	  TEM->(DBUNLOCK())
       ENDIF
       RETURN NIL
*>>>>FIN GRABACION DE LA NOVEDAD
