/*************************************************************************
* TITULO..: MANTENIMIENTO DEL ARCHIVO                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 14/2005 VIE A
       Colombia, Bucaramanga        INICIO:  1:00 PM   OCT 14/2005 VIE

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenJvf(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		   cMaeAct,cValNot)

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
       cMaeAct                              // Maestro Actual
       cValNot                              // Validaci¢n de los Juicios */
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
       lModReg := IF(lModReg .AND. JVF->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfJvf(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
			     lModReg,lDelReg,lInsReg,lHaySql,;
			     cMaeAct,cValNot)

       SETKEY(K_F2,{||lManRegJvf(cMaeAct,cValNot,lShared,cNomUsr,3,oBrowse)})
     *ÀConsulta

       IF lModReg
	  SETKEY(K_F4,{||lManRegJvf(cMaeAct,cValNot,lShared,cNomUsr,2,oBrowse,;
                                    JVF->cCodigoJvf)})
       ENDIF
     *ÀActualizar

       SETKEY(K_F5,{||BuscarJvf(oBrowse)})

       SETKEY(K_F9,{||MenuOtrJvf(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
                                 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
                                 aArchvo,lPrnArc,cOpcPrn,nCodPrn,lModReg,;
                                 lDelReg,lInsReg,lHaySql,oBrowse)})

       JVF->(CtrlBrw(lShared,oBrowse))

       SETKEY(K_F2,NIL)
       SETKEY(K_F4,NIL)
       SETKEY(K_F5,NIL)
       SETKEY(K_F9,NIL)
       CloseAll()
       RETURN NIL
*>>>>FIN MANTENIMIENTO DEL ARCHIVO

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL REGISTRO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 14/2005 VIE A
       Colombia, Bucaramanga        INICIO:  1:00 PM   OCT 14/2005 VIE

OBJETIVOS:

1- Permite inclusi¢n,modificaci¢n y consulta del registro

2- Puede invocarse en la lectura a trav‚s de la clausula VALID

2- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lManRegJvf(cMaeAct,cValNot,lShared,;
		    cNomUsr,nTipMod,oBrowse,cCodigo,nNroOpc)

*>>>>DESCRIPCION DE PARAMETROS
/*     cMaeAct                              // Maestro Actual
       cValNot                              // Validaci¢n de la Nota
       lShared                              // .T. Archivos Compartidos
       cNomUsr                              // Nombre del Usuario
       nTipMod                              // Tipo de Modificaci¢n. 1 =>Insertar, 2=>Modificar 3=>Consultar
       xCodigo                              // C¢digo a Ingresar, Actualizar
       cTipNit                              // Tipo de Documento
       nNroOpc                              // N£mero de Opci¢n
       oBrowse                              // Browse del Archivo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla

       LOCAL      i  := 0                   // Contador
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

       LOCAL cNotDef := ''                 // Juicio Valorativo final

       LOCAL cNombreTjv := ''               // Nombre del Juicio Valorativo Final                          
       LOCAL nNotIniTjv := 0                // Nota Inicial                                                
       LOCAL nNotFinTjv := 0                // Nota Final
       LOCAL cAproboTjv := ''               // Nota Aprobada
       LOCAL lAproboTjv := .F.              // Nota Aprobada
       LOCAL nFactorTjv := 0                // Factor del Juicio valorativo
       LOCAL cNotNumTjv := ''               // Nota Numerica del Juicio Valorativo

       LOCAL GetList := {}                 // Variable del sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>INCLUSION DE LOS REGISTROS POR DEFECTO
       nTipMod := IF(nTipMod==NIL,1,nTipMod)

       IF nTipMod == 1 .AND. JVF->(EOF()) .AND. !EMPTY(cValNot)

	  FOR i := 1 TO LEN(ALLTRIM(cValNot))

	      cNotDef := UPPER(SUBS(cValNot,i,1))
	      DO CASE
	      CASE 'E' $ cNotDef
		   cNombreTjv := 'EXCELENTE'
		   lAproboTjv := .T.

	      CASE 'S' $ cNotDef
		   cNombreTjv := 'SOBRESALIENTE'
		   lAproboTjv := .T.

	      CASE 'B' $ cNotDef
		   cNombreTjv := 'BUENO'
		   lAproboTjv := .T.

	      CASE 'A' $ cNotDef
		   cNombreTjv := 'ACEPTABLE'
		   lAproboTjv := .T.

	      CASE 'R' $ cNotDef
		   cNombreTjv := 'REGULAR'
		   lAproboTjv := .T.

	      CASE 'I' $ cNotDef
		   cNombreTjv := 'INSUFICIENTE'
		   lAproboTjv := .F.

	      CASE 'D' $ cNotDef
		   cNombreTjv := 'DEFICIENTE'
		   lAproboTjv := .F.

	      OTHERWISE
		   cNombreTjv := ''
		   lAproboTjv := .F.
		   LOOP
	      ENDCASE

	      IF JVF->(lRegLock(lShared,.T.))

		 REPL JVF->nIdeCodJvf WITH JVF->(RECNO())
		 REPL JVF->cCodigoJvf WITH cNotDef

		 REPL JVF->cNombreJvf WITH cNombreTjv
		 REPL JVF->lAproboJvf WITH lAproboTjv

		 REPL JVF->cNomUsrJvf WITH cNomUsr
		 REPL JVF->dFecUsrJvf WITH DATE()
		 REPL JVF->cHorUsrJvf WITH TIME()
		 JVF->(DBCOMMIT())
	      ENDIF

	      IF lShared
		 JVF->(DBUNLOCK())
	      ENDIF

	  ENDFOR
	  RETURN NIL
       ENDIF
*>>>>FIN INCLUSION DE LOS REGISTROS POR DEFECTO

*>>>>DECLARACION DEL MENU
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
            cTxtTem := 'JUICIOS VALORATIVOS .INCLUIR. '+aMenus[nNroOpc]
            JVF->(DBGOBOTTOM())
            JVF->(DBSKIP())
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 2
            cTxtTem := 'JUICIOS VALORATIVOS .ACTUALIZAR. '+aMenus[nNroOpc]
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 3
            cTxtTem := 'JUICIOS VALORATIVOS. CONSUTA. '+aMenus[nNroOpc]
       ENDCASE
       nFilIni := nMarco(03,cTxtTem,22,'°')
*>>>>FIN MARCO DEL MANTENIMIENTO

*>>>>MANTENIMIENTO DEL REGISTRO
       SELECT JVF
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
            IF lGrabar

               IF EMPTY(cCodigo)
                  cCodigo := JVF->cCodigoJvf
               ENDIF

               cNombreTjv := JVF->cNombreJvf
               nNotIniTjv := JVF->nNotIniJvf
	       nNotFinTjv := JVF->nNotFinJvf
	       nFactorTjv := JVF->nFactorJvf
	       cNotNumTjv := JVF->cNotNumJvf
            ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil := nFilIni
               cTxtTem := 'JUICIO VALORATIVO:'

               IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(cCodigo)
                  @ nNroFil,nNroCol SAY cTxtTem
                  @ nNroFil,nNroCol+LEN(cTxtTem)+1 SAY cCodigo COLOR('I')
               ELSE
                  @ nNroFil,nNroCol SAY cTxtTem;
                                    GET cCodigo PICT 'X';
                                    VALID !EMPTY(cCodigo) .AND.;
                                          !lValCodJvf(cCodigo)
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'DESCRIPCION      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNombreTjv COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNombreTjv PICT '@!A';
                                    VALID !EMPTY(cNombreTjv);
                                    WHEN {||HelpRead('FAVOR INGRESE LA DESCRIPCION DEL JUICIO VALORATIVO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'NOTA INICIAL     :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nNotIniTjv COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nNotIniTjv PICT '999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE LA NOTA INICIAL')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'NOTA FINAL       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nNotFinTjv COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nNotFinTjv PICT '999.99';
                                    WHEN {||HelpRead('FAVOR INGRESE LA NOTA FINAL')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'NOTA APROBADA    :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cAproboTjv COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cAproboTjv PICT '@!';
                                    VALID lValSiNo(ROW(),COL()-1,;
                                                     @cAproboTjv,@lAproboTjv);
                                    WHEN {||HelpRead('FAVOR INGRESE LA APROBACION DE LA NOTA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'FACTOR PARA JVF  :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nFactorTjv COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nFactorTjv PICT '9.999';
                                    WHEN {||HelpRead('FAVOR INGRESE EL FACTOR DEL JVF')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'NOTA NUMERICA    :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNotNumTjv COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cNotNumTjv PICT '99999';
                                    WHEN {||HelpRead('FAVOR INGRESE LA NOTA NUMERICA')}
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
       SELECT JVF
       IF nTipMod # 3 .AND. lGrabar

          lInsReg := IF(nTipMod == 1,.T.,.F.)
          IF JVF->(lRegLock(lShared,lInsReg))

             IF lInsReg
                REPL JVF->nIdeCodJvf WITH JVF->(RECNO())
                REPL JVF->cCodigoJvf WITH cCodigo
             ENDIF

             REPL JVF->cNombreJvf WITH cNombreTjv
             REPL JVF->nNotIniJvf WITH nNotIniTjv
	     REPL JVF->nNotFinJvf WITH nNotFinTjv
	     REPL JVF->nFactorJvf WITH nFactorTjv
	     REPL JVF->cNotNumJvf WITH cNotNumTjv

             REPL JVF->cNomUsrJvf WITH cNomUsr
             REPL JVF->dFecUsrJvf WITH DATE()
             REPL JVF->cHorUsrJvf WITH TIME()
             JVF->(DBCOMMIT())
          ENDIF

          IF lShared
             JVF->(DBUNLOCK())
          ENDIF

       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SETCURSOR(nTipCur)
*>>>>FIN GRABACION DEL REGISTRO

*>>>>REFRESCAR EL BROWSE
       IF nTipMod == 2
          nNroReg := JVF->(RECNO())
          JVF->(DBGOTOP())
          oBrowse:GOTOP()
          JVF->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ENDIF
       RETURN .T.
*>>>>FIN REFRESCAR EL BROWSE

/*************************************************************************
* TITULO..: DEFINICION DEL OBJETO BROWSE                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 14/2005 VIE A
       Colombia, Bucaramanga        INICIO:  1:00 PM   OCT 14/2005 VIE

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfJvf(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
		    lModReg,lDelReg,lInsReg,lHaySql,cMaeAct,cValNot)

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
       lHaySql                              // .T. Exportar a Sql
       cMaeAct                              // Maestro Actual
       cValNot                              // Validaci¢n del Juicio */
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

       cTitSup := '<< JUICIOS VALORATIVOS.'+cMaeAct+' >>'
       cTitInf := '<F2>Consultar <F5>Buscar'+;
                   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
                   IF(lDelReg,' <DEL>Borrar','')+;
                   IF(lInsReg,' <INS>Incluir','')

       IF lInsReg
	  oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegJvf(cMaeAct,cValNot,;
							  lShared,cNomUsr)}}
       ELSE
          oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT JVF
       oColumn := TBCOLUMNNEW('JUICIO;VALORATIVO',{||JVF->cCodigoJvf})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','JVF'},;
			 {'FIELD','cCodigoJvf'},{'PICTURE','X'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('DESCRIPCION',{||JVF->cNombreJvf})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','JVF'},;
			 {'FIELD','cNombreJvf'},{'PICTURE','@!A'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NOTA;INICIAL',{||JVF->nNotIniJvf})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','JVF'},;
			 {'FIELD','nNotIniJvf'},{'PICTURE','999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NOTA;FINAL',{||JVF->nNotFinJvf})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','JVF'},;
			 {'FIELD','nNotFinJvf'},{'PICTURE','999.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('APRUEBA;LA NOTA',{||JVF->lAproboJvf})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','JVF'},;
			 {'FIELD','lAproboJvf'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('VALOR NUMERICO;PARA EL JVF',{||JVF->nFactorJvf})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','JVF'},;
			 {'FIELD','nFactorJvf'},{'PICTURE','9.99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('NOTA;NUMERICA',{||JVF->cNotNumJvf})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','JVF'},;
			 {'FIELD','cNotNumJvf'},{'PICTURE','99999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||JVF->cNomUsrJvf})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				    {||cFecha(JVF->dFecUsrJvf)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				    {||cHoraSys(JVF->cHorUsrJvf)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CODIGO',{||JVF->nIdeCodJvf})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('No.',{||JVF->(RECNO())})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: JUICIOS VALORATIVOS                                          *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 14/2005 VIE A
       Colombia, Bucaramanga        INICIO: 06:25 PM   OCT 14/2005 VIE

OBJETIVOS:

1- Permite el mantenimiento del archivo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cValNotJvf()

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL cValNot := ''                  // Validaci¢n de la Nota
*>>>>FIN DECLARACION DE VARIABLES

*>>>>JUICIOS VALORATIVOS
       JVF->(DBGOTOP())
       DO WHILE .NOT. JVF->(EOF())
	  cValNot += JVF->cCodigoJvf
	  JVF->(DBSKIP())
       ENDDO
       RETURN cValNot
*>>>>FIN JUICIOS VALORATIVOS

/*************************************************************************
* TITULO..: JUICIOS VALORATIVOS APROBADOS                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 19/2010 MIE A
       Colombia, Bucaramanga        INICIO: 10:30 PM   OCT 19/2010 MIE

OBJETIVOS:

1- Retorna los c¢digos de los juicios valorativos aprobatorios

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cJvfSi()

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL  cJvfSi := ''                  // Juicios valorativos aprobatorios
*>>>>FIN DECLARACION DE VARIABLES

*>>>>JUICIOS VALORATIVOS APROBATORIOS
       JVF->(DBGOTOP())
       DO WHILE .NOT. JVF->(EOF())
	  IF JVF->lAproboJvf
	     cJvfSi += JVF->cCodigoJvf
	  ENDIF
	  JVF->(DBSKIP())
       ENDDO
       RETURN cJvfSi
*>>>>JUICIOS VALORATIVOS APROBATORIOS

/*************************************************************************
* TITULO..: JUICIOS VALORATIVOS NO APROBADOS                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: MAY 19/2010 MIE A
       Colombia, Bucaramanga        INICIO: 10:30 PM   OCT 19/2010 MIE

OBJETIVOS:


1- Retorna los c¢digos de los juicios valorativos NO aprobatorios

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cJvfNo()

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL  cJvfNo := ''                  // Juicios valorativos aprobatorios
*>>>>FIN DECLARACION DE VARIABLES

*>>>>JUICIOS VALORATIVOS
       JVF->(DBGOTOP())
       DO WHILE .NOT. JVF->(EOF())
	  IF .NOT. JVF->lAproboJvf
	     cJvfNo += JVF->cCodigoJvf
	  ENDIF
	  JVF->(DBSKIP())
       ENDDO
       RETURN cJvfNo
*>>>>FIN JUICIOS VALORATIVOS

/*************************************************************************
* TITULO..: NOTA DEFINITIVA                                              *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 14/2005 VIE A
       Colombia, Bucaramanga        INICIO: 06:30 PM   OCT 14/2005 VIE

OBJETIVOS:

1- Localiza el juicio valorativo de acuerdo al intervalo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cNotDefJvf(nNota)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNota                                // Nota Numerica */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cJuiVal := ''                  // Nota Definitiva
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DE LA NOTA
       IF nNota == 0
	  cJuiVal := SPACE(01)
	  RETURN cJuiVal
       ENDIF
       cJuiVal := '*'  // Error

       IF nNota == 100
	  nNota := 100
       ELSE
	  nNota := VAL(STR(nNota,5,2))
       ENDIF
*>>>>FIN VALIDACION DE LA NOTA

*>>>>JUICIO VALORATIVO
       JVF->(DBGOTOP())
       DO WHILE .NOT. JVF->(EOF())
	  IF nNota >= JVF->nNotIniJvf .AND. nNota <= JVF->nNotFinJvf
	     cJuiVal := JVF->cCodigoJvf
	     EXIT
	  ENDIF
	  JVF->(DBSKIP())
       ENDDO
*>>>>JUICIO VALORATIVO

*>>>>VALIDACION JUICIO VALORATIVO
       IF cJuiVal == '*'
	  cError(cJuiVal+'='+STR(nNota,5,2)+' '+;
		 'NO SE ASIGNO EL JUICIO VALORATIVO')
       ENDIF
       RETURN cJuiVal
*>>>>VALIDACION JUICIO VALORATIVO

/*************************************************************************
* TITULO..: APROBACION DEL JUICIO VALORATIVO                             *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 14/2008 VIE A
       Colombia, Bucaramanga        INICIO: 04:30 PM   JUL 14/2008 VIE

OBJETIVOS:

1- Localiza el juicio valorativo de acuerdo al intervalo

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cAproboJvf(cCodigo,cNomJvf,cCodJvf)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodigo			      // C¢digo Juicio Valorativo
       cNomJvf                        // @Nombre del Juicio Valorativo final
       cCodJvf                        // @C¢digo del Juicio valorativo final */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cAprobo := ''            // S=>Aprob N=>No Aprobo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DEL CODIGO
       cCodJvf := ''
       cNomJvf := ''
       IF lLocCodigo('cCodigoJvf','JVF',cCodigo)
	  IF JVF->lAproboJvf
	     cAprobo := 'S'
	  ELSE
	     cAprobo := 'N'
	  ENDIF
	  cCodJvf := JVF->cCodigoJvf
	  cNomJvf := JVF->cNombreJvf
       ENDIF
       RETURN cAprobo
*>>>>FIN LOCALIZACION DEL CODIGO


/*************************************************************************
* TITULO..: NOMBRE DEL JUICIO VALORATIVO                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 14/2005 VIE A
       Colombia, Bucaramanga        INICIO: 06:45 PM   OCT 14/2005 VIE

OBJETIVOS:

1- Localiza el nombre del Juicio Valorativa

2- Si el nombre se incluye en un browse se debe pasar
   el Alias del Archivo del Browse

3- Retorna el nombre

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION cNombreJvf(cCodigo,cNalias)

*>>>>PARAMETROS DE LA FUNCION
/*     cCodigo				      // C¢digo de b£squeda
       cNalias				      // Alias del Browse */
*>>>>FIN PARAMETROS DE LA FUNCION

*>>>>DECLARACION DE VARIABLES
       LOCAL cNombreTjv := ''                 // Nombre del Juicio Valorativo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>LOCALIZACION DEL CODIGO
       IF lLocCodigo('cCodigoJvf','JVF',cCodigo)
	  cNombreTjv := JVF->cNombreJvf
       ELSE
	  cNombreTjv := ''
       ENDIF
       IF cNalias # NIL
	  SELECT &cNalias
       ENDIF
       RETURN cNombreTjv
*>>>>FIN LOCALIZACION DEL CODIGO

/*************************************************************************
* TITULO..: VALIDACION DEL INTERVALO                                     *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 14/2005 VIE A
       Colombia, Bucaramanga        INICIO: 07:50 PM   OCT 14/2005 VIE

OBJETIVOS:

1- Valida la Existencia de la definici¢n del intevalo de equivalencia
   entre la nota numerica y su respectivo juicio valorativo.

2- Retorn .T. si existe un intevalo valido

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lHayItvJvf()

*>>>>DECLARACION DE VARIABLES
       LOCAL lItvJvf := .T.                 // .T. Hay Intervalo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>ANALISIS DE DECISION
       JVF->(DBGOTOP())
       DO WHILE .NOT. JVF->(EOF())
	  IF JVF->nNotIniJvf == 0 .OR. JVF->nNotFinJvf == 0
	     lItvJvf := .F.
	     EXIT
	  ENDIF
	  JVF->(DBSKIP())
       ENDDO
       RETURN lItvJvf
*>>>>FIN ANALISIS DE DECISION

/*************************************************************************
* TITULO..: FACTOR DEL JUICIO VALORATIVO                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 28/2006 VIE A
       Colombia, Bucaramanga        INICIO: 06:00 PM   SEP 28/2006 VIE

OBJETIVOS:

1- Lee los factores de los juicios valorativos finales

2- Retorn el vector con los juicios valorativos

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION aFactorJvf()

*>>>>DECLARACION DE VARIABLES
       LOCAL aFacJvF := {}                  // Factor de los jvf
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DE LOS FACTORES
       JVF->(DBGOTOP())
       DO WHILE .NOT. JVF->(EOF())
	  IF JVF->nFactorJvf == 0
	     RETURN aFacJvf
	  ENDIF
	  JVF->(DBSKIP())
       ENDDO
*>>>>FIN VALIDACION DE LOS FACTORES

*>>>>ANALISIS DE DECISION
       JVF->(DBGOTOP())
       DO WHILE .NOT. JVF->(EOF())
	  AADD(aFacJvf,{ALLTRIM(JVF->cCodigoJvf),JVF->nFactorJvf})
	  JVF->(DBSKIP())
       ENDDO
       RETURN aFacJvf
*>>>>FIN ANALISIS DE DECISION

/*************************************************************************
* TITULO..: FACTOR NUMERICO DEL JUICIO VALORATIVO                        *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: SEP 28/2006 VIE A
       Colombia, Bucaramanga        INICIO: 06:15 PM   SEP 28/2006 VIE

OBJETIVOS:

1- Lee el factor asociado a cada juicio valorativo

2- Retorn un vector con los factores

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nFactorJvf(cCodJvf)

*>>>>DESCRIPCION DE PARAMETROS
/*     cCodJvf                              // C¢digo del Juicio valorativo */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL aFacJvF := {}                  // Factor de los jvf
       LOCAL nFacJvf := 0                   // Factor del Juicio Valorativo
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL FACTOR
       aFacJvf := aFactorJvf()
       IF LEN(aFacJvf) == 0
	  RETURN 0
       ENDIF
*>>>>FIN VALIDACION DEL FACTOR

*>>>>LECTURA DEL FACTOR DEL JVF
       FOR i := 1 TO LEN(aFacJvf)
	   IF aFacJvf[i,1] == cCodJvf
	      nFacJvf := aFacJvf[i,2]
	      EXIT
	   ENDIF
       ENDFOR
       RETURN nFacJvf
*>>>>FIN LECTURA DEL FACTOR DEL JVF