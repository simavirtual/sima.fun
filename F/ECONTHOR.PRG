/*************************************************************************
* TITULO..: MANTENIMIENTO DEL ARCHIVO                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 23/2007 MIE A
       Colombia, Bucaramanga        INICIO:  8:54 AM   MAY 23/2007 MIE

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenHor(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		   cPatCon,cPatSis,cMaeAlu,cMaeAct,nFilInf,nColInf)

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
       cPatCon                              // Path de la Contabilidad
       cPatSis                              // Path del sistema
       cMaeAlu                              // Maestros habilitados
       cMaeAct                              // Maestro Activo
       nFilInf                              // Fila Inferior del SubMen£
       nColInf                              // Columna Inferior del SubMen£ */
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

       LOCAL cCodGru := ''                  // C¢digo del Grupo
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
       lModReg := IF(lModReg .AND. HOR->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>LECTURA DEL GRUPO
       cCodGru := ''
       IF lPregunta('DESEA EL HORARIO POR CURSO? Si No')
	  cSavPan := SAVESCREEN(0,0,24,79)
	  cCodGru := cSpaces('GRU','cCodigoGru')
	  IF !lLeeCodGru(nFilInf+6,nColInf,@cCodGru,cMaeAct)
	     CloseAll()
	     RETURN NIL
	  ENDIF
	  RESTSCREEN(0,0,24,79,cSavPan)
       ENDIF
*>>>>FIN LECTURA DEL GRUPO

*>>>>ANALISIS DE DECISION
       IF !EMPTY(cCodGru) .AND.;
	  !lPregunta('ESCOGIO EL HORARIO DE '+cCodGru+'. '+;
		     'DESEA CONTINUAR? Si No')
	  CloseAll()
	  RETURN NIL
       ENDIF
*>>>>FIN ANALISIS DE DECISION

*>>>>FILTRACION DEL ARCHIVO
       IF !EMPTY(cCodGru)
	  SELECT HOR
	  SET FILTER TO HOR->cCodGruHor == cCodGru
	  HOR->(DBGOTOP())
	  IF HOR->(EOF())
	     cError('NO SE HA CREADO EL HORARIO DE '+cCodGru)
	     CloseAll()
	     RETURN NIL
	  ENDIF
       ENDIF
*>>>>FIN FILTRACION DEL ARCHIVO

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfHor(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
                             lModReg,lDelReg,lInsReg,lHaySql)

       SETKEY(K_F2,{||lManRegHor(lShared,cNomUsr,3,oBrowse)})
     *ÀConsulta

       IF lModReg
          SETKEY(K_F4,{||lManRegHor(lShared,cNomUsr,2,oBrowse,;
                                    HOR->nDiaSemHor)})
       ENDIF
     *ÀActualizar

       SETKEY(K_F5,{||BuscarHor(oBrowse)})

       SETKEY(K_F9,{||MenuOtrHor(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
                                 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
                                 aArchvo,lPrnArc,cOpcPrn,nCodPrn,lModReg,;
				 lDelReg,lInsReg,lHaySql,oBrowse,;
				 cPatCon,cPatSis,cMaeAlu,cMaeAct,nFilInf,;
				 nColInf,cCodGru)})

       HOR->(CtrlBrw(lShared,oBrowse))

       SETKEY(K_F2,NIL)
       SETKEY(K_F4,NIL)
       SETKEY(K_F5,NIL)
       SETKEY(K_F9,NIL)

       SELECT HOR
       SET FILTER TO
       CloseAll()
       RETURN NIL
*>>>>FIN MANTENIMIENTO DEL ARCHIVO

/*************************************************************************
* TITULO..: DEFINICION DEL OBJETO BROWSE                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 23/2007 MIE A
       Colombia, Bucaramanga        INICIO:  8:54 AM   MAY 23/2007 MIE

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfHor(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
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

       cTitSup := '<< HORARIO DE CLASE >>'
       cTitInf := '<F2>Consultar <F5>Buscar'+;
                   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
                   IF(lDelReg,' <DEL>Borrar','')+;
                   IF(lInsReg,' <INS>Incluir','')

       IF lInsReg
          oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegHor(lShared,cNomUsr)}}
       ELSE
          oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT HOR
       oColumn := TBCOLUMNNEW('DIA DE LA;SEMANA',{||HOR->nDiaSemHor})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','HOR'},;
			 {'FIELD','nDiaSemHor'},{'PICTURE','9'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('HORA',{||HOR->cCodHraHor})
       oColumn:Cargo := {{'MODI',.T.},{'ALIAS','HOR'},;
			 {'FIELD','cCodHraHor'},{'PICTURE','XX'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('GRUPO',{||HOR->cCodGruHor})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','HOR'},;
			 {'FIELD','cCodGruHor'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MATERIA',{||HOR->cCodMatHor})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','HOR'},;
			 {'FIELD','cCodMatHor'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MATERIA',{||SUBS(LTRIM(cSekNomMat(HOR->cCodMatHor,'HOR')+SPACE(30)),1,30)})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','HOR'},;
			 {'FIELD','cCodMatHor'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('AULA',{||HOR->cCodAulHor})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','HOR'},;
			 {'FIELD','cCodAulHor'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('PROFESOR',{||HOR->cCodProHor})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','HOR'},;
			 {'FIELD','cCodProHor'},{'PICTURE','999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('PROFESOR',{||SUBS(cSekNomPro(HOR->cCodProHor,'HOR'),1,30)})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','HOR'},;
			 {'FIELD','cCodMatHor'},{'PICTURE','9999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||HOR->cNomUsrHor})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				    {||cFecha(HOR->dFecUsrHor)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				    {||cHoraSys(HOR->cHorUsrHor)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CODIGO',{||HOR->nIdeCodHor})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('No.',{||HOR->(RECNO())})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL REGISTRO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 23/2007 MIE A
       Colombia, Bucaramanga        INICIO:  8:54 AM   MAY 23/2007 MIE

OBJETIVOS:

1- Permite inclusi¢n,modificaci¢n y consulta del registro

2- Puede invocarse en la lectura a trav‚s de la clausula VALID

2- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lManRegHor(lShared,cNomUsr,nTipMod,oBrowse,nDiaSem,nNroOpc)

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

       LOCAL cCodHraTho := ''               // C¢digo de la hora                                           
       LOCAL cCodGruTho := ''               // C¢digo del Grupo                                            
       LOCAL cCodMatTho := ''               // C¢digo de la Materia                                        
       LOCAL cCodAulTho := ''               // C¢digo del Aula o Salon
       LOCAL cCodProTho := ''               // C¢digo del Profesor

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
            cTxtTem := 'HORARIO DE CLASE .INCLUIR. '+aMenus[nNroOpc]
            HOR->(DBGOBOTTOM())
            HOR->(DBSKIP())
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 2
            cTxtTem := 'HORARIO DE CLASE .ACTUALIZAR. '+aMenus[nNroOpc]
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 3
            cTxtTem := 'HORARIO DE CLASE. CONSUTA. '+aMenus[nNroOpc]
       ENDCASE
       nFilIni := nMarco(03,cTxtTem,22,'°')
*>>>>FIN MARCO DEL MANTENIMIENTO

*>>>>MANTENIMIENTO DEL REGISTRO
       SELECT HOR
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
            IF lGrabar

               IF EMPTY(nDiaSem)
                  nDiaSem := HOR->nDiaSemHor
               ENDIF

               cCodHraTho := HOR->cCodHraHor
               cCodGruTho := HOR->cCodGruHor
               cCodMatTho := HOR->cCodMatHor
	       cCodAulTho := HOR->cCodAulHor
	       cCodProTho := HOR->cCodProHor
            ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil := nFilIni
               cTxtTem := 'DIA DE LA SEMANA :'

               IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(nDiaSem)
                  @ nNroFil,nNroCol SAY cTxtTem
                  @ nNroFil,nNroCol+LEN(cTxtTem)+1 SAY nDiaSem COLOR('I')
	       ELSE
                  @ nNroFil,nNroCol SAY cTxtTem;
				    GET nDiaSem PICT '9';
				    VALID lValDiaHor(ROW(),1,@nDiaSem) .AND.;
					  !EMPTY(nDiaSem);
				    WHEN {||HelpRead('FAVOR INGRESE EL DIA DE LA SEMANA')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'HORA             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodHraTho COLOR('I')
               ELSE
		  @ nNroFil,nColTem SAY cTxtTem;
				    GET cCodHraTho PICT 'XX';
				    VALID lValCodHra(ROW(),COL()-1,@cCodHraTho);
				    WHEN {||HelpRead('FAVOR INGRESE LA HORA DEL HORARIO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'GRUPO            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodGruTho COLOR('I')
               ELSE
		  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCodGruTho PICT '9999';
				    VALID lValGrupo(ROW(),COL()-4,@cCodGruTho);
				    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DEL GRUPO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'MATERIA          :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodMatTho COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
				    GET cCodMatTho PICT '9999';
				    VALID lValMateria(ROW(),COL()-4,@cCodMatTho) .AND.;
					  !EMPTY(cCodMatTho);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DE LA MATERIA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'AULA             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodAulTho COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
				    GET cCodAulTho PICT 'XXXX';
				    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DEL AULA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

/*
**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PROFESOR         :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodProTho COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cCodProTho PICT '999999';
                                    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DEL PROFESOR')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO
*/

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
       SELECT HOR
       IF nTipMod # 3 .AND. lGrabar

          lInsReg := IF(nTipMod == 1,.T.,.F.)
          IF HOR->(lRegLock(lShared,lInsReg))

             IF lInsReg
                REPL HOR->nIdeCodHor WITH HOR->(RECNO())
                REPL HOR->nDiaSemHor WITH nDiaSem
             ENDIF

             REPL HOR->cCodHraHor WITH cCodHraTho
             REPL HOR->cCodGruHor WITH cCodGruTho
             REPL HOR->cCodMatHor WITH cCodMatTho
	     REPL HOR->cCodAulHor WITH cCodAulTho
*	     REPL HOR->cCodProHor WITH cCodProTho

             REPL HOR->cNomUsrHor WITH cNomUsr
             REPL HOR->dFecUsrHor WITH DATE()
             REPL HOR->cHorUsrHor WITH TIME()
             HOR->(DBCOMMIT())
          ENDIF

          IF lShared
             HOR->(DBUNLOCK())
          ENDIF

       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SETCURSOR(nTipCur)
*>>>>FIN GRABACION DEL REGISTRO

*>>>>REFRESCAR EL BROWSE
       IF nTipMod == 2
          nNroReg := HOR->(RECNO())
          HOR->(DBGOTOP())
          oBrowse:GOTOP()
          HOR->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ENDIF
       RETURN .T.
*>>>>FIN REFRESCAR EL BROWSE

/*************************************************************************
* TITULO..: VALIDACION DE EXISTENCIA DEL CODIGO                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 15/2007 MAR A
       Colombia, Bucaramanga        INICIO:  4:22 PM   MAY 15/2007 MAR

OBJETIVOS:

1- Debe estar en uso el archivo.

2- Realiza la validaci¢n de existencia del C¢digo.

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValCodHor(cCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CODIGO
       IF lLocCodigo('nDiaSemHor','HOR',cCodigo)
	  cError('ESTE CODIGO YA EXISTE')
	  lHayErr := .T.
       ENDIF
       RETURN lHayErr
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: VALIDACION DEL CODIGO                                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 15/2007 MAR A
       Colombia, Bucaramanga        INICIO:  4:22 PM   MAY 15/2007 MAR

OBJETIVOS:

1- Debe estar en uso el archivo

2- Realiza la validaci¢n del c¢digo

3- Retorna .T. si hay problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValDiaHor(nNroFil,nNroCol,nCodigo)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // Fila de lectura
       nNroCol                              // Columna de lectura
       nCodigo                              // C¢digo a Validar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>VALIDACION DEL CODIGO
       nCodigo := nSelDia(nNroFil,nNroCol,'DIA')
       RETURN .T.
*>>>>FIN VALIDACION DEL CODIGO

/*************************************************************************
* TITULO..: MENU DE OTROS PARA EL ARCHIVO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 23/2007 MIE A
       Colombia, Bucaramanga        INICIO:  8:54 AM   MAY 23/2007 MIE

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrHor(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                    cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                    cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		    oBrowse,cPatCon,cPatSis,cMaeAlu,cMaeAct,nFilInf,;
		    nColInf,cCodGru)

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
       oBrowse                              // Browse del Archivo
       cPatCon                              // Path de la Contabilidad
       cPatSis                              // Path del sistema
       cMaeAlu                              // Maestros habilitados
       cMaeAct                              // Maestro Activo
       nFilInf                              // Fila Inferior del SubMen£
       nColInf                              // Columna Inferior del SubMen£
       cCodGru                              // C¢digo del Grupo */
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
       AADD(aMenus,'1<HORARIO DE CLASE  >')
       IF HOR->(RECCOUNT()) == 0
	  AADD(aMenus,'2<CREAR EL HORARIO  >')
       ELSE
	  AADD(aMenus,'2<ORDENAR EL HORARIO>')
       ENDIF
       AADD(aMenus,'3<ASIGNAR PROFESORES>')

       aAyuda := {}
       AADD(aAyuda,'Imprime los Detalles del Archivo')
       IF HOR->(RECCOUNT()) == 0
	  AADD(aAyuda,'Crea el horario de acuerdo a la intensidad horaria')
       ELSE
	  AADD(aAyuda,'Permite ordenar el Horario')
       ENDIF
       AADD(aAyuda,'Grabar los profesores que dictan las materias')

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
            OtrHor011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
                      oBrowse)
	   *Impresi¢n de los campos del Archivo

       CASE nNroOpc == 2 .AND. HOR->(RECCOUNT()) == 0
	    CreaHorGru(lShared,nModCry,cNomSis,cAnoUsr,;
		       cPatCon,cPatSis,cMaeAlu,cMaeAct)
	  *ÀCreacion del horario

       CASE nNroOpc == 2 .AND. HOR->(RECCOUNT()) # 0
	    OrdenarHor(lShared,nModCry,aArchvo,oBrowse,cCodGru)
	  *ÀOrdenar el horario

       CASE nNroOpc == 3
	    CreaHorPro(lShared,nModCry,cNomSis,cAnoUsr,;
		       cPatCon,cPatSis,cMaeAlu,cMaeAct,;
		       oBrowse,cCodGru)
	  *ÀAsignar profesores

       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE OPCION ESCOGIDA

