/*************************************************************************
* TITULO..: MANTENIMIENTO DEL ARCHIVO                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 28/2005 JUE A
       Colombia, Bucaramanga        INICIO:  5:53 PM   JUL 28/2005 JUE

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenCaj(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		   cPatDat,cPatSys,cPatSis)

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
       cPatDat                              // Path datos del Sistema
       cPatSys                              // Path del Sistema
       cPatSis                              // Path del sistema */
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
       lModReg := lModReg
       lModReg := IF(lModReg .AND. CAJ->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfCaj(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
                             lModReg,lDelReg,lInsReg,lHaySql)

       SETKEY(K_F3,{||RetirosRca(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
				 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
				 aArchvo,lPrnArc,cOpcPrn,nCodPrn,lModReg,;
				 lDelReg,lInsReg,lHaySql,cPatDat,cPatSys,;
				 cPatSis)})

       SETKEY(K_F9,{||MenuOtrCaj(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
                                 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
                                 aArchvo,lPrnArc,cOpcPrn,nCodPrn,lModReg,;
                                 lDelReg,lInsReg,lHaySql,oBrowse)})

       CAJ->(CtrlBrw(lShared,oBrowse))

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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 28/2005 JUE A
       Colombia, Bucaramanga        INICIO:  5:53 PM   JUL 28/2005 JUE

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfCaj(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
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

       cTitSup := '<< CAJA >>'
       cTitInf := '<F3>Retiros'+;
                   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
                   IF(lDelReg,' <DEL>Borrar','')+;
                   IF(lInsReg,' <INS>Incluir','')

       IF lInsReg
          oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegCaj(lShared,cNomUsr)}}
       ELSE
          oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT CAJ
       oColumn := TBCOLUMNNEW('CAJA',{||CAJ->nCodigoCaj})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','CAJ'},;
			 {'FIELD','nCodigoCaj'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR EN CAJA',{||CAJ->nVlrTotCaj})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CAJ'},;
			 {'FIELD','nVlrTotCaj'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR BASE',{||CAJ->nVlrBasCaj})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CAJ'},;
			 {'FIELD','nVlrBasCaj'},{'PICTURE','999999999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('FECHA;INICIO',{||CAJ->dFecIniCaj})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CAJ'},;
			 {'FIELD','dFecIniCaj'},{'PICTURE','@!D'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('HORA;INICIO',{||CAJ->cHorIniCaj})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CAJ'},;
			 {'FIELD','cHorIniCaj'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CAJERO',{||CAJ->cCajeroCaj})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','CAJ'},;
			 {'FIELD','cCajeroCaj'},{'PICTURE','10'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||CAJ->cNomUsrCaj})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				    {||cFecha(CAJ->dFecUsrCaj)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				    {||cHoraSys(CAJ->cHorUsrCaj)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CODIGO',{||CAJ->nIdeCodCaj})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('No.',{||CAJ->(RECNO())})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL REGISTRO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO  1/2005 LUN A
       Colombia, Bucaramanga        INICIO: 11:14 AM   AGO  1/2005 LUN

OBJETIVOS:

1- Permite inclusi¢n,modificaci¢n y consulta del registro

2- Puede invocarse en la lectura a trav‚s de la clausula VALID

2- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lManRegCaj(lShared,cNomUsr,nTipMod,oBrowse,nCodigo,nNroOpc)

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

       LOCAL nVlrTotTca := 0                // Valor Total en Caja                                         
       LOCAL nVlrBasTca := 0                // Valor Base en Caja                                          
       LOCAL cCajeroTca := ''               // Nombre del Cajero
       LOCAL dFecIniTca := CTOD('00/00/00')   // Fecha de Inicio de Caja                                     
       LOCAL cHorIniTca := ''               // Hora de Inicio de la caja                                   

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
            cTxtTem := 'CAJA .INCLUIR. '+aMenus[nNroOpc]
            CAJ->(DBGOBOTTOM())
            CAJ->(DBSKIP())
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 2
            cTxtTem := 'CAJA .ACTUALIZAR. '+aMenus[nNroOpc]
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 3
            cTxtTem := 'CAJA. CONSUTA. '+aMenus[nNroOpc]
       ENDCASE
       nFilIni := nMarco(03,cTxtTem,22,'°')
*>>>>FIN MARCO DEL MANTENIMIENTO

*>>>>MANTENIMIENTO DEL REGISTRO
       SELECT CAJ
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
            IF lGrabar

               IF EMPTY(nCodigo)
                  nCodigo := CAJ->nCodigoCaj
               ENDIF

               nVlrTotTca := CAJ->nVlrTotCaj
               nVlrBasTca := CAJ->nVlrBasCaj
	       cCajeroTca := CAJ->cCajeroCaj
               dFecIniTca := CAJ->dFecIniCaj
               cHorIniTca := CAJ->cHorIniCaj
            ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil := nFilIni
               cTxtTem := 'CAJA No.        :'

               IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(nCodigo)
                  @ nNroFil,nNroCol SAY cTxtTem
                  @ nNroFil,nNroCol+LEN(cTxtTem)+1 SAY nCodigo COLOR('I')
               ELSE
                  @ nNroFil,nNroCol SAY cTxtTem;
                                    GET nCodigo PICT '@!';
                                    VALID !EMPTY(nCodigo) .AND.;
                                          !lValCodCaj(nCodigo)
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'VALOR BASE      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nVlrBasTca COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nVlrBasTca PICT '999999999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE EL VALOR BASE EN CAJA')}
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
       SELECT CAJ
       IF nTipMod # 3 .AND. lGrabar

          lInsReg := IF(nTipMod == 1,.T.,.F.)
          IF CAJ->(lRegLock(lShared,lInsReg))

             IF lInsReg
                REPL CAJ->nIdeCodCaj WITH CAJ->(RECNO())
		REPL CAJ->nCodigoCaj WITH nCodigo
		REPL CAJ->nVlrTotCaj WITH nVlrTotTca
		REPL CAJ->cCajeroCaj WITH cNomUsr
		REPL CAJ->dFecIniCaj WITH DATE()
		REPL CAJ->cHorIniCaj WITH TIME()
             ENDIF

	     REPL CAJ->nVlrBasCaj WITH nVlrBasTca

             REPL CAJ->cNomUsrCaj WITH cNomUsr
             REPL CAJ->dFecUsrCaj WITH DATE()
             REPL CAJ->cHorUsrCaj WITH TIME()
             CAJ->(DBCOMMIT())
          ENDIF

          IF lShared
             CAJ->(DBUNLOCK())
          ENDIF

       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SETCURSOR(nTipCur)
*>>>>FIN GRABACION DEL REGISTRO

*>>>>REFRESCAR EL BROWSE
       IF nTipMod == 2
          nNroReg := CAJ->(RECNO())
          CAJ->(DBGOTOP())
          oBrowse:GOTOP()
          CAJ->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ENDIF
       RETURN .T.
*>>>>FIN REFRESCAR EL BROWSE


/*************************************************************************
* TITULO..: VALIDACION DE EXISTENCIA DEL CODIGO                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 28/2005 JUE A
       Colombia, Bucaramanga        INICIO:  5:53 PM   JUL 28/2005 JUE

OBJETIVOS:

1- Debe estar en uso el archivo.

2- Realiza la validaci¢n de existencia del C¢digo.

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCodCaj(cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF cCodigo # 0
          IF lLocCodigo('nCodigoCaj','CAJ',cCodigo)
             cError('ESTE CODIGO YA EXISTE')
             lHayErr := .T.
          ENDIF
       ENDIF
       RETURN lHayErr
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: RETIROS DE CAJA                                              *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 01/2005 LUN A
       Colombia, Bucaramanga        INICIO: 09:00 PM   AGO 01/2005 LUN

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION RetirosRca(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		    cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		    cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		    cPatDat,cPatSys,cPatSis)

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
       cPatDat                              // Path datos del Sistema
       cPatSys                              // Path del Sistema
       cPatSis                              // Path del sistema */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "CAMPOS\ARC-PARK.PRG"       // Archivos del Sistema

       LOCAL GetList := {}                  // Variable del Sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>AREAS DE TRABAJO
       aArchvo := {}
       AADD(aArchvo,{cPatSis(cPatDat,cPatSys,cPatSis)+'\'+;
		     FileRca,NIL,'RCA'})
       AADD(aArchvo,{PathSis+'\'+FileRca,NIL,'RCA'})
*>>>>FIN AREAS DE TRABAJO

*>>>>MANTENIMIENTO DEL ARCHIVO
       lModReg := .F.
       lDelReg := .F.
       lInsReg := .T.
       lHaySql := .F.

       MantenRca(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
		 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
		 aArchvo,PAR->lPrnArcPak,PAR->cOpcPrnPak,;
		 PAR->nCodigoPrn,lModReg,lDelReg,lInsReg,;
		 lHaySql)

       CloseDbf('RCA')
       RETURN NIL
*>>>>FIN MANTENIMIENTO DEL ARCHIVO

/*************************************************************************
* TITULO..: MENU DE OTROS PARA EL ARCHIVO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO  1/2005 LUN A
       Colombia, Bucaramanga        INICIO: 11:22 AM   AGO  1/2005 LUN

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrCaj(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       AADD(aMenus,'1<MOVIMIENTOS CAJA>')
       AADD(aMenus,'2<CUADRAR LA CAJA >')
       AADD(aMenus,'3<CAMBIO DE CAJERO>')
       AADD(aMenus,'4<RETIROS DE CAJA >')

       aAyuda := {}
       AADD(aAyuda,'Imprime los Movimientos de la Caja')
       AADD(aAyuda,'Permite Cuadrar la Caja')
       AADD(aAyuda,'Permite el Cambio de Cajero')
       AADD(aAyuda,'Permite el retiro de dinero de la Caja')

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
            OtrCaj011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
                      oBrowse)
	   *Impresi¢n de los campos del Archivo

       CASE nNroOpc == 2
	    OtrCaj012(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		      oBrowse)
	   *Cuadrar la caja

       CASE nNroOpc == 3
	    OtrCaj013(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
                      oBrowse)
	   *Cambio de Cajero

       CASE nNroOpc == 4
	    OtrCaj014(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
                      oBrowse)
	   *Retiros de la Caja

       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE OPCION ESCOGIDA

/*************************************************************************
* TITULO..: CUADRAR LA CAJA                                              *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 12/2005 LUN A
       Colombia, Bucaramanga        INICIO: 03:20 AM   AGO 12/2005 LUN

OBJETIVOS:

1- Verifica el cuadre de la caja

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrCaj012(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       #INCLUDE "CAMPOS\ARC-PARK.PRG"       // Archivos del Sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DE VARIABLES
       LOCAL nRegPrn := 0                   // Registro de Impresi¢n
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

       LOCAL nTotPag := 0                   // Total en Caja
       LOCAL nTotRet := 0                   // Total Retiros
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DE DECISION
       IF lCajaOk()
	  cError('LA CAJA ESTA CUADRADA')
	  RETURN NIL
       ENDIF
       cError('LA CAJA ESTA DESCUADRADA')
       IF !lPregunta('DESEA IMPRIMIR EL DETALLE DEL DESCUADRE? Si No')
	  RETURN NIL
       ENDIF
*>>>>FIN ANALISIS DE DECISION

*>>>>ACTIVACION DE LA IMPRESORA
       IF lPrnArc
	  SET DEVICE TO PRINT
       ELSE
	  FilePrn := 'descua'
	  nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,cOpcPrn,.F.,.T.)
	  IF EMPTY(nOpcPrn)
	     RETURN NIL
	  ENDIF
       ENDIF
       SendCodes(PCL('Reset'))

       SendCodes(PCL({'Pica','CondenOn'}))
       SETPRC(0,0)
*>>>>FIN ACTIVACION DE LA IMPRESORA

*>>>>IMPRESION DEL ENCABEZADO
       @ PROW()+1,00 SAY cNomEmp
       IF !EMPTY(cNomSec)
	  @ PROW()+1,00 SAY cNomSec
       ENDIF
       @ PROW()+1,00 SAY ''
       @ PROW()+1,00 SAY 'RECIBOS CANCELADOS:'
*>>>>FIN IMPRESION DEL ENCABEZADO

*>>>>RECIBOS PAGADOS
       SELECT REG
       REG->(DBGOTOP())
       DO WHILE .NOT. REG->(EOF())

**********IMPRESION DE LA LINEA DE ESTADO
	    SET DEVICE TO SCREEN
	    LineaEstado('IMPRIMIENDO. REG: '+;
			STR(REG->(RECNO()),5)+'/'+;
			STR(REG->(RECCOUNT()),5),cNomSis)
	    SET DEVICE TO PRINT
**********FIN IMPRESION DE LA LINEA DE ESTADO

**********VEHICULOS EN EL PARQUEADERO
	    IF !EMPTY(REG->dFecOutReg)
	       IF (CAJ->dFecIniCaj == REG->dFecOutReg .AND.;
		  nHoraSeg(REG->cHorOutReg) >= nHoraSeg(CAJ->cHorIniCaj)) .OR.;
		  (REG->dFecOutReg > CAJ->dFecIniCaj)

		  @ PROW()+1,00 SAY 'RECIBO: '+STR(REG->nNroFacReg,9,0)+'.$'+;
				    TRANS(REG->nVlrTotReg,"####,###,###")
		  nTotPag += REG->nVlrTotReg

	       ENDIF

	    ENDIF
**********FIN VEHICULOS EN EL PARQUEADERO

	  REG->(DBSKIP())

       ENDDO
*>>>>FIN RECIBOS PAGADOS

*>>>>TOTAL RETIROS DE LA CAJA
       @ PROW()+1,00 SAY ''
       @ PROW()+1,00 SAY 'TOTAL RETIROS:'

       SELECT RCA
       RCA->(DBGOTOP())
       DO WHILE .NOT. RCA->(EOF())

**********IMPRESION DE LA LINEA DE ESTADO
	    SET DEVICE TO SCREEN
	    LineaEstado('IMPRIMIENDO. REG: '+;
			STR(RCA->(RECNO()),5)+'/'+;
			STR(RCA->(RECCOUNT()),5),cNomSis)
	    SET DEVICE TO PRINT
**********FIN IMPRESION DE LA LINEA DE ESTADO

**********ANALISIS DE LA CAJA
	    IF CAJ->nCodigoCaj # RCA->nCodigoCaj
	       RCA->(DBSKIP())
	       LOOP
	    ENDIF
**********FIN ANALISIS DE LA CAJA

**********ANALISIS DEL RETIRO
	    IF (CAJ->dFecIniCaj == RCA->dFecRetRca .AND.;
	       nHoraSeg(RCA->cHorRetRca) >= nHoraSeg(CAJ->cHorIniCaj)) .OR.;
	       (RCA->dFecRetRca > CAJ->dFecIniCaj)

	       @ PROW()+1,00 SAY 'FECHA '+cFecha(RCA->dFecRetRca)+':'+;
				 cHoraSys(RCA->cHorRetRca)+' $'+;
				 ALLTRIM(TRANS(RCA->nVlrRetRca,"####,###,###"))

	       nTotRet += RCA->nVlrRetRca

	    ENDIF
**********FIN ANALISIS DEL RETIRO

	  RCA->(DBSKIP())

       ENDDO
       RCA->(DBGOTOP())
*>>>>FIN TOTAL RETIROS DE LA CAJA

*>>>>TOTAL RECIBOS CANCELADOS
       @ PROW()+2,00 SAY '+TOTAL RECIBOS.$: '+;
			 ALLTRIM(TRANS(nTotPag,"####,###,###"))

       @ PROW()+1,00 SAY '-TOTAL RETIROS.$: '+;
			 ALLTRIM(TRANS(nTotRet,"####,###,###"))

       @ PROW()+1,00 SAY '=TOTAL EN CAJA.$: '+;
			 ALLTRIM(TRANS(CAJ->nVlrTotCaj,"####,###,###"))

       VerPrn(nOpcPrn,FilePrn,nHanXml)
       SET DEVICE TO SCREEN
       RETURN NIL
*>>>>FIN TOTAL RECIBOS CANCELADOS

/*************************************************************************
* TITULO..: CAMBIO DE CAJERO                                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 08/2005 LUN A
       Colombia, Bucaramanga        INICIO: 09:30 AM   AGO 08/2005 LUN

OBJETIVOS:

1- Permite el cambio de cajero

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrCaj013(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       #INCLUDE "CAMPOS\ARC-PARK.PRG"       // Archivos del Sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL nRegPrn := 0                   // Registro de Impresi¢n
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

       LOCAL nNroCol := 0                   // N£mero de la Columna
       LOCAL cNomCaj := ''                  // Nombre del Cajero
       LOCAL nTotCaj := 0                   // Total en Caja
       LOCAL lSiDeta := .F.                 // .T. Imprimir Detalle

       LOCAL lSiorNo := .F.                 // Control de Flujo
       LOCAL cFacUno := ''                  // Primera Factura
       LOCAL cUltFac := ''                  // Ultima Factura
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DE DECISION
       IF !lCajaOk()
	  cError('LA CAJA ESTA DESCUADRADA')
	  RETURN NIL
       ENDIF
*>>>>FIN ANALISIS DE DECISION

*>>>>VALIDACION DEL CAJERO
       lHayErr := .T.
       DO CASE
       CASE CAJ->cCajeroCaj # cNomUsr
	    cError(ALLTRIM(cNomUsr)+' NO ES EL CAJERO DE LA CAJA No.'+;
		   STR(CAJ->nCodigoCaj,2))

       OTHERWISE
	    lHayErr :=.F.
       ENDCASE
       IF lHayErr
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DEL CAJERO

*>>>>LECTURA DEL NOMBRE DEL CAJERO
       cNomCaj := cNomUsr(lShared,10,15,PathSis,FileAaa)

       lHayErr := .T.
       DO CASE
       CASE EMPTY(cNomCaj)

       CASE CAJ->cCajeroCaj == cNomCaj
	    cError(ALLTRIM(cNomUsr)+' ES EL CAJERO ACTUAL DE LA CAJA No.'+;
		   STR(CAJ->nCodigoCaj,2))

       OTHERWISE
	    lHayErr :=.F.
       ENDCASE
       IF lHayErr
	  RETURN NIL
       ENDIF

       IF !lPregunta(ALLTRIM(cNomCaj)+' ES EL NUEVO CAJERO? Si No')
	  RETURN NIL
       ENDIF

       lSiDeta := lPregunta('DESEA IMPRIMIR CON DETALLE? No Si')
*>>>>FIN LECTURA DEL NOMBRE DEL CAJERO

*>>>>ACTIVACION DE LA IMPRESORA
       IF lPrnArc
	  SET DEVICE TO PRINT
       ELSE
	  FilePrn := 'cambio'
	  nOpcPrn := nPrinter_On(cNomUsr,@FilePrn,cOpcPrn,.F.,.T.)
	  IF EMPTY(nOpcPrn)
	     RETURN NIL
	  ENDIF
       ENDIF
       SendCodes(PCL('Reset'))

       SendCodes(PCL({'Pica','CondenOn'}))
       SETPRC(0,0)
*>>>>FIN ACTIVACION DE LA IMPRESORA

*>>>>IMPRESION DEL ENCABEZADO
       @ PROW()+1,00 SAY cNomEmp
       IF !EMPTY(cNomSec)
	  @ PROW()+1,00 SAY cNomSec
       ENDIF
       @ PROW()+1,00 SAY 'CAMBIO DE CAJERO CAJA No. '+STR(CAJ->nCodigoCaj,2)
       @ PROW()+1,00 SAY 'VEHICULOS EN EL PARQUEADERO:'
       @ PROW()+1,00 SAY ''
*>>>>FIN IMPRESION DEL ENCABEZADO

*>>>>VEHICULOS EN EL PARQUEADERO
       SELECT REG
       REG->(DBGOTOP())
       DO WHILE .NOT. REG->(EOF())

**********VEHICULOS EN EL PARQUEADERO
	    IF EMPTY(REG->dFecOutReg)
	       @ PROW(),nNroCol SAY ALLTRIM(REG->cPlacaVeh)
	       nNroCol += LEN(ALLTRIM(REG->cPlacaVeh))+2
	       IF nNroCol > 30
		  nNroCol := 0
		  @ PROW()+1,nNroCol SAY ' '
	       ENDIF
	    ENDIF
**********FIN VEHICULOS EN EL PARQUEADERO

	  REG->(DBSKIP())

       ENDDO
*>>>>FIN VEHICULOS EN EL PARQUEADERO

*>>>>RECIBOS PAGADOS
       SELECT REG
       REG->(DBGOTOP())
       DO WHILE .NOT. REG->(EOF())

**********VEHICULOS EN EL PARQUEADERO
	    IF !EMPTY(REG->dFecOutReg)
	       IF (CAJ->dFecIniCaj == REG->dFecOutReg .AND.;
		  nHoraSeg(REG->cHorOutReg) >= nHoraSeg(CAJ->cHorIniCaj)) .OR.;
		  (REG->dFecOutReg > CAJ->dFecIniCaj)

		  cUltFac := ALLTRIM(STR(REG->nNroFacReg,9,0))
		  IF !lSiorNo
		     cFacUno := ALLTRIM(STR(REG->nNroFacReg,9,0))
		     lSiorNo := .T.
		  ENDIF

		  IF lSiDeta
		     @ PROW()+1,00 SAY 'RECIBO: '+cUltFac+' '+;
				       ALLTRIM(REG->cPlacaVeh)+' '+;
				       TRANS(REG->nVlrTotReg,"####,###,###")
		  ENDIF
		  nTotCaj += REG->nVlrTotReg

	       ENDIF

	    ENDIF
**********FIN VEHICULOS EN EL PARQUEADERO

	  REG->(DBSKIP())

       ENDDO
*>>>>FIN RECIBOS PAGADOS

*>>>>TOTAL EN CAJA
       IF !lSiDeta
	  @ PROW()+1,00 SAY 'RECIBOS: '+cFacUno+'-'+cUltFac
       ENDIF

       @ PROW()+1,00 SAY 'TOTAL RECIBOS.$: '+;
			 ALLTRIM(TRANS(nTotCaj,"####,###,###"))

       @ PROW()+1,00 SAY 'TOTAL EN CAJA.$: '+;
			 ALLTRIM(TRANS(CAJ->nVlrTotCaj,"####,###,###"))

       @ PROW()+2,00 SAY 'TOTAL BASE....$: '+;
			 ALLTRIM(TRANS(CAJ->nVlrBasCaj,"####,###,###"))
*>>>>FIN TOTAL EN CAJA

*>>>>ENTREGA DEL PARQUEADERO
       @ PROW()+2,00 SAY 'ENTREGA '+cNomUsr+': '+REPL('_',22)
       @ PROW()+1,00 SAY 'RECIBE  '+cNomCaj+': '+REPL('_',22)

       @ PROW()+2,00 SAY 'FECHA: '+cFecha(DATE(),3)+SPACE(02)+;
			 'HORA: '+cHoraSys(TIME())

       SET DEVICE TO SCREEN
*>>>>FIN ENTREGA DEL PARQUEADERO

*>>>>GRABACION DEL CAJERO
       SELECT CAJ
       IF CAJ->(lRegLock(lShared,.F.))

	  REPL CAJ->cCajeroCaj WITH cNomCaj

	  REPL CAJ->cNomUsrCaj WITH cNomUsr
	  REPL CAJ->dFecUsrCaj WITH DATE()
	  REPL CAJ->cHorUsrCaj WITH TIME()
	  CAJ->(DBCOMMIT())
       ENDIF

       IF lShared
	  CAJ->(DBUNLOCK())
       ENDIF
       VerPrn(nOpcPrn,FilePrn,nHanXml)

       CAJ->(DBGOTOP())
       oBrowse:GOTOP()
       oBrowse:FORCESTABLE()
       RETURN NIL
*>>>>FIN GRABACION DEL CAJERO

/*************************************************************************
* TITULO..: RETIROS DE LA CAJA                                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 16/2005 MAR A
       Colombia, Bucaramanga        INICIO: 06:45 AM   AGO 16/2005 MAR

OBJETIVOS:

1- Permite los retiros de dinero de la Caja

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrCaj014(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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
       #INCLUDE "CAMPOS\ARC-PARK.PRG"       // Archivos del Sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL nRegPrn := 0                   // Registro de Impresi¢n
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

       LOCAL       i := 0                   // Contador
       LOCAL nNroFil := 0                   // N£mero de la Fila
       LOCAL nNroCol := 0                   // N£mero de la Columna
       LOCAL cTxtTem := ''                  // Texto temporal
       LOCAL nRecIni := 0                   // Recibo Inicial
       LOCAL nRecFin := 0                   // Recibos Final
       LOCAL nRecVal := 0                   // Recibo Final a Validar
       LOCAL nTotCaj := 0                   // Total en Caja
       LOCAL nBasIva := 0                   // Base del Iva
       LOCAL nVlrIva := 0                   // Valor del Iva
       LOCAL cNomCaj := ''                  // Nombre del Cajero
       LOCAL lSiDeta := .F.                 // .T. Imprimir Detalle

       LOCAL dFecRetTrc := CTOD('00/00/00') // Fecha del Retiro
       LOCAL cHorRetTrc := ''               // Hora del Retiro

       LOCAL GetList := {}                  // Variable del sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DE DECISION
       cSavPan := SAVESCREEN(0,0,24,79)
       IF !lCajaOk()
	  cError('LA CAJA ESTA DESCUADRADA')
	  RESTSCREEN(0,0,24,79,cSavPan)
	  RETURN NIL
       ENDIF
*>>>>FIN ANALISIS DE DECISION

*>>>>LECTURA DEL NOMBRE DEL CAJERO
       cNomCaj := cNomUsr(lShared,10,15,PathSis,FileAaa)
       IF cNomUsr # cNomCaj
	  RESTSCREEN(0,0,24,79,cSavPan)
	  RETURN NIL
       ENDIF
*>>>>FIN LECTURA DEL NOMBRE DEL CAJERO

*>>>>VALIDACION DEL CAJERO
       lHayErr := .T.
       DO CASE
       CASE CAJ->cCajeroCaj # cNomUsr
	    cError(ALLTRIM(cNomUsr)+' NO ES EL CAJERO DE LA CAJA No.'+;
		   STR(CAJ->nCodigoCaj,2))

       OTHERWISE
	    lHayErr :=.F.
       ENDCASE
       IF lHayErr
	  RESTSCREEN(0,0,24,79,cSavPan)
	  SELECT CAJ
	  CAJ->(DBGOTOP())
	  oBrowse:GOTOP()
	  oBrowse:FORCESTABLE()
	  RETURN NIL
       ENDIF
*>>>>FIN VALIDACION DEL CAJERO

*>>>>LOCALIZACION DEL PRIMER RECIBO A RETIRAR
       SELECT REG
       REG->(DBGOTOP())

       LOCATE FOR REG->nCodigoCaj == CAJ->nCodigoCaj .AND.;
		  EMPTY(REG->dFecRetRca)

       IF .NOT. FOUND()
	  cError('NO EXISTEN VALORES DE RECIBOS POR RETIRAR DE LA CAJA '+;
		 'No. '+ALLTRIM(STR(CAJ->nCodigoCaj,2)))

	  RESTSCREEN(0,0,24,79,cSavPan)
	  SELECT CAJ
	  CAJ->(DBGOTOP())
	  oBrowse:GOTOP()
	  oBrowse:FORCESTABLE()
	  RETURN NIL
       ENDIF
*>>>>FIN LOCALIZACION DEL PRIMER RECIBO A RETIRAR

*>>>>LECTURA DEL INTERVALO DE RECIBOS
       nRecIni := REG->nNroFacReg

       REG->(DBGOBOTTOM())
       DO WHILE .NOT. BOF()

	  IF REG->nCodigoCaj == CAJ->nCodigoCaj .AND.;
	     REG->nNroFacReg # 0                .AND.;
	     EMPTY(REG->dFecRetRca)
	     nRecFin := REG->nNroFacReg
	     EXIT
	  ENDIF

	  REG->(DBSKIP(-1))

       ENDDO
       IF nRecFin < nRecIni

	  cError('EL REGISTRO FINAL No. '+ALLTRIM(STR(nRecFin,9))+' '+;
		 'NO PUEDE SER MENOR AL REGISTRO INICIAL No. '+;
		 ALLTRIM(STR(nRecIni,9)))

	  RESTSCREEN(0,0,24,79,cSavPan)
	  SELECT CAJ
	  CAJ->(DBGOTOP())
	  oBrowse:GOTOP()
	  oBrowse:FORCESTABLE()
	  RETURN NIL
       ENDIF
       nRecVal := nRecFin
       REG->(DBGOTOP())
*>>>>FIN LECTURA DEL INTERVALO DE RECIBOS

*>>>>RETIROS DE CAJA
       SET CURSOR ON

       cTxtTem := 'RECIBOS:'
       TitBuscar(15,@nNroFil,@nNroCol,cTxtTem,'RETIROS',14)

       @ nNroFil  ,nNroCol SAY 'DEL : '+STR(nRecIni,9)
       @ nNroFil+1,nNroCol SAY 'AL  :' GET nRecFin PICT '999999999';
				       VALID nRecFin >= nRecIni .AND.;
					     nRecFin <= nRecVal
       READ

       IF !lPregunta('DESEA RETIRAR LOS VALORES DE LOS RECIBOS '+;
		     'DEL '+ALLTRIM(STR(nRecIni,9))+' '+;
		     'AL '+ALLTRIM(STR(nRecFin,9))+'? Si No')

	  RESTSCREEN(0,0,24,79,cSavPan)
	  SELECT CAJ
	  CAJ->(DBGOTOP())
	  oBrowse:GOTOP()
	  oBrowse:FORCESTABLE()
	  RETURN NIL
       ENDIF

       lSiDeta := lPregunta('DESEA IMPRIMIR CON DETALLE? Si No')
*>>>>FIN RETIROS DE CAJA

*>>>>ACTIVACION DE LA IMPRESORA
       SET DEVICE TO PRINT
       SendCodes(PCL('Reset'))

       SendCodes(PCL({'Pica','CondenOn'}))
       SETPRC(0,0)
*>>>>FIN ACTIVACION DE LA IMPRESORA

*>>>>IMPRESION DEL ENCABEZADO
       dFecRetTrc := DATE()
       cHorRetTrc := TIME()

       @ PROW()+1,00 SAY cNomEmp
       IF !EMPTY(cNomSec)
	  @ PROW()+1,00 SAY cNomSec
       ENDIF
       @ PROW()+1,00 SAY 'RETIRO DE LA CAJA No. '+STR(CAJ->nCodigoCaj,2)
       @ PROW()+1,00 SAY 'FECHA: '+cFecha(dFecRetTrc,3)+SPACE(02)+;
			 'HORA: ' +cHorRetTrc

       IF lSiDeta
	  @ PROW()+1,00 SAY 'RECIBOS:'
       ENDIF
*>>>>FIN IMPRESION DEL ENCABEZADO

*>>>>RETIRO DE CAJA POR RECIBOS
       nTotCaj := 0
       FOR i := nRecIni TO nRecFin

*********LOCALIZACION DEL PRIMER RECIBO A RETIRAR
	   SELECT REG
	   REG->(DBGOTOP())

	   LOCATE FOR REG->nCodigoCaj == CAJ->nCodigoCaj .AND.;
		      REG->nNroFacReg == i               .AND.;
		      EMPTY(REG->dFecRetRca)

	   IF .NOT. FOUND()
	      LOOP
	   ENDIF
*********FIN LOCALIZACION DEL PRIMER RECIBO A RETIRAR

*********GRABACION DEL RETIRO
	   SELECT REG
	   IF REG->(lRegLock(lShared,.F.))

	      nTotCaj += REG->nVlrTotReg
	      nBasIva += REG->nBasIvaReg
	      nVlrIva += REG->nVlrIvaReg

	      REPL REG->dFecRetRca WITH dFecRetTrc
	      REPL REG->cHorRetRca WITH cHorRetTrc

	      REG->(DBCOMMIT())

	      IF lSiDeta
		 @ PROW()+1,00 SAY STR(REG->nNroFacReg,9,0)+' '+;
				   REG->cPlacaVeh+' $'+;
				   TRANS(REG->nVlrTotReg,"####,###,###")
	      ENDIF

	   ENDIF

	   IF lShared
	      REG->(DBUNLOCK())
	   ENDIF
*********FIN GRABACION DEL RETIRO

       ENDFOR
*>>>>FIN RETIRO DE CAJA POR RECIBOS

*>>>>TOTAL EN CAJA
       @ PROW()+1,00 SAY 'RETIRO...:$'+TRANS(nTotCaj,"####,###,###")
       @ PROW()+1,00 SAY 'BASE.....:$'+TRANS(nBasIva,"####,###,###")
       @ PROW()+1,00 SAY 'IVA......:$'+TRANS(nVlrIva,"####,###,###")

       @ PROW()+2,00 SAY 'RESUMEN:'
       @ PROW()+1,00 SAY 'TOTAL EN CAJA.$: '+;
			 ALLTRIM(TRANS(CAJ->nVlrTotCaj,"####,###,###"))

       @ PROW()+1,00 SAY '- ESTE RETIRO.$: '+;
			 ALLTRIM(TRANS(nTotCaj,"####,###,###"))

       @ PROW()+1,00 SAY 'SALDO EN CAJA.$: '+;
			 ALLTRIM(TRANS(CAJ->nVlrTotCaj-nTotCaj,"####,###,###"))
*>>>>FIN TOTAL EN CAJA

*>>>>GRABACION DEL RETIRO
       SELECT RCA
       IF RCA->(lRegLock(lShared,.T.))

	  REPL RCA->nCodigoCaj WITH CAJ->nCodigoCaj
	  REPL RCA->nVlrRetRca WITH nTotCaj
	  REPL RCA->dFecRetRca WITH dFecRetTrc
	  REPL RCA->cHorRetRca WITH cHorRetTrc
	  REPL RCA->cCajeroCaj WITH cNomUsr

	  REPL RCA->nIdeCodRca WITH RCA->(RECNO())
	  REPL RCA->cNomUsrRca WITH cNomUsr
	  REPL RCA->dFecUsrRca WITH dFecRetTrc
	  REPL RCA->cHorUsrRca WITH cHorRetTrc

	  RCA->(DBCOMMIT())
       ENDIF

       IF lShared
	  RCA->(DBUNLOCK())
       ENDIF
*>>>>FIN GRABACION DEL RETIRO

*>>>>GRABACION DEL CAJERO
       SELECT CAJ
       IF CAJ->(lRegLock(lShared,.F.))

	  REPL CAJ->nVlrTotCaj WITH CAJ->nVlrTotCaj-nTotCaj

	  REPL CAJ->cNomUsrCaj WITH cNomUsr
	  REPL CAJ->dFecUsrCaj WITH dFecRetTrc
	  REPL CAJ->cHorUsrCaj WITH cHorRetTrc
	  CAJ->(DBCOMMIT())
       ENDIF

       IF lShared
	  CAJ->(DBUNLOCK())
       ENDIF
*>>>>FIN GRABACION DEL CAJERO

*>>>>ENTREGA DEL PARQUEADERO
       @ PROW()+2,00 SAY 'CAJERO '+cNomUsr
       @ PROW()+1,00 SAY 'QUIEN RETIRA: '+REPL('_',30)
       @ PROW()+1,00 SAY ''

       SET DEVICE TO SCREEN
       RESTSCREEN(0,0,24,79,cSavPan)

       SELECT CAJ
       CAJ->(DBGOTOP())
       oBrowse:GOTOP()
       oBrowse:FORCESTABLE()
       RETURN NIL
*>>>>FIN ENTREGA DEL PARQUEADERO

/*************************************************************************
* TITULO..: CUADRAR LA CAJA                                              *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 12/2005 LUN A
       Colombia, Bucaramanga        INICIO: 09:30 AM   AGO 12/2005 LUN

OBJETIVOS:

1- Permite verificar el cuadre de la caja

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lCajaOk()

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .T.                 // .T. Hay Error
       LOCAL nTotPag := 0                   // Total pagos
       LOCAL nTotRet := 0
*>>>>FIN DECLARACION DE VARIABLES

*>>>>RECIBOS PAGADOS
       SELECT REG
       REG->(DBGOTOP())
       DO WHILE .NOT. REG->(EOF())

**********ANALISIS DE LA CAJA
	    IF CAJ->nCodigoCaj # REG->nCodigoCaj
	       REG->(DBSKIP())
	       LOOP
	    ENDIF
**********FIN ANALISIS DE LA CAJA

**********VEHICULOS EN EL PARQUEADERO
	    IF !EMPTY(REG->dFecOutReg)
	       IF (CAJ->dFecIniCaj == REG->dFecOutReg .AND.;
		  nHoraSeg(REG->cHorOutReg) >= nHoraSeg(CAJ->cHorIniCaj)) .OR.;
		  (REG->dFecOutReg > CAJ->dFecIniCaj)

		  nTotPag += REG->nVlrTotReg

	       ENDIF

	    ENDIF
**********FIN VEHICULOS EN EL PARQUEADERO

	  REG->(DBSKIP())

       ENDDO
       REG->(DBGOTOP())
*>>>>FIN RECIBOS PAGADOS

*>>>>TOTAL RETIROS DE LA CAJA
       SELECT RCA
       RCA->(DBGOTOP())
       DO WHILE .NOT. RCA->(EOF())

**********ANALISIS DE LA CAJA
	    IF CAJ->nCodigoCaj # RCA->nCodigoCaj
	       RCA->(DBSKIP())
	       LOOP
	    ENDIF
**********FIN ANALISIS DE LA CAJA

**********ANALISIS DEL RETIRO
	    IF (CAJ->dFecIniCaj == RCA->dFecRetRca .AND.;
	       nHoraSeg(RCA->cHorRetRca) >= nHoraSeg(CAJ->cHorIniCaj)) .OR.;
	       (RCA->dFecRetRca > CAJ->dFecIniCaj)

	       nTotRet += RCA->nVlrRetRca

	    ENDIF
**********FIN ANALISIS DEL RETIRO

	  RCA->(DBSKIP())

       ENDDO
       RCA->(DBGOTOP())
*>>>>FIN TOTAL RETIROS DE LA CAJA

*>>>>VERIFICAR LA CAJA
       IF CAJ->nVlrTotCaj+nTotRet == nTotPag
	  lHayErr := .F.
       ENDIF
       RETURN !lHayErr
*>>>>FIN VERIFICAR LA CAJA