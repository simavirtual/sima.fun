/*************************************************************************
* TITULO..: MANTENIMIENTO DEL REGISTRO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: AGO 17/2006 JUE A
       Colombia, Bucaramanga        INICIO:  5:07 PM   AGO 17/2006 JUE

OBJETIVOS:

1- Permite inclusi¢n,modificaci¢n y consulta del registro

2- Puede invocarse en la lectura a trav‚s de la clausula VALID

2- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lManRegIso(lShared,cNomUsr,nTipMod,oBrowse,nNumero,nNroOpc,;
		    cTitulo,cOpcSys,cCodInf,aMarInf,nNroDoc,aObsPrn)

*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Archivos Compartidos
       cNomUsr                              // Nombre del Usuario
       nTipMod                              // Tipo de Modificaci¢n. 1 =>Insertar, 2=>Modificar 3=>Consultar
       xCodigo                              // C¢digo a Ingresar, Actualizar
       cTipNit                              // Tipo de Documento
       nNroOpc                              // N£mero de Opci¢n
       oBrowse                              // Browse del Archivo
       cTitulo                              // T¡tulo por defecto del Documento
       cOpcSys			            // Opci¢n del Sistema
       cCodInf                              // C¢digo del Informe
       aMarInf				    // Margenes del Informe
       nNroDoc                              // N£mero del Documento
       aObsPrn			            // Observaciones del Informe */
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

       LOCAL cCodInfTis := ''               // C¢digo del Informe
       LOCAL nCodPrnTis := 0                // C¢digo de la Impresora
       LOCAL dFecAprTis := CTOD('00/00/00')   // Fecha de Aprobaci¢n del Iso
       LOCAL cFecAprTis := ''               // Fecha de Aprobaci¢n del Iso
       LOCAL cNroVerTis := ''               // Versi¢n del Documento
       LOCAL nMargSITis := 0                // Margen Superior Izquierdo
       LOCAL nMargSDTis := 0                // Margen Superior Derecho                                     
       LOCAL nMargIITis := 0                // Margen Inferior Izquierdo                                   
       LOCAL nMargIDTis := 0                // Margen Inferior Derecho                                     
       LOCAL nMarg1ITis := 0                // Margen Uno Izquierdo                                        
       LOCAL nMarg1DTis := 0                // Margen Uno Derecho                                          
       LOCAL nMarg2ITis := 0                // Margen Dos Izquierdo                                        
       LOCAL nMarg2DTis := 0                // Margen Dos Derecho
       LOCAL nNroDocTis := 0                // N£mero del Documento
       LOCAL cCodigoTis := ''               // C¢digo Iso del Documento
       LOCAL cTitUnoTis := ''               // T¡tulo Uno Iso del Documento                                
       LOCAL cTitDosTis := ''               // T¡tulo Dos Iso del Documento                                
       LOCAL cTitTreTis := ''               // T¡tulo Tres Iso del Documento                               
       LOCAL cPieUnoTis := ''               // Pie de P gina Uno del Documento                             
       LOCAL cPieDosTis := ''               // Pie de P gina Dos del Documento                             
       LOCAL cPieTreTis := ''               // Pie de P gina Tres del Documento
       LOCAL cObsUnoTis := ''               // Observaci¢n Uno                                             
       LOCAL cObsDosTis := ''               // Observaci¢n Dos                                             
       LOCAL cObsTreTis := ''               // Observaci¢n Tres
       LOCAL nCabPrnTis := 0                // Encabezado del Informe

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
            cTxtTem := 'DOCUMENTOS ISO .INCLUIR. '+aMenus[nNroOpc]
            ISO->(DBGOBOTTOM())
            ISO->(DBSKIP())
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 2
            cTxtTem := 'DOCUMENTOS ISO .ACTUALIZAR. '+aMenus[nNroOpc]
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 3
            cTxtTem := 'DOCUMENTOS ISO. CONSUTA. '+aMenus[nNroOpc]
       ENDCASE
       nFilIni := nMarco(03,cTxtTem,22,'°')
*>>>>FIN MARCO DEL MANTENIMIENTO