/*************************************************************************
* TITULO..: IMPRESION CAMPOS DEL MANTENIMIENTO                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 23/2007 MIE A
       Colombia, Bucaramanga        INICIO:  7:48 PM   MAY 23/2007 MIE

OBJETIVOS:

1- Imprime los campos del archivo de mantenimiento

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrHor011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
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

       LOCAL cDiaSem := 0                   // D¡a de la Semana
       LOCAL Getlist := {}                  // Variable del sistema
     *ÀVariables espec¡ficas

       LOCAL cNombreTma := ''               // Nombre de la materia
       LOCAL cNombreTpr := ''               // Nombre del profesor
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ACTIVACION DE LA IMPRESORA
       nRegPrn := PRN->(RECNO())
       nLenPrn := PCL('n17Stan')

       IF lPrnArc
          SET DEVICE TO PRINT
       ELSE
          FilePrn := 'Hor'
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
                   'HORARIO DE CLASE',;
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

       AADD(aNroCol,10)
       AADD(aTitPrn,'DIA')

       AADD(aNroCol,4)
       AADD(aTitPrn,'HORA')

       AADD(aNroCol,6)
       AADD(aTitPrn,'GRUPO')

       AADD(aNroCol,8)
       AADD(aTitPrn,'MATERIA')

       AADD(aNroCol,40)
       AADD(aTitPrn,'MATERIA')

       AADD(aNroCol,8)
       AADD(aTitPrn,'PROFESOR')

       AADD(aNroCol,40)
       AADD(aTitPrn,'PROFESOR')

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

       SELECT HOR
       HOR->(DBGOTOP())
       DO WHILE .NOT. HOR->(EOF())

**********VISUALIZACION DE AVANCE
            nAvance := INT(( HOR->(RECNO()) / HOR->(RECCOUNT()) )*100)

            IF STR(nAvance,3) $ '25 50 75100'
               SET DEVICE TO SCREEN
               Termometro(nAvance)
               SET DEVICE TO PRINT
            ENDIF
**********FIN VISUALIZACION DE AVANCE

**********DIA DE LA SEMANA
	   cDiaSem := SPACE(01)
	   IF HOR->nDiaSemHor # 0
	      cDiaSem := cDia(HOR->nDiaSemHor,9)
	   ENDIF
**********FIN DIA DE LA SEMANA

**********LOCALIZACION DE LA MATERIA
	    cNombreTma := SPACE(01)
	    IF lLocCodigo('cCodigoMat','MAT',HOR->cCodMatHor)
	       cNombreTma := SUBS(MAT->cNombreMat+SPACE(40),1,40)
	    ENDIF
**********FIN LOCALIZACION DE LA MATERIA

**********LOCALIZACION DEL PROFESOR
	    cNombreTpr := SPACE(01)
	    IF lLocCodigo('cCodigoPro','PRO',HOR->cCodProHor)
	       cNombreTpr := ALLTRIM(PRO->cNombrePro)+' '+;
			     ALLTRIM(PRO->cApelliPro)
	       cNombreTpr := SUBS(cNombreTpr+SPACE(40),1,40)
	    ENDIF
**********FIN LOCALIZACION DEL PROFESOR

**********IMPRESION DEL REGISTRO
            aRegPrn := {}
	    AADD(aRegPrn,cDiaSem)
            AADD(aRegPrn,HOR->cCodHraHor)
            AADD(aRegPrn,HOR->cCodGruHor)
            AADD(aRegPrn,HOR->cCodMatHor)
	    AADD(aRegPrn,cNombreTma)
	    AADD(aRegPrn,HOR->cCodProHor)
	    AADD(aRegPrn,cNombreTpr)

            lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
                    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
**********FIN IMPRESION DEL REGISTRO

**********AVANCE DEL SIGUIENTE REGISTRO
	    SELECT HOR
	    HOR->(DBSKIP())
	    IF HOR->(EOF())
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
* TITULO..: CREAR EL HORARIO                                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 23/2007 MIE A
       Colombia, Bucaramanga        INICIO: 10:00 AM   MAY 23/2007 MIE

OBJETIVOS:

1- Crea el horario de acuerdo a la intensidad horaria.

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaHorGru(lShared,nModCry,cNomSis,cAnoUsr,cPatCon,cPatSis,;
		    cMaeAlu,cMaeAct)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       cNomSis                              // Nombre del Sistema
       cAnoUsr                              // A¤o del Usuario
       cPatCon                              // Path de la Contabilidad
       cPatSis                              // Path del sistema
       cMaeAlu                              // Maestros habilitados
       cMaeAct                              // Maestro Activo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema

       LOCAL     i,k := 0                   // Contador
       LOCAL nIntHor := 0                   // Intensidad horaria
       LOCAL cMaeAnt := ''                  // Maestro anterior
       LOCAL FileNiv := 'NIVELS'            // Archivo de niveles
       LOCAL FileGru := 'GRU'               // Archivo del grupo
       LOCAL FilePla := ''                  // Archivo del Plan acad‚mico
       LOCAL ExtFile := '.DAT'              // Extension para las bases
*>>>>FIN DECLARACION DE VARIABLES

*>>>>RECORRIDO POR NIVELES
       cMaeAnt := cMaeAct
       FOR k := 1 TO LEN(cMaeAlu)/3

	   cMaeAct := SUBS(cMaeAlu,k*3-2,3)

**********SELECION DE LAS AREAS DE TRABAJO
	    IF !lUseDbf(.T.,cPatCon+'\'+cPatSis+'\'+cMaeAct+'\'+;
			FileNiv+cAnoSis+ExtFile,'NIV',NIL,lShared) .OR.;
	       !lUseDbf(.T.,cPatCon+'\'+cPatSis+'\'+cMaeAct+'\'+;
			FileGru+cMaeAct+cAnoSis+ExtFile,'GRU',NIL,lShared)

	       cError('ABRIENDO ARCHIVOS')
	       RETURN NIL
	    ENDIF
**********FIN SELECION DE LAS AREAS DE TRABAJO

**********RECORRIDO POR GRUPOS
	    SELECT GRU
	    GRU->(DBGOTOP())
	    DO WHILE .NOT. GRU->(EOF())

*==============LINEA DE ESTADO
		 LineaEstado('NIVEL:'+cMaeAct+;
			     'ºCREANDO EL HORARIO DE CLASE DE '+;
			     GRU->cCodigoGru,cNomSis)
*==============FIN LINEA DE ESTADO

*==============SELECION DE LAS AREAS DE TRABAJO
		 FilePla := cFilePlan(cAnoUsr,GRU->cCodigoGru)
		 IF !lUseDbf(.T.,cPatCon+'\'+cPatSis+'\'+cMaeAct+'\'+;
			     FilePla,'PLA',NIL,lShared)

		    SET DEVICE TO SCREEN
		    cError('NO EXISTE PLAN ACADEMICO DEL CURSO '+GRU->cCodigoGru)
		    CloseDbf('PLA')
		    RETURN NIL
		 ENDIF
*==============FIN SELECION DE LAS AREAS DE TRABAJO

*==============RECORRIDO POR PLAN ACADEMICO
		 SELECT PLA
		 PLA->(DBGOTOP())
		 DO WHILE .NOT. PLA->(EOF())

*-------------------VALIDACION DE LA MATERIA
		      IF PLA->cTipArePla == 'P'
			 PLA->(DBSKIP())
			 LOOP
		      ENDIF
*-------------------FIN VALIDACION DE LA MATERIA

*-------------------VALIDACION DE LA INTENSIDAD HORARIA
		      nIntHor := 0
		      IF VALTYPE(ALLTRIM(PLA->cIntHorPla)) == 'N'
			 nIntHor := VAL(ALLTRIM(PLA->cIntHorPla))
		      ENDIF
*-------------------FIN VALIDACION DE LA INTENSIDAD HORARIA

*-------------------GRABACION DE LAS HORAS SEMANALES DE LA MATERIA
		      nIntHor := VAL(ALLTRIM(PLA->cIntHorPla))
		      FOR i := 1 TO nIntHor

			  LineaEstado('NIVEL:'+cMaeAct+;
				      'ºGRUPO: '+GRU->cCodigoGru+;
				      'ºMATERIA:'+PLA->cCodigoMat+;
				      'ºHORA No.'+ALLTRIM(STR(nIntHor,2)),cNomSis)

			  IF HOR->(lRegLock(lShared,.T.))

			     REPL HOR->nIdeCodHor WITH HOR->(RECNO())

			     REPL HOR->cCodGruHor WITH GRU->cCodigoGru
			     REPL HOR->cCodMatHor WITH PLA->cCodigoMat

			     REPL HOR->cNomUsrHor WITH 'system'
			     REPL HOR->dFecUsrHor WITH DATE()
			     REPL HOR->cHorUsrHor WITH TIME()
			     HOR->(DBCOMMIT())

			  ENDIF

			  IF lShared
			     HOR->(DBUNLOCK())
			  ENDIF

		      ENDFOR
*-------------------FIN GRABACION DE LAS HORAS SEMANALES DE LA MATERIA

		    PLA->(DBSKIP())

		 ENDDO
		 CloseDbf('PLA')
*==============FIN RECORRIDO POR PLAN ACADEMICO

	       GRU->(DBSKIP())

	    ENDDO
**********FIN RECORRIDO POR GRUPOS

       ENDFOR
*>>>>FIN RECORRIDO POR NIVELES

*>>>>SELECION DE LAS AREAS DE TRABAJO
       cMaeAnt := cMaeAct
       IF !lUseDbf(.T.,cPatCon+'\'+cPatSis+'\'+cMaeAct+'\'+;
		   FileNiv+cAnoSis+ExtFile,'NIV',NIL,lShared) .OR.;
	  !lUseDbf(.T.,cPatCon+'\'+cPatSis+'\'+cMaeAct+'\'+;
		   FileGru+cMaeAct+cAnoSis+ExtFile,'GRU',NIL,lShared)

	  cError('ABRIENDO ARCHIVOS')
	  RETURN NIL
       ENDIF
       RETURN NIL
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

/*************************************************************************
* TITULO..: ORDENAR EL HORARIO                                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 23/2007 MIE A
       Colombia, Bucaramanga        INICIO: 06:00 PM   MAY 23/2007 MIE

OBJETIVOS:

1- Permite ordenar el horario.

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OrdenarHor(lShared,nModCry,aArchvo,oBrowse,cCodGru)

*>>>>DESCRIPCION DE ARCHIVOS
/*     lShared                              // Archivos del Sistema
       nModCry                              // Modo de Protecci¢n
       aArchvo                              // Archivo en Uso
       oBrowse                              // oBrowse del Archivo
       cCodGru                              // C¢digo del Grupo */
