/*************************************************************************
* TITULO..: MANTENIMIENTO DEL REGISTRO                                   *
**************************************************************************

AUTOR: Nelson Fern ndez G¢mez       FECHA DE CREACION: JUL 28/2005 JUE A
       Colombia, Bucaramanga        INICIO: 10:59 AM   JUL 28/2005 JUE

OBJETIVOS:

1- Permite inclusi¢n,modificaci¢n y consulta del registro

2- Puede invocarse en la lectura a trav‚s de la clausula VALID

2- Returna .T.

*------------------------------------------------------------------------*
*                              PROGRAMA                                  *
*------------------------------------------------------------------------*/

FUNCTION lManRegVeh(lShared,cNomUsr,nTipMod,oBrowse,cPlaca,nNroOpc)

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
       LOCAL lHayErr := .F.                 // .T. Hay Error

       LOCAL aMenus  := {}                  // Vector de declaracion de men£
       LOCAL aAyuda  := {}                  // Vector de ayudas para el men£

       LOCAL nTipCur := 1                   // Tipo de Cursor
       LOCAL nNroFil := 0                   // N£mero de la fila
       LOCAL nNroCol := 1                   // N£mero de la Columna
       LOCAL nColTem := 0                   // Columna Temporal
       LOCAL nFilIni := 0                   // Fila Inicial

       LOCAL cNalias := ''                  // Alias del Archivo
       LOCAL nNroReg := 0                   // N£mero del Registro
       LOCAL lGrabar := .T.                 // .T. Grabar el registro
       LOCAL lInsReg := .F.                 // .T. Insertar el Registro

       LOCAL cTxtTem := ''                  // Texto temporal
       LOCAL cTxtHlp := ''                  // Texto de Ayuda

       LOCAL cTipVehTca := ''               // Tipo de Veh¡culo                                            
       LOCAL dIniPakTve := CTOD('00/00/00')   // Fecha Inicial de Parqueo                                    
       LOCAL dFinPakTve := CTOD('00/00/00')   // Fecha Final de Parqueo                                      
       LOCAL cDocDueTve := ''               // Documento del Due¤o                                         
       LOCAL cTipNitTve := ''               // Tipo del Documento del Due¤o                                
       LOCAL nNroFacTre := 0                // Numero del Recibo del Pago                                  

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
            cTxtTem := 'VEHICULOS .INCLUIR. '+aMenus[nNroOpc]
            VEH->(DBGOBOTTOM())
            VEH->(DBSKIP())
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 2
            cTxtTem := 'VEHICULOS .ACTUALIZAR. '+aMenus[nNroOpc]
            nTipCur := SETCURSOR(1)

       CASE nTipMod == 3
            cTxtTem := 'VEHICULOS. CONSUTA. '+aMenus[nNroOpc]
       ENDCASE
       nFilIni := nMarco(03,cTxtTem,22,'°')
*>>>>FIN MARCO DEL MANTENIMIENTO

*>>>>MANTENIMIENTO DEL REGISTRO
       SELECT VEH
       DO WHILE .T.

**********INICIALIZACION DE LAS VARIABLES
            IF lGrabar

               IF EMPTY(cPlaca)
                  cPlaca := VEH->cPlacaVeh
               ENDIF

               cTipVehTca := VEH->cTipVehCat
               dIniPakTve := VEH->dIniPakVeh
               dFinPakTve := VEH->dFinPakVeh
               cDocDueTve := VEH->cDocDueVeh
               cTipNitTve := VEH->cTipNitVeh
               nNroFacTre := VEH->nNroFacReg
            ENDIF
