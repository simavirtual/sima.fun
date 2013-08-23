/*************************************************************************
* TITULO..: MANTENIMIENTO DEL ARCHIVO                                    *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE  9/2005 DOM A
       Colombia, Bucaramanga        INICIO:  5:40 PM   ENE  9/2005 DOM

OBJETIVOS:

1- Permite el mantenimiento del archivo

2- Debe estar en uso los archivos los maestros de alumnos, conceptos

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MantenCoE(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		   cMaeAlu)

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
       cMaeAlu                              // Maestros Habilitados */
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

*>>>>ORDENAR EL ARCHIVO
	     i := ASCAN(aArchvo,{|aArray|aArray[3] == 'COE'})
       OrdenaCoE(lShared,aArchvo[i,1])
*>>>>FIN ORDENAR EL ARCHIVO

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
       lModReg := IF(lModReg .AND. COE->(RECCOUNT())==0,.F.,lModReg)

       lDelReg := IF(lDelReg==NIL,.F.,lDelReg)

       lInsReg := IF(lInsReg==NIL,.F.,lInsReg)

       lHaySql := IF(lHaySql==NIL,.F.,lHaySql)
*>>>>FIN PARAMETROS POR DEFECTO

*>>>>MANTENIMIENTO DEL ARCHIVO
       oBrowse := oBrwDbfCoE(lShared,cNomUsr,cAnoUsr,03,00,22,79,;
			     lModReg,lDelReg,lInsReg,lHaySql,cMaeAlu)

/*
       SETKEY(K_F2,{||lManRegCoE(lShared,cNomUsr,3,oBrowse)})
     *ÀConsulta

       IF lModReg
          SETKEY(K_F4,{||lManRegCoE(lShared,cNomUsr,2,oBrowse,;
				    COE->cCodigoEst)})
       ENDIF
     *ÀActualizar
*/

       SETKEY(K_F5,{||BuscarCoE(oBrowse)})

       SETKEY(K_F9,{||MenuOtrCoE(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,;
                                 cEmpPal,cNomEmp,cNomSec,cNomUsr,cAnoUsr,;
                                 aArchvo,lPrnArc,cOpcPrn,nCodPrn,lModReg,;
				 lDelReg,lInsReg,lHaySql,oBrowse,cMaeAlu)})

       COE->(CtrlBrw(lShared,oBrowse))

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

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE  9/2005 DOM A
       Colombia, Bucaramanga        INICIO:  5:40 PM   ENE  9/2005 DOM

OBJETIVOS:

1- Define el objeto Browse del archivo

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION oBrwDbfCoE(lShared,cNomUsr,cAnoUsr,nFilSup,nColSup,nFilInf,nColInf,;
		    lModReg,lDelReg,lInsReg,lHaySql,cMaeAlu)

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
       cMaeAlu                              // Maestros Habilitados */
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

       cTitSup := '<< CONCEPTOS INDIVIDUALES A FACTURAR >>'
       cTitInf := '<F5>Buscar <F9>Otros'+;
		   IF(lDelReg,' <DEL>Borrar','')+;
		   IF(lInsReg,' <INS>Incluir','')