*>>>>FIN DESCRIPCION DE ARCHIVOS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador

       LOCAL aUseDbf := {}                  // Archivos en Uso
       LOCAL fArchvo := ''                  // Nombre del Archivo
       LOCAL fNtxArc := ''                  // Archivo Indice
       LOCAL cNalias := ''                  // Alias del Archivo

       LOCAL nNroOpc := 0                   // N£mero de opci¢n.
*>>>>FIN DECLARACION DE VARIABLES

*>>>>AREAS DE TRABAJO
       aUseDbf := {}
       FOR i := 1 TO LEN(aArchvo)
           fArchvo := aArchvo[i,1]
           fNtxArc := aArchvo[i,2]
	   cNalias := aArchvo[i,3]
	   IF cNalias == 'HOR'
	      EXIT
           ENDIF
       ENDFOR
*>>>>FIN AREAS DE TRABAJO

*>>>>ORDENACION DEL ARCHIVO
       CloseDbf('HOR')
       nNroOpc := nLeeOpcion('ORDENAR POR: '+'1<DIA> 2<MATERIA> '+;
			     '3<GRUPO> 4<PROFESOR>?',4,'0')
       DO CASE
       CASE nNroOpc == 1
	    IF !lOrdFile(lShared,fArchvo,;
			 'nDiaSemHor','cCodHraHor','cCodMatHor')
	       cError('NO SE ORDENO EL ARCHIVO')
	    ENDIF

       CASE nNroOpc == 2
	    IF !lOrdFile(lShared,fArchvo,;
			 'cCodMatHor','nDiaSemHor','cCodHraHor')
	       cError('NO SE ORDENO EL ARCHIVO')
	    ENDIF

       CASE nNroOpc == 3
	    IF !lOrdFile(lShared,fArchvo,;
			 'cCodGruHor','cCodMatHor','nDiaSemHor')
	       cError('NO SE ORDENO EL ARCHIVO')
	    ENDIF

       CASE nNroOpc == 4
	    IF !lOrdFile(lShared,fArchvo,;
			 'cCodProHor','nDiaSemHor','cCodHraHor')
	       cError('NO SE ORDENO EL ARCHIVO')
	    ENDIF

       ENDCASE