**********FIN INICIALIZACION DE LAS VARIABLES

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil := nFilIni
               cTxtTem := 'NUMERO DE LA PLACA         :'

               IF nTipMod == 2 .OR. nTipMod == 3 .OR. !EMPTY(cPlaca)
                  @ nNroFil,nNroCol SAY cTxtTem
                  @ nNroFil,nNroCol+LEN(cTxtTem)+1 SAY cPlaca COLOR('I')
               ELSE
                  @ nNroFil,nNroCol SAY cTxtTem;
                                    GET cPlaca PICT '@!';
                                    VALID !EMPTY(cPlaca) .AND.;
                                          !lValCodVeh(cPlaca)
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'TIPO DE VEHICULO           :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cTipVehTca COLOR('I')
	       ELSE
		  cTipVehTca := IF(EMPTY(cTipVehTca),'XX',cTipVehTca)
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cTipVehTca PICT '@!';
				    VALID !EMPTY(cTipVehTca) .AND.;
					  lValCat(ROW(),COL()-3,@cTipVehTca);
				    WHEN {||HelpRead('FAVOR INGRESE EL TIPO DE VEHICULO')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

	       IF nTipMod == 3
		  nNroFil++
		  nColTem := nNroCol
		  cTxtTem := 'FECHA DE INICIO DEL PARQUEO:'

                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY dIniPakTve COLOR('I')
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

	       IF nTipMod == 3
		  nNroFil++
		  nColTem := nNroCol
		  cTxtTem := 'FECHA DE FINAL DEL PARQUEO :'

                  @ nNroFil,nColTem SAY cTxtTem
		  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY dFinPakTve COLOR('I')
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'DOCUMENTO DEL DUE¥O        :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cDocDueTve COLOR('I')
               ELSE
                  @ nNroFil,nColTem SAY cTxtTem;
                                    GET cDocDueTve PICT '@!';
                                    VALID !EMPTY(cDocDueTve);
                                    WHEN {||HelpRead('FAVOR INGRESE EL DOCUMENTO DEL DUE¥O')}
               ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

               nNroFil++
               nColTem := nNroCol
               cTxtTem := 'TIPO DE DOCUMENTO          :'

               IF nTipMod == 3
                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY cTipNitTve COLOR('I')
	       ELSE
		  cTipNitTve := IF(EMPTY(cTipNitTve),'X',cTipNitTve)
		  @ nNroFil,nColTem SAY cTxtTem;
				    GET cTipNitTve PICT '9';
				    VALID !EMPTY(cTipNitTve) .AND.;
				    lValTipDoc(ROW(),COL()-1,@cTipNitTve,'1245');
				    WHEN {||HelpRead('FAVOR INGRESE EL TIPO DE DOCUMENTO')}
	       ENDIF

	    ENDIF
**********FIN LECTURA DE CAMPO

**********LECTURA DE CAMPO
            IF nNroOpc == 1

	       IF nTipMod == 3

		  nNroFil++
		  nColTem := nNroCol
		  cTxtTem := 'RECIBO DE PAGO             :'

                  @ nNroFil,nColTem SAY cTxtTem
                  @ nNroFil,nColTem+LEN(cTxtTem)+1 SAY nNroFacTre COLOR('I')
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

**********VALIDACION DE EXISTENCIA DEL TERCERO
	    lHayErr := .F.
	    cNalias := ''
	    IF !lValDoc(cDocDueTve,cTipNitTve,@cNalias)

*==============ANALISIS DE DECISION
		 lHayErr := .T.
		 cError('LA '+;
			IF(cNalias == 'PER','PERSONA','EMPRESA')+' '+;
			'NO EXISTE')

		 IF !lPregunta('DESEA GRABAR LOS DATOS DE LA '+;
			       IF(cNalias == 'PER','PERSONA','EMPRESA')+;
			       '? Si No')
		    lGrabar := .F.
		    cError('NO SE GRABAN LOS DETALLES DEL VEHICULO')
		    EXIT
		 ENDIF

		 cSavPan := SAVESCREEN(0,0,24,79)
*==============FIN ANALISIS DE DECISION

*==============GRABACION DEL TERCERO
		 DO CASE
		 CASE cNalias == 'PER'
		      lManRegPer(lShared,cNomUsr,1,NIL,cDocDueTve)

		 CASE cNalias == 'EMP'
		      lManRegEmp(lShared,cNomUsr,1,NIL,cDocDueTve,cTipNitTve)

		 ENDCASE
		 RESTSCREEN(0,0,24,79,cSavPan)
*==============FIN GRABACION DEL TERCERO

*==============VALIDACION DE EXISTENCIA DEL TERCERO
		 IF lValDoc(cDocDueTve,cTipNitTve)
		    lGrabar := .T.
		    EXIT
		 ELSE
		    lGrabar := .F.
		 ENDIF
*==============FIN VALIDACION DE EXISTENCIA DEL TERCERO

	    ENDIF
**********FIN VALIDACION DE EXISTENCIA DEL TERCERO

**********PREGUNTA DE DECISION
            DO CASE
            CASE LASTKEY() # K_ESC .AND. nTipMod # 3
		 IF !lPregunta('DESEA GRABAR LOS DETALLES DEL VEHICULO? Si No')
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
       SELECT VEH
       IF nTipMod # 3 .AND. lGrabar

          lInsReg := IF(nTipMod == 1,.T.,.F.)
          IF VEH->(lRegLock(lShared,lInsReg))

             IF lInsReg
                REPL VEH->nIdeCodVeh WITH VEH->(RECNO())
                REPL VEH->cPlacaVeh WITH cPlaca
             ENDIF

             REPL VEH->cTipVehCat WITH cTipVehTca
             REPL VEH->dIniPakVeh WITH dIniPakTve
             REPL VEH->dFinPakVeh WITH dFinPakTve
             REPL VEH->cDocDueVeh WITH cDocDueTve
             REPL VEH->cTipNitVeh WITH cTipNitTve
             REPL VEH->nNroFacReg WITH nNroFacTre

             REPL VEH->cNomUsrVeh WITH cNomUsr
             REPL VEH->dFecUsrVeh WITH DATE()
             REPL VEH->cHorUsrVeh WITH TIME()
             VEH->(DBCOMMIT())
          ENDIF

          IF lShared
             VEH->(DBUNLOCK())
          ENDIF

       ENDIF
       RESTSCREEN(0,0,24,79,cSavPan)
       SETCURSOR(nTipCur)
*>>>>FIN GRABACION DEL REGISTRO

*>>>>REFRESCAR EL BROWSE
       IF nTipMod == 2
          nNroReg := VEH->(RECNO())
          VEH->(DBGOTOP())
          oBrowse:GOTOP()
          VEH->(DBGOTO(nNroReg))
          oBrowse:FORCESTABLE()
       ENDIF
       RETURN .T.
*>>>>FIN REFRESCAR EL BROWSE