/*
       cTitInf := '<F2>Consultar <F5>Buscar'+;
                   IF(lModReg,' <F4>Actualizar','')+' <F9>Otros'+;
                   IF(lDelReg,' <DEL>Borrar','')+;
		   IF(lInsReg,' <INS>Incluir','')
*/

       IF lInsReg
	  oBrowse:Cargo := {cTitSup,cTitInf,{||lManRegCoE(lShared,cNomUsr,;
					       NIL,NIL,NIL,NIL,cMaeAlu)}}
       ELSE
          oBrowse:Cargo := {cTitSup,cTitInf}
       ENDIF
     *ÀDefinici¢n de cabeceras y l¡neas de cabeceras

       SELECT COE
       oColumn := TBCOLUMNNEW('CODIGO;ESTUDIANTE',{||COE->cCodigoEst})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','COE'},;
			 {'FIELD','cCodigoEst'},{'PICTURE','999999'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('CODIGO;CONCEPTO',{||COE->cCodigoCon})
       oColumn:Cargo := {{'MODI',.F.},{'ALIAS','COE'},;
			 {'FIELD','cCodigoCon'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MES INICIAL',{||COE->nMesIniPag})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','COE'},;
			 {'FIELD','nMesIniPag'},{'PICTURE','99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MES FINAL',{||COE->nMesFinPag})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','COE'},;
			 {'FIELD','nMesFinPag'},{'PICTURE','99'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn := TBCOLUMNNEW('MESES PAGOS',{||COE->cMesPagCli})
       oColumn:Cargo := {{'MODI',lModReg},{'ALIAS','COE'},;
			 {'FIELD','cMesPagCli'},{'PICTURE','@!'}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NOMBRE DEL ESTUDIANTE',;
				   {||cSekNomAlu(COE->cCodigoEst,;
						 cMaeAlu,'COE')})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('NOMBRE;DEL USUARIO',{||COE->cNomUsrCoE})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('FECHA DE;PROCESO',;
				    {||cFecha(COE->dFecUsrCoE)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('HORA DE;PROCESO',;
				    {||cHoraSys(COE->cHorUsrCoE)})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('CODIGO',{||COE->nIdeCodCoE})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       oColumn	     := TBCOLUMNNEW('No.',{||COE->(RECNO())})
       oColumn:Cargo := {{'MODI',.F.}}
       oBrowse:ADDCOLUMN(oColumn)
     *ÀDefinici¢n Columna

       RETURN oBrowse
*>>>>FIN DEFINICION DEL OBJETO BROWSE

/*************************************************************************
* TITULO..: MANTENIMIENTO DEL REGISTRO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE  9/2005 DOM A
       Colombia, Bucaramanga        INICIO:  5:40 PM   ENE  9/2005 DOM

OBJETIVOS:

1- Permite inclusi¢n,modificaci¢n y consulta del registro

2- Puede invocarse en la lectura a trav‚s de la clausula VALID

2- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lManRegCoE(lShared,cNomUsr,nTipMod,oBrowse,cCodigo,nNroOpc,cMaeAlu)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos
       cNomUsr                              // Nombre del Usuario
       nTipMod                              // Tipo de Modificaci¢n. 1 =>Insertar, 2=>Modificar 3=>Consultar
       xCodigo                              // C¢digo a Ingresar, Actualizar
       cTipNit                              // Tipo de Documento
       nNroOpc                              // N£mero de Opci¢n
       oBrowse                              // Browse del Archivo
       cMaeAlu                              // Maetros Habilitados */
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
       LOCAL cMaeAct := ''                  // Maestro Actual

       LOCAL cCodigoTco := ''               // C¢digo del C¢ncepto                                         
       LOCAL nMesIniTpa := 0                // Mes inicial del Servicio                                    
       LOCAL nMesFinTpa := 0                // Mes final del Servicio                                      
       LOCAL cNombreTes := ''               // Nombre del Estudiante

       LOCAL GetList := {}                  // Variable del sistema
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
            cTxtTem := 'CONCEPTO ESTUDIANTES .INCLUIR. '+aMenus[nNroOpc]
            COE->(DBGOBOTTOM())
            COE->(DBSKIP())
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 2
            cTxtTem := 'CONCEPTO ESTUDIANTES .ACTUALIZAR. '+aMenus[nNroOpc]
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 3
	    cTxtTem := 'CONCEPTO ESTUDIANTES. CONSULTA. '+aMenus[nNroOpc]
       ENDCASE
       nFilIni := nMarco(03,cTxtTem,22,'°')
*>>>>FIN MARCO DEL MANTENIMIENTO

*>>>>MANTENIMIENTO DEL REGISTRO
       SELECT COE
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
            IF lGrabar

               IF EMPTY(cCodigo)
                  cCodigo := COE->cCodigoEst
               ENDIF

               cCodigoTco := COE->cCodigoCon
               nMesIniTpa := COE->nMesIniPag
               nMesFinTpa := COE->nMesFinPag
	    ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil := nFilIni
               cTxtTem := 'CODIGO DEL ESTUDIANTE:'

	       IF nTipMod == 3
		  @ nNroFil,nNroCol SAY cTxtTem
		  @ nNroFil,nNroCol+LEN(cTxtTem)+1 SAY cCodigo COLOR('I')
	       ELSE
		  @ nNroFil,nNroCol SAY cTxtTem
		  cCodigo := cLeeCodEst(nNroFil,nNroCol+LEN(cTxtTem)+1,;
					cMaeAlu,@cMaeAct)
		  SELECT COE
		  IF EMPTY(cCodigo)
		     RETURN NIL
		  ENDIF
		  cNombreTes := ALLTRIM(&cMaeAct->cNombreEst)+' '+;
				ALLTRIM(&cMaeAct->cApelliEst)

		  @ nNroFil,nNroCol+LEN(cTxtTem)+8 SAY &cMaeAct->cCodigoGru+':'+;
						       ALLTRIM(&cMaeAct->cConcepEst)+':'+;
						       cNombreTes COLOR('I')

		  IF EMPTY(&cMaeAct->cConcepEst)
		     cError('NO TIENE CONCEPTOS INDIVIDUALES APLICADOS')
		     RETURN NIL
		  ENDIF

	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CODIGO DEL CONCEPTO  :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodigoTco COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
				    GET cCodigoTco PICT '@!';
				    VALID lValConcep(ROW(),COL()-2,@cCodigoTco) .AND.;
					  !EMPTY(cCodigoTco);
				    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DEL CONCEPTO')}
		  READ

		  SELECT COE
		  IF !(cCodigoTco $ &cMaeAct->cConcepEst)
		     cError(ALLTRIM(CON->cNombreCon)+' NO FIGURA APLICADO COMO CONCEPTO INDIVIDUAL')
		     RETURN NIL
		  ENDIF

	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********VALIDACION DE LOS CONCEPTOS GRABADOS
	    SELECT COE
	    LOCATE FOR COE->cCodigoEst == cCodigo .AND.;
		       COE->cCodigoCon == cCodigoTco

	    IF COE->(FOUND())
	       cError(ALLTRIM(CON->cNombreCon)+' YA FIGURA REGISTRADO')
	       RETURN NIL
	    ENDIF
**********FIN VALIDACION DE LOS CONCEPTOS GRABADOS

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'MES INICIAL          :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nMesIniTpa COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nMesIniTpa PICT '99';
				    VALID lnValMes(ROW(),COL()-2,@nMesIniTpa) .AND.;
					  nMesIniTpa > 0 .AND. nMesIniTpa <= 12;
				    WHEN {||HelpRead('FAVOR INGRESE EL MES INICIAL DEL SERVICIO')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'MES FINAL            :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nMesFinTpa COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nMesFinTpa PICT '99';
				    VALID lnValMes(ROW(),COL()-2,@nMesFinTpa) .AND.;
					  nMesFinTpa > 0 .AND. nMesFinTpa <= 12;
				    WHEN {||HelpRead('FAVOR INGRESE EL MES FINAL DEL SERVICIO')}
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

**********VALIDACION DE LOS MESES
	    IF nMesFinTpa < nMesIniTpa
	       cError('EL MES FINAL NO PUEDE SER MENOR AL MES INICIAL')
	       lGrabar := .F.
	       LOOP
	    ENDIF
**********FIN VALIDACION DE LOS MESES

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
       SELECT COE
       IF nTipMod # 3 .AND. lGrabar

          lInsReg := IF(nTipMod == 1,.T.,.F.)
          IF COE->(lRegLock(lShared,lInsReg))

             IF lInsReg
                REPL COE->nIdeCodCoE WITH COE->(RECNO())
                REPL COE->cCodigoEst WITH cCodigo
             ENDIF

             REPL COE->cCodigoCon WITH cCodigoTco
             REPL COE->nMesIniPag WITH nMesIniTpa
             REPL COE->nMesFinPag WITH nMesFinTpa

             REPL COE->cNomUsrCoE WITH cNomUsr
             REPL COE->dFecUsrCoE WITH DATE()
             REPL COE->cHorUsrCoE WITH TIME()
             COE->(DBCOMMIT())
          ENDIF

          IF lShared
             COE->(DBUNLOCK())
          ENDIF

       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SETCURSOR(nTipCur)
*>>>>FIN GRABACION DEL REGISTRO

*>>>>REFRESCAR EL BROWSE
       IF nTipMod == 2
          nNroReg := COE->(RECNO())
          COE->(DBGOTOP())
          oBrowse:GOTOP()
          COE->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ENDIF
       RETURN .T.
*>>>>FIN REFRESCAR EL BROWSE

/*************************************************************************
* TITULO..: MENU DE OTROS PARA EL ARCHIVO                                *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE  9/2005 DOM A
       Colombia, Bucaramanga        INICIO:  5:40 PM   ENE  9/2005 DOM

OBJETIVOS:

1- Menu de Otros para el archivo

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION MenuOtrCoE(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                    cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                    cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		    oBrowse,cMaeAlu)

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
       cMaeAlu                              // Maestros Habilitados */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cSavPan := ''                  // Salvar Pantalla
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del sistema
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL      i  := 0                   // Contador
       LOCAL aMenus  := {}                  // Vector de declaracion de men£
       LOCAL aAyuda  := {}                  // Vector de ayudas para el men£
       LOCAL nNroOpc := 1                   // Numero de la opcion
       LOCAL FileDbf := ''                  // Archivo de Dbf

       LOCAL GetList := {}                  // Variable del Sistema
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARCION Y EJECUCION DEL MENU
       aMenus := {}
       AADD(aMenus,'1<CONCEPTO ESTUDIANTES  >')

       aAyuda := {}
       AADD(aAyuda,'Imprime los detalles del control de la facturaci¢n')

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
            OtrCoE011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
                      cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
                      cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		      oBrowse,cMaeAlu)
	   *Impresi¢n de los campos del Archivo

       ENDCASE
       RETURN NIL
*>>>>FIN ANALISIS DE OPCION ESCOGIDA

/*************************************************************************
* TITULO..: IMPRESION CAMPOS DEL MANTENIMIENTO                           *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: ENE  9/2005 DOM A
       Colombia, Bucaramanga        INICIO:  5:40 PM   ENE  9/2005 DOM

OBJETIVOS:

1- Imprime los campos del archivo de mantenimiento

2- Retorna NIL

SINTAXIS:

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION OtrCoE011(lShared,nModCry,cNomSis,cCodEmp,cNitEmp,cEmpPal,;
		   cNomEmp,cNomSec,cNomUsr,cAnoUsr,aArchvo,lPrnArc,;
		   cOpcPrn,nCodPrn,lModReg,lDelReg,lInsReg,lHaySql,;
		   oBrowse,cMaeAlu)

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
       oBrowse                              // Browse del Archivo
       cMaeAlu                              // Maestros Habilitados */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL cAnoSis := SUBS(cAnoUsr,3,2)   // A¤o del Sistema
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

       LOCAL       i := 0                   // Contador
       LOCAL nAvance := 0                   // Avance de registros
       LOCAL cMaeAct := ''                  // Maestro Actual
       LOCAL cCodAct := ''                  // C¢digo Actual
       LOCAL cCodAnt := ''                  // C¢digo Anterior
       LOCAL nRegAnt := 0                   // Registro Anterior
       LOCAL nRegAct := 0                   // Registro Actual
       LOCAL lRegUno := .T.                 // .T. Primer Registro

       LOCAL FileTem := ''                  // Archivo Temporal
       LOCAL FileCli := ''                  // Archivo de Clientes
       LOCAL FilePag := ''                  // Archivo de Pagos
       LOCAL cPatSis := ''                  // Path del Sistema
       LOCAL ExtFile := ''                  // Extensi¢n del Archivo
       LOCAL Getlist := {}                  // Variable del sistema
     *ÀVariables espec¡ficas

       LOCAL cNombreTes := ''               // Nombre del Estudiante
       LOCAL cCodigoTgr := ''               // C¢digo del Grupo
       LOCAL cNombreTco := ''               // Nombre del Concepto
*>>>>FIN DECLARACION DE VARIABLES

*>>>>CALCULO DEL PATH DEL SISTEMA
       cPatSis := ''
       ExtFile := ''
       FileTem := aArchvo[ASCAN(aArchvo,{|aArray|aArray[3] == 'COE'}),1]
       aDivPath(FileTem,@cPatSis,NIL,@ExtFile)
*>>>>FIN CALCULO DEL PATH DEL SISTEMA

*>>>>ACTIVACION DE LA IMPRESORA
       nRegPrn := PRN->(RECNO())
       nLenPrn := PCL('n17Stan')

       IF lPrnArc
          SET DEVICE TO PRINT
       ELSE
          FilePrn := 'CoE'
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
                   'CONCEPTO ESTUDIANTES',;
		   'CONTROL DE CONCEPTOS INDIVIDUALES',;
		   'RELACION DE LOS RECIBOS FACTURADOS'}

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

       AADD(aNroCol,40)
       AADD(aTitPrn,'NOMBRE')

       AADD(aNroCol,06)
       AADD(aTitPrn,'GRUPO')

       AADD(aNroCol,6)
       AADD(aTitPrn,'INICIO')

       AADD(aNroCol,6)
       AADD(aTitPrn,'FINAL')

       AADD(aNroCol,20)
       AADD(aTitPrn,'CONCEPTO')

       AADD(aNroCol,12)
       AADD(aTitPrn,'PAGOS')

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

       SELECT COE
       COE->(DBGOTOP())
       cCodAnt := COE->cCodigoEst
       DO WHILE .NOT. COE->(EOF())

**********VISUALIZACION DE AVANCE
            nAvance := INT(( COE->(RECNO()) / COE->(RECCOUNT()) )*100)

            IF STR(nAvance,3) $ '25 50 75100'
               SET DEVICE TO SCREEN
               Termometro(nAvance)
               SET DEVICE TO PRINT
            ENDIF
**********FIN VISUALIZACION DE AVANCE

**********BUSQUEDA DEL CODIGO
	    cNombreTes := 'ALUMNO NO EXISTE'
	    cCodigoTgr := ''
	    IF lSekCodMae(COE->cCodigoEst,cMaeAlu,@cMaeAct,.F.)

	       cNombreTes := RTRIM(&cMaeAct->cApelliEst)+' '+;
			     &cMaeAct->cNombreEst
	       
	       IF &cMaeAct->lRetiroEst
		  cNombreTes := 'RETIRADO '+cNombreTes
	       ENDIF
	       cNombreTes := SUBS(cNombreTes+SPACE(40),1,40)
               cCodigoTgr := &cMaeAct->cCodigoGru
	    ENDIF
**********FIN BUSQUEDA DEL CODIGO

**********LOCALIZACION DEL CONCEPTO
	    cNombreTco := 'NO EXISTE:'+COE->cCodigoCon
	    IF lLocCodigo('cCodigoCon','CON',COE->cCodigoCon)
	       cNombreTco := COE->cCodigoCon+':'+CON->cNombreCon
	    ENDIF
	    cNombreTco := SUBS(cNombreTco+SPACE(20),1,20)
**********FIN LOCALIZACION DEL CONCEPTO

**********IMPRESION DEL REGISTRO
	    SELECT COE
	    cCodAct := COE->cCodigoEst
	    IF cCodAct == cCodAnt .AND. lRegUno
		aRegPrn := {}
		AADD(aRegPrn,COE->cCodigoEst)
		AADD(aRegPrn,cNombreTes)
		AADD(aRegPrn,cCodigoTgr)
		AADD(aRegPrn,cMes(COE->nMesIniPag,3))
		AADD(aRegPrn,cMes(COE->nMesFinPag,3))
		AADD(aRegPrn,cNombreTco)
		AADD(aRegPrn,COE->cMesPagCli)
	    ELSE
		aRegPrn := {}
		AADD(aRegPrn,'')
		AADD(aRegPrn,'')
		AADD(aRegPrn,'')
		AADD(aRegPrn,cMes(COE->nMesIniPag,3))
		AADD(aRegPrn,cMes(COE->nMesFinPag,3))
		AADD(aRegPrn,cNombreTco)
		AADD(aRegPrn,COE->cMesPagCli)
	    ENDIF

	    lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
                    aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
**********FIN IMPRESION DEL REGISTRO

**********AVANCE DEL SIGUIENTE REGISTRO
	    nRegAnt := COE->(RECNO())
	    SELECT COE
	    COE->(DBSKIP())
	    nRegAct := COE->(RECNO())

	    IF COE->(EOF())
	       SET DEVICE TO SCREEN
	       Termometro(100)
	       SET DEVICE TO PRINT
	    ENDIF
**********FIN AVANCE DEL SIGUIENTE REGISTRO

**********ANALISIS DEL CODIGO ANTERIOR
	    IF cCodAnt # COE->cCodigoEst
	       cCodAnt := COE->cCodigoEst
	       lRegUno := .T.
	    ELSE
	       lRegUno := .F.
	       LOOP
	    ENDIF
**********FIN ANALISIS DEL CODIGO ANTERIOR

**********PREPARACION DE LAS VARIABLES DE ARCHIVO
	    FileCli := cPatSis+'\CLIENTES\CL'+;
			       cCodigoTgr+cAnoSis+ExtFile

	    FilePag := cPatSis+'\PAGOS\PA'+;
			       cCodigoTgr+cAnoSis+ExtFile
**********FIN PREPARACION DE LAS VARIABLES DE ARCHIVO

**********SELECION DE LAS AREAS DE TRABAJO
	    IF !lUseDbf(.T.,FileCli,'CLI',NIL,lShared,nModCry) .OR.;
	       !lUseDbf(.T.,FilePag,'PAG',NIL,lShared,nModCry)
	       LOOP
	    ENDIF
**********FIN SELECION DE LAS AREAS DE TRABAJO

**********LOCALIZACION DEL CLIENTE
	    COE->(DBGOTO(nRegAnt))
	    IF !lLocCodigo('cCodigoEst','CLI',COE->cCodigoEst)
	       COE->(DBGOTO(nRegAct))
	       LOOP
	    ENDIF
**********FIN LOCALIZACION DEL CLIENTE

**********FILTRACION DE LOS PAGOS
	    SELECT PAG
	    SET FILTER TO PAG->cCodigoEst == CLI->cCodigoEst
	    PAG->(DBGOTOP())
	    IF PAG->(EOF())
	       SET FILTER TO
	       COE->(DBGOTO(nRegAct))
	       LOOP
	    ENDIF
**********FIN FILTRACION DE LOS PAGOS

**********IMPRESION DE LOS RECIBOS
	    SELECT PAG
	    PAG->(DBGOTOP())
	    DO WHILE .NOT. PAG->(EOF())

*--------------IMPRESION DEL RECIBO DE PAGO
		 cNombreTes := ALLTRIM(PAG->cConcepPag)+'=>'+;
			       ALLTRIM(PAG->cIniFinPag)
		 cNombreTes := SUBS(cNombreTes+SPACE(40),1,40)

		 aRegPrn := {}
		 AADD(aRegPrn,IF(PAG->cCodigoEst==COE->cCodigoEst,'','ERROR'))
		 AADD(aRegPrn,cNombreTes)
		 AADD(aRegPrn,'RECIBO')
		 AADD(aRegPrn,cMes(PAG->nMesIniPag,3))
		 AADD(aRegPrn,cMes(PAG->nMesFinPag,3))
		 AADD(aRegPrn,SUBS(&cMaeAct->cConcepEst+SPACE(20),1,20))
		 AADD(aRegPrn,cFecha(PAG->dFecPagPag))

		 lPrnOpc(lShared,nOpcPrn,FilePrn,nHanXml,01,nColCab,;
			 aTitPrn,aRegPrn,aNroCol,bPagina,bDerAut,bCabeza)
*--------------FIN IMPRESION DEL RECIBO DE PAGO

*---------------AVANCE DEL SIGUIENTE REGISTRO
		  SELECT PAG
		  PAG->(DBSKIP())
*---------------FIN AVANCE DEL SIGUIENTE REGISTRO

	    ENDDO
	    SELECT PAG
	    SET FILTER TO
	    COE->(DBGOTO(nRegAct))
**********FIN IMPRESION DE LOS RECIBOS

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