*>>>>FIN ORDENACION DEL ARCHIVO

*>>>>AREAS DE TRABAJO
       aUseDbf := {}
       FOR i := 1 TO LEN(aArchvo)
           fArchvo := aArchvo[i,1]
           fNtxArc := aArchvo[i,2]
           cNalias := aArchvo[i,3]
	   IF cNalias == 'HOR'
	      AADD(aUseDbf,{.T.,fArchvo,cNalias,fNtxArc,lShared,nModCry})
           ENDIF
       ENDFOR
*>>>>FIN AREAS DE TRABAJO

*>>>>SELECION DE LAS AREAS DE TRABAJO
       IF !lUseDbfs(aUseDbf)
	  cError('ABRIENDO EL ARCHIVO DE HORARIOS')
	  RETURN NIL
       ENDIF
*>>>>FIN SELECION DE LAS AREAS DE TRABAJO

*>>>>FILTRACION DEL ARCHIVO
       SELECT HOR
       IF !EMPTY(cCodGru)
	  SET FILTER TO HOR->cCodGruHor == cCodGru
       ENDIF
       HOR->(DBGOTOP())
       oBrowse:GOTOP()
       oBrowse:FORCESTABLE()
       RETURN NIL
*>>>>FIN FILTRACION DEL ARCHIVO