*>>>>MANTENIMIENTO DEL REGISTRO
       SELECT ISO
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
            IF lGrabar

               IF EMPTY(nNumero)
		  nNumero := ISO->nNumeroIso
		  cOpcSys := ISO->cOpcSysIso
	       ENDIF

	       nCodPrnTis := ISO->nCodPrnIso
	       dFecAprTis := ISO->dFecAprIso
	       cFecAprTis := ISO->cFecAprIso
	       cNroVerTis := ISO->cNroVerIso
	       cCodigoTis := ISO->cCodigoIso
               cTitUnoTis := ISO->cTitUnoIso
               cTitDosTis := ISO->cTitDosIso
               cTitTreTis := ISO->cTitTreIso
               cPieUnoTis := ISO->cPieUnoIso
               cPieDosTis := ISO->cPieDosIso
	       cPieTreTis := ISO->cPieTreIso
	       nCabPrnTis := ISO->nCabPrnIso

	       IF nTipMod == 1   // Incluir

		  IF ALIAS(SELECT('INF')) == 'INF'
		     cCodInfTis := cCodInf
		  ENDIF

		  IF ALIAS(SELECT('INF')) == 'INF'
		     IF LEN(aMarInf) >= 1
			nMargSITis := aMarInf[1,1]
			nMargSDTis := aMarInf[1,2]
		     ENDIF
		  ENDIF

		  IF ALIAS(SELECT('INF')) == 'INF'
		     IF LEN(aMarInf) >= 2
			nMargIITis := aMarInf[2,1]
			nMargIDTis := aMarInf[2,2]
		     ENDIF
		  ENDIF

		  IF ALIAS(SELECT('INF')) == 'INF'
		     IF LEN(aMarInf) >= 3
			nMarg1ITis := aMarInf[3,1]
			nMarg1DTis := aMarInf[3,2]
		     ENDIF
		  ENDIF

		  IF ALIAS(SELECT('INF')) == 'INF'
		     IF LEN(aMarInf) >= 4
			nMarg2ITis := aMarInf[4,1]
			nMarg2DTis := aMarInf[4,2]
		     ENDIF
		  ENDIF

		  nNroDocTis := nNroDoc

		  IF ALIAS(SELECT('INF')) == 'INF'
		     cObsUnoTis := aObsPrn[1]
		     cObsDosTis := aObsPrn[2]
		     cObsTreTis := aObsPrn[3]
		  ELSE
		     cObsUnoTis := ''
		     cObsDosTis := ''
		     cObsTreTis := ''
		  ENDIF
	       ELSE
		  cCodInfTis := ISO->cCodInfIso
		  nMargSITis := ISO->nMargSIIso
		  nMargSDTis := ISO->nMargSDIso
		  nMargIITis := ISO->nMargIIIso
		  nMargIDTis := ISO->nMargIDIso
		  nMarg1ITis := ISO->nMarg1IIso
		  nMarg1DTis := ISO->nMarg1DIso
		  nMarg2ITis := ISO->nMarg2IIso
		  nMarg2DTis := ISO->nMarg2DIso
		  nNroDocTis := ISO->nNroDocIso
		  cObsUnoTis := ISO->cObsUnoIso
		  cObsDosTis := ISO->cObsDosIso
		  cObsTreTis := ISO->cObsTreIso
	       ENDIF

	    ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil := nFilIni
               cTxtTem := 'NUMERO DEL DOCUMENTO    :'

               IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(nNumero)
                  @ nNroFil,nNroCol SAY cTxtTem
                  @ nNroFil,nNroCol+LEN(cTxtTem)+1 SAY nNumero COLOR('I')
               ELSE
                  @ nNroFil,nNroCol SAY cTxtTem;
                                    GET nNumero PICT '@!';
                                    VALID !EMPTY(nNumero) .AND.;
                                          !lValCodIso(nNumero)
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'TITULO POR DEFECTO      :'

	       IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(cTitulo)
		  @ nNroFil,nColTem SAY cTxtTem
		  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cTitulo COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
				    GET cTitulo PICT '@S42';
				    WHEN {||HelpRead('FAVOR INGRESE EL TITULO POR DEFECTO')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'OPCION DEL SISTEMA      :'

	       IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(cOpcSys)
		  @ nNroFil,nColTem SAY cTxtTem
		  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cOpcSys COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
				    GET cOpcSys PICT '@!S42';
				    WHEN {||HelpRead('FAVOR INGRESE LA OPCION DEL INFORME')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
	    IF nNroOpc == 1 .AND. ALIAS(SELECT('INF')) == 'INF'

               nNroFil++
               nColTem := nNroCol
	       cTxtTem := 'CODIGO DEL INFORME      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodInfTis COLOR('I')
	       ELSE
		  @ nNroFil,nColTem SAY cTxtTem;
				    GET cCodInfTis PICT 'XXXXXXXX';
				    VALID !EMPTY(cCodInfTis) .AND.;
					  lValInf(ROW()+1,15,@cCodInfTis);
                                    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DEL INFORME')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
	    IF nNroOpc == 1 .AND. ALIAS(SELECT('INF')) == 'INF'

*               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CODIGO IMPRESORA        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nCodPrnTis COLOR('I')
	       ELSE
		  cTxtTem := 'IMPRESORA:'
		  @ nNroFil,nColTem+LEN(cTxtTem)+25 SAY cTxtTem;
				    GET nCodPrnTis PICT '9999';
				    VALID lValPrn(ROW()+1,15,@nCodPrnTis);
				    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO DE LA IMPRESORA')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
	    IF nNroOpc == 1  .AND. ALIAS(SELECT('INF')) == 'INF'

*              nNroFil++
	       nColTem := nNroCol
	       cTxtTem := 'ENCABEZADO No.          :'

	       IF nTipMod == 3
		  @ nNroFil,nColTem SAY cTxtTem
		  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nCabPrnTis COLOR('I')
	       ELSE
		  cTxtTem := 'ENCABEZADO No:'
		  @ nNroFil,nColTem+51 SAY cTxtTem;
				       GET nCabPrnTis PICT '99';
				       WHEN {||HelpRead('FAVOR INGRESE EL NUMERO DEL ENCABEZDO DEL INFORME')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
	    IF nNroOpc == 1 .AND.;
	       ALIAS(SELECT('INF')) == 'INF' .AND.;
	       INF->lInfVarInf

*               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'NUMERO DOCUMENTO        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nNroDocTis COLOR('I')
	       ELSE
		  cTxtTem := 'DOC No'
		  @ nNroFil,nColTem+69 SAY cTxtTem;
				    GET nNroDocTis PICT '99';
				    VALID !EMPTY(nNroDocTis);
                                    WHEN {||HelpRead('FAVOR INGRESE EL NUMERO DEL DOCUMENTO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
	    IF nNroOpc == 1 .AND.;
	       ALIAS(SELECT('INF')) == 'INF'

               nNroFil++
               nColTem := nNroCol
	       cTxtTem := 'MARGEN SUPERIOR IZQUIERD:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nMargSITis COLOR('I')
	       ELSE
		  cTxtTem := 'MARGENES DEL INFORME    : MSI:'
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nMargSITis PICT '999';
                                    WHEN {||HelpRead('FAVOR INGRESE EL MARGEN SUPERIOR IZQUIERDO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
	    IF nNroOpc == 1 .AND.;
	       ALIAS(SELECT('INF')) == 'INF'

*               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'MARGEN SUPERIOR DERECHO :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nMargSDTis COLOR('I')
	       ELSE
		  cTxtTem := 'MSD:'
		  @ nNroFil,nColTem+35 SAY cTxtTem;
                                    GET nMargSDTis PICT '999';
                                    WHEN {||HelpRead('FAVOR INGRESE EL MARGEN SUPERIOR DERECHO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
	    IF nNroOpc == 1 .AND.;
	       ALIAS(SELECT('INF')) == 'INF'

*               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'MARGEN INFERIOR IZQUIERD:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nMargIITis COLOR('I')
	       ELSE
		  cTxtTem := 'MII:'
		  @ nNroFil,nColTem+44 SAY cTxtTem;
				    GET nMargIITis PICT '999';
				    WHEN {||HelpRead('FAVOR INGRESE EL MARGEN INFERIOR IZQUIERDO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
	    IF nNroOpc == 1 .AND.;
	       ALIAS(SELECT('INF')) == 'INF'

*               nNroFil++
	       nColTem := nNroCol
	       cTxtTem := 'MARGEN INFERIOR DERECHO :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nMargIDTis COLOR('I')
	       ELSE
		  cTxtTem := 'MID:'
		  @ nNroFil,nColTem+53 SAY cTxtTem;
				    GET nMargIDTis PICT '999';
				    WHEN {||HelpRead('FAVOR INGRESE EL MARGEN INFERIOR DERECHO')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
	    IF nNroOpc == 1 .AND.;
	       ALIAS(SELECT('INF')) == 'INF'

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'MARGEN UNO IZQUIERDO    :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nMarg1ITis COLOR('I')
	       ELSE
		  cTxtTem := 'MARGENES AUXILIARES     : 1SI:'
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET nMarg1ITis PICT '999';
                                    WHEN {||HelpRead('FAVOR INGRESE EL MARGEN UNO IZQUIERDO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
	    IF nNroOpc == 1 .AND.;
	       ALIAS(SELECT('INF')) == 'INF'

*               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'MARGEN UNO DERECHO      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nMarg1DTis COLOR('I')
	       ELSE
		  cTxtTem := '1SD:'
		  @ nNroFil,nColTem+35 SAY cTxtTem;
				    GET nMarg1DTis PICT '999';
                                    WHEN {||HelpRead('FAVOR INGRESE EL MARGEN UNO DERECHO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
	    IF nNroOpc == 1 .AND.;
	       ALIAS(SELECT('INF')) == 'INF'

*               nNroFil++
	       nColTem := nNroCol
	       cTxtTem := 'MARGEN DOS IZQUIERDO    :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nMarg2ITis COLOR('I')
	       ELSE
		  cTxtTem := '2II:'
		  @ nNroFil,nColTem+44 SAY cTxtTem;
				    GET nMarg2ITis PICT '999';
                                    WHEN {||HelpRead('FAVOR INGRESE EL MARGEN DOS IZQUIERDO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
	    IF nNroOpc == 1 .AND.;
	       ALIAS(SELECT('INF')) == 'INF'

*               nNroFil++
	       nColTem := nNroCol
	       cTxtTem := 'MARGEN DOS DERECHO      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nMarg2DTis COLOR('I')
	       ELSE
		  cTxtTem := '2ID:'
		  @ nNroFil,nColTem+53 SAY cTxtTem;
				    GET nMarg2DTis PICT '999';
                                    WHEN {||HelpRead('FAVOR INGRESE EL MARGEN DOS DERECHO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'CODIGO ISO DEL DOCUMENTO:'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cCodigoTis COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
				    GET cCodigoTis PICT '@!S16';
                                    WHEN {||HelpRead('FAVOR INGRESE EL CODIGO ISO DEL DOCUMENTO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
	    IF nNroOpc == 1 .AND. ALIAS(SELECT('INF')) == 'INF'

*              nNroFil++
               nColTem := nNroCol
               cTxtTem := 'FECHA APROBACION        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cFecAprTis COLOR('I')
	       ELSE
		  cTxtTem := 'FECHA:'
		  @ nNroFil,nColTem+43 SAY cTxtTem;
				    GET cFecAprTis PICT '@!S10';
				    WHEN {||HelpRead('FAVOR INGRESE LA FECHA DE APROBACION FORMATO TEXTO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
	    IF nNroOpc == 1 .AND. ALIAS(SELECT('INF')) == 'INF'

*	       nNroFil++
	       nColTem := nNroCol
	       cTxtTem := 'FECHA APROBACION        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY dFecAprTis COLOR('I')
	       ELSE
		  cTxtTem := 'FECHA:'
		  @ nNroFil-6,nColTem+43 SAY cTxtTem;
				    GET dFecAprTis PICT '@!D';
				    WHEN {||HelpRead('FAVOR INGRESE LA FECHA DE APROBACION MM/DD/AAAA')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
	    IF nNroOpc == 1 .AND. ALIAS(SELECT('INF')) == 'INF'

*               nNroFil++
	       nColTem := nNroCol
	       cTxtTem := 'VERSION                 :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cNroVerTis COLOR('I')
	       ELSE
		  cTxtTem := 'VERSION:'
		  @ nNroFil,nColTem+61 SAY cTxtTem;
				    GET cNroVerTis PICT '@!S7';
                                    WHEN {||HelpRead('FAVOR INGRESE LA VERSION DEL INFORME')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'TITULO UNO              :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cTitUnoTis COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
				    GET cTitUnoTis PICT '@S42';
				    WHEN {||HelpRead('FAVOR INGRESE EL TITULO UNO DEL DOCUMENTO')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'TITULO DOS              :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cTitDosTis COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
				    GET cTitDosTis PICT '@S42';
				    WHEN {||HelpRead('FAVOR INGRESE EL TITULO DOS DEL DOCUMENTO')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'TITULO TRES             :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cTitTreTis COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
				    GET cTitTreTis PICT '@S42';
				    WHEN {||HelpRead('FAVOR INGRESE EL TITULO UNO ISO DEL DOCUMENTO')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PIE DE PAGINA UNO       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cPieUnoTis COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
				    GET cPieUnoTis PICT '@S42';
				    WHEN {||HelpRead('FAVOR INGRESE EL PIE DE PAGINA UNO DEL DOCUMENTO')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PIE DE PAGINA DOS       :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cPieDosTis COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
				    GET cPieDosTis PICT '@S42';
				    WHEN {||HelpRead('FAVOR INGRESE EL PIE DE PAGINA DOS DEL DOCUMENTO')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'PIE DE PAGINA TRES      :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cPieTreTis COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
				    GET cPieTreTis PICT '@S42';
				    WHEN {||HelpRead('FAVOR INGRESE EL PIE DE PAGINA UNO DEL DOCUMENTO')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'OBSERVACION UNO         :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cObsUnoTis COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cObsUnoTis PICT '@!S42';
                                    WHEN {||HelpRead('FAVOR INGRESE LA OBSERVACION UNO')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'OBSERVACION DOS         :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cObsDosTis COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cObsDosTis PICT '@!S42';
                                    WHEN {||HelpRead('FAVOR INGRESE LA OBSERVACION DOS')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'OBSERVACION TRES        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cObsTreTis COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cObsTreTis PICT '@!S42';
                                    WHEN {||HelpRead('FAVOR INGRESE LA OBSERVACION TRES')}
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
       SELECT ISO
       IF nTipMod # 3 .AND. lGrabar

	  lInsReg := IF(nTipMod == 1,.T.,.F.)
	  IF ISO->(lRegLock(lShared,lInsReg))

             IF lInsReg
		REPL ISO->nIdeCodIso WITH ISO->(RECNO())
		REPL ISO->nNumeroIso WITH nNumero
		REPL ISO->cOpcSysIso WITH cOpcSys

		IF ALIAS(SELECT('INF')) == 'INF'
		   REPL ISO->cObsUnoIso WITH aObsPrn[1]
		   REPL ISO->cObsDosIso WITH aObsPrn[2]
		   REPL ISO->cObsTreIso WITH aObsPrn[3]
		ENDIF
	     ENDIF

	     IF ALIAS(SELECT('INF')) == 'INF'
		REPL ISO->cCodSuiIso WITH INF->cCodSuiInf
		REPL ISO->nNroOrdIso WITH INF->nNroOrdInf
	     ENDIF

	     IF ALIAS(SELECT('INF')) == 'INF'
		REPL ISO->cCodInfIso WITH cCodInfTis
		REPL ISO->nCodPrnIso WITH nCodPrnTis
		REPL ISO->dFecAprIso WITH dFecAprTis
		REPL ISO->cFecAprIso WITH cFecAprTis
		REPL ISO->cNroVerIso WITH cNroVerTis
		REPL ISO->nMargSIIso WITH nMargSITis
		REPL ISO->nMargSDIso WITH nMargSDTis
		REPL ISO->nMargIIIso WITH nMargIITis
		REPL ISO->nMargIDIso WITH nMargIDTis
		REPL ISO->nMarg1IIso WITH nMarg1ITis
		REPL ISO->nMarg1DIso WITH nMarg1DTis
		REPL ISO->nMarg2IIso WITH nMarg2ITis
		REPL ISO->nMarg2DIso WITH nMarg2DTis
		REPL ISO->nNroDocIso WITH nNroDocTis
	     ENDIF
	     REPL ISO->cTituloIso WITH cTitulo
             REPL ISO->cCodigoIso WITH cCodigoTis
             REPL ISO->cTitUnoIso WITH cTitUnoTis
             REPL ISO->cTitDosIso WITH cTitDosTis
             REPL ISO->cTitTreIso WITH cTitTreTis
             REPL ISO->cPieUnoIso WITH cPieUnoTis
             REPL ISO->cPieDosIso WITH cPieDosTis
	     REPL ISO->cPieTreIso WITH cPieTreTis
             REPL ISO->cObsUnoIso WITH cObsUnoTis
             REPL ISO->cObsDosIso WITH cObsDosTis
	     REPL ISO->cObsTreIso WITH cObsTreTis
	     REPL ISO->nCabPrnIso WITH nCabPrnTis

             REPL ISO->cNomUsrIso WITH cNomUsr
             REPL ISO->dFecUsrIso WITH DATE()
             REPL ISO->cHorUsrIso WITH TIME()
	     ISO->(DBCOMMIT())

          ENDIF

          IF lShared
             ISO->(DBUNLOCK())
	  ENDIF

       ENDIF
*>>>>FIN GRABACION DEL REGISTRO

*>>>>REFRESCAR EL BROWSE
       IF nTipMod == 2

	  IF !EMPTY(oBrowse)
	     nNroReg := ISO->(RECNO())
	     ISO->(DBGOTOP())
	     oBrowse:GOTOP()
	     ISO->(DBGOTO(nNroReg))
	     oBrowse:FORCESTABLE()
	  ELSE
	     nNroReg := ISO->(RECNO())
	     ISO->(DBGOTOP())
	     ISO->(DBGOTO(nNroReg))
	  ENDIF

       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SETCURSOR(nTipCur)
       RETURN .T.
*>>>>FIN REFRESCAR EL BROWSE

/*************************************************************************
* TITULO..: GESTION DOCUMENTAL DE LOS INFORMES                           *
**************************************************************************

OBJETIVOS:

1- Localiza el N£mero Iso del informe

2- Retorna los detalles de la gestion documental del informe

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION DetalleIso(nNroIso,cCodIso,aTitIso,aPieIso)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroIso                              // N£mero Iso del Informe
       cCodIso                              // @C¢digo Iso del Informe
       aTitIso                              // @T¡tulo Iso del Informe
       aPieIso			            // @Pie del p gina del informe */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DETALLES DE LA GESTION DOCUMENTAL
       cCodIso := ''
       IF lLocCodigo('nNumeroIso','ISO',nNroIso)

	  cCodIso := ALLTRIM(cTxtToPcl(ISO->cCodigoIso))

	  IF !EMPTY(ISO->cTitUnoIso)
	     aTitIso[1] := ALLTRIM(cTxtToPcl(ISO->cTitUnoIso))
	  ENDIF
	  IF !EMPTY(ISO->cTitDosIso)
	     aTitIso[2] := ALLTRIM(cTxtToPcl(ISO->cTitDosIso))
	  ENDIF
	  IF !EMPTY(ISO->cTitTreIso)
	     aTitIso[3] := ALLTRIM(cTxtToPcl(ISO->cTitTreIso))
	  ENDIF

	  IF !EMPTY(ISO->cPieUnoIso)
	     aPieIso[1] := RTRIM(cTxtToPcl(ISO->cPieUnoIso))
	  ENDIF
	  IF !EMPTY(ISO->cPieDosIso)
	     aPieIso[2] := RTRIM(cTxtToPcl(ISO->cPieDosIso))
	  ENDIF
	  IF !EMPTY(ISO->cPieTreIso)
	     aPieIso[3] := RTRIM(cTxtToPcl(ISO->cPieTreIso))
	  ENDIF
       ENDIF
       RETURN NIL
*>>>>FIN DETALLES DE LA GESTION DOCUMENTAL

/*************************************************************************
* TITULO..: VALIDACION DE LOS DETALLES DEL ISO                           *
**************************************************************************

OBJETIVOS:

1- Localiza el N£mero Iso del informe

2- Retorna los detalles de la gestion documental del informe

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lValDetIso(nNroIso,cCodIso,aTitIso,aPieIso,;
		    cCodInf,aMarInf,nNroDoc,aObsPrn,;
		    FileDoc)

*>>>>DESCRIPCION DE PARAMETROS
/*     nNroIso                              // N£mero Iso del Informe
       cCodIso                              // @C¢digo Iso del Informe
       aTitIso                              // @T¡tulo Iso del Informe
       aPieIso			            // @Pie del p gina del informe
       cCodInf                              // @C¢digo del Informe
       aMarInf			            // L¡neas de Espaciado
       nNroDoc                              // N£mero del Documento
       aObsPrn			            // Observaciones del informe
       FileDoc                              // Archivo del Documento */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL cNroDoc := ''                  // N£mero del documento
       LOCAL nNroPos := 0                   // N£mero de posici¢n
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DETALLES DE LA GESTION DOCUMENTAL
       cCodIso := ''
       IF lLocCodigo('nNumeroIso','ISO',nNroIso)

	  IF !EMPTY(ALLTRIM(ISO->cCodInfIso))
	     cCodInf := ALLTRIM(ISO->cCodInfIso)
	  ENDIF

	  IF LEN(aMarInf) >= 1
	     aMarInf[1,1] := ISO->nMargSIIso
	     aMarInf[1,2] := ISO->nMargSDIso
	  ENDIF

	  IF LEN(aMarInf) >= 2
	     aMarInf[2,1] := ISO->nMargIIIso
	     aMarInf[2,2] := ISO->nMargIDIso
	  ENDIF

	  IF LEN(aMarInf) >= 3
	     aMarInf[3,1] := ISO->nMarg1IIso
	     aMarInf[3,2] := ISO->nMarg1DIso
	  ENDIF

	  IF LEN(aMarInf) >= 4
	     aMarInf[4,1] := ISO->nMarg2IIso
	     aMarInf[4,2] := ISO->nMarg2DIso
	  ENDIF

	  cCodIso := ALLTRIM(cTxtToPcl(ISO->cCodigoIso))

	  IF !EMPTY(ISO->cTitUnoIso)
	     aTitIso[1] := ALLTRIM(cTxtToPcl(ISO->cTitUnoIso))
	  ENDIF
	  IF !EMPTY(ISO->cTitDosIso)
	     aTitIso[2] := ALLTRIM(cTxtToPcl(ISO->cTitDosIso))
	  ENDIF
	  IF !EMPTY(ISO->cTitTreIso)
	     aTitIso[3] := ALLTRIM(cTxtToPcl(ISO->cTitTreIso))
	  ENDIF

	  IF !EMPTY(ISO->cPieUnoIso)
	     aPieIso[1] := RTRIM(cTxtToPcl(ISO->cPieUnoIso))
	  ENDIF
	  IF !EMPTY(ISO->cPieDosIso)
	     aPieIso[2] := RTRIM(cTxtToPcl(ISO->cPieDosIso))
	  ENDIF
	  IF !EMPTY(ISO->cPieTreIso)
	     aPieIso[3] := RTRIM(cTxtToPcl(ISO->cPieTreIso))
	  ENDIF

	  IF !EMPTY(ISO->cObsUnoIso)
	     aObsPrn[1] := RTRIM(cTxtToPcl(ISO->cObsUnoIso))
	  ENDIF
	  IF !EMPTY(ISO->cObsDosIso)
	     aObsPrn[2] := RTRIM(cTxtToPcl(ISO->cObsDosIso))
	  ENDIF
	  IF !EMPTY(ISO->cObsTreIso)
	     aObsPrn[3] := RTRIM(cTxtToPcl(ISO->cObsTreIso))
	  ENDIF

       ENDIF
*>>>>FIN DETALLES DE LA GESTION DOCUMENTAL

*>>>>LOCALIZACION DE LA IMPRESORA
       IF !EMPTY(ISO->nCodPrnIso)
	  IF !lLocCodigo('nCodigoPrn','PRN',ISO->nCodPrnIso)
	     cError('NO EXISTE LA IMPRESORA CONFIGURADA PARA EL INFORME')
	     RETURN .F.
	  ENDIF
       ENDIF
*>>>>FIN LOCALIZACION DE LA IMPRESORA

*>>>>LOCALIZACION DEL INFORME DEL SISTEMA
       IF lLocCodigo('cCodigoInf','INF',cCodInf)
	  IF INF->lInfVarInf
	     nNroDoc := ISO->nNroDocIso
	  ELSE
	     nNroDoc := 0
	  ENDIF
       ENDIF
*>>>>FIN LOCALIZACION DEL INFORME DEL SISTEMA

*>>>>VALIDACION DEL ARCHIVO DEL DOCUMENTO
       IF !EMPTY(nNroDoc)

**********SUSTITUCION DEL ARCHIVO
	    IF !EMPTY(FileDoc)
	       cNroDoc := STR(nNroDoc,2)
	       lCorrecion(@cNroDoc)

	       nNroPos := AT('.',FileDoc)
	       FileDoc := STUFF(FileDoc,nNroPos-2,2,cNroDoc)
	    ENDIF
**********FIN SUSTITUCION DEL ARCHIVO

**********VALIDACION DEL ARCHIVO
	    lHayErr := .T.
	    DO CASE
	    CASE EMPTY(FileDoc)
		 cError('SE DEBE PASAR EL ARCHIVO')

	    CASE !FILE(FileDoc)
		 cError('EL ARCHIVO '+FileDoc+' NO EXISTE')

	    OTHERWISE
		 lHayErr :=.F.
	    ENDCASE
**********FIN VALIDACION DEL ARCHIVO

       ENDIF
*>>>>FIN VALIDACION DEL ARCHIVO DEL DOCUMENTO

*>>>>VALIDACION DE LA FECHA DE APROBACION
       IF !EMPTY(ISO->dFecAprIso)
	  IF DATE() < ISO->dFecAprIso
	     cError('ES MAYOR A LA FECHA DEL SISTEMA: '+cFecha(DATE()),;
		    'FECHA DE APROBACION '+;
		    'DEL INFORME: '+cFecha(ISO->dFecAprIso))
	     lHayErr := .T.
	  ENDIF
       ENDIF
       RETURN !lHayErr
*>>>>FIN VALIDACION DE LA FECHA DE APROBACION

/*************************************************************************
* TITULO..: MODIFICACION DEL GESTION DOCUMENTAL                          *
**************************************************************************

OBJETIVOS:

1- Localiza el informe de acuerdo a su c¢digo.

2- Si no existe permite registrar la gesti¢n documental.

3- Retorn Nil

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lModRegIso(lShared,cNomUsr,oBrowse,nNroIso,cTitPrn,;
		    cOpcSys,cUsrIso,cCodInf,aMarInf,nNroDoc,;
		    aObsPrn)


*>>>>DESCRIPCION DE PARAMETROS
/*     lShared                              // .T. Sistema Compartido
       cNomUsr                              // Nombre del Usuario
       oBrowse                              // Browse del Archivo
       nNroIso                              // N£mero del Documento Iso
       cTitPrn                              // T¡tulo del Informe
       cOpcSys			            // Opci¢n del Informe
       cUsrIso                              // Usuario Iso
       cCodInf                              // C¢digo del Informe
       aMarInf			            // L¡neas de Espaciado
       nNroDoc                              // N£mero del Documento
       aObsPrn			            // Observaciones del Informe */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       #INCLUDE "FILES.PRG"           // Archivos Compartidos

       LOCAL cSavPan := ''                   // Salvar Pantalla
       LOCAL cUsrVal := ''                   // Usuario a validar
       LOCAL lLocReg := .F.                  // .T. Localizado el registro
*>>>>FIN DECLARACION DE VARIABLES

*>>>>DECLARACION DE VARIABLES
       LOCAL nNroCur := 0                    // N£mero del Cursor
*>>>>FIN DECLARACION DE VARIABLES

*>>>>VALIDACION DEL USUARIO
       IF !EMPTY(cUsrIso)

	  cSavPan := SAVESCREEN(0,0,24,79)
	  nNroCur := SETCURSOR(1)
	  cUsrVal := cNomUsr(lShared,08,19,PathSis,FileAaa)
	  RESTSCREEN(0,0,24,79,cSavPan)
	  SETCURSOR(nNroCur)

	  IF cUsrIso # cUsrVal
	     RETURN NIL
	  ENDIF
       ENDIF
*>>>>FIN VALIDACION DEL USUARIO

*>>>>FILTRACION DEL ARCHIVO
       IF ALIAS(SELECT('INF')) == 'INF'
	  SELECT INF
	  SET FILTER TO
	  SET FILTER TO INF->nNumeroInf == nNroIso
	  INF->(DBGOTOP())
	  IF INF->(EOF())
	     cError('NO EXISTEN INFORMES CON NUMERO '+ALLTRIM(STR(nNroIso,4)))
	     SET FILTER TO
	     RETURN NIL
	  ENDIF
       ENDIF
*>>>>FIN FILTRACION DEL ARCHIVO

*>>>>INCLUIR EL DOCUMENTO
       lLocReg := lLocCodigo('nNumeroIso','ISO',nNroIso)
       IF !lLocReg
	  lManRegIso(lShared,cNomUsr,1,oBrowse,nNroIso,1,cTitPrn,cOpcSys,;
		     cCodInf,aMarInf,nNroDoc,aObsPrn)
       ENDIF
*>>>>FIN INCLUIR EL DOCUMENTO

*>>>>LOCALIZACION DEL INFORME
IF ALIAS(SELECT('INF')) == 'INF'

       IF !EMPTY(ISO->cCodInfIso) .AND.;
	  !lLocCodigo('cCodigoInf','INF',ISO->cCodInfIso)

	  cError('NO EXISTE EL INFORME CON CODIGO '+;
	  ALLTRIM(ISO->cCodInfIso))

	  SET FILTER TO
	  RETURN NIL
       ENDIF
ENDIF
*>>>>FIN LOCALIZACION DEL INFORME


*>>>>VALIDACION DEL INFORME VARIABLE
IF ALIAS(SELECT('INF')) == 'INF'
       IF INF->lInfVarInf .AND. ISO->nNroDocIso == 0
	  cError('DEBE DEFINIR EL NUMERO DEL DOCUMENTO')
	  lLocReg := .T.
       ENDIF
ENDIF
*>>>>FIN VALIDACION DEL INFORME VARIABLE

*>>>>MODIFICACION DEL INFORME
       IF lLocReg

***********MODIFICACION DEL REGISTRO
	     lManRegIso(lShared,cNomUsr,2,oBrowse,nNroIso,1,cTitPrn,cOpcSys,;
			cCodInf,aMarInf,nNroDoc,aObsPrn)
***********FIN MODIFICACION DEL REGISTRO

       ENDIF
       SELECT ISO
       SET FILTER TO
       RETURN NIL
*>>>>FIN MODIFICACION DEL INFORME

/*************************************************************************
* TITULO..: TOTAL NOTAS DE PIE DE PAGINA                                 *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUN 05/2007 MAR A
       Colombia, Bucaramanga        INICIO:  4:00 PM   JUN 05/2007 MAR

OBJETIVOS:

1- Totaliza el total de notas del pie de p gina 

2- Returna el total de notas de pie de p gina.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION nTotPieIso(aPieIso)

*>>>>DESCRIPCION DE PARAMETROS
/*      aPieIso                             // Textos del pie de p gina */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL       i := 0                   // Contador
       LOCAL nTotPie := 0                   // Total de Pie de p ginas
*>>>>FIN DECLARACION DE VARIABLES

*>>>>TOTAL NOTAS DE PIE DE PAGINA
       nTotPie := 0
       FOR i := 1 TO LEN(aPieIso)
	   IF EMPTY(aPieIso[i])
	      LOOP
	   ENDIF
	   nTotPie++
       ENDFOR
       RETURN nTotPie
*>>>>FIN TOTAL NOTAS DE PIE DE PAGINA

/*************************************************************************
* TITULO..: REEMPLAZO DE TEXTO EN EL TITULO                              *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: OCT 16/2007 MAR A
       Colombia, Bucaramanga        INICIO: 05:00 PM   OCT 16/2007 MAR

OBJETIVOS:

1- Reemplaza el texto en el titulo del informe

2- Retorna Nil

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION ReplTitIso(aTitIso,aMezIso)

*>>>>DESCRIPCION DE PARAMETROS
/*     aTitIso                              // T¡tulo Iso del Informe
       aMezIso                              // Campos a Mesclar */
*>>>>FIN DESCRIPCION DE PARAMETROS

*>>>>DECLARACION DE VARIABLES
       LOCAL i,j := 0                       // Contador
*>>>>FIN DECLARACION DE VARIABLES

*>>>>REEMPLAZO DEL TEXTO
       FOR i := 1 TO LEN(aTitIso)
	   FOR j := 1 TO LEN(aMezIso)
	       aTitIso[i] := cReplTxt(aMezIso[j,1],;
				      aMezIso[j,2],;
				      aTitIso[i])
	   ENDFOR
       ENDFOR
       RETURN NIL
*>>>>FIN REEMPLAZO DEL TEXTO