/*************************************************************************
* TITULO..: ASIGNAR PROFESORES                                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 23/2007 MIE A
       Colombia, Bucaramanga        INICIO: 08:00 AM   MAY 23/2007 MIE

OBJETIVOS:

1- Graba los profesores que dictan las materias.

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION CreaHorPro(lShared,nModCry,cNomSis,cAnoUsr,cPatCon,cPatSis,;
		    cMaeAlu,cMaeAct,oBrowse,cCodGru)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       nModCry                              // Modo de Protecci¢n
       cNomSis                              // Nombre del Sistema
       cAnoUsr                              // A¤o del Usuario
       cPatCon                              // Path de la Contabilidad
       cPatSis                              // Path del sistema
       cMaeAlu                              // Maestros habilitados
       cMaeAct                              // Maestro Activo
       oBrowse                              // Browse del Archivo
       cCodGru                              // C¢digo del Grupo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cCodigoTpr := ''               // C¢digo del Profesor
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL CONTENIDO
       IF HOR->(RECCOUNT()) == 0
	  cError('HO SE HA CREADO EL HORARIO')
       ENDIF
*>>>>FIN VALIDACION DEL CONTENIDO

*>>>>RECORRIDO POR HORARIO
       SELECT HOR
       SET FILTER TO
       HOR->(DBGOTOP())
       DO WHILE .NOT. HOR->(EOF())

**********LINEA DE ESTADO
	    LineaEstado(IF(EMPTY(HOR->nDiaSemHor),'',;
			   'DIA:'+cDia(HOR->nDiaSemHor,9))+;
			IF(EMPTY(HOR->cCodHraHor),'',;
			   'ºHORA: '+HOR->cCodHraHor)+;
			'ºGRUPO:'+HOR->cCodGruHor+;
			'ºMATERIA:'+HOR->cCodMatHor+;
			'ºNo. '+HOR->(STR(RECNO(),4))+'/'+;
				HOR->(STR(RECCOUNT(),4)),cNomSis)
**********FIN LINEA DE ESTADO

**********SELECION DE LAS AREAS DE TRABAJO
	    IF !lUseDbf(.T.,cPatCon+'\'+cPatSis+'\'+cMaeAct+'\'+;
			cFilePlan(cAnoUsr,HOR->cCodGruHor),;
			'PLA',NIL,lShared)

	       SET DEVICE TO SCREEN
	       cError('NO EXISTE PLAN ACADEMICO DEL CURSO '+HOR->cCodGruHor)
	       CloseDbf('PLA')
	       RETURN NIL
	    ENDIF
**********FIN SELECION DE LAS AREAS DE TRABAJO

**********GRABACION DEL PROFESOR
	    cCodigoTpr := ''
	    IF lLocCodigo('cCodigoMat','PLA',HOR->cCodMatHor)

	       cCodigoTpr := &('PLA->cPr'+HOR->cCodGruHor+'Pla')
	       IF HOR->(lRegLock(lShared,.F.))

		  REPL HOR->cCodProHor WITH cCodigoTpr
		  HOR->(DBCOMMIT())

	       ENDIF

	       IF lShared
		  HOR->(DBUNLOCK())
	       ENDIF

	    ENDIF
	    CloseDbf('PLA')
**********FIN GRABACION DEL PROFESOR

	  HOR->(DBSKIP())

       ENDDO
*>>>>FIN RECORRIDO POR HORARIO

*>>>>FILTRACION DEL ARCHIVO
       SELECT HOR
       IF !EMPTY(cCodGru)
	  SET FILTER TO HOR->cCodGruHor == cCodGru
       ENDIF
       HOR->(DBGOTOP())
       oBrowse:GOTOP()
       oBrowse:FORCESTABLE()
       RETURN NIL
*>>>>FIN FILTRACION DEL ARCHIVO

/*************************************************************************
* TITULO..: INTERVALO DE HORAS                                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 30/2007 JUE A
       Colombia, Bucaramanga        INICIO: 09:00 AM   AGO 30/2007 JUE

OBJETIVOS:

1- Permite selecionar un intervalo de Horas.

2- Retorna por referencia los param‚tros de la funci¢n marcados con @

3- Retorna .T. si no se hubo problemas

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lIntervHra(nNroFil,nNroCol,nRegIni,nRegFin,lIniFin)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroFil                              // N£mero de la fila
       nNroCol                              // N£mero de la Columna
       nRegIni                              // @Registro Inicial
       nRegFin                              // @Registro Final
       lIniFin                              // @ .T. Todos los Registros */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cMsgTxt := ''                  // Texto variable
       LOCAL nFilSup := 0                   // Fila superior
       LOCAL nColSup := 0                   // Colunma superior
       LOCAL nFilInf := 0                   // Fila inferior
       LOCAL nColInf := 0                   // Columna inferior
       LOCAL nRegTem := 0                   // Registro temporal
       LOCAL nIniReg := 0                   // Registro Inicial
       LOCAL nFinReg := 0                   // Registro Final
*>>>>FIN DECLARACION DE VARIABLES

*>>>>IMPRESION DE ENCABEZADOS
       cMsgTxt ='HORA INICIAL:'
       @ nNroFil  ,nNroCol SAY cMsgTxt
       @ nNroFil+1,nNroCol SAY 'HORA FINAL  :'
*>>>>FIN IMPRESION DE ENCABEZADOS

*>>>>CAPTURA DEL INTERVALO INICIAL
	SELECT HRA
	nNroCol = nNroCol + LEN(cMsgTxt)
	nFilSup := nNroFil
	nColSup := nNroCol
	IF nFilSup+RECCOUNT() > 22
	   nFilInf := 21
	ELSE
	   nFilInf := nFilSup + RECCOUNT()
	ENDIF
	nColInf := nColSup+LEN(HRA->cNombreHra)

	HRA->(DBGOTOP())
	nIniReg := HRA->(RECNO())
	nRegIni := nBrowseDbf(nFilSup,nColSup+1,nFilInf,nColInf,;
			      {||HRA->cNombreHra})
	IF nRegIni == 0
	   RETURN .F.
	ENDIF
	HRA->(DBGOTO(nRegIni))
	@ nFilSup,nColSup SAY HRA->cCodigoHra
*>>>>FIN CAPTURA DEL INTERVALO INICIAL

*>>>>CAPTURA DEL INTERVALO FINAL
       HRA->(DBGOBOTTOM())
       nFinReg := HRA->(RECNO())

       HRA->(DBGOTOP())
       nRegFin := nBrowseDbf(nFilSup+2,nColSup+1,nFilInf,nColInf,;
			     {||HRA->cNombreHra})
       IF nRegFin == 0
	  RETURN .F.
       ENDIF
       HRA->(DBGOTO(nRegFin))
       @ nFilSup+1,nColSup SAY HRA->cCodigoHra
*>>>>FIN CAPTURA DEL INTERVALO FINAL

*>>>>INTERCAMBIO DE REGISTROS
       IF nRegIni > nRegFin
	  nRegTem = nRegIni
	  nRegIni = nRegFin
	  nRegFin = nRegTem
       ENDIF
*>>>>FIN INTERCAMBIO DE REGISTROS

*>>>>ANALISIS DE TODOS LOS REGISTROS
       lIniFin := .F.
       IF nRegIni == nIniReg .AND. nRegFin == nFinReg
	  lIniFin := .T.
       ENDIF
       RETURN .T.
*>>>>FIN ANALISIS DE TODOS LOS REGISTROS